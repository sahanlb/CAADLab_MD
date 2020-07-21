/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module: Partial_Force_Acc.v
//
//	Function: Accumulate the particle force for a single reference particle
//				Take the partial force from force evaluation module every cycle and perform accumulation
//				When the input particle id changed, which means the accumulation for the current particle has done, then output the accumulated force, and set as valid
//				When particle id change, reset the accumulated value and restart accumulation
//				The accumulator is always in enable mode, if the incoming data is invalid, set the input value as 0
//
//  Modified Functionality:
//  To support multiple referece particles from different cells in parallel, particle ID comparison is 
//  extended to also check cell ID of the reference particle. Each instance of Partial_Force_Acc is 
//  passed its index between 0-6, and the force output corresponding to a reference particle from a 
//  particular cell is picked based on the accumulator's index.
//
// Used by:
//				RL_LJ_Evaluation_Unit.v
//
// Dependency:
//				FP_ACC.v
//
// Testbench:
//				Partial_Force_Acc_tb.v
//
// Timing: 
//				FP_ACC: 1 cycle
//
// Created by: Chen Yang 10/23/18
// Modified by: Sahan Bandara 7/7/2020
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Partial_Force_Acc
#(
	parameter DATA_WIDTH 				= 32,
	parameter PARTICLE_ID_WIDTH	= 20, // # of bit used to represent particle ID, 9*9*7 cells, each 4-bit, each cell have max of 200 particles, 8-bit
  parameter CELL_ID_WIDTH     = 3,
  parameter ACC_ID            = 0,
  parameter ID_WIDTH          = 3*CELL_ID_WIDTH + PARTICLE_ID_WIDTH
)
(
	input  clk,
	input  rst,
	input  in_input_valid,
	input  [ID_WIDTH-1:0] in_particle_id,
	input  [DATA_WIDTH-1:0] in_partial_force_x,							// in IEEE single precision floating point format
	input  [DATA_WIDTH-1:0] in_partial_force_y,							// in IEEE single precision floating point format
	input  [DATA_WIDTH-1:0] in_partial_force_z,							// in IEEE single precision floating point format
	output reg [ID_WIDTH-1:0] out_particle_id,
	output reg [DATA_WIDTH-1:0] out_particle_acc_force_x,
	output reg [DATA_WIDTH-1:0] out_particle_acc_force_y,
	output reg [DATA_WIDTH-1:0] out_particle_acc_force_z,
	output reg out_acc_force_valid,
  output reg start_wb // signal to downstream modules to start force writebacks for reference particles
);

  // Cell ID encoding
  localparam CELL_1 = 3'b001;
  localparam CELL_2 = 3'b010;
  localparam CELL_3 = 3'b011;


  typedef struct packed{
    logic [3*CELL_ID_WIDTH-1:0] cell_id;
    logic [PARTICLE_ID_WIDTH-1:0] particle;
  }full_id_t;

  full_id_t cur_particle_id;
  full_id_t in_id;

  assign in_id   = in_particle_id;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// Signals connected to accumulators
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// Enable the accumulation operation
	// Always set as enable
	wire acc_enable;
	assign acc_enable = ~rst;

  // ID comparisons
  wire particle_id_match, cell_id_match;
  wire phase_change;

  // Cell ID values to be compared with input particle IDs.
  logic [2:0][CELL_ID_WIDTH-1:0] cell_id1, cell_id2;

  assign particle_id_match = (cur_particle_id.particle == in_id.particle);
  assign cell_id_match     = (cur_particle_id.cell_id == in_id.cell_id);

  assign phase_change = in_input_valid & ~cell_id_match & (in_id.cell_id == cell_id2);
  // This assumes that force values related to phase 0 and 1 will not be received 
  // in an interleaved fashion.
	
	// Accumulated output value
	wire [DATA_WIDTH-1:0] acc_value_out_x;									
	wire [DATA_WIDTH-1:0] acc_value_out_y;
	wire [DATA_WIDTH-1:0] acc_value_out_z;
	
	// Assign wires for partial force, if the incoming data is invalid, set as 0
	wire [DATA_WIDTH-1:0] partial_force_x_in_wire;
	wire [DATA_WIDTH-1:0] partial_force_y_in_wire;
	wire [DATA_WIDTH-1:0] partial_force_z_in_wire;
	assign partial_force_x_in_wire = in_input_valid & particle_id_match & (cell_id_match | phase_change) ? in_partial_force_x : 0;
	assign partial_force_y_in_wire = in_input_valid & particle_id_match & (cell_id_match | phase_change) ? in_partial_force_y : 0;
	assign partial_force_z_in_wire = in_input_valid & particle_id_match & (cell_id_match | phase_change) ? in_partial_force_z : 0;
	
	// Assign wires for accumulation data, if particle id changes, set the acc value as 0
	wire [DATA_WIDTH-1:0] acc_force_x_in_wire;
	wire [DATA_WIDTH-1:0] acc_force_y_in_wire;
	wire [DATA_WIDTH-1:0] acc_force_z_in_wire;
	assign acc_force_x_in_wire = ((in_input_valid & ~particle_id_match) | phase_change) ? 0 : acc_value_out_x;
	assign acc_force_y_in_wire = ((in_input_valid & ~particle_id_match) | phase_change) ? 0 : acc_value_out_y;
	assign acc_force_z_in_wire = ((in_input_valid & ~particle_id_match) | phase_change) ? 0 : acc_value_out_z;


  // Track whether there is a valid accumulated value to be written back. Some of the accumulators 
  // may not have a value to be writtenback because of the different neighbor cells having different 
  // particle counts and certain neighbors not having a valid reference particle for the current iteration.
  reg valid_wb_value;

  always @(posedge clk)begin
    if(rst)
      valid_wb_value <= 1'b0;
    else begin
      if((acc_force_x_in_wire == 0) & (acc_force_y_in_wire == 0) & (acc_force_z_in_wire == 0))
        valid_wb_value <= 1'b0;
      else if((partial_force_x_in_wire != 0) | (partial_force_y_in_wire != 0) | (acc_force_z_in_wire != 0))
        valid_wb_value <= 1'b1;
      else
        valid_wb_value <= valid_wb_value;
    end
  end

