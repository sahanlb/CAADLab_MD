	component FIX_SQRT is
		port (
			clk     : in  std_logic                     := 'X';             -- clk
			en      : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- en
			radical : in  std_logic_vector(31 downto 0) := (others => 'X'); -- radical
			result  : out std_logic_vector(31 downto 0);                    -- result
			rst     : in  std_logic                     := 'X'              -- reset
		);
	end component FIX_SQRT;

	u0 : component FIX_SQRT
		port map (
			clk     => CONNECTED_TO_clk,     --     clk.clk
			en      => CONNECTED_TO_en,      --      en.en
			radical => CONNECTED_TO_radical, -- radical.radical
			result  => CONNECTED_TO_result,  --  result.result
			rst     => CONNECTED_TO_rst      --     rst.reset
		);

