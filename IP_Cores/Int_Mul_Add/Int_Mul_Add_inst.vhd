	component Int_Mul_Add is
		port (
			dataa_0 : in  std_logic_vector(3 downto 0) := (others => 'X'); -- dataa_0
			datab_0 : in  std_logic_vector(3 downto 0) := (others => 'X'); -- datab_0
			result  : out std_logic_vector(3 downto 0)                     -- result
		);
	end component Int_Mul_Add;

	u0 : component Int_Mul_Add
		port map (
			dataa_0 => CONNECTED_TO_dataa_0, -- dataa_0.dataa_0
			datab_0 => CONNECTED_TO_datab_0, -- datab_0.datab_0
			result  => CONNECTED_TO_result   --  result.result
		);