/* // For scattered selection
  always_comb begin
    case(ACC_ID)
      0: {cell_id1, cell_id2} = {CELL_2, CELL_2, CELL_2, CELL_1, CELL_1, CELL_1};
      1: {cell_id1, cell_id2} = {CELL_3, CELL_2, CELL_1, CELL_1, CELL_2, CELL_1};
      2: {cell_id1, cell_id2} = {CELL_2, CELL_3, CELL_3, CELL_1, CELL_3, CELL_2};
      3: {cell_id1, cell_id2} = {CELL_1, CELL_1, CELL_2, CELL_2, CELL_3, CELL_1};
      4: {cell_id1, cell_id2} = {CELL_1, CELL_3, CELL_1, CELL_2, CELL_2, CELL_3};
      5: {cell_id1, cell_id2} = {CELL_1, CELL_3, CELL_3, CELL_2, CELL_1, CELL_2};
      6: {cell_id1, cell_id2} = {CELL_1, CELL_1, CELL_3, CELL_3, CELL_2, CELL_2};
    endcase
  end
*/
  // For half shell neighbor selection  
  always_comb begin
    case(ACC_ID)
      0: {cell_id1, cell_id2} = {CELL_2, CELL_2, CELL_2, CELL_3, CELL_1, CELL_3};
      1: {cell_id1, cell_id2} = {CELL_2, CELL_2, CELL_3, CELL_3, CELL_2, CELL_1};
      2: {cell_id1, cell_id2} = {CELL_2, CELL_3, CELL_1, CELL_3, CELL_2, CELL_2};
      3: {cell_id1, cell_id2} = {CELL_2, CELL_3, CELL_2, CELL_3, CELL_2, CELL_3};
      4: {cell_id1, cell_id2} = {CELL_2, CELL_3, CELL_3, CELL_3, CELL_3, CELL_1};
      5: {cell_id1, cell_id2} = {CELL_3, CELL_1, CELL_1, CELL_3, CELL_3, CELL_2};
      6: {cell_id1, cell_id2} = {CELL_3, CELL_1, CELL_2, CELL_3, CELL_3, CELL_3};
    endcase
  end

	// Controller for accumulation operation
  always @(posedge clk)begin
    if(rst)begin
			cur_particle_id          <= {cell_id1, {PARTICLE_ID_WIDTH{1'b0}}};
			out_particle_id          <= 0;
			out_particle_acc_force_x <= 0;
			out_particle_acc_force_y <= 0;
			out_particle_acc_force_z <= 0;
			out_acc_force_valid      <= 1'b0;
      start_wb                 <= 1'b0;
    end
    else begin
			out_particle_id          <= cur_particle_id;
			out_particle_acc_force_x <= acc_value_out_x;
			out_particle_acc_force_y <= acc_value_out_y;
			out_particle_acc_force_z <= acc_value_out_z;
      if(in_input_valid & ~particle_id_match)begin // next ref particle
        out_acc_force_valid      <= valid_wb_value;  
        start_wb                 <= 1'b1;
        cur_particle_id.particle <= in_id.particle;
        cur_particle_id.cell_id  <= cell_id1;
      end
      else if(phase_change)begin // switch from phase 0 to 1
        out_acc_force_valid      <= (cell_id1 == {CELL_2, CELL_2, CELL_2}) ? 1'b0 : valid_wb_value;
        // Don't writeback accumulated value if the reference particle is from the home cell.
        cur_particle_id.cell_id  <= cell_id2;
      end
      else begin
        out_acc_force_valid <= 1'b0;
        start_wb            <= 1'b0;
        cur_particle_id     <= cur_particle_id;
      end
    end
  end


		
	// Acc_Value_X
	FP_ACC
	#(
		.DATA_WIDTH(DATA_WIDTH)
	)
	FP_ACC_X (
		.clk(clk),
		.clr(1'b0),
		.ena(acc_enable),
		.ax(partial_force_x_in_wire),
		.ay(acc_force_x_in_wire),
		.result(acc_value_out_x)
	);
	
	// Acc_Value_Y
	FP_ACC
	#(
		.DATA_WIDTH(DATA_WIDTH)
	)
	FP_ACC_Y (
		.clk(clk),
		.clr(1'b0),
		.ena(acc_enable),
		.ax(partial_force_y_in_wire),
		.ay(acc_force_y_in_wire),
		.result(acc_value_out_y)
	);
	
	// Acc_Value_Z
	FP_ACC
	#(
		.DATA_WIDTH(DATA_WIDTH)
	)
	FP_ACC_Z (
		.clk(clk),
		.clr(1'b0),
		.ena(acc_enable),
		.ax(partial_force_z_in_wire),
		.ay(acc_force_z_in_wire),
		.result(acc_value_out_z)
	);
		
endmodule
