`timescale 1ns/1ns
module broadcast_controller_tb;

parameter NUM_CELLS = 1;
parameter PARTICLE_ID_WIDTH = 7;

reg clk; 
reg rst; 
reg [NUM_CELLS*PARTICLE_ID_WIDTH-1:0] particle_number;
reg [NUM_CELLS*PARTICLE_ID_WIDTH-1:0] particle_id;

wire [NUM_CELLS-1:0] broadcast_done;

always #1 clk = ~clk; 
initial
	begin
	clk <= 1'b0;
	rst <= 1'b1;
	particle_number[PARTICLE_ID_WIDTH-1:0] <= 7'b0001010;
	
	#10
	rst <= 1'b0;
	particle_id[PARTICLE_ID_WIDTH-1:0] <= 7'b0000001;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	
	#2
	particle_id[PARTICLE_ID_WIDTH-1:0] <= particle_id[PARTICLE_ID_WIDTH-1:0] + 1'b1;
	end
	
	broadcast_controller
	#(
		.NUM_CELLS(NUM_CELLS),
		.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
	)
	broadcast_controller
	(
		.clk(clk),
		.rst(rst),
		.particle_number(particle_number),
		.particle_id(particle_id),
		
		.broadcast_done(broadcast_done)
	);

	
endmodule