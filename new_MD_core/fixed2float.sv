import md_pkg::*;

/* The input cell id should be increased by 1 so the first cell has the id of 1 instead of 0 */
/* ASSUMPTION: CELL_ID_WIDTH NEVER EXCEEDS 8 BITS */

module fixed2float(
	input [31:0] a, 
	output reg [31:0] q
);

// Disregard the first bit since it's always 0
wire [CELL_ID_WIDTH-1:0] cell_id;
assign cell_id = a[31:32-CELL_ID_WIDTH];

reg [DECIMAL_ADDR_WIDTH-1:0] decimal_pt;
reg [7:0] new_exp;

always@(*)
	begin
	// The 1st bit in cell_id is 0, so no need to consider it
	casex(cell_id)
		3'b01x:
			begin
			decimal_pt = 2'b01;
			q[22:0] = a[32-CELL_ID_WIDTH:10-CELL_ID_WIDTH];
			end
		3'b001:
			begin
			decimal_pt = 2'b00;
			q[22:0] = a[31-CELL_ID_WIDTH:9-CELL_ID_WIDTH];
			end
		default:
			begin
			decimal_pt = 2'b00;
			q[22:0] = 0;
			end
	endcase
	new_exp = EXP_0 + decimal_pt;
	q[31] = a[31];
	q[30:23] = new_exp;
	end

endmodule
