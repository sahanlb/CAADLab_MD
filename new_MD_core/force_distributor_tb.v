`timescale 1ns/1ns
module force_distributor_tb;

parameter DATA_WIDTH = 32;
parameter PARTICLE_ID_WIDTH = 7;
parameter ID_WIDTH = 16;
parameter NUM_FILTER = 7;
parameter FORCE_BUFFER_WIDTH = 3*DATA_WIDTH+ID_WIDTH+1;

reg clk;
reg rst;
reg [DATA_WIDTH-1:0] ref_force_x;
reg [DATA_WIDTH-1:0] ref_force_y;
reg [DATA_WIDTH-1:0] ref_force_z;
reg [PARTICLE_ID_WIDTH-1:0] ref_id;
reg ref_force_valid;
reg [DATA_WIDTH-1:0] force_x;
reg [DATA_WIDTH-1:0] force_y;
reg [DATA_WIDTH-1:0] force_z;
reg [ID_WIDTH-1:0] nb_id;
reg force_valid;
// Successfully chosen by the arbiter
reg [NUM_FILTER-1:0] write_success;
	
wire [NUM_FILTER*FORCE_BUFFER_WIDTH-1:0] force_buffer_data_out;
wire [NUM_FILTER-1:0] output_force_valid;

always #1 clk <= ~clk;
initial
	begin
	clk <= 1'b0;
	rst <= 1'b1;
	
	#10
	rst <= 1'b0;
	ref_id <= 7'b0000001;
	nb_id <= 16'b0100100100000001;
	ref_force_x <= 1;
	ref_force_y <= 1;
	ref_force_z <= 1;
	ref_force_valid <= 1'b0;
	force_x <= 2;
	force_y <= 2;
	force_z <= 2;
	force_valid <= 1'b1;
	write_success <= 1'b0;
	#10
	rst <= 1'b0;
	ref_id <= 7'b0000001;
	nb_id <= 16'b0110100010000001;
	ref_force_x <= 1;
	ref_force_y <= 1;
	ref_force_z <= 1;
	ref_force_valid <= 1'b1;
	force_x <= 3;
	force_y <= 3;
	force_z <= 3;
	force_valid <= 1'b1;
	write_success <= 1'b0;
	#2
	ref_force_valid <= 1'b0;
	nb_id <= 16'b0100100100000001;
	end


force_distributor
#()
force_distributor
(
	
	.clk(clk),
	.rst(rst),
	.ref_force_x(ref_force_x),
	.ref_force_y(ref_force_y),
	.ref_force_z(ref_force_z),
	.ref_id(ref_id),
	.ref_force_valid(ref_force_valid),
	.force_x(force_x),
	.force_y(force_y),
	.force_z(force_z),
	.nb_id(nb_id),
	.force_valid(force_valid),
	.write_success(write_success),
	
	.force_buffer_data_out(force_buffer_data_out),
	.output_force_valid(output_force_valid),
	.force_buffer_usedw()
);

endmodule