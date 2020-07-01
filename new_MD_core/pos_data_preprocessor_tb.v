`timescale 1ns/1ns
module pos_data_preprocessor_tb;

parameter DATA_WIDTH = 32;
parameter NUM_NEIGHBOR_CELLS = 13;
parameter NUM_FILTER = 7;
parameter PARTICLE_ID_WIDTH = 7;


reg clk; 
reg rst; 
reg start; 
// All PEs have a synchronized phase; so use a global phase
reg phase; 
// From data source
reg [(NUM_NEIGHBOR_CELLS+1)*3*DATA_WIDTH-1:0] rd_nb_position; 
reg [NUM_NEIGHBOR_CELLS:0] broadcast_done; 
reg [PARTICLE_ID_WIDTH-1:0] ref_particle_number; 
reg [PARTICLE_ID_WIDTH-1:0] particle_id; 

wire [DATA_WIDTH-1:0] ref_x;
wire [DATA_WIDTH-1:0] ref_y;
wire [DATA_WIDTH-1:0] ref_z;
wire [PARTICLE_ID_WIDTH-1:0] ref_id;
wire [NUM_FILTER-1:0] nb_particle_valid;
wire [NUM_FILTER*3*DATA_WIDTH-1:0] assembled_position;

// 4 home cell particles, MSB cell has 5 neighbor particles
// 
always #1 clk <= ~clk;
initial
	begin
	clk <= 1'b0;
	rst <= 1'b1;
	phase <= 1'b0;
	broadcast_done <= 0;
	rd_nb_position <= 0;
	
	#10
	rst <= 1'b0;
	ref_particle_number <= 4;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 0;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 0;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 0;
	particle_id <= 5;
	
	
	
	#2
	phase <= 1'b1;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hEEEEEEEE;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hEEEEEEEE;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hEEEEEEEE;
	particle_id <= 5;
	
	
	
	#2
	phase <= 1'b0;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 0;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 0;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 0;
	particle_id <= 5;
	
	
	
	
	#2
	phase <= 1'b1;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hEEEEEEEE;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hEEEEEEEE;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hEEEEEEEE;
	particle_id <= 5;
	
	
	
	#2
	phase <= 1'b0;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 0;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 0;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 0;
	particle_id <= 5;
	
	
	
	
	#2
	phase <= 1'b1;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hEEEEEEEE;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hEEEEEEEE;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hEEEEEEEE;
	particle_id <= 5;
	
	
	
	#2
	phase <= 1'b0;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 0;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 0;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 0;
	particle_id <= 5;
	
	
	
	
	#2
	phase <= 1'b1;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hEEEEEEEE;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hEEEEEEEE;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hEEEEEEEE;
	particle_id <= 5;
	broadcast_done <= 14'b01111111111111;
	
	
	
	#2
	phase <= 1'b0;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 0;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 0;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 0;
	particle_id <= 5;
	
	
	
	
	#2
	phase <= 1'b1;
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hAAAAAAAA;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hAAAAAAAA;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hAAAAAAAA;
	particle_id <= 1;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hBBBBBBBB;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hBBBBBBBB;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hBBBBBBBB;
	particle_id <= 2;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hCCCCCCCC;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hCCCCCCCC;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hCCCCCCCC;
	particle_id <= 3;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hDDDDDDDD;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hDDDDDDDD;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hDDDDDDDD;
	particle_id <= 4;
	
	#2
	rd_nb_position[DATA_WIDTH-1:0] <= 32'hEEEEEEEE;
	rd_nb_position[2*DATA_WIDTH-1:DATA_WIDTH] <= 32'hEEEEEEEE;
	rd_nb_position[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 32'hEEEEEEEE;
	particle_id <= 5;
	broadcast_done <= 14'b11111111111111;
	
	end
	
	
PE_wrapper
#(
	.DATA_WIDTH(DATA_WIDTH),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.NUM_FILTER(NUM_FILTER),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
PE_wrapper
(
	
	.clk(clk),
	.rst(rst),
	.start(start),
	.phase(phase),
	.rd_nb_position(rd_nb_position),
	.broadcast_done(broadcast_done),
	.ref_particle_number(ref_particle_number),
	.particle_id(particle_id),
	
	.ref_x(ref_x),
	.ref_y(ref_y),
	.ref_z(ref_z),
	.ref_id(ref_id),
	.nb_particle_valid(nb_particle_valid),
	.assembled_position(assembled_position)
);
endmodule	