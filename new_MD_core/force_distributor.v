//////////////////////////////////////////////////////////////
// Based on target cell id, distribute the forces to buffers
// Take the data output from the buffers and pack with flags
//////////////////////////////////////////////////////////////
module force_distributor
#(
	parameter DATA_WIDTH = 32, 
	parameter CELL_ID_WIDTH = 3, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter NUM_FILTER = 7, 
	parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH, 
	// Full data + 1 bit destination selection (cell id discarded, represented by dst bit instead)
	parameter FORCE_BUFFER_WIDTH = 3*DATA_WIDTH+PARTICLE_ID_WIDTH+1, 
	parameter FORCE_BUFFER_ADDR_WIDTH = 5, 
	parameter CELL_222 = 9'b010010010, 
	parameter CELL_111 = 9'b001001001
)
(
	input clk, 
	input rst, 
	input [DATA_WIDTH-1:0] ref_force_x, 
	input [DATA_WIDTH-1:0] ref_force_y, 
	input [DATA_WIDTH-1:0] ref_force_z, 
	input [PARTICLE_ID_WIDTH-1:0] ref_id, 
	input ref_force_valid, 
	input [DATA_WIDTH-1:0] force_x, 
	input [DATA_WIDTH-1:0] force_y, 
	input [DATA_WIDTH-1:0] force_z, 
	input [ID_WIDTH-1:0] nb_id, 
	input force_valid, 
	// Successfully chosen by the arbiter
	input [NUM_FILTER-1:0] write_success, 
	
	output [NUM_FILTER*FORCE_BUFFER_WIDTH-1:0] force_buffer_data_out, 
	output [NUM_FILTER-1:0] output_force_valid, 
	output [NUM_FILTER*FORCE_BUFFER_ADDR_WIDTH-1:0] force_buffer_usedw
);

wire [FORCE_BUFFER_WIDTH-1:0] force_buffer_data_in_ref;
wire ref_selected;
reg [DATA_WIDTH-1:0] reg_ref_force_x;
reg [DATA_WIDTH-1:0] reg_ref_force_y;
reg [DATA_WIDTH-1:0] reg_ref_force_z;
reg [PARTICLE_ID_WIDTH-1:0] reg_ref_id;
reg reg_ref_force_valid;

wire [3*CELL_ID_WIDTH-1:0] cell_id;
wire [PARTICLE_ID_WIDTH-1:0] nb_particle_id;
assign cell_id = nb_id[ID_WIDTH-1:PARTICLE_ID_WIDTH];
assign nb_particle_id = nb_id[PARTICLE_ID_WIDTH-1:0];
wire [NUM_FILTER-1:0] force_buffer_wr_en;
wire [FORCE_BUFFER_WIDTH-1:0] force_buffer_data_homecell;

// Assemble buffer input data
wire force_dst_ref;
assign force_dst_ref = 1'b0;
assign force_buffer_data_in_ref = {reg_ref_id, reg_ref_force_z, reg_ref_force_y, reg_ref_force_x, force_dst_ref};
wire [FORCE_BUFFER_WIDTH-1:0] force_buffer_data_in;
// Used to identify the output destination
wire force_dst;
assign force_buffer_data_in = {nb_particle_id, force_z, force_y, force_x, force_dst};

// Use a register to save ref data, in case there's conflict in 222 ref force wr and nb force wr
always@(posedge clk)
	begin
	if (rst)
		begin
		reg_ref_force_x <= 0;
		reg_ref_force_y <= 0;
		reg_ref_force_z <= 0;
		reg_ref_id <= 0;
		reg_ref_force_valid <= 0;
		end
	else
		begin
		// The valid signal only lasts for 1 cycle
		if (ref_force_valid)
			begin
			reg_ref_force_x <= ref_force_x;
			reg_ref_force_y <= ref_force_y;
			reg_ref_force_z <= ref_force_z;
			reg_ref_id <= ref_id;
			reg_ref_force_valid <= 1'b1;
			end
		// ref_selected can only be triggered at least 1 cycle after ref_force_valid
		else if (ref_selected)
			begin
			reg_ref_force_valid <= 1'b0;
			end
		end
	end
	
