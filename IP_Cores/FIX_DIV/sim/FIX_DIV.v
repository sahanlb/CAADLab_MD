// FIX_DIV.v

// Generated using ACDS version 18.0 219

`timescale 1 ps / 1 ps
module FIX_DIV (
		input  wire        clk,         //         clk.clk
		input  wire [31:0] denominator, // denominator.denominator
		input  wire [0:0]  en,          //          en.en
		input  wire [31:0] numerator,   //   numerator.numerator
		output wire [31:0] result,      //      result.result
		input  wire        rst          //         rst.reset
	);

	FIX_DIV_altera_fxp_functions_180_z7uu2xi fxp_functions_0 (
		.clk         (clk),         //   input,   width = 1,         clk.clk
		.rst         (rst),         //   input,   width = 1,         rst.reset
		.en          (en),          //   input,   width = 1,          en.en
		.numerator   (numerator),   //   input,  width = 32,   numerator.numerator
		.denominator (denominator), //   input,  width = 32, denominator.denominator
		.result      (result)       //  output,  width = 32,      result.result
	);

endmodule
