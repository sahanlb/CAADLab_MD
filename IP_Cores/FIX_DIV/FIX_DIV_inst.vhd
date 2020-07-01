	component FIX_DIV is
		port (
			clk         : in  std_logic                     := 'X';             -- clk
			denominator : in  std_logic_vector(31 downto 0) := (others => 'X'); -- denominator
			en          : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- en
			numerator   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- numerator
			result      : out std_logic_vector(31 downto 0);                    -- result
			rst         : in  std_logic                     := 'X'              -- reset
		);
	end component FIX_DIV;

	u0 : component FIX_DIV
		port map (
			clk         => CONNECTED_TO_clk,         --         clk.clk
			denominator => CONNECTED_TO_denominator, -- denominator.denominator
			en          => CONNECTED_TO_en,          --          en.en
			numerator   => CONNECTED_TO_numerator,   --   numerator.numerator
			result      => CONNECTED_TO_result,      --      result.result
			rst         => CONNECTED_TO_rst          --         rst.reset
		);