// Order: The same as pos distributor
// Select a buffer to hold the input data
force_buffer_select
#(
	.NUM_FILTER(NUM_FILTER), 
	.CELL_ID_WIDTH(CELL_ID_WIDTH), 
	.FORCE_BUFFER_WIDTH(FORCE_BUFFER_WIDTH)
)
force_buffer_select
(
	.ref_force_valid(reg_ref_force_valid),
	.force_valid(force_valid), 
	.cell_id(cell_id), 
	.force_buffer_data_in(force_buffer_data_in),
	.force_buffer_data_in_ref(force_buffer_data_in_ref),
	
	.force_buffer_data_homecell(force_buffer_data_homecell),
	.force_buffer_wr_en(force_buffer_wr_en), 
	.ref_selected(ref_selected),
	.force_dst(force_dst)
);


// Read enable control
wire [NUM_FILTER-1:0] force_buffer_empty;
wire [NUM_FILTER-1:0] force_buffer_rd_en;
wire [NUM_FILTER-1:0] queuing;
wire [NUM_FILTER-1:0] prev_force_buffer_empty;
assign force_buffer_rd_en = ~(queuing | force_buffer_empty);

// 6 force output buffers, the home cell force buffer is controlled differently
genvar i;
generate
	for (i = 1; i < NUM_FILTER; i = i + 1)
		begin: force_output_buffers
		force_output_buffer
		#(
			.FORCE_BUFFER_WIDTH(FORCE_BUFFER_WIDTH), 
			.FORCE_BUFFER_DEPTH(32), 
			.FORCE_BUFFER_ADDR_WIDTH(5)
		)
		force_output_buffer
		(
			.clock(clk),
			.data(force_buffer_data_in),
			.wrreq(force_buffer_wr_en[i]),
			.rdreq(force_buffer_rd_en[i]),
			.empty(force_buffer_empty[i]),
			.q(force_buffer_data_out[(i+1)*FORCE_BUFFER_WIDTH-1:i*FORCE_BUFFER_WIDTH]),
			.usedw(force_buffer_usedw[(i+1)*FORCE_BUFFER_ADDR_WIDTH-1:i*FORCE_BUFFER_ADDR_WIDTH])
		);
		end
endgenerate
// Home cell force buffer, including cell 111 as well
force_output_buffer
#(
	.FORCE_BUFFER_WIDTH(FORCE_BUFFER_WIDTH), 
	.FORCE_BUFFER_DEPTH(32), 
	.FORCE_BUFFER_ADDR_WIDTH(5)
)
force_output_buffer_homecell
(
	.clock(clk),
	.data(force_buffer_data_homecell),
	.wrreq(force_buffer_wr_en[0] || ref_selected),
	.rdreq(force_buffer_rd_en[0]),
	.empty(force_buffer_empty[0]),
	.q(force_buffer_data_out[FORCE_BUFFER_WIDTH-1:0]),
	.usedw(force_buffer_usedw[FORCE_BUFFER_ADDR_WIDTH-1:0])
);

// 1 cycle delay
check_output_force_valid
#(
	.NUM_FILTER(NUM_FILTER)
)
check_output_force_valid
(
	.clk(clk),
	.rst(rst),
	.force_buffer_empty(force_buffer_empty),
	.write_success(write_success),
	
	.prev_force_buffer_empty(prev_force_buffer_empty),
	.output_force_valid(output_force_valid)
);

// combinational
get_queuing_status
#(
	.NUM_FILTER(NUM_FILTER)
)
get_queuing_status
(
	.output_force_valid(output_force_valid),
	.force_buffer_empty(force_buffer_empty),
	.prev_force_buffer_empty(prev_force_buffer_empty),
	.write_success(write_success),
	
	.queuing(queuing)
);

endmodule