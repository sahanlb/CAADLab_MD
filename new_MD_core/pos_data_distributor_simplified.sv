///////////////////////////////////////////////////////////////////////////////
// Simplified position data distributor module.
// - No longer assembles position data from multiple neighbors into a single
//   vector.
// - Instead only sends particle position data from home cell because the 
//   home cell particles are iterated over while keeping multiple neighbor 
//   particles as reference.
///////////////////////////////////////////////////////////////////////////////
import md_pkg::*;

module pos_data_distributor_simplified(
	input  clk, 
  input offset_tuple_t rd_nb_position,
	// 2 phases, read home cell in both phases 
	input phase, 
	// If back pressure happens, pause reading
	input pause_reading, 
	// If done broadcasting, set the neighbor particle to invalid
	input [NUM_NEIGHBOR_CELLS:0] broadcast_done, 
	// If the reference particle has just been read, set invalid since it does not interact with itself
	input ref_particle_read, 
	// If the reference particle is invalid, all neighbor particles are invalid
	input [NUM_FILTER-1:0] ref_valid, 
	
	output reg [NUM_FILTER-1:0] pair_valid, 
	output data_tuple_t assembled_position 
);

assign assembled_position = {CELL_2, rd_nb_position.offset_z, CELL_2, rd_nb_position.offset_y, CELL_2, rd_nb_position.offset_x};

// If done broadcasting, set invalid. If ref invalid, set invalid, special control for home cell
always_comb
	begin
	if (~pause_reading)
		begin
		if (phase == 1'b0)
			begin
			pair_valid[0] = ~broadcast_done[0] & ref_particle_read & ref_valid[0];
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
