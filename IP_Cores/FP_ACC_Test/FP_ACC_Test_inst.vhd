	component FP_ACC_Test is
		port (
			ax     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- ax
			ay     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- ay
			clk    : in  std_logic                     := 'X';             -- clk
			clr    : in  std_logic                     := 'X';             -- clr
			ena    : in  std_logic                     := 'X';             -- ena
			result : out std_logic_vector(31 downto 0)                     -- result
		);
	end component FP_ACC_Test;

	u0 : component FP_ACC_Test
		port map (
			ax     => CONNECTED_TO_ax,     --     ax.ax
			ay     => CONNECTED_TO_ay,     --     ay.ay
			clk    => CONNECTED_TO_clk,    --    clk.clk
			clr    => CONNECTED_TO_clr,    --    clr.clr
			ena    => CONNECTED_TO_ena,    --    ena.ena
			result => CONNECTED_TO_result  -- result.result
		);

