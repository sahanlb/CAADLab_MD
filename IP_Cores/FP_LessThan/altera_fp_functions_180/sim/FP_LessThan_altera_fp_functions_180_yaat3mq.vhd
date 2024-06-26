-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.0 (Release Build #219)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from FP_LessThan_altera_fp_functions_180_yaat3mq
-- VHDL created on Sat Dec 29 16:49:39 2018


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

library fourteennm;
use fourteennm.fourteennm_components.fourteennm_mac;
use fourteennm.fourteennm_components.fourteennm_fp_mac;

entity FP_LessThan_altera_fp_functions_180_yaat3mq is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        b : in std_logic_vector(31 downto 0);  -- float32_m23
        q : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end FP_LessThan_altera_fp_functions_180_yaat3mq;

architecture normal of FP_LessThan_altera_fp_functions_180_yaat3mq is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstAllOWE_uid6_fpCompareTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWF_uid7_fpCompareTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal cstAllZWE_uid8_fpCompareTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal exp_x_uid9_fpCompareTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_x_uid10_fpCompareTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_x_uid11_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_x_uid11_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid12_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid12_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid13_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid13_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid14_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid16_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exp_y_uid23_fpCompareTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_y_uid24_fpCompareTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_y_uid25_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid25_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid26_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid26_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid27_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid27_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid28_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid30_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneIsNaN_uid34_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oneIsNaN_uid34_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xNotZero_uid39_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yNotZero_uid40_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXPS_uid41_fpCompareTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracXPS_uid41_fpCompareTest_qi : STD_LOGIC_VECTOR (22 downto 0);
    signal fracXPS_uid41_fpCompareTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracYPS_uid42_fpCompareTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracYPS_uid42_fpCompareTest_qi : STD_LOGIC_VECTOR (22 downto 0);
    signal fracYPS_uid42_fpCompareTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expFracX_uid43_fpCompareTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal expFracY_uid45_fpCompareTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal efxGTefy_uid47_fpCompareTest_a : STD_LOGIC_VECTOR (32 downto 0);
    signal efxGTefy_uid47_fpCompareTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal efxGTefy_uid47_fpCompareTest_o : STD_LOGIC_VECTOR (32 downto 0);
    signal efxGTefy_uid47_fpCompareTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal efxLTefy_uid48_fpCompareTest_a : STD_LOGIC_VECTOR (32 downto 0);
    signal efxLTefy_uid48_fpCompareTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal efxLTefy_uid48_fpCompareTest_o : STD_LOGIC_VECTOR (32 downto 0);
    signal efxLTefy_uid48_fpCompareTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal signX_uid52_fpCompareTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signY_uid53_fpCompareTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal two_uid54_fpCompareTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal concSXSY_uid55_fpCompareTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal sxLTsy_uid56_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xorSigns_uid57_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sxEQsy_uid58_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracCompMux_uid59_fpCompareTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracCompMux_uid59_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneNonZero_uid62_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oneNonZero_uid62_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rc2_uid63_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rc2_uid63_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sxEQsyExpFracCompMux_uid64_fpCompareTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal sxEQsyExpFracCompMux_uid64_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid65_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rPostExc_uid66_fpCompareTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rPostExc_uid66_fpCompareTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_oneNonZero_uid62_fpCompareTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_signY_uid53_fpCompareTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_signX_uid52_fpCompareTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_oneIsNaN_uid34_fpCompareTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_frac_y_uid24_fpCompareTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist5_exp_y_uid23_fpCompareTest_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist6_exp_y_uid23_fpCompareTest_b_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist7_frac_x_uid10_fpCompareTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist8_exp_x_uid9_fpCompareTest_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist9_exp_x_uid9_fpCompareTest_b_2_q : STD_LOGIC_VECTOR (7 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- cstAllZWE_uid8_fpCompareTest(CONSTANT,7)
    cstAllZWE_uid8_fpCompareTest_q <= "00000000";

    -- exp_y_uid23_fpCompareTest(BITSELECT,22)@0
    exp_y_uid23_fpCompareTest_b <= b(30 downto 23);

    -- excZ_y_uid25_fpCompareTest(LOGICAL,24)@0 + 1
    excZ_y_uid25_fpCompareTest_qi <= "1" WHEN exp_y_uid23_fpCompareTest_b = cstAllZWE_uid8_fpCompareTest_q ELSE "0";
    excZ_y_uid25_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excZ_y_uid25_fpCompareTest_qi, xout => excZ_y_uid25_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- yNotZero_uid40_fpCompareTest(LOGICAL,39)@1
    yNotZero_uid40_fpCompareTest_q <= not (excZ_y_uid25_fpCompareTest_q);

    -- exp_x_uid9_fpCompareTest(BITSELECT,8)@0
    exp_x_uid9_fpCompareTest_b <= a(30 downto 23);

    -- excZ_x_uid11_fpCompareTest(LOGICAL,10)@0 + 1
    excZ_x_uid11_fpCompareTest_qi <= "1" WHEN exp_x_uid9_fpCompareTest_b = cstAllZWE_uid8_fpCompareTest_q ELSE "0";
    excZ_x_uid11_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excZ_x_uid11_fpCompareTest_qi, xout => excZ_x_uid11_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- xNotZero_uid39_fpCompareTest(LOGICAL,38)@1
    xNotZero_uid39_fpCompareTest_q <= not (excZ_x_uid11_fpCompareTest_q);

    -- oneNonZero_uid62_fpCompareTest(LOGICAL,61)@1 + 1
    oneNonZero_uid62_fpCompareTest_qi <= xNotZero_uid39_fpCompareTest_q or yNotZero_uid40_fpCompareTest_q;
    oneNonZero_uid62_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => oneNonZero_uid62_fpCompareTest_qi, xout => oneNonZero_uid62_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist0_oneNonZero_uid62_fpCompareTest_q_2(DELAY,67)
    redist0_oneNonZero_uid62_fpCompareTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => oneNonZero_uid62_fpCompareTest_q, xout => redist0_oneNonZero_uid62_fpCompareTest_q_2_q, clk => clk, aclr => areset, ena => '1' );

    -- two_uid54_fpCompareTest(CONSTANT,53)
    two_uid54_fpCompareTest_q <= "10";

    -- signX_uid52_fpCompareTest(BITSELECT,51)@0
    signX_uid52_fpCompareTest_b <= STD_LOGIC_VECTOR(a(31 downto 31));

    -- redist2_signX_uid52_fpCompareTest_b_3(DELAY,69)
    redist2_signX_uid52_fpCompareTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => signX_uid52_fpCompareTest_b, xout => redist2_signX_uid52_fpCompareTest_b_3_q, clk => clk, aclr => areset, ena => '1' );

    -- signY_uid53_fpCompareTest(BITSELECT,52)@0
    signY_uid53_fpCompareTest_b <= STD_LOGIC_VECTOR(b(31 downto 31));

    -- redist1_signY_uid53_fpCompareTest_b_3(DELAY,68)
    redist1_signY_uid53_fpCompareTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => signY_uid53_fpCompareTest_b, xout => redist1_signY_uid53_fpCompareTest_b_3_q, clk => clk, aclr => areset, ena => '1' );

    -- concSXSY_uid55_fpCompareTest(BITJOIN,54)@3
    concSXSY_uid55_fpCompareTest_q <= redist2_signX_uid52_fpCompareTest_b_3_q & redist1_signY_uid53_fpCompareTest_b_3_q;

    -- sxLTsy_uid56_fpCompareTest(LOGICAL,55)@3
    sxLTsy_uid56_fpCompareTest_q <= "1" WHEN concSXSY_uid55_fpCompareTest_q = two_uid54_fpCompareTest_q ELSE "0";

    -- rc2_uid63_fpCompareTest(LOGICAL,62)@3 + 1
    rc2_uid63_fpCompareTest_qi <= sxLTsy_uid56_fpCompareTest_q and redist0_oneNonZero_uid62_fpCompareTest_q_2_q;
    rc2_uid63_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rc2_uid63_fpCompareTest_qi, xout => rc2_uid63_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist8_exp_x_uid9_fpCompareTest_b_1(DELAY,75)
    redist8_exp_x_uid9_fpCompareTest_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => exp_x_uid9_fpCompareTest_b, xout => redist8_exp_x_uid9_fpCompareTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- redist9_exp_x_uid9_fpCompareTest_b_2(DELAY,76)
    redist9_exp_x_uid9_fpCompareTest_b_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist8_exp_x_uid9_fpCompareTest_b_1_q, xout => redist9_exp_x_uid9_fpCompareTest_b_2_q, clk => clk, aclr => areset, ena => '1' );

    -- frac_x_uid10_fpCompareTest(BITSELECT,9)@0
    frac_x_uid10_fpCompareTest_b <= a(22 downto 0);

    -- redist7_frac_x_uid10_fpCompareTest_b_1(DELAY,74)
    redist7_frac_x_uid10_fpCompareTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => frac_x_uid10_fpCompareTest_b, xout => redist7_frac_x_uid10_fpCompareTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- fracXPS_uid41_fpCompareTest(LOGICAL,40)@1 + 1
    fracXPS_uid41_fpCompareTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 1 => xNotZero_uid39_fpCompareTest_q(0)) & xNotZero_uid39_fpCompareTest_q));
    fracXPS_uid41_fpCompareTest_qi <= redist7_frac_x_uid10_fpCompareTest_b_1_q and fracXPS_uid41_fpCompareTest_b;
    fracXPS_uid41_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracXPS_uid41_fpCompareTest_qi, xout => fracXPS_uid41_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- expFracX_uid43_fpCompareTest(BITJOIN,42)@2
    expFracX_uid43_fpCompareTest_q <= redist9_exp_x_uid9_fpCompareTest_b_2_q & fracXPS_uid41_fpCompareTest_q;

    -- redist5_exp_y_uid23_fpCompareTest_b_1(DELAY,72)
    redist5_exp_y_uid23_fpCompareTest_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => exp_y_uid23_fpCompareTest_b, xout => redist5_exp_y_uid23_fpCompareTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- redist6_exp_y_uid23_fpCompareTest_b_2(DELAY,73)
    redist6_exp_y_uid23_fpCompareTest_b_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist5_exp_y_uid23_fpCompareTest_b_1_q, xout => redist6_exp_y_uid23_fpCompareTest_b_2_q, clk => clk, aclr => areset, ena => '1' );

    -- frac_y_uid24_fpCompareTest(BITSELECT,23)@0
    frac_y_uid24_fpCompareTest_b <= b(22 downto 0);

    -- redist4_frac_y_uid24_fpCompareTest_b_1(DELAY,71)
    redist4_frac_y_uid24_fpCompareTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => frac_y_uid24_fpCompareTest_b, xout => redist4_frac_y_uid24_fpCompareTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- fracYPS_uid42_fpCompareTest(LOGICAL,41)@1 + 1
    fracYPS_uid42_fpCompareTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 1 => yNotZero_uid40_fpCompareTest_q(0)) & yNotZero_uid40_fpCompareTest_q));
    fracYPS_uid42_fpCompareTest_qi <= redist4_frac_y_uid24_fpCompareTest_b_1_q and fracYPS_uid42_fpCompareTest_b;
    fracYPS_uid42_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracYPS_uid42_fpCompareTest_qi, xout => fracYPS_uid42_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- expFracY_uid45_fpCompareTest(BITJOIN,44)@2
    expFracY_uid45_fpCompareTest_q <= redist6_exp_y_uid23_fpCompareTest_b_2_q & fracYPS_uid42_fpCompareTest_q;

    -- efxGTefy_uid47_fpCompareTest(COMPARE,46)@2 + 1
    efxGTefy_uid47_fpCompareTest_a <= STD_LOGIC_VECTOR("00" & expFracY_uid45_fpCompareTest_q);
    efxGTefy_uid47_fpCompareTest_b <= STD_LOGIC_VECTOR("00" & expFracX_uid43_fpCompareTest_q);
    efxGTefy_uid47_fpCompareTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                efxGTefy_uid47_fpCompareTest_o <= (others => '0');
            ELSE
                efxGTefy_uid47_fpCompareTest_o <= STD_LOGIC_VECTOR(UNSIGNED(efxGTefy_uid47_fpCompareTest_a) - UNSIGNED(efxGTefy_uid47_fpCompareTest_b));
            END IF;
        END IF;
    END PROCESS;
    efxGTefy_uid47_fpCompareTest_c(0) <= efxGTefy_uid47_fpCompareTest_o(32);

    -- efxLTefy_uid48_fpCompareTest(COMPARE,47)@2 + 1
    efxLTefy_uid48_fpCompareTest_a <= STD_LOGIC_VECTOR("00" & expFracX_uid43_fpCompareTest_q);
    efxLTefy_uid48_fpCompareTest_b <= STD_LOGIC_VECTOR("00" & expFracY_uid45_fpCompareTest_q);
    efxLTefy_uid48_fpCompareTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                efxLTefy_uid48_fpCompareTest_o <= (others => '0');
            ELSE
                efxLTefy_uid48_fpCompareTest_o <= STD_LOGIC_VECTOR(UNSIGNED(efxLTefy_uid48_fpCompareTest_a) - UNSIGNED(efxLTefy_uid48_fpCompareTest_b));
            END IF;
        END IF;
    END PROCESS;
    efxLTefy_uid48_fpCompareTest_c(0) <= efxLTefy_uid48_fpCompareTest_o(32);

    -- expFracCompMux_uid59_fpCompareTest(MUX,58)@3
    expFracCompMux_uid59_fpCompareTest_s <= redist2_signX_uid52_fpCompareTest_b_3_q;
    expFracCompMux_uid59_fpCompareTest_combproc: PROCESS (expFracCompMux_uid59_fpCompareTest_s, efxLTefy_uid48_fpCompareTest_c, efxGTefy_uid47_fpCompareTest_c)
    BEGIN
        CASE (expFracCompMux_uid59_fpCompareTest_s) IS
            WHEN "0" => expFracCompMux_uid59_fpCompareTest_q <= efxLTefy_uid48_fpCompareTest_c;
            WHEN "1" => expFracCompMux_uid59_fpCompareTest_q <= efxGTefy_uid47_fpCompareTest_c;
            WHEN OTHERS => expFracCompMux_uid59_fpCompareTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- xorSigns_uid57_fpCompareTest(LOGICAL,56)@3
    xorSigns_uid57_fpCompareTest_q <= redist2_signX_uid52_fpCompareTest_b_3_q xor redist1_signY_uid53_fpCompareTest_b_3_q;

    -- sxEQsy_uid58_fpCompareTest(LOGICAL,57)@3
    sxEQsy_uid58_fpCompareTest_q <= not (xorSigns_uid57_fpCompareTest_q);

    -- sxEQsyExpFracCompMux_uid64_fpCompareTest(LOGICAL,63)@3 + 1
    sxEQsyExpFracCompMux_uid64_fpCompareTest_qi <= sxEQsy_uid58_fpCompareTest_q and expFracCompMux_uid59_fpCompareTest_q;
    sxEQsyExpFracCompMux_uid64_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sxEQsyExpFracCompMux_uid64_fpCompareTest_qi, xout => sxEQsyExpFracCompMux_uid64_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- r_uid65_fpCompareTest(LOGICAL,64)@4
    r_uid65_fpCompareTest_q <= sxEQsyExpFracCompMux_uid64_fpCompareTest_q or rc2_uid63_fpCompareTest_q;

    -- cstZeroWF_uid7_fpCompareTest(CONSTANT,6)
    cstZeroWF_uid7_fpCompareTest_q <= "00000000000000000000000";

    -- fracXIsZero_uid27_fpCompareTest(LOGICAL,26)@1 + 1
    fracXIsZero_uid27_fpCompareTest_qi <= "1" WHEN cstZeroWF_uid7_fpCompareTest_q = redist4_frac_y_uid24_fpCompareTest_b_1_q ELSE "0";
    fracXIsZero_uid27_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracXIsZero_uid27_fpCompareTest_qi, xout => fracXIsZero_uid27_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- fracXIsNotZero_uid28_fpCompareTest(LOGICAL,27)@2
    fracXIsNotZero_uid28_fpCompareTest_q <= not (fracXIsZero_uid27_fpCompareTest_q);

    -- cstAllOWE_uid6_fpCompareTest(CONSTANT,5)
    cstAllOWE_uid6_fpCompareTest_q <= "11111111";

    -- expXIsMax_uid26_fpCompareTest(LOGICAL,25)@1 + 1
    expXIsMax_uid26_fpCompareTest_qi <= "1" WHEN redist5_exp_y_uid23_fpCompareTest_b_1_q = cstAllOWE_uid6_fpCompareTest_q ELSE "0";
    expXIsMax_uid26_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => expXIsMax_uid26_fpCompareTest_qi, xout => expXIsMax_uid26_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- excN_y_uid30_fpCompareTest(LOGICAL,29)@2
    excN_y_uid30_fpCompareTest_q <= expXIsMax_uid26_fpCompareTest_q and fracXIsNotZero_uid28_fpCompareTest_q;

    -- fracXIsZero_uid13_fpCompareTest(LOGICAL,12)@1 + 1
    fracXIsZero_uid13_fpCompareTest_qi <= "1" WHEN cstZeroWF_uid7_fpCompareTest_q = redist7_frac_x_uid10_fpCompareTest_b_1_q ELSE "0";
    fracXIsZero_uid13_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracXIsZero_uid13_fpCompareTest_qi, xout => fracXIsZero_uid13_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- fracXIsNotZero_uid14_fpCompareTest(LOGICAL,13)@2
    fracXIsNotZero_uid14_fpCompareTest_q <= not (fracXIsZero_uid13_fpCompareTest_q);

    -- expXIsMax_uid12_fpCompareTest(LOGICAL,11)@1 + 1
    expXIsMax_uid12_fpCompareTest_qi <= "1" WHEN redist8_exp_x_uid9_fpCompareTest_b_1_q = cstAllOWE_uid6_fpCompareTest_q ELSE "0";
    expXIsMax_uid12_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => expXIsMax_uid12_fpCompareTest_qi, xout => expXIsMax_uid12_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- excN_x_uid16_fpCompareTest(LOGICAL,15)@2
    excN_x_uid16_fpCompareTest_q <= expXIsMax_uid12_fpCompareTest_q and fracXIsNotZero_uid14_fpCompareTest_q;

    -- oneIsNaN_uid34_fpCompareTest(LOGICAL,33)@2 + 1
    oneIsNaN_uid34_fpCompareTest_qi <= excN_x_uid16_fpCompareTest_q or excN_y_uid30_fpCompareTest_q;
    oneIsNaN_uid34_fpCompareTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => oneIsNaN_uid34_fpCompareTest_qi, xout => oneIsNaN_uid34_fpCompareTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist3_oneIsNaN_uid34_fpCompareTest_q_2(DELAY,70)
    redist3_oneIsNaN_uid34_fpCompareTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => oneIsNaN_uid34_fpCompareTest_q, xout => redist3_oneIsNaN_uid34_fpCompareTest_q_2_q, clk => clk, aclr => areset, ena => '1' );

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- rPostExc_uid66_fpCompareTest(MUX,65)@4
    rPostExc_uid66_fpCompareTest_s <= redist3_oneIsNaN_uid34_fpCompareTest_q_2_q;
    rPostExc_uid66_fpCompareTest_combproc: PROCESS (rPostExc_uid66_fpCompareTest_s, r_uid65_fpCompareTest_q, GND_q)
    BEGIN
        CASE (rPostExc_uid66_fpCompareTest_s) IS
            WHEN "0" => rPostExc_uid66_fpCompareTest_q <= r_uid65_fpCompareTest_q;
            WHEN "1" => rPostExc_uid66_fpCompareTest_q <= GND_q;
            WHEN OTHERS => rPostExc_uid66_fpCompareTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- xOut(GPOUT,4)@4
    q <= rPostExc_uid66_fpCompareTest_q;

END normal;
