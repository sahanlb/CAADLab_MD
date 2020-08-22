module filter_bank_with_conversion_ip
#(
	// Data width
	parameter DATA_WIDTH = 32,
	parameter CELL_ID_WIDTH = 3,
	parameter DECIMAL_ADDR_WIDTH = 2, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter BODY_BITS = 8, 
	parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH,
	parameter FILTER_BUFFER_DATA_WIDTH = 2*ID_WIDTH+6*DATA_WIDTH, 
	
	// Constants
	parameter SQRT_2 = 8'b10110110,
	parameter SQRT_3 = 8'b11011110, 
	parameter BACK_PRESSURE_THRESHOLD = 16, 
	parameter NUM_FILTER = 8, 
	parameter ARBITER_MSB = 128, 
	parameter EXP_0 = 8'b01111111
)
(
	input clk, 
	input rst, 
	input [NUM_FILTER-1:0] input_valid,
	input [NUM_FILTER*ID_WIDTH-1:0] ref_id_in,
	input [NUM_FILTER*ID_WIDTH-1:0] nb_id_in,
	input [NUM_FILTER*DATA_WIDTH-1:0] ref_x,
	input [NUM_FILTER*DATA_WIDTH-1:0] ref_y,
	input [NUM_FILTER*DATA_WIDTH-1:0] ref_z,
	input [NUM_FILTER*DATA_WIDTH-1:0] nb_x,
	input [NUM_FILTER*DATA_WIDTH-1:0] nb_y,
	input [NUM_FILTER*DATA_WIDTH-1:0] nb_z,
	output [ID_WIDTH-1:0] ref_id_out,
	output [ID_WIDTH-1:0] nb_id_out,
	output [DATA_WIDTH-1:0] r2_out,
	output [DATA_WIDTH-1:0] dx_out,
	output [DATA_WIDTH-1:0] dy_out,
	output [DATA_WIDTH-1:0] dz_out,
	output out_valid,
	
	output [NUM_FILTER-1:0] back_pressure,				// If one of the FIFO is full, then set the back_pressure flag to stop more incoming particle pairs
	output all_buffer_empty
);

wire [NUM_FILTER-1:0] buffer_empty;
wire [NUM_FILTER*FILTER_BUFFER_DATA_WIDTH-1:0] buffer_rd_data;
wire [NUM_FILTER-1:0] arbitration_result;

reg raw_data_valid;
reg [FILTER_BUFFER_DATA_WIDTH-1:0] data_out;
wire [ID_WIDTH-1:0] ref_id;
wire [ID_WIDTH-1:0] nb_id;

// Fixed point format
wire [DATA_WIDTH-1:0] x1, y1, z1, x2, y2, z2;

// Floating point format
wire [DATA_WIDTH-1:0] x1_f, y1_f, z1_f, x2_f, y2_f, z2_f;

reg [DATA_WIDTH-1:0] reg_ref_id_1;
reg [DATA_WIDTH-1:0] reg_ref_id_2;
reg [DATA_WIDTH-1:0] reg_ref_id_3;
reg [DATA_WIDTH-1:0] reg_ref_id_4;
reg [DATA_WIDTH-1:0] reg_ref_id_5;
reg [DATA_WIDTH-1:0] reg_ref_id_6;
reg [DATA_WIDTH-1:0] reg_ref_id_7;
reg [DATA_WIDTH-1:0] reg_ref_id_8;
reg [DATA_WIDTH-1:0] reg_ref_id_9;
reg [DATA_WIDTH-1:0] reg_ref_id_10;
reg [DATA_WIDTH-1:0] reg_ref_id_11;
reg [DATA_WIDTH-1:0] reg_ref_id_12;
reg [DATA_WIDTH-1:0] reg_ref_id_13;
reg [DATA_WIDTH-1:0] reg_ref_id_14;
reg [DATA_WIDTH-1:0] reg_ref_id_15;
reg [DATA_WIDTH-1:0] reg_ref_id_16;
reg [DATA_WIDTH-1:0] reg_ref_id_delay;

