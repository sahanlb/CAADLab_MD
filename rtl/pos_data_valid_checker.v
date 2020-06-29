/////////////////////////////////////////////////////////////////////
// This module checks if the reference particle is valid, and checks
// if a home cell particle is valid as a neighbor particle. 
/////////////////////////////////////////////////////////////////////

module pos_data_valid_checker
#(
	parameter PARTICLE_ID_WIDTH = 7
)
(
	input phase, 
	input reading_particle_num, 
	input [PARTICLE_ID_WIDTH-1:0] ref_id, 
	input [PARTICLE_ID_WIDTH-1:0] particle_id, 
	input [PARTICLE_ID_WIDTH-1:0] ref_particle_num, 
	
	output ref_not_read_yet, 
	output reading_done, 
	output ref_valid
);

// If phase 1, the bit is disabled in pos_data_distributor
assign ref_not_read_yet = (ref_id < particle_id) ? 1'b0 : 1'b1;
assign reading_done = (ref_id > ref_particle_num && ref_particle_num != 0) ? 1'b1 : 1'b0;
// If reading number of particles, all pairs should be invalid 
assign ref_valid = (ref_id > ref_particle_num || reading_particle_num) ? 1'b0 : 1'b1;

endmodule