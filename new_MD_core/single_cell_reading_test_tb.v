`timescale 1ns/1ns
module single_cell_reading_test_tb;

parameter NUM_CELLS = 14; 
parameter PARTICLE_NUM = 100; 

// Data width
parameter OFFSET_WIDTH = 29; 
parameter DATA_WIDTH = 32;
parameter CELL_ID_WIDTH = 3;
parameter DECIMAL_ADDR_WIDTH = 2; 
parameter PARTICLE_ID_WIDTH = 7; 
parameter BODY_BITS = 8; 
parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH;
parameter FULL_CELL_ID_WIDTH = 3*CELL_ID_WIDTH; 
parameter FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH; 

// Constants
parameter SQRT_2 = 8'b10110110;
parameter SQRT_3 = 8'b11011110; 
parameter BACK_PRESSURE_THRESHOLD = 27; 
parameter NUM_FILTER = 7; 
parameter ARBITER_MSB = 64; 				// 2^(NUM_FILTER-1)
parameter NUM_NEIGHBOR_CELLS = 13;
parameter EXP_0 = 8'b01111111; 

// Force evaluation
parameter SEGMENT_NUM					= 9;
parameter SEGMENT_WIDTH					= 4;
parameter BIN_NUM							= 256;
parameter BIN_WIDTH						= 8;
parameter LOOKUP_NUM						= SEGMENT_NUM * BIN_NUM;		// SEGMENT_NUM * BIN_NUM
parameter LOOKUP_ADDR_WIDTH			= SEGMENT_WIDTH + BIN_WIDTH;	// log LOOKUP_NUM / log 2

reg clk;
reg rst;
reg iter_start;

// From preprocessor
wire reading_done; 
wire [PARTICLE_ID_WIDTH-1:0] ref_particle_num; 
// From force evaluation
wire back_pressure;
wire filter_buffer_empty;
wire [ID_WIDTH-1:0] out_ref_particle_id;
wire [DATA_WIDTH-1:0] ref_force_x;
wire [DATA_WIDTH-1:0] ref_force_y;
wire [DATA_WIDTH-1:0] ref_force_z;
wire ref_force_valid;
wire [ID_WIDTH-1:0] out_neighbor_particle_id;
wire [DATA_WIDTH-1:0] nb_force_x;
wire [DATA_WIDTH-1:0] nb_force_y;
wire [DATA_WIDTH-1:0] nb_force_z;
wire nb_force_valid;

always #1 clk <= ~clk;
initial
	begin
	clk <= 1'b0;
	rst <= 1'b1;
	iter_start <= 1'b0;
	
	#10
	rst <= 1'b0;
	iter_start <= 1'b1;
	end
	

single_cell_reading_test
#(
	.NUM_CELLS(NUM_CELLS),
	.PARTICLE_NUM(PARTICLE_NUM),
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.BODY_BITS(BODY_BITS),
	.ID_WIDTH(ID_WIDTH),
	.FULL_CELL_ID_WIDTH(FULL_CELL_ID_WIDTH),
	.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH), 
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS)
)
reading_test
(
	.clk(clk), 
	.rst(rst), 
	.iter_start(iter_start), 
	
	.reading_done(reading_done),
	.ref_particle_num(ref_particle_num),
	.back_pressure(back_pressure),
	.filter_buffer_empty(filter_buffer_empty),
	.out_ref_particle_id(out_ref_particle_id),
	.ref_force_x(ref_force_x),
	.ref_force_y(ref_force_y),
	.ref_force_z(ref_force_z),
	.ref_force_valid(ref_force_valid),
	.out_neighbor_particle_id(out_neighbor_particle_id),
	.nb_force_x(nb_force_x),
	.nb_force_y(nb_force_y),
	.nb_force_z(nb_force_z),
	.nb_force_valid(nb_force_valid)
);
	
endmodule