reg [DATA_WIDTH-1:0] reg_nb_id_1;
reg [DATA_WIDTH-1:0] reg_nb_id_2;
reg [DATA_WIDTH-1:0] reg_nb_id_3;
reg [DATA_WIDTH-1:0] reg_nb_id_4;
reg [DATA_WIDTH-1:0] reg_nb_id_5;
reg [DATA_WIDTH-1:0] reg_nb_id_6;
reg [DATA_WIDTH-1:0] reg_nb_id_7;
reg [DATA_WIDTH-1:0] reg_nb_id_8;
reg [DATA_WIDTH-1:0] reg_nb_id_9;
reg [DATA_WIDTH-1:0] reg_nb_id_10;
reg [DATA_WIDTH-1:0] reg_nb_id_11;
reg [DATA_WIDTH-1:0] reg_nb_id_12;
reg [DATA_WIDTH-1:0] reg_nb_id_13;
reg [DATA_WIDTH-1:0] reg_nb_id_14;
reg [DATA_WIDTH-1:0] reg_nb_id_15;
reg [DATA_WIDTH-1:0] reg_nb_id_16;
reg [DATA_WIDTH-1:0] reg_nb_id_delay;

// Disassemble data_out
assign ref_id = data_out[FILTER_BUFFER_DATA_WIDTH-1:FILTER_BUFFER_DATA_WIDTH-ID_WIDTH];
assign nb_id = data_out[FILTER_BUFFER_DATA_WIDTH-ID_WIDTH-1:FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH];
assign ref_id_out = reg_ref_id_delay;
assign nb_id_out = reg_nb_id_delay;
assign x1 = data_out[FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-1:FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-1*DATA_WIDTH];
assign y1 = data_out[FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-1*DATA_WIDTH-1:FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-2*DATA_WIDTH];
assign z1 = data_out[FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-2*DATA_WIDTH-1:FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-3*DATA_WIDTH];
assign x2 = data_out[FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-3*DATA_WIDTH-1:FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-4*DATA_WIDTH];
assign y2 = data_out[FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-4*DATA_WIDTH-1:FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-5*DATA_WIDTH];
assign z2 = data_out[FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-5*DATA_WIDTH-1:FILTER_BUFFER_DATA_WIDTH-2*ID_WIDTH-6*DATA_WIDTH];

