module planar_filter_normalized
#(
	// 1|3|7
	parameter CELL_ID_WIDTH = 3, 
	parameter BODY_BITS = 8,			// Including 1 bit integer part
	parameter SQRT_2 = 10'b0101101011,	// 101101010, round up to 101101011
	parameter SQRT_3 = 10'b0110111100	// 110111011, round up to 110111100
)
(
	input clk, 
	input rst, 
	input input_valid, 
	input [CELL_ID_WIDTH+BODY_BITS-1:0] x1, y1, z1, x2, y2, z2, 
	output pass
);

wire signed [CELL_ID_WIDTH+BODY_BITS-1:0] dx_full, dy_full, dz_full;
wire signed [CELL_ID_WIDTH+BODY_BITS-1:0] dx_positive, dy_positive, dz_positive;

assign dx_full = x1 - x2;
assign dy_full = y1 - y2;
assign dz_full = z1 - z2;

wire signed [BODY_BITS:0] dx, dy, dz;
wire signed [CELL_ID_WIDTH-1:0] int_part_x, int_part_y, int_part_z;

assign dx_positive = dx_full[CELL_ID_WIDTH+BODY_BITS-1] ? -dx_full : dx_full;
assign dy_positive = dy_full[CELL_ID_WIDTH+BODY_BITS-1] ? -dy_full : dy_full;
assign dz_positive = dz_full[CELL_ID_WIDTH+BODY_BITS-1] ? -dz_full : dz_full;

assign dx = {1'b0, dx_positive[BODY_BITS-1:0]};
assign dy = {1'b0, dy_positive[BODY_BITS-1:0]};
assign dz = {1'b0, dz_positive[BODY_BITS-1:0]};

assign int_part_x = dx_positive[CELL_ID_WIDTH+BODY_BITS-1:BODY_BITS];
assign int_part_y = dy_positive[CELL_ID_WIDTH+BODY_BITS-1:BODY_BITS];
assign int_part_z = dz_positive[CELL_ID_WIDTH+BODY_BITS-1:BODY_BITS];

wire signed [BODY_BITS+1:0] dx_plus_dy;
wire signed [BODY_BITS+1:0] dy_plus_dz;
wire signed [BODY_BITS+1:0] dz_plus_dx;
wire signed [BODY_BITS+2:0] dx_plus_dy_plus_dz;

assign dx_plus_dy = dx + dy;
assign dy_plus_dz = dy + dz;
assign dz_plus_dx = dz + dx;
assign dx_plus_dy_plus_dz = dx + dy + dz;

// The int part = 0 means dx < 1
assign pass = (input_valid &&
		 int_part_x == 0 && 
	    int_part_y == 0 && 
		 int_part_z == 0 && 
	    dx_plus_dy < SQRT_2 && 
	    dy_plus_dz < SQRT_2 && 
		 dz_plus_dx < SQRT_2 && 
		 dx_plus_dy_plus_dz < SQRT_3) ? 1'b1 : 1'b0;

endmodule