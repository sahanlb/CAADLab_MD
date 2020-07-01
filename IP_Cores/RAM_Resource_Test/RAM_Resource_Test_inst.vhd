	component RAM_Resource_Test is
		port (
			data    : in  std_logic_vector(95 downto 0) := (others => 'X'); -- datain
			address : in  std_logic_vector(14 downto 0) := (others => 'X'); -- address
			wren    : in  std_logic                     := 'X';             -- wren
			clock   : in  std_logic                     := 'X';             -- clk
			q       : out std_logic_vector(95 downto 0)                     -- dataout
		);
	end component RAM_Resource_Test;

	u0 : component RAM_Resource_Test
		port map (
			data    => CONNECTED_TO_data,    --  ram_input.datain
			address => CONNECTED_TO_address, --           .address
			wren    => CONNECTED_TO_wren,    --           .wren
			clock   => CONNECTED_TO_clock,   --           .clk
			q       => CONNECTED_TO_q        -- ram_output.dataout
		);

