	component eSRAM_test is
		port (
			c0_data_0       : in  std_logic_vector(35 downto 0) := (others => 'X'); -- s2c0_da_0
			c0_rdaddress_0  : in  std_logic_vector(14 downto 0) := (others => 'X'); -- s2c0_adrb_0
			c0_rden_n_0     : in  std_logic                     := 'X';             -- s2c0_meb_n_0
			c0_sd_n_0       : in  std_logic                     := 'X';             -- s2c0_sd_n_0
			c0_wraddress_0  : in  std_logic_vector(14 downto 0) := (others => 'X'); -- s2c0_adra_0
			c0_wren_n_0     : in  std_logic                     := 'X';             -- s2c0_mea_n_0
			c1_data_0       : in  std_logic_vector(35 downto 0) := (others => 'X'); -- s2c1_da_0
			c1_rdaddress_0  : in  std_logic_vector(14 downto 0) := (others => 'X'); -- s2c1_adrb_0
			c1_rden_n_0     : in  std_logic                     := 'X';             -- s2c1_meb_n_0
			c1_sd_n_0       : in  std_logic                     := 'X';             -- s2c1_sd_n_0
			c1_wraddress_0  : in  std_logic_vector(14 downto 0) := (others => 'X'); -- s2c1_adra_0
			c1_wren_n_0     : in  std_logic                     := 'X';             -- s2c1_mea_n_0
			c2_data_0       : in  std_logic_vector(35 downto 0) := (others => 'X'); -- s2c2_da_0
			c2_rdaddress_0  : in  std_logic_vector(14 downto 0) := (others => 'X'); -- s2c2_adrb_0
			c2_rden_n_0     : in  std_logic                     := 'X';             -- s2c2_meb_n_0
			c2_sd_n_0       : in  std_logic                     := 'X';             -- s2c2_sd_n_0
			c2_wraddress_0  : in  std_logic_vector(14 downto 0) := (others => 'X'); -- s2c2_adra_0
			c2_wren_n_0     : in  std_logic                     := 'X';             -- s2c2_mea_n_0
			refclk          : in  std_logic                     := 'X';             -- clock
			c0_q_0          : out std_logic_vector(35 downto 0);                    -- s2c0_qb_0
			c1_q_0          : out std_logic_vector(35 downto 0);                    -- s2c1_qb_0
			c2_q_0          : out std_logic_vector(35 downto 0);                    -- s2c2_qb_0
			esram2f_clk     : out std_logic;                                        -- esram2f_clk
			iopll_lock2core : out std_logic                                         -- iopll_lock2core
		);
	end component eSRAM_test;

	u0 : component eSRAM_test
		port map (
			c0_data_0       => CONNECTED_TO_c0_data_0,       --  ram_input.s2c0_da_0
			c0_rdaddress_0  => CONNECTED_TO_c0_rdaddress_0,  --           .s2c0_adrb_0
			c0_rden_n_0     => CONNECTED_TO_c0_rden_n_0,     --           .s2c0_meb_n_0
			c0_sd_n_0       => CONNECTED_TO_c0_sd_n_0,       --           .s2c0_sd_n_0
			c0_wraddress_0  => CONNECTED_TO_c0_wraddress_0,  --           .s2c0_adra_0
			c0_wren_n_0     => CONNECTED_TO_c0_wren_n_0,     --           .s2c0_mea_n_0
			c1_data_0       => CONNECTED_TO_c1_data_0,       --           .s2c1_da_0
			c1_rdaddress_0  => CONNECTED_TO_c1_rdaddress_0,  --           .s2c1_adrb_0
			c1_rden_n_0     => CONNECTED_TO_c1_rden_n_0,     --           .s2c1_meb_n_0
			c1_sd_n_0       => CONNECTED_TO_c1_sd_n_0,       --           .s2c1_sd_n_0
			c1_wraddress_0  => CONNECTED_TO_c1_wraddress_0,  --           .s2c1_adra_0
			c1_wren_n_0     => CONNECTED_TO_c1_wren_n_0,     --           .s2c1_mea_n_0
			c2_data_0       => CONNECTED_TO_c2_data_0,       --           .s2c2_da_0
			c2_rdaddress_0  => CONNECTED_TO_c2_rdaddress_0,  --           .s2c2_adrb_0
			c2_rden_n_0     => CONNECTED_TO_c2_rden_n_0,     --           .s2c2_meb_n_0
			c2_sd_n_0       => CONNECTED_TO_c2_sd_n_0,       --           .s2c2_sd_n_0
			c2_wraddress_0  => CONNECTED_TO_c2_wraddress_0,  --           .s2c2_adra_0
			c2_wren_n_0     => CONNECTED_TO_c2_wren_n_0,     --           .s2c2_mea_n_0
			refclk          => CONNECTED_TO_refclk,          --           .clock
			c0_q_0          => CONNECTED_TO_c0_q_0,          -- ram_output.s2c0_qb_0
			c1_q_0          => CONNECTED_TO_c1_q_0,          --           .s2c1_qb_0
			c2_q_0          => CONNECTED_TO_c2_q_0,          --           .s2c2_qb_0
			esram2f_clk     => CONNECTED_TO_esram2f_clk,     --           .esram2f_clk
			iopll_lock2core => CONNECTED_TO_iopll_lock2core  --           .iopll_lock2core
		);

