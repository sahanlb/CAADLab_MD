module filter_logic
#(
	// Data width
	parameter DATA_WIDTH = 32,
	parameter CELL_ID_WIDTH = 3, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter BODY_BITS = 8, 
	parameter FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH, 
	
	// Buffer config
	parameter FILTER_BUFFER_DEPTH = 32, 
	parameter FILTER_BUFFER_ADDR_WIDTH = 5, 
	parameter BUFFER_USEDW_WIDTH = 5, 
	
	// Constants
	parameter SQRT_2 = 10'b0101101011,
	parameter SQRT_3 = 10'b0110111100,
	
	// Now r2 computing is after filtering, so only 4 cycles of propagation cycles are needed
	parameter BACK_PRESSURE_THRESHOLD = 27
)
(
	input clk, 
	input rst, 
	input [DATA_WIDTH-1:0] x1, y1, z1, x2, y2, z2, 
	input [PARTICLE_ID_WIDTH-1:0] cell_id_2,
	input buffer_rd_en, 
	input input_valid, 
	
	output [FILTER_BUFFER_DATA_WIDTH-1:0] buffer_rd_data, 
	output buffer_empty, 
	output back_pressure
);

wire pass;

// Filter
planar_filter_normalized
#(
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.BODY_BITS(BODY_BITS),
	.SQRT_2(SQRT_2),
	.SQRT_3(SQRT_3)
)
planar_filter
(
	.clk(clk), 
	.rst(rst),
	.input_valid(input_valid), 
	.x1(x1[DATA_WIDTH-1:DATA_WIDTH-CELL_ID_WIDTH-BODY_BITS]),		// Do not need all the data
	.y1(y1[DATA_WIDTH-1:DATA_WIDTH-CELL_ID_WIDTH-BODY_BITS]),
	.z1(z1[DATA_WIDTH-1:DATA_WIDTH-CELL_ID_WIDTH-BODY_BITS]), 
	.x2(x2[DATA_WIDTH-1:DATA_WIDTH-CELL_ID_WIDTH-BODY_BITS]),
	.y2(y2[DATA_WIDTH-1:DATA_WIDTH-CELL_ID_WIDTH-BODY_BITS]),
	.z2(z2[DATA_WIDTH-1:DATA_WIDTH-CELL_ID_WIDTH-BODY_BITS]), 
	.pass(pass)
);

wire [FILTER_BUFFER_DATA_WIDTH-1:0] buffer_wr_data;
wire [BUFFER_USEDW_WIDTH-1:0] buffer_usedw;
wire buffer_wr_en;

assign buffer_wr_data = {cell_id_2, z2, y2, x2};
assign back_pressure = buffer_usedw > BACK_PRESSURE_THRESHOLD ? 1'b1 : 1'b0;
assign buffer_wr_en = pass ? 1'b1 : 1'b0;

//filter_buffer_MLAB
//#(
//	.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH)
//)
//filter_buffer
//(
//		 .clk(clk),
//		 .w_data(buffer_wr_data),
//		 .w_req(buffer_wr_en),
//		 .r_req(buffer_rd_en),
//		 .r_empty(buffer_empty),
//		 .r_data(buffer_rd_data),
//		 .w_usedw(buffer_usedw)
//);

filter_buffer
#(
	.DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH), 
	.FILTER_BUFFER_DEPTH(FILTER_BUFFER_DEPTH),
	.FILTER_BUFFER_ADDR_WIDTH(FILTER_BUFFER_ADDR_WIDTH)
	
)
filter_buffer
(
		 .clock(clk),
		 .data(buffer_wr_data),
		 .wrreq(buffer_wr_en),
		 .rdreq(buffer_rd_en),
		 .empty(buffer_empty),
		 .q(buffer_rd_data),
		 .usedw(buffer_usedw)
);
endmodule