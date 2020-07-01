// Add float displacement back to fixed position
module float2fixed
#(
	parameter OFFSET_WIDTH = 29, 
	parameter DATA_WIDTH = 32, 
	parameter EXP_0 = 8'b01111111
)
(
	input [DATA_WIDTH-1:0] a, 
	input [OFFSET_WIDTH-1:0] b, 
	
	output reg [1:0] cell_offset, 
	output [OFFSET_WIDTH-1:0] q
);

wire [7:0] exp;
wire [7:0] shift;
wire [OFFSET_WIDTH-1:0] mantissa_ext;
wire [OFFSET_WIDTH-1:0] fixed;
reg [OFFSET_WIDTH:0] sum;

assign exp = a[30:23];
assign mantissa_ext = {1'b1, a[22:0], {(OFFSET_WIDTH-24){1'b0}}};
assign shift = EXP_0-exp;
assign fixed = mantissa_ext >> shift;
assign q = sum[OFFSET_WIDTH-1:0];

always@(*)
	begin
	// Negative displacement
	if (a[31])
		begin
		sum = b-fixed;
		// Underflow, meaning particle migrates to the cell at x-. 2's complement is taken advantage of
		if (sum[OFFSET_WIDTH])
			begin
			cell_offset = 2'b11;
			end
		// Particle remains in the same cell
		else
			begin
			cell_offset = 2'b00;
			end
		end
	else
		begin
		sum = b+fixed;
		// Overflow, meaning the particle migrates to the cell at x+.
		if (sum[OFFSET_WIDTH])
			begin
			cell_offset = 2'b01;
			end
		// Particle remains in the same cell
		else
			begin
			cell_offset = 2'b00;
			end
		end
	end

endmodule