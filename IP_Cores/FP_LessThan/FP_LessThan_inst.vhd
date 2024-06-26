	component FP_LessThan is
		port (
			a      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- a
			areset : in  std_logic                     := 'X';             -- reset
			b      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- b
			clk    : in  std_logic                     := 'X';             -- clk
			q      : out std_logic_vector(0 downto 0)                      -- q
		);
	end component FP_LessThan;

	u0 : component FP_LessThan
		port map (
			a      => CONNECTED_TO_a,      --      a.a
			areset => CONNECTED_TO_areset, -- areset.reset
			b      => CONNECTED_TO_b,      --      b.b
			clk    => CONNECTED_TO_clk,    --    clk.clk
			q      => CONNECTED_TO_q       --      q.q
		);

