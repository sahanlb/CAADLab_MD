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

-- VHDL created from FIX_MUL_altera_fxp_functions_180_ua7mybq
-- VHDL created on Thu Mar 28 18:38:53 2019


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

entity FIX_MUL_altera_fxp_functions_180_ua7mybq is
    port (
        a : in std_logic_vector(31 downto 0);  -- sfix32
        b : in std_logic_vector(31 downto 0);  -- sfix32
        en : in std_logic_vector(0 downto 0);  -- ufix1
        result : out std_logic_vector(63 downto 0);  -- sfix64
        clk : in std_logic;
        rst : in std_logic
    );
end FIX_MUL_altera_fxp_functions_180_ua7mybq;

architecture normal of FIX_MUL_altera_fxp_functions_180_ua7mybq is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal multiplier_bs1_in : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_bs1_b : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_bs2_in : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_bs2_b : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_bs4_in : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_bs4_b : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_bjA5_q : STD_LOGIC_VECTOR (18 downto 0);
    signal multiplier_bs6_b : STD_LOGIC_VECTOR (13 downto 0);
    signal multiplier_bs7_b : STD_LOGIC_VECTOR (13 downto 0);
    signal multiplier_bs8_in : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_bs8_b : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_bjB9_q : STD_LOGIC_VECTOR (18 downto 0);
    signal multiplier_align_14_q : STD_LOGIC_VECTOR (51 downto 0);
    signal multiplier_align_14_qint : STD_LOGIC_VECTOR (51 downto 0);
    signal multiplier_result_add_0_0_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal multiplier_result_add_0_0_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal multiplier_result_add_0_0_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal multiplier_result_add_0_0_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal multiplier_result_add_0_0_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal multiplier_result_add_0_0_p2_of_2_a : STD_LOGIC_VECTOR (31 downto 0);
    signal multiplier_result_add_0_0_p2_of_2_b : STD_LOGIC_VECTOR (31 downto 0);
    signal multiplier_result_add_0_0_p2_of_2_o : STD_LOGIC_VECTOR (31 downto 0);
    signal multiplier_result_add_0_0_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal multiplier_result_add_0_0_p2_of_2_q : STD_LOGIC_VECTOR (29 downto 0);
    signal multiplier_result_add_0_0_BitJoin_for_q_q : STD_LOGIC_VECTOR (64 downto 0);
    signal multiplier_result_add_0_0_BitSelect_for_a_tessel1_2_b : STD_LOGIC_VECTOR (0 downto 0);
    signal multiplier_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (29 downto 0);
    signal multiplier_result_add_0_0_BitSelect_for_b_tessel0_0_b : STD_LOGIC_VECTOR (34 downto 0);
    signal multiplier_result_add_0_0_BitSelect_for_b_tessel1_0_b : STD_LOGIC_VECTOR (16 downto 0);
    signal multiplier_result_add_0_0_BitSelect_for_b_tessel1_1_b : STD_LOGIC_VECTOR (0 downto 0);
    signal multiplier_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (29 downto 0);
    signal multiplier_im0_cma_reset : std_logic;
    type multiplier_im0_cma_ahtype is array(NATURAL range <>) of UNSIGNED(17 downto 0);
    signal multiplier_im0_cma_ah : multiplier_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of multiplier_im0_cma_ah : signal is true;
    signal multiplier_im0_cma_ch : multiplier_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of multiplier_im0_cma_ch : signal is true;
    signal multiplier_im0_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_im0_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal multiplier_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal multiplier_im0_cma_qq : STD_LOGIC_VECTOR (35 downto 0);
    signal multiplier_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal multiplier_im0_cma_ena0 : std_logic;
    signal multiplier_im0_cma_ena1 : std_logic;
    signal multiplier_im0_cma_ena2 : std_logic;
    signal multiplier_im10_cma_reset : std_logic;
    type multiplier_im10_cma_ahtype is array(NATURAL range <>) of SIGNED(13 downto 0);
    signal multiplier_im10_cma_ah : multiplier_im10_cma_ahtype(0 to 0);
    attribute preserve_syn_only of multiplier_im10_cma_ah : signal is true;
    signal multiplier_im10_cma_ch : multiplier_im10_cma_ahtype(0 to 0);
    attribute preserve_syn_only of multiplier_im10_cma_ch : signal is true;
    signal multiplier_im10_cma_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal multiplier_im10_cma_c0 : STD_LOGIC_VECTOR (13 downto 0);
    signal multiplier_im10_cma_s0 : STD_LOGIC_VECTOR (27 downto 0);
    signal multiplier_im10_cma_qq : STD_LOGIC_VECTOR (27 downto 0);
    signal multiplier_im10_cma_q : STD_LOGIC_VECTOR (27 downto 0);
    signal multiplier_im10_cma_ena0 : std_logic;
    signal multiplier_im10_cma_ena1 : std_logic;
    signal multiplier_im10_cma_ena2 : std_logic;
    signal multiplier_ma3_cma_reset : std_logic;
    signal multiplier_ma3_cma_ah : multiplier_im10_cma_ahtype(0 to 1);
    attribute preserve_syn_only of multiplier_ma3_cma_ah : signal is true;
    type multiplier_ma3_cma_chtype is array(NATURAL range <>) of SIGNED(18 downto 0);
    signal multiplier_ma3_cma_ch : multiplier_ma3_cma_chtype(0 to 1);
    attribute preserve_syn_only of multiplier_ma3_cma_ch : signal is true;
    signal multiplier_ma3_cma_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal multiplier_ma3_cma_c0 : STD_LOGIC_VECTOR (18 downto 0);
    signal multiplier_ma3_cma_a1 : STD_LOGIC_VECTOR (13 downto 0);
    signal multiplier_ma3_cma_c1 : STD_LOGIC_VECTOR (18 downto 0);
    signal multiplier_ma3_cma_s0 : STD_LOGIC_VECTOR (33 downto 0);
    signal multiplier_ma3_cma_qq : STD_LOGIC_VECTOR (33 downto 0);
    signal multiplier_ma3_cma_q : STD_LOGIC_VECTOR (33 downto 0);
    signal multiplier_ma3_cma_ena0 : std_logic;
    signal multiplier_ma3_cma_ena1 : std_logic;
    signal multiplier_ma3_cma_ena2 : std_logic;
    signal multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_multiplier_ma3_cma_q_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist2_multiplier_im10_cma_q_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist3_multiplier_im0_cma_q_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_multiplier_result_add_0_0_BitSelect_for_b_tessel1_0_b_1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal redist18_multiplier_result_add_0_0_p1_of_2_q_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist19_multiplier_bs7_b_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist20_multiplier_bs6_b_1_q : STD_LOGIC_VECTOR (13 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- multiplier_bs4(BITSELECT,10)@0
    multiplier_bs4_in <= STD_LOGIC_VECTOR(a(17 downto 0));
    multiplier_bs4_b <= STD_LOGIC_VECTOR(multiplier_bs4_in(17 downto 0));

    -- multiplier_bjA5(BITJOIN,11)@0
    multiplier_bjA5_q <= GND_q & multiplier_bs4_b;

    -- multiplier_bs6(BITSELECT,12)@0
    multiplier_bs6_b <= STD_LOGIC_VECTOR(b(31 downto 18));

    -- multiplier_bs8(BITSELECT,14)@0
    multiplier_bs8_in <= STD_LOGIC_VECTOR(b(17 downto 0));
    multiplier_bs8_b <= STD_LOGIC_VECTOR(multiplier_bs8_in(17 downto 0));

    -- multiplier_bjB9(BITJOIN,15)@0
    multiplier_bjB9_q <= GND_q & multiplier_bs8_b;

    -- multiplier_bs7(BITSELECT,13)@0
    multiplier_bs7_b <= STD_LOGIC_VECTOR(a(31 downto 18));

    -- multiplier_ma3_cma(CHAINMULTADD,59)@0 + 5
    -- out q@6
    multiplier_ma3_cma_reset <= rst;
    multiplier_ma3_cma_ena0 <= en(0) or multiplier_ma3_cma_reset;
    multiplier_ma3_cma_ena1 <= multiplier_ma3_cma_ena0;
    multiplier_ma3_cma_ena2 <= multiplier_ma3_cma_ena0;
    multiplier_ma3_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    multiplier_ma3_cma_ah(0) <= RESIZE(SIGNED(multiplier_bs7_b),14);
                    multiplier_ma3_cma_ah(1) <= RESIZE(SIGNED(multiplier_bs6_b),14);
                    multiplier_ma3_cma_ch(0) <= RESIZE(SIGNED(multiplier_bjB9_q),19);
                    multiplier_ma3_cma_ch(1) <= RESIZE(SIGNED(multiplier_bjA5_q),19);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    multiplier_ma3_cma_a0 <= STD_LOGIC_VECTOR(multiplier_ma3_cma_ah(0));
    multiplier_ma3_cma_c0 <= STD_LOGIC_VECTOR(multiplier_ma3_cma_ch(0));
    multiplier_ma3_cma_a1 <= STD_LOGIC_VECTOR(multiplier_ma3_cma_ah(1));
    multiplier_ma3_cma_c1 <= STD_LOGIC_VECTOR(multiplier_ma3_cma_ch(1));
    multiplier_ma3_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_sumof2",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 19,
        by_clock => "0",
        by_width => 19,
        ax_clock => "0",
        bx_clock => "0",
        ax_width => 14,
        bx_width => 14,
        signed_may => "true",
        signed_mby => "true",
        signed_max => "true",
        signed_mbx => "true",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 34
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => multiplier_ma3_cma_ena0,
        ena(1) => multiplier_ma3_cma_ena1,
        ena(2) => multiplier_ma3_cma_ena2,
        clr(0) => multiplier_ma3_cma_reset,
        clr(1) => multiplier_ma3_cma_reset,
        ay => multiplier_ma3_cma_c1,
        by => multiplier_ma3_cma_c0,
        ax => multiplier_ma3_cma_a1,
        bx => multiplier_ma3_cma_a0,
        resulta => multiplier_ma3_cma_s0
    );
    multiplier_ma3_cma_delay : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_ma3_cma_s0, xout => multiplier_ma3_cma_qq, ena => en(0), clk => clk, aclr => rst );
    multiplier_ma3_cma_q <= STD_LOGIC_VECTOR(multiplier_ma3_cma_qq(33 downto 0));

    -- redist1_multiplier_ma3_cma_q_1(DELAY,62)
    redist1_multiplier_ma3_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_ma3_cma_q, xout => redist1_multiplier_ma3_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- multiplier_align_14(BITSHIFT,20)@7
    multiplier_align_14_qint <= redist1_multiplier_ma3_cma_q_1_q & "000000000000000000";
    multiplier_align_14_q <= multiplier_align_14_qint(51 downto 0);

    -- multiplier_result_add_0_0_BitSelect_for_b_tessel0_0(BITSELECT,40)@7
    multiplier_result_add_0_0_BitSelect_for_b_tessel0_0_b <= STD_LOGIC_VECTOR(multiplier_align_14_q(34 downto 0));

    -- multiplier_bs2(BITSELECT,8)@0
    multiplier_bs2_in <= b(17 downto 0);
    multiplier_bs2_b <= multiplier_bs2_in(17 downto 0);

    -- multiplier_bs1(BITSELECT,7)@0
    multiplier_bs1_in <= a(17 downto 0);
    multiplier_bs1_b <= multiplier_bs1_in(17 downto 0);

    -- multiplier_im0_cma(CHAINMULTADD,57)@0 + 5
    -- out q@6
    multiplier_im0_cma_reset <= rst;
    multiplier_im0_cma_ena0 <= en(0) or multiplier_im0_cma_reset;
    multiplier_im0_cma_ena1 <= multiplier_im0_cma_ena0;
    multiplier_im0_cma_ena2 <= multiplier_im0_cma_ena0;
    multiplier_im0_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    multiplier_im0_cma_ah(0) <= RESIZE(UNSIGNED(multiplier_bs1_b),18);
                    multiplier_im0_cma_ch(0) <= RESIZE(UNSIGNED(multiplier_bs2_b),18);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    multiplier_im0_cma_a0 <= STD_LOGIC_VECTOR(multiplier_im0_cma_ah(0));
    multiplier_im0_cma_c0 <= STD_LOGIC_VECTOR(multiplier_im0_cma_ch(0));
    multiplier_im0_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 18,
        ax_clock => "0",
        ax_width => 18,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 36,
        bx_width => 1,
        by_width => 1,
        result_b_width => 1
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => multiplier_im0_cma_ena0,
        ena(1) => multiplier_im0_cma_ena1,
        ena(2) => multiplier_im0_cma_ena2,
        clr(0) => multiplier_im0_cma_reset,
        clr(1) => multiplier_im0_cma_reset,
        ay => multiplier_im0_cma_a0,
        ax => multiplier_im0_cma_c0,
        resulta => multiplier_im0_cma_s0
    );
    multiplier_im0_cma_delay : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_im0_cma_s0, xout => multiplier_im0_cma_qq, ena => en(0), clk => clk, aclr => rst );
    multiplier_im0_cma_q <= STD_LOGIC_VECTOR(multiplier_im0_cma_qq(35 downto 0));

    -- redist3_multiplier_im0_cma_q_1(DELAY,64)
    redist3_multiplier_im0_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_im0_cma_q, xout => redist3_multiplier_im0_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select(BITSELECT,60)@7
    multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(redist3_multiplier_im0_cma_q_1_q(34 downto 0));
    multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(redist3_multiplier_im0_cma_q_1_q(35 downto 35));

    -- multiplier_result_add_0_0_p1_of_2(ADD,31)@7 + 1
    multiplier_result_add_0_0_p1_of_2_a <= STD_LOGIC_VECTOR("0" & multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b);
    multiplier_result_add_0_0_p1_of_2_b <= STD_LOGIC_VECTOR("0" & multiplier_result_add_0_0_BitSelect_for_b_tessel0_0_b);
    multiplier_result_add_0_0_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                multiplier_result_add_0_0_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    multiplier_result_add_0_0_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(multiplier_result_add_0_0_p1_of_2_a) + UNSIGNED(multiplier_result_add_0_0_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    multiplier_result_add_0_0_p1_of_2_c(0) <= multiplier_result_add_0_0_p1_of_2_o(35);
    multiplier_result_add_0_0_p1_of_2_q <= multiplier_result_add_0_0_p1_of_2_o(34 downto 0);

    -- multiplier_result_add_0_0_BitSelect_for_b_tessel1_1(BITSELECT,43)@7
    multiplier_result_add_0_0_BitSelect_for_b_tessel1_1_b <= STD_LOGIC_VECTOR(multiplier_align_14_q(51 downto 51));

    -- redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1(DELAY,65)
    redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_result_add_0_0_BitSelect_for_b_tessel1_1_b, xout => redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- multiplier_result_add_0_0_BitSelect_for_b_tessel1_0(BITSELECT,42)@7
    multiplier_result_add_0_0_BitSelect_for_b_tessel1_0_b <= STD_LOGIC_VECTOR(multiplier_align_14_q(51 downto 35));

    -- redist17_multiplier_result_add_0_0_BitSelect_for_b_tessel1_0_b_1(DELAY,78)
    redist17_multiplier_result_add_0_0_BitSelect_for_b_tessel1_0_b_1 : dspba_delay
    GENERIC MAP ( width => 17, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_result_add_0_0_BitSelect_for_b_tessel1_0_b, xout => redist17_multiplier_result_add_0_0_BitSelect_for_b_tessel1_0_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- multiplier_result_add_0_0_BitSelect_for_b_BitJoin_for_c(BITJOIN,56)@8
    multiplier_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q <= redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist4_multiplier_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist17_multiplier_result_add_0_0_BitSelect_for_b_tessel1_0_b_1_q;

    -- multiplier_result_add_0_0_BitSelect_for_a_tessel1_2(BITSELECT,38)@8
    multiplier_result_add_0_0_BitSelect_for_a_tessel1_2_b <= STD_LOGIC_VECTOR(redist2_multiplier_im10_cma_q_1_q(27 downto 27));

    -- redist20_multiplier_bs6_b_1(DELAY,81)
    redist20_multiplier_bs6_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_bs6_b, xout => redist20_multiplier_bs6_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist19_multiplier_bs7_b_1(DELAY,80)
    redist19_multiplier_bs7_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_bs7_b, xout => redist19_multiplier_bs7_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- multiplier_im10_cma(CHAINMULTADD,58)@1 + 5
    -- out q@7
    multiplier_im10_cma_reset <= rst;
    multiplier_im10_cma_ena0 <= en(0) or multiplier_im10_cma_reset;
    multiplier_im10_cma_ena1 <= multiplier_im10_cma_ena0;
    multiplier_im10_cma_ena2 <= multiplier_im10_cma_ena0;
    multiplier_im10_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    multiplier_im10_cma_ah(0) <= RESIZE(SIGNED(redist19_multiplier_bs7_b_1_q),14);
                    multiplier_im10_cma_ch(0) <= RESIZE(SIGNED(redist20_multiplier_bs6_b_1_q),14);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    multiplier_im10_cma_a0 <= STD_LOGIC_VECTOR(multiplier_im10_cma_ah(0));
    multiplier_im10_cma_c0 <= STD_LOGIC_VECTOR(multiplier_im10_cma_ch(0));
    multiplier_im10_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 14,
        ax_clock => "0",
        ax_width => 14,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 28,
        bx_width => 1,
        by_width => 1,
        result_b_width => 1
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => multiplier_im10_cma_ena0,
        ena(1) => multiplier_im10_cma_ena1,
        ena(2) => multiplier_im10_cma_ena2,
        clr(0) => multiplier_im10_cma_reset,
        clr(1) => multiplier_im10_cma_reset,
        ay => multiplier_im10_cma_a0,
        ax => multiplier_im10_cma_c0,
        resulta => multiplier_im10_cma_s0
    );
    multiplier_im10_cma_delay : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_im10_cma_s0, xout => multiplier_im10_cma_qq, ena => en(0), clk => clk, aclr => rst );
    multiplier_im10_cma_q <= STD_LOGIC_VECTOR(multiplier_im10_cma_qq(27 downto 0));

    -- redist2_multiplier_im10_cma_q_1(DELAY,63)
    redist2_multiplier_im10_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_im10_cma_q, xout => redist2_multiplier_im10_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist0_multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1(DELAY,61)
    redist0_multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c, xout => redist0_multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- multiplier_result_add_0_0_BitSelect_for_a_BitJoin_for_c(BITJOIN,39)@8
    multiplier_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q <= multiplier_result_add_0_0_BitSelect_for_a_tessel1_2_b & redist2_multiplier_im10_cma_q_1_q & redist0_multiplier_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q;

    -- multiplier_result_add_0_0_p2_of_2(ADD,32)@8 + 1
    multiplier_result_add_0_0_p2_of_2_cin <= multiplier_result_add_0_0_p1_of_2_c;
    multiplier_result_add_0_0_p2_of_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => multiplier_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q(29)) & multiplier_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q) & '1');
    multiplier_result_add_0_0_p2_of_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => multiplier_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q(29)) & multiplier_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q) & multiplier_result_add_0_0_p2_of_2_cin(0));
    multiplier_result_add_0_0_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                multiplier_result_add_0_0_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    multiplier_result_add_0_0_p2_of_2_o <= STD_LOGIC_VECTOR(SIGNED(multiplier_result_add_0_0_p2_of_2_a) + SIGNED(multiplier_result_add_0_0_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    multiplier_result_add_0_0_p2_of_2_q <= multiplier_result_add_0_0_p2_of_2_o(30 downto 1);

    -- redist18_multiplier_result_add_0_0_p1_of_2_q_1(DELAY,79)
    redist18_multiplier_result_add_0_0_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multiplier_result_add_0_0_p1_of_2_q, xout => redist18_multiplier_result_add_0_0_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- multiplier_result_add_0_0_BitJoin_for_q(BITJOIN,33)@9
    multiplier_result_add_0_0_BitJoin_for_q_q <= multiplier_result_add_0_0_p2_of_2_q & redist18_multiplier_result_add_0_0_p1_of_2_q_1_q;

    -- out_rsrvd_fix(GPOUT,5)@9
    result <= multiplier_result_add_0_0_BitJoin_for_q_q(63 downto 0);

END normal;
