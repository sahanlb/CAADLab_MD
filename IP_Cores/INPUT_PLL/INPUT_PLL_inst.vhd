	component INPUT_PLL is
		port (
			locked   : out std_logic;        -- export
			outclk_0 : out std_logic;        -- clk
			refclk   : in  std_logic := 'X'; -- clk
			rst      : in  std_logic := 'X'  -- reset
		);
	end component INPUT_PLL;

	u0 : component INPUT_PLL
		port map (
			locked   => CONNECTED_TO_locked,   --  locked.export
			outclk_0 => CONNECTED_TO_outclk_0, -- outclk0.clk
			refclk   => CONNECTED_TO_refclk,   --  refclk.clk
			rst      => CONNECTED_TO_rst       --   reset.reset
		);

