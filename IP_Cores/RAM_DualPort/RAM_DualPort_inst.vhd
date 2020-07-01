	component RAM_DualPort is
		port (
			data      : in  std_logic_vector(12287 downto 0) := (others => 'X'); -- datain
			wraddress : in  std_logic_vector(4 downto 0)     := (others => 'X'); -- wraddress
			rdaddress : in  std_logic_vector(9 downto 0)     := (others => 'X'); -- rdaddress
			wren      : in  std_logic                        := 'X';             -- wren
			clock     : in  std_logic                        := 'X';             -- clock
			q         : out std_logic_vector(383 downto 0)                       -- dataout
		);
	end component RAM_DualPort;

	u0 : component RAM_DualPort
		port map (
			data      => CONNECTED_TO_data,      --  ram_input.datain
			wraddress => CONNECTED_TO_wraddress, --           .wraddress
			rdaddress => CONNECTED_TO_rdaddress, --           .rdaddress
			wren      => CONNECTED_TO_wren,      --           .wren
			clock     => CONNECTED_TO_clock,     --           .clock
			q         => CONNECTED_TO_q          -- ram_output.dataout
		);