always@(posedge clk)
	begin
	if (rst)
		begin
		reg_ref_id_1 <= 0;
		reg_ref_id_2 <= 0;
		reg_ref_id_3 <= 0;
		reg_ref_id_4 <= 0;
		reg_ref_id_5 <= 0;
		reg_ref_id_6 <= 0;
		reg_ref_id_7 <= 0;
		reg_ref_id_8 <= 0;
		reg_ref_id_9 <= 0;
		reg_ref_id_10 <= 0;
		reg_ref_id_11 <= 0;
		reg_ref_id_12 <= 0;
		reg_ref_id_13 <= 0;
		reg_ref_id_14 <= 0;
		reg_ref_id_15 <= 0;
		reg_ref_id_16 <= 0;
		reg_ref_id_delay <= 0;
		
		reg_nb_id_1 <= 0;
		reg_nb_id_2 <= 0;
		reg_nb_id_3 <= 0;
		reg_nb_id_4 <= 0;
		reg_nb_id_5 <= 0;
		reg_nb_id_6 <= 0;
		reg_nb_id_7 <= 0;
		reg_nb_id_8 <= 0;
		reg_nb_id_9 <= 0;
		reg_nb_id_10 <= 0;
		reg_nb_id_11 <= 0;
		reg_nb_id_12 <= 0;
		reg_nb_id_13 <= 0;
		reg_nb_id_14 <= 0;
		reg_nb_id_15 <= 0;
		reg_nb_id_16 <= 0;
		reg_nb_id_delay <= 0;
		end
	else
		begin
		reg_ref_id_1 <= ref_id;
		reg_ref_id_2 <= reg_ref_id_1;
		reg_ref_id_3 <= reg_ref_id_2;
		reg_ref_id_4 <= reg_ref_id_3;
		reg_ref_id_5 <= reg_ref_id_4;
		reg_ref_id_6 <= reg_ref_id_5;
		reg_ref_id_7 <= reg_ref_id_6;
		reg_ref_id_8 <= reg_ref_id_7;
		reg_ref_id_9 <= reg_ref_id_8;
		reg_ref_id_10 <= reg_ref_id_9;
		reg_ref_id_11 <= reg_ref_id_10;
		reg_ref_id_12 <= reg_ref_id_11;
		reg_ref_id_13 <= reg_ref_id_12;
		reg_ref_id_14 <= reg_ref_id_13;
		reg_ref_id_15 <= reg_ref_id_14;
		reg_ref_id_16 <= reg_ref_id_15;
		reg_ref_id_delay <= reg_ref_id_1;
		
		reg_nb_id_1 <= nb_id;
		reg_nb_id_2 <= reg_nb_id_1;
		reg_nb_id_3 <= reg_nb_id_2;
		reg_nb_id_4 <= reg_nb_id_3;
		reg_nb_id_5 <= reg_nb_id_4;
		reg_nb_id_6 <= reg_nb_id_5;
		reg_nb_id_7 <= reg_nb_id_6;
		reg_nb_id_8 <= reg_nb_id_7;
		reg_nb_id_9 <= reg_nb_id_8;
		reg_nb_id_10 <= reg_nb_id_9;
		reg_nb_id_11 <= reg_nb_id_10;
		reg_nb_id_12 <= reg_nb_id_11;
		reg_nb_id_13 <= reg_nb_id_12;
		reg_nb_id_14 <= reg_nb_id_13;
		reg_nb_id_15 <= reg_nb_id_14;
		reg_nb_id_16 <= reg_nb_id_15;
		reg_nb_id_delay <= reg_nb_id_1;
		end
	end

// save the arbitration result for further use
reg  [NUM_FILTER-1:0] prev_arbitration_result;	
always@(posedge clk)
	begin
	prev_arbitration_result <= arbitration_result;
	end

