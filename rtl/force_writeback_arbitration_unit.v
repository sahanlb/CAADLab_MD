////////////////////////////////////////////////////////////////////////////////////////////
// Accepts partial force data from PEs, then send the arbitration result back to PEs
// Based on arbitration result, select the chosen forces. If none chosen, set write disabled
////////////////////////////////////////////////////////////////////////////////////////////

module force_writeback_arbitration_unit
#(
	parameter NUM_CELLS = 64, 
	parameter NUM_NEIGHBOR_CELLS = 13, 
	parameter NUM_FILTER = 7, 
	parameter DATA_WIDTH = 32,
	parameter CELL_ID_WIDTH = 3,
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH,
	parameter FORCE_BUFFER_WIDTH = 3*DATA_WIDTH+PARTICLE_ID_WIDTH+1, 
	parameter FORCE_DATA_WIDTH = FORCE_BUFFER_WIDTH-1
)
(
	input clk, 
	input rst, 
	input [NUM_CELLS*NUM_FILTER*FORCE_BUFFER_WIDTH-1:0] force_data, 
	input [NUM_CELLS*NUM_FILTER-1:0] force_valid, 
	
	output [NUM_CELLS*FORCE_DATA_WIDTH-1:0] force_to_caches, 
	output [NUM_CELLS-1:0] force_wr_enable, 
	output [NUM_CELLS*NUM_FILTER-1:0] force_cache_write_success
);

wire [NUM_CELLS*NUM_FILTER*FORCE_DATA_WIDTH-1:0] force_and_addr;
wire [NUM_CELLS*NUM_FILTER-1:0] force_dst;

// Arbiter input
wire [NUM_CELLS*(NUM_NEIGHBOR_CELLS+1)-1:0] force_wr_enable_splitted;
wire [NUM_CELLS*(NUM_NEIGHBOR_CELLS+1)-1:0] arbitration_result;

// Disassemble input data {addr, force, dst}
genvar i;
generate
	for (i = 0; i < NUM_CELLS*NUM_FILTER; i = i + 1)
		begin: input_data_disassemble
		assign force_and_addr[(i+1)*FORCE_DATA_WIDTH-1:i*FORCE_DATA_WIDTH] = 
				 force_data[(i+1)*FORCE_BUFFER_WIDTH-1:i*FORCE_BUFFER_WIDTH+1];
		assign force_dst[i] = force_data[i*FORCE_BUFFER_WIDTH];
		end
endgenerate

// It's possible that a force cache is requested writing by all 14 PEs, so 14 entries
genvar j;
generate
	for (j = 0; j < NUM_CELLS; j = j + 1)
		begin: force_writeback_arbiters
		force_writeback_arbiter
		#(
			.FORCE_WTADDR_ARBITER_SIZE(NUM_NEIGHBOR_CELLS+1),
			.FORCE_WTADDR_ARBITER_MSB(14'b10000000000000)
		)
		force_writeback_arbiter
		(
			.clk(clk),
			.rst(rst),
			.enable(force_wr_enable_splitted[(j+1)*(NUM_NEIGHBOR_CELLS+1)-1:j*(NUM_NEIGHBOR_CELLS+1)]),
			
			.Arbitration_Result(arbitration_result[(j+1)*(NUM_NEIGHBOR_CELLS+1)-1:j*(NUM_NEIGHBOR_CELLS+1)])
		);
		// If arbitration result is not 0, there must be one force chosen to be written
		assign force_wr_enable[j] = (arbitration_result[(j+1)*(NUM_NEIGHBOR_CELLS+1)-1:j*(NUM_NEIGHBOR_CELLS+1)] == 0) ? 1'b0 : 1'b1;
		end
endgenerate

// force valid to force wr enable splitted mapping (
force_valid_to_enable_mapping
#(
	.NUM_CELLS(NUM_CELLS),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.NUM_FILTER(NUM_FILTER)
)
force_valid_to_enable_mapping
(
	.force_valid(force_valid),
	.force_dst(force_dst),
	
	.force_wr_enable_splitted(force_wr_enable_splitted)
);

// arbitration result to write success mapping, reversed mapping as valid-to-enable
arbitration_to_success_mapping
#(
	.NUM_CELLS(NUM_CELLS),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.NUM_FILTER(NUM_FILTER)
)
arbitration_to_success_mapping
(
	.arbitration_result(arbitration_result), 
	
	.force_cache_write_success(force_cache_write_success)
);

// force to valid force mapping based on arbitration result
force_to_valid_force_mapping
#(
	.DATA_WIDTH(DATA_WIDTH),
	.NUM_CELLS(NUM_CELLS),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.NUM_FILTER(NUM_FILTER), 
	.FORCE_BUFFER_WIDTH(FORCE_BUFFER_WIDTH), 
	.FORCE_DATA_WIDTH(FORCE_DATA_WIDTH)
)
force_to_valid_force_mapping
(
	.arbitration_result(arbitration_result), 
	.force_and_addr(force_and_addr),
	
	.force_to_caches(force_to_caches)
);

endmodule