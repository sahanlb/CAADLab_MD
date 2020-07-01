	FIX_DIV u0 (
		.clk         (_connected_to_clk_),         //   input,   width = 1,         clk.clk
		.denominator (_connected_to_denominator_), //   input,  width = 32, denominator.denominator
		.en          (_connected_to_en_),          //   input,   width = 1,          en.en
		.numerator   (_connected_to_numerator_),   //   input,  width = 32,   numerator.numerator
		.result      (_connected_to_result_),      //  output,  width = 32,      result.result
		.rst         (_connected_to_rst_)          //   input,   width = 1,         rst.reset
	);