assign all_buffer_empty = buffer_empty == {(NUM_FILTER){1'b1}} ? 1'b1 : 1'b0;


// Choose the data out
always@(posedge clk)
	begin
	case(prev_arbitration_result)
		8'b00000001:
			begin
			data_out <= buffer_rd_data[1*FILTER_BUFFER_DATA_WIDTH-1:0];
			raw_data_valid <= 1'b1;
			end
		8'b00000010:
			begin
			data_out <= buffer_rd_data[2*FILTER_BUFFER_DATA_WIDTH-1:1*FILTER_BUFFER_DATA_WIDTH];
			raw_data_valid <= 1'b1;
			end
		8'b00000100:
			begin
			data_out <= buffer_rd_data[3*FILTER_BUFFER_DATA_WIDTH-1:2*FILTER_BUFFER_DATA_WIDTH];
			raw_data_valid <= 1'b1;
			end
		8'b00001000:
			begin
			data_out <= buffer_rd_data[4*FILTER_BUFFER_DATA_WIDTH-1:3*FILTER_BUFFER_DATA_WIDTH];
			raw_data_valid <= 1'b1;
			end
		8'b00010000:
			begin
			data_out <= buffer_rd_data[5*FILTER_BUFFER_DATA_WIDTH-1:4*FILTER_BUFFER_DATA_WIDTH];
			raw_data_valid <= 1'b1;
			end
		8'b00100000:
			begin
			data_out <= buffer_rd_data[6*FILTER_BUFFER_DATA_WIDTH-1:5*FILTER_BUFFER_DATA_WIDTH];
			raw_data_valid <= 1'b1;
			end
		8'b01000000:
			begin
			data_out <= buffer_rd_data[7*FILTER_BUFFER_DATA_WIDTH-1:6*FILTER_BUFFER_DATA_WIDTH];
			raw_data_valid <= 1'b1;
			end
		8'b10000000:
			begin
			data_out <= buffer_rd_data[8*FILTER_BUFFER_DATA_WIDTH-1:7*FILTER_BUFFER_DATA_WIDTH];
			raw_data_valid <= 1'b1;
			end
		default:
			begin
			data_out <= 0;
			raw_data_valid <= 1'b0;
			end
	endcase
	end
	
	
// 8 filters
genvar i;
generate 
	for(i = 0; i < NUM_FILTER; i = i + 1) begin: Filter_Unit
	filter_logic
	#(
		.DATA_WIDTH(DATA_WIDTH),
		.CELL_ID_WIDTH(CELL_ID_WIDTH),
		.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
		.BODY_BITS(BODY_BITS),
		.SQRT_2(SQRT_2),
		.SQRT_3(SQRT_3),
		.BACK_PRESSURE_THRESHOLD(BACK_PRESSURE_THRESHOLD)
	)
	filter_logic
	(
		.clk(clk),
		.rst(rst),
		.x1(ref_x[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]),
		.y1(ref_y[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]),
		.z1(ref_z[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]), 
		.x2(nb_x[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]),
		.y2(nb_y[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]),
		.z2(nb_z[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]), 
		.cell_id_1(ref_id_in[(i+1)*ID_WIDTH-1:i*ID_WIDTH]),
		.cell_id_2(nb_id_in[(i+1)*ID_WIDTH-1:i*ID_WIDTH]), 
		.buffer_rd_en(arbitration_result[i]), 
		.input_valid(input_valid[i]), 
		
		.buffer_rd_data(buffer_rd_data[(i+1)*FILTER_BUFFER_DATA_WIDTH-1:i*FILTER_BUFFER_DATA_WIDTH]),
		.buffer_empty(buffer_empty[i]),
		.back_pressure(back_pressure[i])
	);
	end
endgenerate

// Filter arbiter
filter_arbiter
#(
	.NUM_FILTER(NUM_FILTER),
	.ARBITER_MSB(ARBITER_MSB)
)
filter_arbiter
(
	.clk(clk),
	.rst(rst),
	.Filter_Available_Flag(~buffer_empty),
	.Arbitration_Result(arbitration_result)
);

// Convert fixed point to floating point
FIXED_TO_FLOAT convert_x1(.a(x1), .q(x1_f), .clk(clk), .areset(reset));
FIXED_TO_FLOAT convert_y1(.a(y1), .q(y1_f), .clk(clk), .areset(reset));
FIXED_TO_FLOAT convert_z1(.a(z1), .q(z1_f), .clk(clk), .areset(reset));
FIXED_TO_FLOAT convert_x2(.a(x2), .q(x2_f), .clk(clk), .areset(reset));
FIXED_TO_FLOAT convert_y2(.a(y2), .q(y2_f), .clk(clk), .areset(reset));
FIXED_TO_FLOAT convert_z2(.a(z2), .q(z2_f), .clk(clk), .areset(reset));

r2_compute
#(
	.DATA_WIDTH(DATA_WIDTH)
)
r2_compute
(
	.clk(clk),
	.rst(rst),
	.enable(raw_data_valid),
	.refx(x1_f),
	.refy(y1_f),
	.refz(z1_f),
	.neighborx(x2_f),
	.neighbory(y2_f),
	.neighborz(z2_f),
	.r2(r2_out),
	.dx_out(dx_out),
	.dy_out(dy_out),
	.dz_out(dz_out),
	.r2_valid(out_valid)
);


endmodule