///////////////////////////////////////////////////////////////////////////////
// Simplified position data distributor module.
// - No longer assembles position data from multiple neighbors into a single
//   vector.
// - Instead only sends particle position data from home cell because the 
//   home cell particles are iterated over while keeping multiple neighbor 
//   particles as reference.
///////////////////////////////////////////////////////////////////////////////
module pos_data_distributor_simplified
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
	input [(NUM_NEIGHBOR_CELLS+1)*3*OFFSET_WIDTH-1:0] rd_nb_position, 
	// 2 phases, read home cell in both phases 
	input phase, 
	// If back pressure happens, pause reading
	input pause_reading, 
	// If done broadcasting, set the neighbor particle to invalid
	input [NUM_NEIGHBOR_CELLS:0] broadcast_done, 
	// If the reference particle has just been read, set invalid since it does not interact with itself
	input read_ref_particle, 
	// If the reference particle is invalid, all neighbor particles are invalid
	input [NUM_FILTER-1:0] ref_valid, 
	
	output reg [NUM_FILTER-1:0] pair_valid, 
	output [3*DATA_WIDTH-1:0] assembled_position 
);

wire [OFFSET_WIDTH-1:0] position_x, position_y, position_z;

assign position_x = rd_nb_position[0*OFFSET_WIDTH +: OFFSET_WIDTH];
assign position_y = rd_nb_position[1*OFFSET_WIDTH +: OFFSET_WIDTH];
assign position_z = rd_nb_position[2*OFFSET_WIDTH +: OFFSET_WIDTH];

assign assembled_position = {CELL_2, position_z, CELL_2, position_y, CELL_2, position_x};

// If done broadcasting, set invalid. If ref invalid, set invalid, special control for home cell
always@(*)
	begin
	if (~pause_reading)
		begin
		if (phase == 1'b0)
			begin
			pair_valid[0] = ~broadcast_done[0] & ~read_ref_particle & ref_valid[0];
			pair_valid[6:1] = ~broadcast_done[6:1] & ref_valid[6:1];
			end
		else
			begin
			pair_valid = ~broadcast_done[13:7] & ref_valid;
			end
		end
	else
		begin
		pair_valid = 0;
		end
	end

endmodule
