/////////////////////////////////////////////////////////////////////////
// Not half-shell any more
// Instead, use scattered cells
//
// Phase 0: {222, 123, 332, 211, 131, 331, 311}
// Phase 1: {111, 121, 231, 212, 322, 212, 223}
// Type:     03   22   22   22   31   31   31
//
// Cell ID order (MSB to LSB): 
// 223, 212, 322, 212, 231, 121, 111, 311, 331, 131, 211, 332, 123, 222
/////////////////////////////////////////////////////////////////////////
module pos_data_distributor_disorder
#(
	// Data width
	// OFFSET_WIDTH is the data width from position RAMs
	parameter OFFSET_WIDTH = 29, 
	parameter DATA_WIDTH = 32,
	parameter NUM_NEIGHBOR_CELLS = 13,
	parameter CELL_ID_WIDTH = 3, 
	parameter FULL_CELL_ID_WIDTH = 3*CELL_ID_WIDTH, 
	parameter NUM_FILTER = 7, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter CELL_1 = 3'b001, 
	parameter CELL_2 = 3'b010, 
	parameter CELL_3 = 3'b011
)
(
	input  clk, 
	// Order: MSB->LSB {223, 212, 322, 212, 231, 121, 111, 311, 331, 131, 211, 332, 123, 222} 
	// Order: ZYX		 {322, 212, 223, 231, 132, 121, 111, 113, 133, 131, 112, 233, 321, 222}
	// Homecell is on LSB side
	input [(NUM_NEIGHBOR_CELLS+1)*3*OFFSET_WIDTH-1:0] rd_nb_position, 
	// 2 phases, for each phase 7 neighbor cells are being read from. 
	input phase, 
	// If back pressure happens, pause reading
	input pause_reading, 
	// If done broadcasting, set the neighbor particle to invalid
	input [NUM_NEIGHBOR_CELLS:0] broadcast_done, 
	// If the reference particle has just been read, set invalid since it does not interact with itself
	input ref_not_read_yet, 
	// If the reference particle is invalid, all neighbor particles are invalid
	input ref_valid, 
	
	output reg [NUM_FILTER-1:0] pair_valid, 
	output [NUM_FILTER*3*DATA_WIDTH-1:0] assembled_position 
);

reg [3*CELL_ID_WIDTH*NUM_FILTER-1:0] nb_cell_id;

// If done broadcasting, set invalid. If ref invalid, set invalid, special control for home cell
always@(*)
	begin
	if (ref_valid && ~pause_reading)
		begin
		if (phase == 1'b0)
			begin
			pair_valid[0] = ~(broadcast_done[0] || ref_not_read_yet);
			pair_valid[6:1] = ~broadcast_done[6:1];
			// Order: Z, Y, X
			nb_cell_id[1*FULL_CELL_ID_WIDTH-1:0*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_2, CELL_2};
			nb_cell_id[2*FULL_CELL_ID_WIDTH-1:1*FULL_CELL_ID_WIDTH] = {CELL_3, CELL_2, CELL_1};
			nb_cell_id[3*FULL_CELL_ID_WIDTH-1:2*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_3, CELL_3};
			nb_cell_id[4*FULL_CELL_ID_WIDTH-1:3*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_1, CELL_2};
			nb_cell_id[5*FULL_CELL_ID_WIDTH-1:4*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_3, CELL_1};
			nb_cell_id[6*FULL_CELL_ID_WIDTH-1:5*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_3, CELL_3};
			nb_cell_id[7*FULL_CELL_ID_WIDTH-1:6*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_1, CELL_3};
			end
		else
			begin
			pair_valid = ~broadcast_done[13:7];
			nb_cell_id[1*FULL_CELL_ID_WIDTH-1:0*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_1, CELL_1};
			nb_cell_id[2*FULL_CELL_ID_WIDTH-1:1*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_2, CELL_1};
			nb_cell_id[3*FULL_CELL_ID_WIDTH-1:2*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_3, CELL_2};
			nb_cell_id[4*FULL_CELL_ID_WIDTH-1:3*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_3, CELL_1};
			nb_cell_id[5*FULL_CELL_ID_WIDTH-1:4*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_2, CELL_3};
			nb_cell_id[6*FULL_CELL_ID_WIDTH-1:5*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_1, CELL_2};
			nb_cell_id[7*FULL_CELL_ID_WIDTH-1:6*FULL_CELL_ID_WIDTH] = {CELL_3, CELL_2, CELL_2};
			end
		end
	else
		begin
		pair_valid = 0;
		nb_cell_id = 0;
		end
	end
	
// Distribute based on phase, 0, 11, 7, 5, 4, 2, 6, 13, 1, 3, 9, 10, 12, 8
// Each 32 bit data consists of 3 bit cell id and 29 bit offset
genvar i, j;
generate
	for (i = 0; i < NUM_FILTER; i = i + 1)
		begin: pos_assembler
		for (j = 0; j < 3; j = j + 1)
			begin: pos_assembler_xyz
		assign assembled_position[i*3*DATA_WIDTH+(j+1)*DATA_WIDTH-1:i*3*DATA_WIDTH+j*DATA_WIDTH] = 
			(phase == 1'b0) ? {nb_cell_id[i*FULL_CELL_ID_WIDTH+(j+1)*CELL_ID_WIDTH-1:i*FULL_CELL_ID_WIDTH+j*CELL_ID_WIDTH], 
									rd_nb_position[i*3*OFFSET_WIDTH+(j+1)*OFFSET_WIDTH-1:i*3*OFFSET_WIDTH+j*OFFSET_WIDTH]} : 
									{nb_cell_id[i*FULL_CELL_ID_WIDTH+(j+1)*CELL_ID_WIDTH-1:i*FULL_CELL_ID_WIDTH+j*CELL_ID_WIDTH], 
									rd_nb_position[(i+NUM_FILTER)*3*OFFSET_WIDTH+(j+1)*OFFSET_WIDTH-1:(i+NUM_FILTER)*3*OFFSET_WIDTH+j*OFFSET_WIDTH]};
			end
		end
endgenerate

endmodule