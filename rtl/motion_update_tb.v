`timescale 1ns/1ns
module motion_update_tb;

parameter NUM_CELLS = 64;
parameter GLOBAL_CELL_ID_WIDTH = 6; 
parameter CELL_ID_WIDTH = 3; 
parameter OFFSET_WIDTH = 29; 
parameter DATA_WIDTH = 32;											// Data width of a single force value; 32-bit
parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH; 
parameter VELOCITY_CACHE_WIDTH = 3*DATA_WIDTH; 
parameter POS_CACHE_WIDTH = 3*OFFSET_WIDTH; 
parameter TIME_STEP = 32'h27101D7D;							// 2fs time step
parameter PARTICLE_ID_WIDTH = 7; 
parameter EXP_0 = 8'b01111111; 
parameter X_DIM = 4; 
parameter Y_DIM = 4; 
parameter Z_DIM = 4;

reg clk;
reg rst;
reg motion_update_start;																// Only need to keep high for 1 cycle
reg [POS_CACHE_WIDTH-1:0] in_position_data;
reg [FORCE_CACHE_WIDTH-1:0] in_force_data;
reg [VELOCITY_CACHE_WIDTH-1:0] in_velocity_data;

wire [POS_CACHE_WIDTH-1:0] out_position_data;
wire [VELOCITY_CACHE_WIDTH-1:0] out_velocity_data;
wire [PARTICLE_ID_WIDTH-1:0] out_rd_addr; 
wire out_rd_enable; 
wire out_data_valid; 
wire out_motion_update_enable; 
wire out_motion_update_done; 
wire [GLOBAL_CELL_ID_WIDTH-1:0] cell_counter; 

// Particle migration
wire [1:0] cell_x_offset;
wire [1:0] cell_y_offset;
wire [1:0] cell_z_offset; 
wire [CELL_ID_WIDTH-1:0] cell_x; 
wire [CELL_ID_WIDTH-1:0] cell_y; 
wire [CELL_ID_WIDTH-1:0] cell_z;

// 4 home cell particles; MSB cell has 5 neighbor particles
// 
always #1 clk <= ~clk;
initial
	begin
	clk <= 1'b0;
	rst <= 1'b1;
	motion_update_start <= 1'b0;
	
	#10
	rst <= 1'b0;
	motion_update_start <= 1'b1;
	
	#6
	in_position_data <= 29'h00000004;
	in_velocity_data <= 0;
	in_force_data <= 0;
	
	#2
	in_position_data <= 0;
	in_velocity_data <= 32'h3f800000;
	in_force_data <= 32'h3f800000;
	
	#2
	in_position_data <= 0;
	in_velocity_data <= 32'h3f800000;
	in_force_data <= 32'h3f800000;
	
	#2
	in_position_data <= 29'h00000001;
	in_velocity_data <= 32'h3f800000;
	in_force_data <= 32'h40000000;
	
	#2
	in_position_data <= 29'h00000005;
	in_velocity_data <= 32'h40400000;
	in_force_data <= 32'h40400000;
	end
	
motion_update
#(
	.NUM_CELLS(NUM_CELLS), 
	.GLOBAL_CELL_ID_WIDTH(GLOBAL_CELL_ID_WIDTH), 
	.CELL_ID_WIDTH(CELL_ID_WIDTH), 
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.FORCE_CACHE_WIDTH(FORCE_CACHE_WIDTH),
	.VELOCITY_CACHE_WIDTH(VELOCITY_CACHE_WIDTH),
	.POS_CACHE_WIDTH(POS_CACHE_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH), 
	.X_DIM(X_DIM), 
	.Y_DIM(Y_DIM), 
	.Z_DIM(Z_DIM)
)
motion_update
(
	.clk(clk),
	.rst(rst),
	.motion_update_start(motion_update_start),
	.in_force_data(in_force_data),
	.in_position_data(in_position_data),
	.in_velocity_data(in_velocity_data),
	
	.out_position_data(out_position_data),
	.out_velocity_data(out_velocity_data),
	.out_rd_addr(out_rd_addr),
	.out_rd_enable(out_rd_enable), 
	.out_data_valid(out_data_valid), 
	.out_motion_update_enable(out_motion_update_enable), 
	.out_motion_update_done(out_motion_update_done), 
	.cell_counter(cell_counter), 
	.cell_x_offset(cell_x_offset),
	.cell_y_offset(cell_y_offset),
	.cell_z_offset(cell_z_offset), 
	.cell_x(cell_x), 
	.cell_y(cell_y), 
	.cell_z(cell_z)
);
endmodule	