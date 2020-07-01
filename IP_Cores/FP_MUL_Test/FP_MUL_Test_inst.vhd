	component FP_MUL_Test is
		port (
			ay     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- ay
			az     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- az
			clk    : in  std_logic                     := 'X';             -- clk
			clr    : in  std_logic                     := 'X';             -- clr
			ena    : in  std_logic                     := 'X';             -- ena
			result : out std_logic_vector(31 downto 0)                     -- result
		);
	end component FP_MUL_Test;

	u0 : component FP_MUL_Test
		port map (
			ay     => CONNECTED_TO_ay,     --     ay.ay
			az     => CONNECTED_TO_az,     --     az.az
			clk    => CONNECTED_TO_clk,    --    clk.clk
			clr    => CONNECTED_TO_clr,    --    clr.clr
			ena    => CONNECTED_TO_ena,    --    ena.ena
			result => CONNECTED_TO_result  -- result.result
		);

