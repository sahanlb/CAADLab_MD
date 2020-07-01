	component FIX_MUL is
		port (
			a      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- a
			b      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- b
			clk    : in  std_logic                     := 'X';             -- clk
			en     : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- en
			result : out std_logic_vector(63 downto 0);                    -- result
			rst    : in  std_logic                     := 'X'              -- reset
		);
	end component FIX_MUL;

	u0 : component FIX_MUL
		port map (
			a      => CONNECTED_TO_a,      --      a.a
			b      => CONNECTED_TO_b,      --      b.b
			clk    => CONNECTED_TO_clk,    --    clk.clk
			en     => CONNECTED_TO_en,     --     en.en
			result => CONNECTED_TO_result, -- result.result
			rst    => CONNECTED_TO_rst     --    rst.reset
		);

