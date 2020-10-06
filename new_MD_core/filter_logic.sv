import md_pkg::*;

module filter_logic #(
  parameter FILTER_BUFFER_DEPTH     = 32,
  parameter BACK_PRESSURE_THRESHOLD = 27
)(
	input clk, 
	input rst, 
	input [DATA_WIDTH-1:0] x1, y1, z1, x2, y2, z2, 
	input particle_id_t cell_id_2,
	input buffer_rd_en, 
	input input_valid, 
	
	output position_data_t buffer_rd_data, 
	output buffer_empty, 
	output back_pressure
);

localparam FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH;
localparam FILTER_BUFFER_ADDR_WIDTH = $clog2(FILTER_BUFFER_DEPTH);
localparam BUFFER_USEDW_WIDTH = $clog2(FILTER_BUFFER_DEPTH);

wire pass;

// Filter
planar_filter_normalized 
planar_filter(
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

wire position_data_t buffer_wr_data;
wire [BUFFER_USEDW_WIDTH-1:0] buffer_usedw;
wire buffer_wr_en;

assign buffer_wr_data = {cell_id_2, z2, y2, x2};
assign back_pressure = buffer_usedw > BACK_PRESSURE_THRESHOLD;
assign buffer_wr_en = pass;

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
