////////////////////////////////////////////////////////////////////////////////////////////////
// It takes the data read from the position caches (14 cells) and assemble the data in the 
// format (7 cells) that can be read by the filters. 
// Also, it generates the local cell id for the force evaluation unit, so no need to consider PBC
// 
// Phase 0: {312,231,233,311,313,331,222}
// Phase 1: {321,332,323,322,232,223,333}
// Type:     22  22  22  31  31  31  03
////////////////////////////////////////////////////////////////////////////////////////////////

module pos_data_distributor
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
	// Order: MSB->LSB {333,332,331,323,322,321,313,312,311,233,232,231,223,222} Homecell is on LSB side
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
			pair_valid[1] = ~(broadcast_done[11]);
			pair_valid[2] = ~(broadcast_done[7]);
			pair_valid[3] = ~(broadcast_done[5]);
			pair_valid[4] = ~(broadcast_done[4]);
			pair_valid[5] = ~(broadcast_done[2]);
			pair_valid[6] = ~(broadcast_done[6]);
			// Order: Z, Y, X
			nb_cell_id[1*FULL_CELL_ID_WIDTH-1:0*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_2, CELL_2};
			nb_cell_id[2*FULL_CELL_ID_WIDTH-1:1*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_3, CELL_3};
			nb_cell_id[3*FULL_CELL_ID_WIDTH-1:2*FULL_CELL_ID_WIDTH] = {CELL_3, CELL_1, CELL_3};
			nb_cell_id[4*FULL_CELL_ID_WIDTH-1:3*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_1, CELL_3};
			nb_cell_id[5*FULL_CELL_ID_WIDTH-1:4*FULL_CELL_ID_WIDTH] = {CELL_3, CELL_3, CELL_2};
			nb_cell_id[6*FULL_CELL_ID_WIDTH-1:5*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_3, CELL_2};
			nb_cell_id[7*FULL_CELL_ID_WIDTH-1:6*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_1, CELL_3};
			end
		else
			begin
			pair_valid[0] = ~(broadcast_done[13]);
			pair_valid[1] = ~(broadcast_done[1]);
			pair_valid[2] = ~(broadcast_done[3]);
			pair_valid[3] = ~(broadcast_done[9]);
			pair_valid[4] = ~(broadcast_done[10]);
			pair_valid[5] = ~(broadcast_done[12]);
			pair_valid[6] = ~(broadcast_done[8]);
			nb_cell_id[1*FULL_CELL_ID_WIDTH-1:0*FULL_CELL_ID_WIDTH] = {CELL_3, CELL_3, CELL_3};
			nb_cell_id[2*FULL_CELL_ID_WIDTH-1:1*FULL_CELL_ID_WIDTH] = {CELL_3, CELL_2, CELL_2};
			nb_cell_id[3*FULL_CELL_ID_WIDTH-1:2*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_3, CELL_2};
			nb_cell_id[4*FULL_CELL_ID_WIDTH-1:3*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_2, CELL_3};
			nb_cell_id[5*FULL_CELL_ID_WIDTH-1:4*FULL_CELL_ID_WIDTH] = {CELL_3, CELL_2, CELL_3};
			nb_cell_id[6*FULL_CELL_ID_WIDTH-1:5*FULL_CELL_ID_WIDTH] = {CELL_2, CELL_3, CELL_3};
			nb_cell_id[7*FULL_CELL_ID_WIDTH-1:6*FULL_CELL_ID_WIDTH] = {CELL_1, CELL_2, CELL_3};
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
genvar i;
generate
	for (i = 0; i < 3; i = i + 1)
		begin: pos_assembler
		assign assembled_position[0*3*DATA_WIDTH+(i+1)*DATA_WIDTH-1:0*3*DATA_WIDTH+i*DATA_WIDTH] = 
			(phase == 1'b0) ? {nb_cell_id[0*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:0*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[0*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:0*3*OFFSET_WIDTH+i*OFFSET_WIDTH]} : 
									{nb_cell_id[0*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:0*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[13*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:13*3*OFFSET_WIDTH+i*OFFSET_WIDTH]};
		assign assembled_position[1*3*DATA_WIDTH+(i+1)*DATA_WIDTH-1:1*3*DATA_WIDTH+i*DATA_WIDTH] = 
			(phase == 1'b0) ? {nb_cell_id[1*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:1*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[11*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:11*3*OFFSET_WIDTH+i*OFFSET_WIDTH]} : 
									{nb_cell_id[1*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:1*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[1*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:1*3*OFFSET_WIDTH+i*OFFSET_WIDTH]};
		assign assembled_position[2*3*DATA_WIDTH+(i+1)*DATA_WIDTH-1:2*3*DATA_WIDTH+i*DATA_WIDTH] = 
			(phase == 1'b0) ? {nb_cell_id[2*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:2*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[7*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:7*3*OFFSET_WIDTH+i*OFFSET_WIDTH]} : 
									{nb_cell_id[2*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:2*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[3*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:3*3*OFFSET_WIDTH+i*OFFSET_WIDTH]};
		assign assembled_position[3*3*DATA_WIDTH+(i+1)*DATA_WIDTH-1:3*3*DATA_WIDTH+i*DATA_WIDTH] = 
			(phase == 1'b0) ? {nb_cell_id[3*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:3*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[5*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:5*3*OFFSET_WIDTH+i*OFFSET_WIDTH]} : 
									{nb_cell_id[3*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:3*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[9*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:9*3*OFFSET_WIDTH+i*OFFSET_WIDTH]};
		assign assembled_position[4*3*DATA_WIDTH+(i+1)*DATA_WIDTH-1:4*3*DATA_WIDTH+i*DATA_WIDTH] = 
			(phase == 1'b0) ? {nb_cell_id[4*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:4*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[4*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:4*3*OFFSET_WIDTH+i*OFFSET_WIDTH]} : 
									{nb_cell_id[4*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:4*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[10*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:10*3*OFFSET_WIDTH+i*OFFSET_WIDTH]};
		assign assembled_position[5*3*DATA_WIDTH+(i+1)*DATA_WIDTH-1:5*3*DATA_WIDTH+i*DATA_WIDTH] = 
			(phase == 1'b0) ? {nb_cell_id[5*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:5*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[2*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:2*3*OFFSET_WIDTH+i*OFFSET_WIDTH]} : 
									{nb_cell_id[5*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:5*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[12*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:12*3*OFFSET_WIDTH+i*OFFSET_WIDTH]};
		assign assembled_position[6*3*DATA_WIDTH+(i+1)*DATA_WIDTH-1:6*3*DATA_WIDTH+i*DATA_WIDTH] = 
			(phase == 1'b0) ? {nb_cell_id[6*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:6*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[6*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:6*3*OFFSET_WIDTH+i*OFFSET_WIDTH]} : 
									{nb_cell_id[6*FULL_CELL_ID_WIDTH+(i+1)*CELL_ID_WIDTH-1:6*FULL_CELL_ID_WIDTH+i*CELL_ID_WIDTH], 
									rd_nb_position[8*3*OFFSET_WIDTH+(i+1)*OFFSET_WIDTH-1:8*3*OFFSET_WIDTH+i*OFFSET_WIDTH]};
		end
	endgenerate
//assign assembled_position[1*DATA_WIDTH-1:0] = (phase == 1'b0) ? {CELL_2, rd_nb_position[1*OFFSET_WIDTH-1:0]} : rd_nb_position[14*3*OFFSET_WIDTH-1:13*3*OFFSET_WIDTH];
//assign assembled_position[2*3*DATA_WIDTH-1:1*3*DATA_WIDTH] = (phase == 1'b0) ? rd_nb_position[12*3*DATA_WIDTH-1:11*3*DATA_WIDTH] : rd_nb_position[2*3*DATA_WIDTH-1:1*3*DATA_WIDTH];
//assign assembled_position[3*3*DATA_WIDTH-1:2*3*DATA_WIDTH] = (phase == 1'b0) ? rd_nb_position[8*3*DATA_WIDTH-1:7*3*DATA_WIDTH] : rd_nb_position[4*3*DATA_WIDTH-1:3*3*DATA_WIDTH];
//assign assembled_position[4*3*DATA_WIDTH-1:3*3*DATA_WIDTH] = (phase == 1'b0) ? rd_nb_position[6*3*DATA_WIDTH-1:5*3*DATA_WIDTH] : rd_nb_position[10*3*DATA_WIDTH-1:9*3*DATA_WIDTH];
//assign assembled_position[5*3*DATA_WIDTH-1:4*3*DATA_WIDTH] = (phase == 1'b0) ? rd_nb_position[5*3*DATA_WIDTH-1:4*3*DATA_WIDTH] : rd_nb_position[11*3*DATA_WIDTH-1:10*3*DATA_WIDTH];
//assign assembled_position[6*3*DATA_WIDTH-1:5*3*DATA_WIDTH] = (phase == 1'b0) ? rd_nb_position[3*3*DATA_WIDTH-1:2*3*DATA_WIDTH] : rd_nb_position[13*3*DATA_WIDTH-1:12*3*DATA_WIDTH];
//assign assembled_position[7*3*DATA_WIDTH-1:6*3*DATA_WIDTH] = (phase == 1'b0) ? rd_nb_position[7*3*DATA_WIDTH-1:6*3*DATA_WIDTH] : rd_nb_position[9*3*DATA_WIDTH-1:8*3*DATA_WIDTH];

endmodule