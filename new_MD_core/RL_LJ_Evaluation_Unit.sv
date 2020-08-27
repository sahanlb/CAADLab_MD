/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module: RL_LJ_Evaluation_Unit.v
//
//	Function: 
//				Evaluate the accumulated LJ force of given datasets using 1st order interpolation (interpolation index is generated in Matlab (under Ethan_GoldenModel/Matlab_Interpolation))
// 			Force_Evaluation_Unit with multiple Accumulation_Units to accumulate force on reference neighbor particles(with negation) and send out force on home cell particles.
//				Single set of force evaluation unit, including:
//							* Single force evaluation pipeline
//							* Multiple (7) filters
//							* 7 Accumulation units for reference particles
//				Output:
//							* Each iteration, output a home cell particle's partial force
//							* When the reference particle is done or at phase change, output the accumulated force on the 7 reference particles
//
// Mapping Model:
//				Half-shell mapping
//				Each force pipeline working on a seven reference particles at a time until all the home cell particles are evaluated, then move to the next reference particle
//
// Format:
//				particle_id [ID_WIDTH-1:0]:  {cell_x, cell_y, cell_z, particle_in_cell_rd_addr}
//				in_ref_particle_position [3*DATA_WIDTH-1:0]: {refz, refy, refx}
//				in_neighbor_particle_position [3*DATA_WIDTH-1:0]: {neighborz, neighbory, neighborx}
//
//	Purpose:
//				Filter version, used for final system (half-shell mapping scheme)
//
// Used by:
//				RL_LJ_Top.v
//
// Dependency:
//				RL_LJ_Force_Evaluation_Unit.v / RL_LJ_Force_Evaluation_Unit_simple_filter.v
//				Partial_Force_Acc.v
//
// Testbench:
//				RL_LJ_Top_tb.v
//
// Timing:
//				Total Latency:									32 cycles
//				RL_LJ_Force_Evaluation_Unit:				31 cycles
//				Partial_Force_Acc:							currently 1 cycle
//
// Created by:
//				Chen Yang 10/23/2018
// Modified by:
//        Sahan Bandara 7/12/2020
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import md_pkg::*;

module RL_LJ_Evaluation_Unit(
	input  clk,
	input  rst,
  input  phase,
	input  [NUM_FILTER-1:0] pair_valid,
	input  particle_id_t ref_particle_id,
	input  particle_id_t nb_particle_id,
  input  data_tuple_t [NUM_FILTER-1:0] ref_pos,
	input  data_tuple_t nb_position,	// {neighborz, neighbory, neighborx}
	
	output [NUM_FILTER-1:0] out_back_pressure_to_input,						// backpressure signal to stop new data arrival from particle memory
	output out_all_buffer_empty_to_input,											// Output to FSM that generate particle pairs. Only when all the filter buffers are empty, then the FSM will move on to the next reference particle
	// Output accumulated force for reference particles
	// The output value is the accumulated value
	// Connected to home cell
	output full_id_t [NUM_FILTER-1:0] out_ref_particle_id,
  output data_tuple_t [NUM_FILTER-1:0] out_ref_LJ_Force,
	output [NUM_FILTER-1:0] out_ref_force_valid,
	output out_start_wb,
	// Output partial force for neighbor particles
	// The output value should be the minus value of the calculated force data
	// Connected to neighbor cells, if the neighbor paritle comes from the home cell, then discard, since the value will be recalculated when evaluating this particle as reference one
	output full_id_t out_neighbor_particle_id,
  output data_tuple_t out_neighbor_LJ_Force,
	output out_neighbor_force_valid
);

genvar i;
	
full_id_t ref_particle_id_wire;				// Wires sending from RL_LJ_Force_Evaluation_Unit to Partial_Force_Acc

  
wire [NUM_FILTER-1:0] start_wb;

assign out_start_wb = start_wb[0];
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Wires for assigning the output neighbor particle partial force value
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// assign the neighbor particle partial force valid, connected directly to force evaluation unit
wire evaluated_force_valid;
// assign the output port for neighbor partial force valid
assign out_neighbor_force_valid = evaluated_force_valid;
// assign the neighbor particle partial force, should negate the sign bit to signify the mutual force
data_tuple_t LJ_Force;
	
// Assign the output neighbor force, flip the sign bit
assign out_neighbor_LJ_Force.data_x[30:0] = LJ_Force.data_x[30:0];
assign out_neighbor_LJ_Force.data_y[30:0] = LJ_Force.data_y[30:0];
assign out_neighbor_LJ_Force.data_z[30:0] = LJ_Force.data_z[30:0];
assign out_neighbor_LJ_Force.data_x[31]   = ~LJ_Force.data_x[31];
assign out_neighbor_LJ_Force.data_y[31]   = ~LJ_Force.data_y[31];
assign out_neighbor_LJ_Force.data_z[31]   = ~LJ_Force.data_z[31];
	
	
// RL_Force_Evaluation_Unit Including filters and force evaluation pipeline
RL_Force_Evaluation_Unit
RL_Force_Evaluation_Unit(
	.clk(clk),
	.rst(rst),
  .phase(phase),
	.pair_valid(pair_valid),
	.ref_particle_id(ref_particle_id),
	.nb_particle_id(nb_particle_id),	
  .ref_pos(ref_pos),
  .nb_pos(nb_position),
	
	.out_ref_particle_id(ref_particle_id_wire),							// OUTPUT [PARTICLE_ID_WIDTH-1:0]
	.out_neighbor_particle_id(out_neighbor_particle_id),				// OUTPUT [PARTICLE_ID_WIDTH-1:0]
  .out_RL_Force(LJ_Force),
	.out_forceoutput_valid(evaluated_force_valid),							// OUTPUT
	.out_back_pressure_to_input(out_back_pressure_to_input),			// OUTPUT [NUM_FILTER-1:0]
	.out_all_buffer_empty_to_input(out_all_buffer_empty_to_input)	// OUTPUT
);


// Instantiate multiple Partial_Force_Acc units
generate
  for(i=0; i<NUM_FILTER; i=i+1)begin: partial_acc_inst
    Partial_Force_Acc
    #(
      .ACC_ID(i)
    )
    Partial_Force_Acc
    (
    	.clk(clk),
    	.rst(rst),
    	.in_input_valid(evaluated_force_valid),
    	.in_particle_id(ref_particle_id_wire),
      .in_partial_force(LJ_Force),
    	
    	.out_particle_id(out_ref_particle_id[i]),
      .out_particle_acc_force(out_ref_LJ_Force[i]),
    	.out_acc_force_valid(out_ref_force_valid[i]),
      .start_wb(start_wb[i])
    );
  end
endgenerate

endmodule


