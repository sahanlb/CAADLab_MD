import md_pkg::*;

module all_force_caches(
	input clk, 
	input rst, 
	input [NUM_CELLS-1:0] motion_updata_rd_request,
	input particle_id_t motion_update_rd_addr,
	input force_data_t [NUM_CELLS-1:0] force_and_addr_in,
	input [NUM_CELLS-1:0] force_wr_enable, 
	
	output all_force_input_buffer_empty, 
	output data_tuple_t [NUM_CELLS-1:0] force_to_MU,
	output particle_id_t [NUM_CELLS-1:0] force_id_to_MU,
	output [NUM_CELLS-1:0] force_valid_to_MU
);

localparam FORCE_CACHE_WIDTH = 3*DATA_WIDTH;
localparam FORCE_CACHE_DEPTH = NUM_PARTICLE_PER_CELL;
localparam FORCE_DATA_WIDTH  = FORCE_CACHE_WIDTH+PARTICLE_ID_WIDTH;

wire [NUM_CELLS-1:0] force_input_buffer_empty;

assign all_force_input_buffer_empty = &force_input_buffer_empty;

genvar i;
generate
	for (i = 0; i < NUM_CELLS; i = i + 1)begin: force_caches
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
			.force_to_cache(force_and_addr_in[i].force_val),
			.force_wr_addr(force_and_addr_in[i].particle_id),
			.force_rd_addr(motion_update_rd_addr),
			
			.input_buffer_empty(force_input_buffer_empty[i]), 
			.force_to_MU(force_to_MU[i]),
			.force_id_to_MU(force_id_to_MU[i]),
			.force_valid_to_MU(force_valid_to_MU[i])
		); 
	end
endgenerate

endmodule
