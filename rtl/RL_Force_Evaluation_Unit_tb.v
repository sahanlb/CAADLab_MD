`timescale 1ns/1ns
module RL_Force_Evaluation_Unit_tb;

	// Data width
	parameter DATA_WIDTH = 32;
	parameter CELL_ID_WIDTH = 3;
	parameter DECIMAL_ADDR_WIDTH = 2; 
	parameter PARTICLE_ID_WIDTH = 7; 
	parameter BODY_BITS = 8; 
	parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH;
	parameter FILTER_BUFFER_DATA_WIDTH = ID_WIDTH+3*DATA_WIDTH; 
	
	// Constants
	parameter SQRT_2 = 8'b10110110;
	parameter SQRT_3 = 8'b11011110; 
	parameter BACK_PRESSURE_THRESHOLD = 27; 
	parameter NUM_FILTER = 7; 
	parameter ARBITER_MSB = 64; 
	parameter EXP_0 = 8'b01111111; 
	
	// Force evaluation
	parameter SEGMENT_NUM					= 9;
	parameter SEGMENT_WIDTH					= 4;
	parameter BIN_NUM							= 256;
	parameter BIN_WIDTH						= 8;
	parameter LOOKUP_NUM						= SEGMENT_NUM * BIN_NUM;
	parameter LOOKUP_ADDR_WIDTH			= SEGMENT_WIDTH + BIN_WIDTH;
	
	reg clk, rst, start;
	reg [NUM_FILTER-1:0] in_input_valid;
	reg [PARTICLE_ID_WIDTH-1:0] in_ref_particle_id;
	reg [PARTICLE_ID_WIDTH-1:0] in_neighbor_particle_id;
	reg [DATA_WIDTH-1:0] in_refx;
	reg [DATA_WIDTH-1:0] in_refy;
	reg [DATA_WIDTH-1:0] in_refz;
	reg [NUM_FILTER*DATA_WIDTH-1:0] in_nbx;
	reg [NUM_FILTER*DATA_WIDTH-1:0] in_nby;
	reg [NUM_FILTER*DATA_WIDTH-1:0] in_nbz;
	wire [ID_WIDTH-1:0] out_ref_particle_id;
	wire [ID_WIDTH-1:0] out_neighbor_particle_id;
	wire [DATA_WIDTH-1:0] out_RL_Force_X;
	wire [DATA_WIDTH-1:0] out_RL_Force_Y;
	wire [DATA_WIDTH-1:0] out_RL_Force_Z;
	wire out_forceoutput_valid;
	wire [NUM_FILTER-1:0] out_back_pressure_to_input;
	wire out_all_buffer_empty_to_input;
	
	always #1 clk <= ~clk;
	initial
		begin
		clk <= 1'b0;
		rst <= 1'b1;
		
		#10
		rst <= 1'b0;
		in_input_valid <= 7'b1100000;
		in_ref_particle_id <= 7'b0000001;
		in_neighbor_particle_id <= 7'b0000001;
		in_refx <= 32'h40000000;
		in_refy <= 32'h40000000;
		in_refz <= 32'h40000000;
		in_nbx[NUM_FILTER*DATA_WIDTH-1:(NUM_FILTER-1)*DATA_WIDTH] <= 32'h48000000;
		in_nby[NUM_FILTER*DATA_WIDTH-1:(NUM_FILTER-1)*DATA_WIDTH] <= 32'h48000000;
		in_nbz[NUM_FILTER*DATA_WIDTH-1:(NUM_FILTER-1)*DATA_WIDTH] <= 32'h48000000;
		in_nbx[(NUM_FILTER-1)*DATA_WIDTH-1:(NUM_FILTER-2)*DATA_WIDTH] <= 32'h44000000;
		in_nby[(NUM_FILTER-1)*DATA_WIDTH-1:(NUM_FILTER-2)*DATA_WIDTH] <= 32'h44000000;
		in_nbz[(NUM_FILTER-1)*DATA_WIDTH-1:(NUM_FILTER-2)*DATA_WIDTH] <= 32'h44000000;
		in_nbx[(NUM_FILTER-2)*DATA_WIDTH-1:0] <= 0;
		in_nby[(NUM_FILTER-2)*DATA_WIDTH-1:0] <= 0;
		in_nbz[(NUM_FILTER-2)*DATA_WIDTH-1:0] <= 0;
		
		#2
		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
		in_input_valid <= 7'b1000000;
		#2
		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
		in_input_valid <= 7'b1100000;
		#2
		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
		in_input_valid <= 7'b1000000;
		#2
		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
		in_input_valid <= 7'b1100000;
		
		#2
		in_input_valid = 0;
		
		#100
		in_input_valid = 7'b1100000;
		in_ref_particle_id <= 7'b0000010;
		in_neighbor_particle_id <= 7'b0000001;
		in_nbz[(NUM_FILTER-1)*DATA_WIDTH-1:(NUM_FILTER-2)*DATA_WIDTH] <= 32'h44000100;
		#2
		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
		#2
		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
		#2
		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
		#2
		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
		
//		#2
//		in_ref_particle_id <= 7'b0000011;
//		in_neighbor_particle_id <= 7'b0000001;
//		in_nbz[(NUM_FILTER-1)*DATA_WIDTH-1:(NUM_FILTER-2)*DATA_WIDTH] <= 32'h44000200;
//		#2
//		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
//		#2
//		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
//		#2
//		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
//		#2
//		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
//		
//		#2
//		in_ref_particle_id <= 7'b0000100;
//		in_neighbor_particle_id <= 7'b0000001;
//		in_nbz[(NUM_FILTER-1)*DATA_WIDTH-1:(NUM_FILTER-2)*DATA_WIDTH] <= 32'h44000300;
//		#2
//		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
//		#2
//		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
//		#2
//		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
//		#2
//		in_neighbor_particle_id <= in_neighbor_particle_id + 1'b1;
		
		end
	
	RL_Force_Evaluation_Unit RL_Force_Evaluation_Unit
	(
		.clk(clk),
		.rst(rst),
		.pair_valid(in_input_valid),
		.ref_particle_id(in_ref_particle_id),
		.nb_particle_id(in_neighbor_particle_id),
		.ref_x(in_refx),
		.ref_y(in_refy),
		.ref_z(in_refz),
		.nb_x(in_nbx),
		.nb_y(in_nby),
		.nb_z(in_nbz),
		.out_ref_particle_id(out_ref_particle_id),
		.out_neighbor_particle_id(out_neighbor_particle_id),
		.out_RL_Force_X(out_RL_Force_X),
		.out_RL_Force_Y(out_RL_Force_Y),
		.out_RL_Force_Z(out_RL_Force_Z),
		.out_forceoutput_valid(out_forceoutput_valid),
		.out_back_pressure_to_input(out_back_pressure_to_input),
		.out_all_buffer_empty_to_input(out_all_buffer_empty_to_input)
	);
endmodule