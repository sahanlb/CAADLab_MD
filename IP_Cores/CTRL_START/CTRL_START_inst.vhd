	component CTRL_START is
		port (
			data    : in  std_logic_vector(0 downto 0) := (others => 'X'); -- datain
			address : in  std_logic_vector(0 downto 0) := (others => 'X'); -- address
			wren    : in  std_logic                    := 'X';             -- wren
			clock   : in  std_logic                    := 'X';             -- clk
			q       : out std_logic_vector(0 downto 0)                     -- dataout
		);
	end component CTRL_START;

	u0 : component CTRL_START
		port map (
			data    => CONNECTED_TO_data,    --  ram_input.datain
			address => CONNECTED_TO_address, --           .address
			wren    => CONNECTED_TO_wren,    --           .wren
			clock   => CONNECTED_TO_clock,   --           .clk
			q       => CONNECTED_TO_q        -- ram_output.dataout
		);

