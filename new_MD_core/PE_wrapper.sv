///////////////////////////////////////////////////////////////////////////////////////////////
// Take all the available data for granted, connects the force pipeline with other components
// Determine all the valid signals (ref_not_read_yet and ref_valid)
// Extract useful data from the broadcasted data
///////////////////////////////////////////////////////////////////////////////////////////////
import md_pkg::*;

module PE_wrapper(
	input clk, 
	input rst, 
	// All PEs have a synchronized phase, so use a global phase
	input phase, 
	input pause_reading, 
	input reading_particle_num, 
	// From data source
	input offset_tuple_t [NUM_NEIGHBOR_CELLS:0] rd_nb_position, 
	input particle_id_t particle_id, 
	input particle_id_t ref_particle_id, 
  //from ring interconnect
  input ready,
	
	// From preprocessor
	output reading_done, 
	output particle_id_t ref_particle_num, 
	// From force evaluation
	output back_pressure,
	output all_buffer_empty,
	output force_wb_t force_data_out, 
	output output_force_valid,
  // From force_distributor
  output all_ref_wb_issued
);


data_tuple_t [NUM_FILTER-1:0] ref_pos;
wire particle_id_t delay_particle_id;
wire particle_id_t delay_ref_id;
wire [NUM_FILTER-1:0] pair_valid;
data_tuple_t assembled_position;

// Back pressure status of each filter
wire [NUM_FILTER-1:0] filter_back_pressure;
assign back_pressure = |filter_back_pressure;

full_id_t [NUM_FILTER-1:0] out_ref_particle_id;
data_tuple_t ref_force;
wire [NUM_FILTER-1:0] ref_force_valid;
full_id_t out_neighbor_particle_id;
data_tuple_t nb_force;
wire nb_force_valid;
wire prev_phase;
wire start_wb;

// Prepare the data for force evaluation unit
pos_data_preprocessor
pos_data_preprocessor(
	.clk(clk),
	.rst(rst),
	.phase(phase),
	.pause_reading(pause_reading), 
	.reading_particle_num(reading_particle_num),
	.rd_nb_position(rd_nb_position),
	.particle_id(particle_id),
	.ref_id(ref_particle_id),
	
	.reading_done(reading_done), 
	.ref_pos(ref_pos),
	.prev_ref_id(delay_ref_id), 
	.ref_particle_count(ref_particle_num), 
	.prev_particle_id(delay_particle_id), 
	.pair_valid(pair_valid),
	.assembled_position(assembled_position),
  .prev_phase(prev_phase)
);

RL_LJ_Evaluation_Unit
RL_LJ_Evaluation_Unit(
	.clk(clk),
	.rst(rst),
  .phase(prev_phase),
	.pair_valid(pair_valid),
	.ref_particle_id(delay_ref_id),
	.nb_particle_id(delay_particle_id),
  .ref_pos(ref_pos),
	.nb_position(assembled_position),
	
	.out_back_pressure_to_input(filter_back_pressure),
	.out_all_buffer_empty_to_input(all_buffer_empty),
	.out_ref_particle_id(out_ref_particle_id),
  .out_ref_LJ_Force(ref_force),
	.out_ref_force_valid(ref_force_valid),
  .out_start_wb(start_wb),
	.out_neighbor_particle_id(out_neighbor_particle_id),
  .out_neighbor_LJ_Force(nb_force),
	.out_neighbor_force_valid(nb_force_valid)
);

// Contains force buffers
force_distributor
force_distributor(
	.clk(clk), 
	.rst(rst), 
  .start_wb(start_wb),
  .ref_force(ref_force),
	.ref_id(out_ref_particle_id),
	.ref_force_valid(ref_force_valid),
  .force_in(nb_force),
	.nb_id(out_neighbor_particle_id),
	.force_valid(nb_force_valid),
  .ready(ready),
	
  .wb_out(force_data_out),
  .wb_valid(output_force_valid),
  .all_ref_wb_issued(all_ref_wb_issued)
);

endmodule
