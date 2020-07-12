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

module RL_LJ_Evaluation_Unit
#(
	// Data width
	parameter DATA_WIDTH = 32,
	parameter CELL_ID_WIDTH = 3,
	parameter DECIMAL_ADDR_WIDTH = 2, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter BODY_BITS = 8, 
	parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH,
	parameter FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH, 
	
	// Constants
	parameter SQRT_2 = 10'b0101101011,
	parameter SQRT_3 = 10'b0110111100,
	parameter NUM_FILTER = 7, 
	parameter ARBITER_MSB = 64, 				// 2^(NUM_FILTER-1)
	parameter EXP_0 = 8'b01111111, 
	
	// Force evaluation
	parameter SEGMENT_NUM					= 9,
	parameter SEGMENT_WIDTH				= 4,
	parameter BIN_NUM							= 256,
	parameter BIN_WIDTH						= 8,
	parameter LOOKUP_NUM					= SEGMENT_NUM * BIN_NUM,		// SEGMENT_NUM * BIN_NUM
	parameter LOOKUP_ADDR_WIDTH		= SEGMENT_WIDTH + BIN_WIDTH	// log LOOKUP_NUM / log 2
)
(
	input  clk,
	input  rst,
  input  phase,
	input  [NUM_FILTER-1:0] pair_valid,
	input  [PARTICLE_ID_WIDTH-1:0] ref_particle_id,
	input  [PARTICLE_ID_WIDTH-1:0] nb_particle_id,
	input  [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_x,
	input  [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_y,
	input  [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_z,
	input  [3*DATA_WIDTH-1:0] nb_position,	// {neighborz, neighbory, neighborx}
	
	output [NUM_FILTER-1:0] out_back_pressure_to_input,						// backpressure signal to stop new data arrival from particle memory
	output out_all_buffer_empty_to_input,											// Output to FSM that generate particle pairs. Only when all the filter buffers are empty, then the FSM will move on to the next reference particle
	// Output accumulated force for reference particles
	// The output value is the accumulated value
	// Connected to home cell
	output [NUM_FILTER-1:0][ID_WIDTH-1:0] out_ref_particle_id,
	output [NUM_FILTER-1:0][DATA_WIDTH-1:0] out_ref_LJ_Force_X,
	output [NUM_FILTER-1:0][DATA_WIDTH-1:0] out_ref_LJ_Force_Y,
	output [NUM_FILTER-1:0][DATA_WIDTH-1:0] out_ref_LJ_Force_Z,
	output [NUM_FILTER-1:0] out_ref_force_valid,
	// Output partial force for neighbor particles
	// The output value should be the minus value of the calculated force data
	// Connected to neighbor cells, if the neighbor paritle comes from the home cell, then discard, since the value will be recalculated when evaluating this particle as reference one
	output [ID_WIDTH-1:0] out_neighbor_particle_id,
	output [DATA_WIDTH-1:0] out_neighbor_LJ_Force_X,
	output [DATA_WIDTH-1:0] out_neighbor_LJ_Force_Y,
	output [DATA_WIDTH-1:0] out_neighbor_LJ_Force_Z,
	output out_neighbor_force_valid
);
	
	wire [ID_WIDTH-1:0] ref_particle_id_wire;				// Wires sending from RL_LJ_Force_Evaluation_Unit to Partial_Force_Acc
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Wires for assigning the output neighbor particle partial force value
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// assign the neighbor particle partial force valid, connected directly to force evaluation unit
	wire evaluated_force_valid;
	// assign the output port for neighbor partial force valid
	assign out_neighbor_force_valid = evaluated_force_valid;
	// assign the neighbor particle partial force, should negate the sign bit to signify the mutual force
	wire [DATA_WIDTH-1:0] LJ_Force_X_wire;
	wire [DATA_WIDTH-1:0] LJ_Force_Y_wire;
	wire [DATA_WIDTH-1:0] LJ_Force_Z_wire;
	
	// Assign the output neighbor force, flip the sign bit
	assign out_neighbor_LJ_Force_X[30:0] = LJ_Force_X_wire[30:0];
	assign out_neighbor_LJ_Force_Y[30:0] = LJ_Force_Y_wire[30:0];
	assign out_neighbor_LJ_Force_Z[30:0] = LJ_Force_Z_wire[30:0];
	assign out_neighbor_LJ_Force_X[31] = ~LJ_Force_X_wire[31];
	assign out_neighbor_LJ_Force_Y[31] = ~LJ_Force_Y_wire[31];
	assign out_neighbor_LJ_Force_Z[31] = ~LJ_Force_Z_wire[31];
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Wires for assigning input particle data to Force Evaluation Unit
	// Data alignment: {refz, refy, refx}, {neighborz, neighbory, neighborx}
  // Same value is copied over and sent to each filter along with different reference particles.
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	wire [NUM_FILTER*DATA_WIDTH-1:0] nb_x, nb_y, nb_z;
	genvar i;
	generate 
		for(i = 0; i < NUM_FILTER; i = i + 1)
			begin: input_wire_assignment
			assign nb_x[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH] = nb_position[0*DATA_WIDTH +: DATA_WIDTH];
			assign nb_y[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH] = nb_position[1*DATA_WIDTH +: DATA_WIDTH];
			assign nb_z[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH] = nb_position[2*DATA_WIDTH +: DATA_WIDTH];
			end
	endgenerate
	
	// Including filters and force evaluation pipeline
	RL_Force_Evaluation_Unit
	#(
		
		.DATA_WIDTH(DATA_WIDTH),
		.CELL_ID_WIDTH(CELL_ID_WIDTH),
		.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
		.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
		.BODY_BITS(BODY_BITS),
		.ID_WIDTH(ID_WIDTH), 
		.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH),
		.SQRT_2(SQRT_2),
		.SQRT_3(SQRT_3),
		.NUM_FILTER(NUM_FILTER),
		.ARBITER_MSB(ARBITER_MSB),
		.EXP_0(EXP_0),
		.SEGMENT_NUM(SEGMENT_NUM),
		.SEGMENT_WIDTH(SEGMENT_WIDTH),
		.BIN_NUM(BIN_NUM),
		.BIN_WIDTH(BIN_WIDTH),
		.LOOKUP_NUM(LOOKUP_NUM),
		.LOOKUP_ADDR_WIDTH(LOOKUP_ADDR_WIDTH)
	)
	RL_Force_Evaluation_Unit
	(
		.clk(clk),
		.rst(rst),
    .phase(phase),
		.pair_valid(pair_valid),
		.ref_particle_id(ref_particle_id),
		.nb_particle_id(nb_particle_id),	
		.ref_x(ref_x),
		.ref_y(ref_y),
		.ref_z(ref_z),
		.nb_x(nb_x),
		.nb_y(nb_y),
		.nb_z(nb_z),
		
		.out_ref_particle_id(ref_particle_id_wire),							// OUTPUT [PARTICLE_ID_WIDTH-1:0]
		.out_neighbor_particle_id(out_neighbor_particle_id),				// OUTPUT [PARTICLE_ID_WIDTH-1:0]
		.out_RL_Force_X(LJ_Force_X_wire),												// OUTPUT [DATA_WIDTH-1:0]
		.out_RL_Force_Y(LJ_Force_Y_wire),												// OUTPUT [DATA_WIDTH-1:0]
		.out_RL_Force_Z(LJ_Force_Z_wire),												// OUTPUT [DATA_WIDTH-1:0]
		.out_forceoutput_valid(evaluated_force_valid),							// OUTPUT
		.out_back_pressure_to_input(out_back_pressure_to_input),			// OUTPUT [NUM_FILTER-1:0]
		.out_all_buffer_empty_to_input(out_all_buffer_empty_to_input)	// OUTPUT
	);
	

  // Instantiate multiple Partial_Force_Acc units
  generate
    for(i=0; i<NUM_FILTER; i=i+1)begin: partial_acc_inst
	    Partial_Force_Acc
	    #(
	    	.DATA_WIDTH(DATA_WIDTH),
	    	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
        .CELL_ID_WIDTH(CELL_ID_WIDTH),
        .ACC_ID(i)
	    )
	    Partial_Force_Acc
	    (
	    	.clk(clk),
	    	.rst(rst),
	    	.in_input_valid(evaluated_force_valid),
	    	.in_particle_id(ref_particle_id_wire),
	    	.in_partial_force_x(LJ_Force_X_wire),
	    	.in_partial_force_y(LJ_Force_Y_wire),
	    	.in_partial_force_z(LJ_Force_Z_wire),
	    	
	    	.out_particle_id(out_ref_particle_id[i]),
	    	.out_particle_acc_force_x(out_ref_LJ_Force_X[i]),
	    	.out_particle_acc_force_y(out_ref_LJ_Force_Y[i]),
	    	.out_particle_acc_force_z(out_ref_LJ_Force_Z[i]),
	    	.out_acc_force_valid(out_ref_force_valid[i])
	    );
    end
  endgenerate

endmodule


