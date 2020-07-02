`timescale 1ns/1ns
module RL_top_tb;

parameter NUM_CELLS = 64; 
parameter NUM_PARTICLE_PER_CELL = 100; 
parameter OFFSET_WIDTH = 29; 
parameter DATA_WIDTH = 32;
parameter CELL_ID_WIDTH = 3;
parameter DECIMAL_ADDR_WIDTH = 2; 
parameter PARTICLE_ID_WIDTH = 7; 
parameter X_DIM = 4; 
parameter Y_DIM = 4; 
parameter Z_DIM = 4; 
parameter BODY_BITS = 8; 
parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH;
parameter FULL_CELL_ID_WIDTH = 3*CELL_ID_WIDTH; 
parameter FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH; 
parameter FORCE_BUFFER_WIDTH = 3*DATA_WIDTH+PARTICLE_ID_WIDTH+1; 
parameter FORCE_DATA_WIDTH = FORCE_BUFFER_WIDTH-1; 
parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH; 
parameter POS_CACHE_WIDTH = 3*OFFSET_WIDTH; 
parameter VELOCITY_CACHE_WIDTH = 3*DATA_WIDTH; 
parameter NUM_FILTER = 7; 
parameter ARBITER_MSB = 64; 				// 2^(NUM_FILTER-1)
parameter NUM_NEIGHBOR_CELLS = 13; 
parameter ALL_POSITION_WIDTH = (NUM_NEIGHBOR_CELLS+1)*POS_CACHE_WIDTH;

reg clk; 
reg rst; 
reg start;

// Output from PE
wire [NUM_CELLS-1:0] reading_done; 
wire [NUM_CELLS*PARTICLE_ID_WIDTH-1:0] particle_num; 
wire [NUM_CELLS-1:0] back_pressure; 
wire [NUM_CELLS-1:0] filter_buffer_empty; 
wire [NUM_CELLS*NUM_FILTER*FORCE_BUFFER_WIDTH-1:0] force_data; 
wire [NUM_CELLS*NUM_FILTER-1:0] force_valid;
wire force_valid_and;

always #1 clk <= ~clk;

initial begin
	clk <= 1;
	rst <= 1;
	start <= 0;
	
	#10
	rst <= 0;
	
	#8
	start <= 1;
	
	#100
	start <= 0;
end

RL_top
#(
	.NUM_CELLS(NUM_CELLS),
	.NUM_PARTICLE_PER_CELL(NUM_PARTICLE_PER_CELL),
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.X_DIM(X_DIM),
	.Y_DIM(Y_DIM),
	.Z_DIM(Z_DIM),
	.BODY_BITS(BODY_BITS),
	.ID_WIDTH(ID_WIDTH),
	.FULL_CELL_ID_WIDTH(FULL_CELL_ID_WIDTH),
	.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH),
	.FORCE_BUFFER_WIDTH(FORCE_BUFFER_WIDTH),
	.FORCE_DATA_WIDTH(FORCE_DATA_WIDTH),
	.FORCE_CACHE_WIDTH(FORCE_CACHE_WIDTH),
	.POS_CACHE_WIDTH(POS_CACHE_WIDTH),
	.VELOCITY_CACHE_WIDTH(VELOCITY_CACHE_WIDTH),
	.NUM_FILTER(NUM_FILTER),
	.ARBITER_MSB(ARBITER_MSB),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.ALL_POSITION_WIDTH(ALL_POSITION_WIDTH)
)
RL_top
(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.reading_done(reading_done),
	.particle_num(particle_num),
	.back_pressure(back_pressure),
	.filter_buffer_empty(filter_buffer_empty),
	.force_data(force_data),
	.force_valid(force_valid),
	.force_valid_and(force_valid_and)
);

endmodule
