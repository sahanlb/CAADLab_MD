import md_pkg::offset_tuple_t;
import md_pkg::full_cell_id_t;

module all_position_caches
#(
	parameter NUM_CELLS = 64, 
	parameter DATA_WIDTH = 29, 
	parameter CELL_ID_WIDTH = 3,
	parameter NUM_PARTICLE_PER_CELL = 128, 
	parameter PARTICLE_ID_WIDTH = 7
)
(
	input clk,
	input rst,
	input Motion_Update_enable,
	input [PARTICLE_ID_WIDTH-1:0] MU_rd_addr,
	input [PARTICLE_ID_WIDTH-1:0] rd_addr,
	input offset_tuple_t MU_wr_data,
	input full_cell_id_t MU_dst_cell,
	input MU_wr_data_valid,
	input MU_rden,
	
	output offset_tuple_t [NUM_CELLS-1:0] pos_data_out
);

`include "define.v"
	

`POS_CACHE_INSTANCE(1,1,1)
`POS_CACHE_INSTANCE(2,1,1)
`POS_CACHE_INSTANCE(3,1,1)
`POS_CACHE_INSTANCE(4,1,1)
`POS_CACHE_INSTANCE(1,2,1)
`POS_CACHE_INSTANCE(2,2,1)
`POS_CACHE_INSTANCE(3,2,1)
`POS_CACHE_INSTANCE(4,2,1)
`POS_CACHE_INSTANCE(1,3,1)
`POS_CACHE_INSTANCE(2,3,1)
`POS_CACHE_INSTANCE(3,3,1)
`POS_CACHE_INSTANCE(4,3,1)
`POS_CACHE_INSTANCE(1,4,1)
`POS_CACHE_INSTANCE(2,4,1)
`POS_CACHE_INSTANCE(3,4,1)
`POS_CACHE_INSTANCE(4,4,1)

`POS_CACHE_INSTANCE(1,1,2)
`POS_CACHE_INSTANCE(2,1,2)
`POS_CACHE_INSTANCE(3,1,2)
`POS_CACHE_INSTANCE(4,1,2)
`POS_CACHE_INSTANCE(1,2,2)
`POS_CACHE_INSTANCE(2,2,2)
`POS_CACHE_INSTANCE(3,2,2)
`POS_CACHE_INSTANCE(4,2,2)
`POS_CACHE_INSTANCE(1,3,2)
`POS_CACHE_INSTANCE(2,3,2)
`POS_CACHE_INSTANCE(3,3,2)
`POS_CACHE_INSTANCE(4,3,2)
`POS_CACHE_INSTANCE(1,4,2)
`POS_CACHE_INSTANCE(2,4,2)
`POS_CACHE_INSTANCE(3,4,2)
`POS_CACHE_INSTANCE(4,4,2)

`POS_CACHE_INSTANCE(1,1,3)
`POS_CACHE_INSTANCE(2,1,3)
`POS_CACHE_INSTANCE(3,1,3)
`POS_CACHE_INSTANCE(4,1,3)
`POS_CACHE_INSTANCE(1,2,3)
`POS_CACHE_INSTANCE(2,2,3)
`POS_CACHE_INSTANCE(3,2,3)
`POS_CACHE_INSTANCE(4,2,3)
`POS_CACHE_INSTANCE(1,3,3)
`POS_CACHE_INSTANCE(2,3,3)
`POS_CACHE_INSTANCE(3,3,3)
`POS_CACHE_INSTANCE(4,3,3)
`POS_CACHE_INSTANCE(1,4,3)
`POS_CACHE_INSTANCE(2,4,3)
`POS_CACHE_INSTANCE(3,4,3)
`POS_CACHE_INSTANCE(4,4,3)

`POS_CACHE_INSTANCE(1,1,4)
`POS_CACHE_INSTANCE(2,1,4)
`POS_CACHE_INSTANCE(3,1,4)
`POS_CACHE_INSTANCE(4,1,4)
`POS_CACHE_INSTANCE(1,2,4)
`POS_CACHE_INSTANCE(2,2,4)
`POS_CACHE_INSTANCE(3,2,4)
`POS_CACHE_INSTANCE(4,2,4)
`POS_CACHE_INSTANCE(1,3,4)
`POS_CACHE_INSTANCE(2,3,4)
`POS_CACHE_INSTANCE(3,3,4)
`POS_CACHE_INSTANCE(4,3,4)
`POS_CACHE_INSTANCE(1,4,4)
`POS_CACHE_INSTANCE(2,4,4)
`POS_CACHE_INSTANCE(3,4,4)
`POS_CACHE_INSTANCE(4,4,4)
	
endmodule
