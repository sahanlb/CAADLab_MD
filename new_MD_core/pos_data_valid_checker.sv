/////////////////////////////////////////////////////////////////////
// This module checks if the reference particle is valid, and checks
// if a home cell particle is valid as a neighbor particle. 
/////////////////////////////////////////////////////////////////////
import md_pkg::*;

module pos_data_valid_checker(
	input phase, 
	input reading_particle_num, 
	input particle_id_t ref_id, 
	input particle_id_t particle_id, 
	input particle_id_t ref_particle_count, 
	
	output ref_particle_read, 
	output reading_done, 
	output ref_valid
);

// If phase 1, the bit is disabled in pos_data_distributor
assign ref_particle_read = (particle_id > ref_id);

assign reading_done = (ref_id > ref_particle_count) & (ref_particle_count != 0);
// If reading number of particles, all pairs should be invalid 
assign ref_valid = ref_id < ref_particle_count & ~reading_particle_num;

endmodule
