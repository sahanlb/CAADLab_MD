module all_force_caches
#(
	parameter NUM_CELLS = 64, 
	parameter DATA_WIDTH = 32,
	parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter FORCE_CACHE_DEPTH = 128, 
	parameter FORCE_DATA_WIDTH = FORCE_CACHE_WIDTH+PARTICLE_ID_WIDTH
)
(
	input clk, 
	input rst, 
	input [NUM_CELLS-1:0] motion_updata_rd_request,
	input [PARTICLE_ID_WIDTH-1:0]motion_update_rd_addr,
	input [NUM_CELLS*FORCE_DATA_WIDTH-1:0] force_and_addr_in,
	input [NUM_CELLS-1:0] force_wr_enable, 
	
	output all_force_input_buffer_empty, 
	output [NUM_CELLS*FORCE_CACHE_WIDTH-1:0] force_to_MU,
	output [NUM_CELLS*PARTICLE_ID_WIDTH-1:0] force_id_to_MU,
	output [NUM_CELLS-1:0] force_valid_to_MU
);

wire [NUM_CELLS*FORCE_CACHE_WIDTH-1:0] force_in;
wire [NUM_CELLS*PARTICLE_ID_WIDTH-1:0] particle_id_in;
wire [NUM_CELLS-1:0] force_input_buffer_empty;

assign all_force_input_buffer_empty = (~force_input_buffer_empty == 0);

genvar i;
generate
	for (i = 0; i < NUM_CELLS; i = i + 1)
		begin: force_caches
		assign force_in[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] = force_and_addr_in[i*FORCE_DATA_WIDTH+FORCE_CACHE_WIDTH-1:i*FORCE_DATA_WIDTH];
		assign particle_id_in[(i+1)*PARTICLE_ID_WIDTH-1:i*PARTICLE_ID_WIDTH] = force_and_addr_in[(i+1)*FORCE_DATA_WIDTH-1:i*FORCE_DATA_WIDTH+FORCE_CACHE_WIDTH];
		force_wb_controller
		#(
			.DATA_WIDTH(DATA_WIDTH),
			.FORCE_CACHE_WIDTH(FORCE_CACHE_WIDTH),
			.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
			.FORCE_CACHE_DEPTH(FORCE_CACHE_DEPTH),
			.FORCE_DATA_WIDTH(FORCE_DATA_WIDTH)
		)
		force_wb_controller
		(
			.clk(clk),
			.rst(rst),
			.wr_enable(force_wr_enable[i]),
			.rd_enable(motion_updata_rd_request[i]),
			.force_to_cache(force_in[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH]),
			.force_wr_addr(particle_id_in[(i+1)*PARTICLE_ID_WIDTH-1:i*PARTICLE_ID_WIDTH]),
			.force_rd_addr(motion_update_rd_addr),
			
			.input_buffer_empty(force_input_buffer_empty[i]), 
			.force_to_MU(force_to_MU[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH]),
			.force_id_to_MU(force_id_to_MU[(i+1)*PARTICLE_ID_WIDTH-1:i*PARTICLE_ID_WIDTH]),
			.force_valid_to_MU(force_valid_to_MU[i])
		);
		end
endgenerate

endmodule