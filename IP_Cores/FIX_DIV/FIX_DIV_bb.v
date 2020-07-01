module FIX_DIV (
		input  wire        clk,         //         clk.clk
		input  wire [31:0] denominator, // denominator.denominator
		input  wire [0:0]  en,          //          en.en
		input  wire [31:0] numerator,   //   numerator.numerator
		output wire [31:0] result,      //      result.result
		input  wire        rst          //         rst.reset
	);
endmodule

