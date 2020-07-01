	component FIX_ADD is
		port (
			a0     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- a0
			a1     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- a1
			clk    : in  std_logic                     := 'X';             -- clk
			en     : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- en
			result : out std_logic_vector(31 downto 0);                    -- result
			rst    : in  std_logic                     := 'X'              -- reset
		);
	end component FIX_ADD;

	u0 : component FIX_ADD
		port map (
			a0     => CONNECTED_TO_a0,     --     a0.a0
			a1     => CONNECTED_TO_a1,     --     a1.a1
			clk    => CONNECTED_TO_clk,    --    clk.clk
			en     => CONNECTED_TO_en,     --     en.en
			result => CONNECTED_TO_result, -- result.result
			rst    => CONNECTED_TO_rst     --    rst.reset
		);

