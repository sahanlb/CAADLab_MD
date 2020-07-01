module test_sub_32
(
	input [31:0] a, 
	input [31:0] b,
	output [31:0] q
);

assign q = a-b;

endmodule