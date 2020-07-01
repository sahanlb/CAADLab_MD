`timescale 1ns/1ns
module ref_data_extractor_tb;

parameter DATA_WIDTH = 32;
parameter PARTICLE_ID_WIDTH = 7;

reg clk;
reg rst;
reg phase;
reg prev_phase;
// Particle data from home cell
reg [DATA_WIDTH-1:0] home_pos_x;
reg [DATA_WIDTH-1:0] home_pos_y;
reg [DATA_WIDTH-1:0] home_pos_z; 
reg [PARTICLE_ID_WIDTH-1:0] particle_id;

wire [PARTICLE_ID_WIDTH-1:0] ref_id; 
wire [DATA_WIDTH-1:0] ref_x;
wire [DATA_WIDTH-1:0] ref_y; 
wire [DATA_WIDTH-1:0] ref_z; 

always #1 clk <= ~clk;
always #2 prev_phase <= phase;
initial
	begin
	clk <= 1'b0;
	rst <= 1'b1;
	phase <= 1'b0;
	
	#10
	rst <= 1'b0;
	home_pos_x <= 32'hAAAAAAAA;
	home_pos_y <= 32'hAAAAAAAA;
	home_pos_z <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	home_pos_x <= 32'hBBBBBBBB;
	home_pos_y <= 32'hBBBBBBBB;
	home_pos_z <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	home_pos_x <= 32'hCCCCCCCC;
	home_pos_y <= 32'hCCCCCCCC;
	home_pos_z <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	home_pos_x <= 32'hDDDDDDDD;
	home_pos_y <= 32'hDDDDDDDD;
	home_pos_z <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	home_pos_x <= 32'hEEEEEEEE;
	home_pos_y <= 32'hEEEEEEEE;
	home_pos_z <= 32'hEEEEEEEE;
	particle_id <= 5;
	
	#2
	home_pos_x <= 32'hFFFFFFFF;
	home_pos_y <= 32'hFFFFFFFF;
	home_pos_z <= 32'hFFFFFFFF;
	particle_id <= 6;
	
	#2
	phase <= 1'b1;
	home_pos_x <= 32'hAAAAAAAA;
	home_pos_y <= 32'hAAAAAAAA;
	home_pos_z <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	home_pos_x <= 32'hBBBBBBBB;
	home_pos_y <= 32'hBBBBBBBB;
	home_pos_z <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	home_pos_x <= 32'hCCCCCCCC;
	home_pos_y <= 32'hCCCCCCCC;
	home_pos_z <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	home_pos_x <= 32'hDDDDDDDD;
	home_pos_y <= 32'hDDDDDDDD;
	home_pos_z <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	home_pos_x <= 32'hEEEEEEEE;
	home_pos_y <= 32'hEEEEEEEE;
	home_pos_z <= 32'hEEEEEEEE;
	particle_id <= 5;
	
	#2
	home_pos_x <= 32'hFFFFFFFF;
	home_pos_y <= 32'hFFFFFFFF;
	home_pos_z <= 32'hFFFFFFFF;
	particle_id <= 6;
	
	#2
	phase <= 1'b0;
	home_pos_x <= 32'hAAAAAAAA;
	home_pos_y <= 32'hAAAAAAAA;
	home_pos_z <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	home_pos_x <= 32'hBBBBBBBB;
	home_pos_y <= 32'hBBBBBBBB;
	home_pos_z <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	home_pos_x <= 32'hCCCCCCCC;
	home_pos_y <= 32'hCCCCCCCC;
	home_pos_z <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	home_pos_x <= 32'hDDDDDDDD;
	home_pos_y <= 32'hDDDDDDDD;
	home_pos_z <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	home_pos_x <= 32'hEEEEEEEE;
	home_pos_y <= 32'hEEEEEEEE;
	home_pos_z <= 32'hEEEEEEEE;
	particle_id <= 5;
	
	#2
	home_pos_x <= 32'hFFFFFFFF;
	home_pos_y <= 32'hFFFFFFFF;
	home_pos_z <= 32'hFFFFFFFF;
	particle_id <= 6;
	end
	
	
ref_data_extractor
#(
	.DATA_WIDTH(DATA_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
ref_data_extractor
(
	
	.clk(clk),
	.rst(rst),
	.phase(phase),
	.prev_phase(prev_phase),
	.home_pos_x(home_pos_x),
	.home_pos_y(home_pos_y),
	.home_pos_z(home_pos_z),
	.particle_id(particle_id),
	
	.ref_id(ref_id),
	.ref_x(ref_x),
	.ref_y(ref_y),
	.ref_z(ref_z)
);
endmodule