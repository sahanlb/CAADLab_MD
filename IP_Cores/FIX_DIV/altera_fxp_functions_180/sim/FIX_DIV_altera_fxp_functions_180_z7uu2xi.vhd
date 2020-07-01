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

-- VHDL created from FIX_DIV_altera_fxp_functions_180_z7uu2xi
-- VHDL created on Thu Mar 28 19:07:56 2019


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

entity FIX_DIV_altera_fxp_functions_180_z7uu2xi is
    port (
        numerator : in std_logic_vector(31 downto 0);  -- ufix32
        denominator : in std_logic_vector(31 downto 0);  -- ufix32
        en : in std_logic_vector(0 downto 0);  -- ufix1
        result : out std_logic_vector(31 downto 0);  -- sfix32
        clk : in std_logic;
        rst : in std_logic
    );
end FIX_DIV_altera_fxp_functions_180_z7uu2xi;

architecture normal of FIX_DIV_altera_fxp_functions_180_z7uu2xi is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal normYNoLeadOne_uid11_divider_in : STD_LOGIC_VECTOR (30 downto 0);
    signal normYNoLeadOne_uid11_divider_b : STD_LOGIC_VECTOR (30 downto 0);
    signal paddingY_uid12_divider_q : STD_LOGIC_VECTOR (30 downto 0);
    signal updatedY_uid13_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal normYIsOneC2_uid15_divider_b : STD_LOGIC_VECTOR (0 downto 0);
    signal normYIsOne_uid16_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal normYIsOne_uid16_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yIsZero_uid17_divider_b : STD_LOGIC_VECTOR (31 downto 0);
    signal yIsZero_uid17_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal yIsZero_uid17_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yAddr_uid19_divider_b : STD_LOGIC_VECTOR (7 downto 0);
    signal yPPolyEval_uid20_divider_in : STD_LOGIC_VECTOR (22 downto 0);
    signal yPPolyEval_uid20_divider_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fxpInverseRes_uid22_divider_in : STD_LOGIC_VECTOR (38 downto 0);
    signal fxpInverseRes_uid22_divider_b : STD_LOGIC_VECTOR (32 downto 0);
    signal oneInvRes_uid23_divider_q : STD_LOGIC_VECTOR (32 downto 0);
    signal invResPostOneHandling2_uid24_divider_s : STD_LOGIC_VECTOR (0 downto 0);
    signal invResPostOneHandling2_uid24_divider_q : STD_LOGIC_VECTOR (32 downto 0);
    signal cWOut_uid25_divider_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rShiftCount_uid26_divider_a : STD_LOGIC_VECTOR (6 downto 0);
    signal rShiftCount_uid26_divider_b : STD_LOGIC_VECTOR (6 downto 0);
    signal rShiftCount_uid26_divider_o : STD_LOGIC_VECTOR (6 downto 0);
    signal rShiftCount_uid26_divider_q : STD_LOGIC_VECTOR (6 downto 0);
    signal prodPostRightShiftPost_uid29_divider_in : STD_LOGIC_VECTOR (63 downto 0);
    signal prodPostRightShiftPost_uid29_divider_b : STD_LOGIC_VECTOR (32 downto 0);
    signal allOnes_uid30_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal allOnes_uid30_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invAllOnes_uid32_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addOp2_uid33_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal prodPostRightShiftPostRnd_uid34_divider_a : STD_LOGIC_VECTOR (33 downto 0);
    signal prodPostRightShiftPostRnd_uid34_divider_b : STD_LOGIC_VECTOR (33 downto 0);
    signal prodPostRightShiftPostRnd_uid34_divider_o : STD_LOGIC_VECTOR (33 downto 0);
    signal prodPostRightShiftPostRnd_uid34_divider_q : STD_LOGIC_VECTOR (33 downto 0);
    signal prodPostRightShiftPostRndRange_uid35_divider_in : STD_LOGIC_VECTOR (32 downto 0);
    signal prodPostRightShiftPostRndRange_uid35_divider_b : STD_LOGIC_VECTOR (31 downto 0);
    signal cstValOvf_uid36_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal resFinal_uid37_divider_s : STD_LOGIC_VECTOR (0 downto 0);
    signal resFinal_uid37_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid39_zCount_uid9_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vCount_uid41_zCount_uid9_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid41_zCount_uid9_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid44_zCount_uid9_divider_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid44_zCount_uid9_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid45_zCount_uid9_divider_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid47_zCount_uid9_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid47_zCount_uid9_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid50_zCount_uid9_divider_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid50_zCount_uid9_divider_q : STD_LOGIC_VECTOR (15 downto 0);
    signal zs_uid51_zCount_uid9_divider_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vCount_uid53_zCount_uid9_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid53_zCount_uid9_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid56_zCount_uid9_divider_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid56_zCount_uid9_divider_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid57_zCount_uid9_divider_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid59_zCount_uid9_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid59_zCount_uid9_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid62_zCount_uid9_divider_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid62_zCount_uid9_divider_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid63_zCount_uid9_divider_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid65_zCount_uid9_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid65_zCount_uid9_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid68_zCount_uid9_divider_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid68_zCount_uid9_divider_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid70_zCount_uid9_divider_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid71_zCount_uid9_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid72_zCount_uid9_divider_q : STD_LOGIC_VECTOR (5 downto 0);
    signal yT1_uid90_invPolyEval_b : STD_LOGIC_VECTOR (13 downto 0);
    signal lowRangeB_uid92_invPolyEval_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid92_invPolyEval_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid93_invPolyEval_b : STD_LOGIC_VECTOR (12 downto 0);
    signal s1sumAHighB_uid94_invPolyEval_a : STD_LOGIC_VECTOR (21 downto 0);
    signal s1sumAHighB_uid94_invPolyEval_b : STD_LOGIC_VECTOR (21 downto 0);
    signal s1sumAHighB_uid94_invPolyEval_o : STD_LOGIC_VECTOR (21 downto 0);
    signal s1sumAHighB_uid94_invPolyEval_q : STD_LOGIC_VECTOR (21 downto 0);
    signal s1_uid95_invPolyEval_q : STD_LOGIC_VECTOR (22 downto 0);
    signal yT2_uid96_invPolyEval_b : STD_LOGIC_VECTOR (20 downto 0);
    signal lowRangeB_uid98_invPolyEval_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid98_invPolyEval_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid99_invPolyEval_b : STD_LOGIC_VECTOR (21 downto 0);
    signal s2sumAHighB_uid100_invPolyEval_a : STD_LOGIC_VECTOR (29 downto 0);
    signal s2sumAHighB_uid100_invPolyEval_b : STD_LOGIC_VECTOR (29 downto 0);
    signal s2sumAHighB_uid100_invPolyEval_o : STD_LOGIC_VECTOR (29 downto 0);
    signal s2sumAHighB_uid100_invPolyEval_q : STD_LOGIC_VECTOR (29 downto 0);
    signal s2_uid101_invPolyEval_q : STD_LOGIC_VECTOR (30 downto 0);
    signal lowRangeB_uid104_invPolyEval_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid104_invPolyEval_b : STD_LOGIC_VECTOR (1 downto 0);
    signal s3_uid107_invPolyEval_q : STD_LOGIC_VECTOR (40 downto 0);
    signal osig_uid110_pT1_uid91_invPolyEval_b : STD_LOGIC_VECTOR (13 downto 0);
    signal osig_uid113_pT2_uid97_invPolyEval_b : STD_LOGIC_VECTOR (22 downto 0);
    signal nx_mergedSignalTM_uid127_pT3_uid103_invPolyEval_q : STD_LOGIC_VECTOR (23 downto 0);
    signal aboveLeftY_bottomExtension_uid132_pT3_uid103_invPolyEval_q : STD_LOGIC_VECTOR (4 downto 0);
    signal aboveLeftY_mergedSignalTM_uid134_pT3_uid103_invPolyEval_q : STD_LOGIC_VECTOR (17 downto 0);
    signal rightBottomX_bottomExtension_uid136_pT3_uid103_invPolyEval_q : STD_LOGIC_VECTOR (11 downto 0);
    signal rightBottomX_mergedSignalTM_uid138_pT3_uid103_invPolyEval_q : STD_LOGIC_VECTOR (17 downto 0);
    signal lowRangeB_uid144_pT3_uid103_invPolyEval_in : STD_LOGIC_VECTOR (17 downto 0);
    signal lowRangeB_uid144_pT3_uid103_invPolyEval_b : STD_LOGIC_VECTOR (17 downto 0);
    signal lev1_a0_uid147_pT3_uid103_invPolyEval_q : STD_LOGIC_VECTOR (54 downto 0);
    signal os_uid148_pT3_uid103_invPolyEval_in : STD_LOGIC_VECTOR (52 downto 0);
    signal os_uid148_pT3_uid103_invPolyEval_b : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage0Idx1Rng16_uid153_normY_uid10_divider_in : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx1Rng16_uid153_normY_uid10_divider_b : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx1_uid154_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage0_uid158_normY_uid10_divider_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid158_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage1Idx1Rng4_uid160_normY_uid10_divider_in : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx1Rng4_uid160_normY_uid10_divider_b : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx1_uid161_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage1Idx2Rng8_uid163_normY_uid10_divider_in : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2Rng8_uid163_normY_uid10_divider_b : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2_uid164_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage1Idx3Rng12_uid166_normY_uid10_divider_in : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage1Idx3Rng12_uid166_normY_uid10_divider_b : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage1Idx3_uid167_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage1_uid169_normY_uid10_divider_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid169_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage2Idx1Rng1_uid171_normY_uid10_divider_in : STD_LOGIC_VECTOR (30 downto 0);
    signal leftShiftStage2Idx1Rng1_uid171_normY_uid10_divider_b : STD_LOGIC_VECTOR (30 downto 0);
    signal leftShiftStage2Idx1_uid172_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage2Idx2Rng2_uid174_normY_uid10_divider_in : STD_LOGIC_VECTOR (29 downto 0);
    signal leftShiftStage2Idx2Rng2_uid174_normY_uid10_divider_b : STD_LOGIC_VECTOR (29 downto 0);
    signal leftShiftStage2Idx2_uid175_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage2Idx3Pad3_uid176_normY_uid10_divider_q : STD_LOGIC_VECTOR (2 downto 0);
    signal leftShiftStage2Idx3Rng3_uid177_normY_uid10_divider_in : STD_LOGIC_VECTOR (28 downto 0);
    signal leftShiftStage2Idx3Rng3_uid177_normY_uid10_divider_b : STD_LOGIC_VECTOR (28 downto 0);
    signal leftShiftStage2Idx3_uid178_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage2_uid180_normY_uid10_divider_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage2_uid180_normY_uid10_divider_q : STD_LOGIC_VECTOR (31 downto 0);
    signal x0_uid182_normYIsOneC2_uid12_divider_in : STD_LOGIC_VECTOR (15 downto 0);
    signal x0_uid182_normYIsOneC2_uid12_divider_b : STD_LOGIC_VECTOR (15 downto 0);
    signal eq0_uid184_normYIsOneC2_uid12_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq0_uid184_normYIsOneC2_uid12_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal x1_uid185_normYIsOneC2_uid12_divider_b : STD_LOGIC_VECTOR (14 downto 0);
    signal eq1_uid187_normYIsOneC2_uid12_divider_a : STD_LOGIC_VECTOR (15 downto 0);
    signal eq1_uid187_normYIsOneC2_uid12_divider_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid187_normYIsOneC2_uid12_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal andEq_uid188_normYIsOneC2_uid12_divider_q : STD_LOGIC_VECTOR (0 downto 0);
    signal prodXInvY_uid27_divider_bs1_in : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_bs1_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_bs2_in : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_bs2_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_bs4_in : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_bs4_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_bjA5_q : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXInvY_uid27_divider_bs6_b : STD_LOGIC_VECTOR (14 downto 0);
    signal prodXInvY_uid27_divider_bjB7_q : STD_LOGIC_VECTOR (15 downto 0);
    signal prodXInvY_uid27_divider_bs8_b : STD_LOGIC_VECTOR (13 downto 0);
    signal prodXInvY_uid27_divider_bjA9_q : STD_LOGIC_VECTOR (14 downto 0);
    signal prodXInvY_uid27_divider_bs10_in : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_bs10_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_bjB11_q : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXInvY_uid27_divider_bs13_b : STD_LOGIC_VECTOR (13 downto 0);
    signal prodXInvY_uid27_divider_bs14_b : STD_LOGIC_VECTOR (14 downto 0);
    signal prodXInvY_uid27_divider_align_16_q : STD_LOGIC_VECTOR (53 downto 0);
    signal prodXInvY_uid27_divider_align_16_qint : STD_LOGIC_VECTOR (53 downto 0);
    signal rightShiftStage0Idx1Rng1_uid210_prodPostRightShift_uid28_divider_in : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage0Idx1Rng1_uid210_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (63 downto 0);
    signal rightShiftStage0Idx1_uid212_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage0Idx2Rng2_uid213_prodPostRightShift_uid28_divider_in : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage0Idx2Rng2_uid213_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (62 downto 0);
    signal rightShiftStage0Idx2_uid215_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage0Idx3Rng3_uid216_prodPostRightShift_uid28_divider_in : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage0Idx3Rng3_uid216_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage0Idx3_uid218_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage0_uid220_prodPostRightShift_uid28_divider_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage1Idx1Rng4_uid221_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (60 downto 0);
    signal rightShiftStage1Idx1_uid223_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage1Idx2Rng8_uid224_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (56 downto 0);
    signal rightShiftStage1Idx2_uid226_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage1Idx3Rng12_uid227_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (52 downto 0);
    signal rightShiftStage1Idx3_uid229_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage1_uid231_prodPostRightShift_uid28_divider_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage2Idx1Rng16_uid232_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx1_uid234_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage2Idx2Rng32_uid235_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage2Idx2_uid237_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage2Idx3Rng48_uid238_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (16 downto 0);
    signal rightShiftStage2Idx3Pad48_uid239_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage2Idx3_uid240_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage2_uid242_prodPostRightShift_uid28_divider_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid242_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage3Idx1Rng64_uid243_prodPostRightShift_uid28_divider_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage3Idx1Pad64_uid244_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (63 downto 0);
    signal rightShiftStage3Idx1_uid245_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage3_uid247_prodPostRightShift_uid28_divider_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage3_uid247_prodPostRightShift_uid28_divider_q : STD_LOGIC_VECTOR (64 downto 0);
    signal memoryC0_uid74_invTabGen_lutmem_reset0 : std_logic;
    signal memoryC0_uid74_invTabGen_lutmem_ia : STD_LOGIC_VECTOR (37 downto 0);
    signal memoryC0_uid74_invTabGen_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC0_uid74_invTabGen_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC0_uid74_invTabGen_lutmem_ir : STD_LOGIC_VECTOR (37 downto 0);
    signal memoryC0_uid74_invTabGen_lutmem_r : STD_LOGIC_VECTOR (37 downto 0);
    signal memoryC0_uid74_invTabGen_lutmem_enaOr_rst : std_logic;
    signal memoryC1_uid77_invTabGen_lutmem_reset0 : std_logic;
    signal memoryC1_uid77_invTabGen_lutmem_ia : STD_LOGIC_VECTOR (28 downto 0);
    signal memoryC1_uid77_invTabGen_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC1_uid77_invTabGen_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC1_uid77_invTabGen_lutmem_ir : STD_LOGIC_VECTOR (28 downto 0);
    signal memoryC1_uid77_invTabGen_lutmem_r : STD_LOGIC_VECTOR (28 downto 0);
    signal memoryC1_uid77_invTabGen_lutmem_enaOr_rst : std_logic;
    signal memoryC2_uid80_invTabGen_lutmem_reset0 : std_logic;
    signal memoryC2_uid80_invTabGen_lutmem_ia : STD_LOGIC_VECTOR (20 downto 0);
    signal memoryC2_uid80_invTabGen_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC2_uid80_invTabGen_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC2_uid80_invTabGen_lutmem_ir : STD_LOGIC_VECTOR (20 downto 0);
    signal memoryC2_uid80_invTabGen_lutmem_r : STD_LOGIC_VECTOR (20 downto 0);
    signal memoryC2_uid80_invTabGen_lutmem_enaOr_rst : std_logic;
    signal memoryC3_uid83_invTabGen_lutmem_reset0 : std_logic;
    signal memoryC3_uid83_invTabGen_lutmem_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal memoryC3_uid83_invTabGen_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC3_uid83_invTabGen_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC3_uid83_invTabGen_lutmem_ir : STD_LOGIC_VECTOR (13 downto 0);
    signal memoryC3_uid83_invTabGen_lutmem_r : STD_LOGIC_VECTOR (13 downto 0);
    signal memoryC3_uid83_invTabGen_lutmem_enaOr_rst : std_logic;
    signal s3sumAHighB_uid106_invPolyEval_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_p2_of_2_a : STD_LOGIC_VECTOR (5 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_p2_of_2_b : STD_LOGIC_VECTOR (5 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_p2_of_2_o : STD_LOGIC_VECTOR (5 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_p2_of_2_q : STD_LOGIC_VECTOR (3 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitJoin_for_q_q : STD_LOGIC_VECTOR (38 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_a : STD_LOGIC_VECTOR (3 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_b : STD_LOGIC_VECTOR (3 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_o : STD_LOGIC_VECTOR (3 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitJoin_for_q_q : STD_LOGIC_VECTOR (36 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p2_of_2_a : STD_LOGIC_VECTOR (33 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p2_of_2_b : STD_LOGIC_VECTOR (33 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p2_of_2_o : STD_LOGIC_VECTOR (33 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_p2_of_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_BitJoin_for_q_q : STD_LOGIC_VECTOR (66 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel0_0_b : STD_LOGIC_VECTOR (34 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_0_b : STD_LOGIC_VECTOR (2 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_1_b : STD_LOGIC_VECTOR (0 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (3 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_0_b : STD_LOGIC_VECTOR (29 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_1_b : STD_LOGIC_VECTOR (0 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel1_0_b : STD_LOGIC_VECTOR (0 downto 0);
    signal s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (3 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel0_0_b : STD_LOGIC_VECTOR (34 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_0_b : STD_LOGIC_VECTOR (0 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (1 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_0_b : STD_LOGIC_VECTOR (18 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b : STD_LOGIC_VECTOR (0 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (1 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (31 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel0_0_b : STD_LOGIC_VECTOR (34 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_0_b : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_1_b : STD_LOGIC_VECTOR (0 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (31 downto 0);
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_reset : std_logic;
    type prodXY_uid109_pT1_uid91_invPolyEval_cma_ahtype is array(NATURAL range <>) of UNSIGNED(13 downto 0);
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_ah : prodXY_uid109_pT1_uid91_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of prodXY_uid109_pT1_uid91_invPolyEval_cma_ah : signal is true;
    type prodXY_uid109_pT1_uid91_invPolyEval_cma_chtype is array(NATURAL range <>) of SIGNED(13 downto 0);
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_ch : prodXY_uid109_pT1_uid91_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid109_pT1_uid91_invPolyEval_cma_ch : signal is true;
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (13 downto 0);
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (27 downto 0);
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_qq : STD_LOGIC_VECTOR (27 downto 0);
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_q : STD_LOGIC_VECTOR (27 downto 0);
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid109_pT1_uid91_invPolyEval_cma_ena2 : std_logic;
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_reset : std_logic;
    type prodXY_uid112_pT2_uid97_invPolyEval_cma_ahtype is array(NATURAL range <>) of UNSIGNED(20 downto 0);
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_ah : prodXY_uid112_pT2_uid97_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid112_pT2_uid97_invPolyEval_cma_ah : signal is true;
    type prodXY_uid112_pT2_uid97_invPolyEval_cma_chtype is array(NATURAL range <>) of SIGNED(22 downto 0);
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_ch : prodXY_uid112_pT2_uid97_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid112_pT2_uid97_invPolyEval_cma_ch : signal is true;
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (20 downto 0);
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (22 downto 0);
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (43 downto 0);
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_qq : STD_LOGIC_VECTOR (43 downto 0);
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_q : STD_LOGIC_VECTOR (43 downto 0);
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid112_pT2_uid97_invPolyEval_cma_ena2 : std_logic;
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_reset : std_logic;
    type sm0_uid141_pT3_uid103_invPolyEval_cma_ahtype is array(NATURAL range <>) of SIGNED(17 downto 0);
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_ah : sm0_uid141_pT3_uid103_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of sm0_uid141_pT3_uid103_invPolyEval_cma_ah : signal is true;
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_ch : sm0_uid141_pT3_uid103_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of sm0_uid141_pT3_uid103_invPolyEval_cma_ch : signal is true;
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_qq : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_ena0 : std_logic;
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_ena1 : std_logic;
    signal sm0_uid141_pT3_uid103_invPolyEval_cma_ena2 : std_logic;
    signal prodXInvY_uid27_divider_im0_cma_reset : std_logic;
    type prodXInvY_uid27_divider_im0_cma_ahtype is array(NATURAL range <>) of UNSIGNED(17 downto 0);
    signal prodXInvY_uid27_divider_im0_cma_ah : prodXInvY_uid27_divider_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXInvY_uid27_divider_im0_cma_ah : signal is true;
    signal prodXInvY_uid27_divider_im0_cma_ch : prodXInvY_uid27_divider_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXInvY_uid27_divider_im0_cma_ch : signal is true;
    signal prodXInvY_uid27_divider_im0_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_im0_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid27_divider_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid27_divider_im0_cma_qq : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid27_divider_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid27_divider_im0_cma_ena0 : std_logic;
    signal prodXInvY_uid27_divider_im0_cma_ena1 : std_logic;
    signal prodXInvY_uid27_divider_im0_cma_ena2 : std_logic;
    signal prodXInvY_uid27_divider_im12_cma_reset : std_logic;
    type prodXInvY_uid27_divider_im12_cma_ahtype is array(NATURAL range <>) of UNSIGNED(14 downto 0);
    signal prodXInvY_uid27_divider_im12_cma_ah : prodXInvY_uid27_divider_im12_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXInvY_uid27_divider_im12_cma_ah : signal is true;
    signal prodXInvY_uid27_divider_im12_cma_ch : prodXY_uid109_pT1_uid91_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXInvY_uid27_divider_im12_cma_ch : signal is true;
    signal prodXInvY_uid27_divider_im12_cma_a0 : STD_LOGIC_VECTOR (14 downto 0);
    signal prodXInvY_uid27_divider_im12_cma_c0 : STD_LOGIC_VECTOR (13 downto 0);
    signal prodXInvY_uid27_divider_im12_cma_s0 : STD_LOGIC_VECTOR (28 downto 0);
    signal prodXInvY_uid27_divider_im12_cma_qq : STD_LOGIC_VECTOR (28 downto 0);
    signal prodXInvY_uid27_divider_im12_cma_q : STD_LOGIC_VECTOR (28 downto 0);
    signal prodXInvY_uid27_divider_im12_cma_ena0 : std_logic;
    signal prodXInvY_uid27_divider_im12_cma_ena1 : std_logic;
    signal prodXInvY_uid27_divider_im12_cma_ena2 : std_logic;
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_reset : std_logic;
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ah : prodXInvY_uid27_divider_im0_cma_ahtype(0 to 1);
    attribute preserve_syn_only of multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ah : signal is true;
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ch : sm0_uid141_pT3_uid103_invPolyEval_cma_ahtype(0 to 1);
    attribute preserve_syn_only of multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ch : signal is true;
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_a1 : STD_LOGIC_VECTOR (17 downto 0);
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_c1 : STD_LOGIC_VECTOR (17 downto 0);
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (36 downto 0);
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_qq : STD_LOGIC_VECTOR (36 downto 0);
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q : STD_LOGIC_VECTOR (36 downto 0);
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena0 : std_logic;
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena1 : std_logic;
    signal multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena2 : std_logic;
    signal prodXInvY_uid27_divider_ma3_cma_reset : std_logic;
    type prodXInvY_uid27_divider_ma3_cma_ahtype is array(NATURAL range <>) of SIGNED(15 downto 0);
    signal prodXInvY_uid27_divider_ma3_cma_ah : prodXInvY_uid27_divider_ma3_cma_ahtype(0 to 1);
    attribute preserve_syn_only of prodXInvY_uid27_divider_ma3_cma_ah : signal is true;
    type prodXInvY_uid27_divider_ma3_cma_chtype is array(NATURAL range <>) of SIGNED(18 downto 0);
    signal prodXInvY_uid27_divider_ma3_cma_ch : prodXInvY_uid27_divider_ma3_cma_chtype(0 to 1);
    attribute preserve_syn_only of prodXInvY_uid27_divider_ma3_cma_ch : signal is true;
    signal prodXInvY_uid27_divider_ma3_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal prodXInvY_uid27_divider_ma3_cma_c0 : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXInvY_uid27_divider_ma3_cma_a1 : STD_LOGIC_VECTOR (15 downto 0);
    signal prodXInvY_uid27_divider_ma3_cma_c1 : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXInvY_uid27_divider_ma3_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid27_divider_ma3_cma_qq : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid27_divider_ma3_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid27_divider_ma3_cma_ena0 : std_logic;
    signal prodXInvY_uid27_divider_ma3_cma_ena1 : std_logic;
    signal prodXInvY_uid27_divider_ma3_cma_ena2 : std_logic;
    signal y0_uid183_normYIsOneC2_uid12_divider_merged_bit_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal y0_uid183_normYIsOneC2_uid12_divider_merged_bit_select_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_e : STD_LOGIC_VECTOR (0 downto 0);
    signal rVStage_uid46_zCount_uid9_divider_merged_bit_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid46_zCount_uid9_divider_merged_bit_select_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid52_zCount_uid9_divider_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid52_zCount_uid9_divider_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid58_zCount_uid9_divider_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid58_zCount_uid9_divider_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid64_zCount_uid9_divider_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid64_zCount_uid9_divider_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal topRangeY_uid130_pT3_uid103_invPolyEval_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal topRangeY_uid130_pT3_uid103_invPolyEval_merged_bit_select_c : STD_LOGIC_VECTOR (12 downto 0);
    signal topRangeX_uid129_pT3_uid103_invPolyEval_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal topRangeX_uid129_pT3_uid103_invPolyEval_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist2_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_d_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist3_rVStage_uid64_zCount_uid9_divider_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist4_rVStage_uid64_zCount_uid9_divider_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_rVStage_uid58_zCount_uid9_divider_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_rVStage_uid58_zCount_uid9_divider_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_rVStage_uid52_zCount_uid9_divider_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist8_rVStage_uid52_zCount_uid9_divider_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist9_rVStage_uid46_zCount_uid9_divider_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist10_rVStage_uid46_zCount_uid9_divider_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist11_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_d_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist12_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_e_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_prodXInvY_uid27_divider_ma3_cma_q_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal redist14_multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist15_prodXInvY_uid27_divider_im12_cma_q_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist16_prodXInvY_uid27_divider_im0_cma_q_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal redist17_sm0_uid141_pT3_uid103_invPolyEval_cma_q_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_0_b_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist32_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel1_1_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_1_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_1_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_0_b_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist38_prodXInvY_uid27_divider_result_add_0_0_p1_of_2_q_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist39_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist40_s3sumAHighB_uid106_invPolyEval_p1_of_2_q_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist41_memoryC3_uid83_invTabGen_lutmem_r_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist42_memoryC2_uid80_invTabGen_lutmem_r_1_q : STD_LOGIC_VECTOR (20 downto 0);
    signal redist43_memoryC1_uid77_invTabGen_lutmem_r_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist44_memoryC0_uid74_invTabGen_lutmem_r_1_q : STD_LOGIC_VECTOR (37 downto 0);
    signal redist45_prodXInvY_uid27_divider_bs14_b_1_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist46_prodXInvY_uid27_divider_bs13_b_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist47_lowRangeB_uid144_pT3_uid103_invPolyEval_b_2_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist48_osig_uid113_pT2_uid97_invPolyEval_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist49_osig_uid110_pT1_uid91_invPolyEval_b_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist50_lowRangeB_uid104_invPolyEval_b_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist52_vCount_uid59_zCount_uid9_divider_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist53_vCount_uid53_zCount_uid9_divider_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_vCount_uid47_zCount_uid9_divider_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist55_vCount_uid41_zCount_uid9_divider_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_prodPostRightShiftPostRndRange_uid35_divider_b_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_prodPostRightShiftPost_uid29_divider_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist58_prodPostRightShiftPost_uid29_divider_b_2_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist59_yPPolyEval_uid20_divider_b_3_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist60_yPPolyEval_uid20_divider_b_10_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist61_yPPolyEval_uid20_divider_b_17_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist62_yAddr_uid19_divider_b_7_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist63_yAddr_uid19_divider_b_14_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist64_yAddr_uid19_divider_b_22_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist65_yIsZero_uid17_divider_q_43_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist66_normYIsOne_uid16_divider_q_26_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist67_normYIsOneC2_uid15_divider_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist68_normYNoLeadOne_uid11_divider_b_1_q : STD_LOGIC_VECTOR (30 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist70_in_rsrvd_fix_denominator_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist60_yPPolyEval_uid20_divider_b_10_inputreg0_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist60_yPPolyEval_uid20_divider_b_10_outputreg2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist60_yPPolyEval_uid20_divider_b_10_outputreg1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist61_yPPolyEval_uid20_divider_b_17_inputreg2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist61_yPPolyEval_uid20_divider_b_17_outputreg2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist61_yPPolyEval_uid20_divider_b_17_inputreg1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist62_yAddr_uid19_divider_b_7_inputreg1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist62_yAddr_uid19_divider_b_7_outputreg2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist63_yAddr_uid19_divider_b_14_inputreg2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist63_yAddr_uid19_divider_b_14_outputreg2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist64_yAddr_uid19_divider_b_22_inputreg2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist64_yAddr_uid19_divider_b_22_outputreg2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist64_yAddr_uid19_divider_b_22_inputreg1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_inputreg2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_outputreg1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_mem_reset0 : std_logic;
    signal redist71_in_rsrvd_fix_denominator_7_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_mem_enaOr_rst : std_logic;
    signal redist71_in_rsrvd_fix_denominator_7_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of redist71_in_rsrvd_fix_denominator_7_rdcnt_i : signal is true;
    signal redist71_in_rsrvd_fix_denominator_7_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist71_in_rsrvd_fix_denominator_7_rdcnt_eq : signal is true;
    signal redist71_in_rsrvd_fix_denominator_7_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_mem_last_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist71_in_rsrvd_fix_denominator_7_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist71_in_rsrvd_fix_denominator_7_sticky_ena_q : signal is true;
    signal redist71_in_rsrvd_fix_denominator_7_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_reset0 : std_logic;
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_ia : STD_LOGIC_VECTOR (5 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_iq : STD_LOGIC_VECTOR (5 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_enaOr_rst : std_logic;
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_i : signal is true;
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist51_r_uid72_zCount_uid9_divider_q_38_split_0_sticky_ena_q : signal is true;
    signal redist51_r_uid72_zCount_uid9_divider_q_38_split_0_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_outputreg2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_outputreg1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_mem_reset0 : std_logic;
    signal redist69_in_rsrvd_fix_numerator_37_split_0_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_mem_enaOr_rst : std_logic;
    signal redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_i : signal is true;
    signal redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_eq : signal is true;
    signal redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_in_rsrvd_fix_numerator_37_split_0_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist69_in_rsrvd_fix_numerator_37_split_0_sticky_ena_q : signal is true;
    signal redist69_in_rsrvd_fix_numerator_37_split_0_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- cstValOvf_uid36_divider(CONSTANT,35)
    cstValOvf_uid36_divider_q <= "11111111111111111111111111111111";

    -- rightShiftStage3Idx1Pad64_uid244_prodPostRightShift_uid28_divider(CONSTANT,243)
    rightShiftStage3Idx1Pad64_uid244_prodPostRightShift_uid28_divider_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage3Idx1Rng64_uid243_prodPostRightShift_uid28_divider(BITSELECT,242)@47
    rightShiftStage3Idx1Rng64_uid243_prodPostRightShift_uid28_divider_b <= rightShiftStage2_uid242_prodPostRightShift_uid28_divider_q(64 downto 64);

    -- rightShiftStage3Idx1_uid245_prodPostRightShift_uid28_divider(BITJOIN,244)@47
    rightShiftStage3Idx1_uid245_prodPostRightShift_uid28_divider_q <= rightShiftStage3Idx1Pad64_uid244_prodPostRightShift_uid28_divider_q & rightShiftStage3Idx1Rng64_uid243_prodPostRightShift_uid28_divider_b;

    -- rightShiftStage2Idx3Pad48_uid239_prodPostRightShift_uid28_divider(CONSTANT,238)
    rightShiftStage2Idx3Pad48_uid239_prodPostRightShift_uid28_divider_q <= "000000000000000000000000000000000000000000000000";

    -- rightShiftStage2Idx3Rng48_uid238_prodPostRightShift_uid28_divider(BITSELECT,237)@47
    rightShiftStage2Idx3Rng48_uid238_prodPostRightShift_uid28_divider_b <= rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q(64 downto 48);

    -- rightShiftStage2Idx3_uid240_prodPostRightShift_uid28_divider(BITJOIN,239)@47
    rightShiftStage2Idx3_uid240_prodPostRightShift_uid28_divider_q <= rightShiftStage2Idx3Pad48_uid239_prodPostRightShift_uid28_divider_q & rightShiftStage2Idx3Rng48_uid238_prodPostRightShift_uid28_divider_b;

    -- zs_uid39_zCount_uid9_divider(CONSTANT,38)
    zs_uid39_zCount_uid9_divider_q <= "00000000000000000000000000000000";

    -- rightShiftStage2Idx2Rng32_uid235_prodPostRightShift_uid28_divider(BITSELECT,234)@47
    rightShiftStage2Idx2Rng32_uid235_prodPostRightShift_uid28_divider_b <= rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q(64 downto 32);

    -- rightShiftStage2Idx2_uid237_prodPostRightShift_uid28_divider(BITJOIN,236)@47
    rightShiftStage2Idx2_uid237_prodPostRightShift_uid28_divider_q <= zs_uid39_zCount_uid9_divider_q & rightShiftStage2Idx2Rng32_uid235_prodPostRightShift_uid28_divider_b;

    -- zs_uid45_zCount_uid9_divider(CONSTANT,44)
    zs_uid45_zCount_uid9_divider_q <= "0000000000000000";

    -- rightShiftStage2Idx1Rng16_uid232_prodPostRightShift_uid28_divider(BITSELECT,231)@47
    rightShiftStage2Idx1Rng16_uid232_prodPostRightShift_uid28_divider_b <= rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q(64 downto 16);

    -- rightShiftStage2Idx1_uid234_prodPostRightShift_uid28_divider(BITJOIN,233)@47
    rightShiftStage2Idx1_uid234_prodPostRightShift_uid28_divider_q <= zs_uid45_zCount_uid9_divider_q & rightShiftStage2Idx1Rng16_uid232_prodPostRightShift_uid28_divider_b;

    -- rightBottomX_bottomExtension_uid136_pT3_uid103_invPolyEval(CONSTANT,135)
    rightBottomX_bottomExtension_uid136_pT3_uid103_invPolyEval_q <= "000000000000";

    -- rightShiftStage1Idx3Rng12_uid227_prodPostRightShift_uid28_divider(BITSELECT,226)@46
    rightShiftStage1Idx3Rng12_uid227_prodPostRightShift_uid28_divider_b <= rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q(64 downto 12);

    -- rightShiftStage1Idx3_uid229_prodPostRightShift_uid28_divider(BITJOIN,228)@46
    rightShiftStage1Idx3_uid229_prodPostRightShift_uid28_divider_q <= rightBottomX_bottomExtension_uid136_pT3_uid103_invPolyEval_q & rightShiftStage1Idx3Rng12_uid227_prodPostRightShift_uid28_divider_b;

    -- zs_uid51_zCount_uid9_divider(CONSTANT,50)
    zs_uid51_zCount_uid9_divider_q <= "00000000";

    -- rightShiftStage1Idx2Rng8_uid224_prodPostRightShift_uid28_divider(BITSELECT,223)@46
    rightShiftStage1Idx2Rng8_uid224_prodPostRightShift_uid28_divider_b <= rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q(64 downto 8);

    -- rightShiftStage1Idx2_uid226_prodPostRightShift_uid28_divider(BITJOIN,225)@46
    rightShiftStage1Idx2_uid226_prodPostRightShift_uid28_divider_q <= zs_uid51_zCount_uid9_divider_q & rightShiftStage1Idx2Rng8_uid224_prodPostRightShift_uid28_divider_b;

    -- zs_uid57_zCount_uid9_divider(CONSTANT,56)
    zs_uid57_zCount_uid9_divider_q <= "0000";

    -- rightShiftStage1Idx1Rng4_uid221_prodPostRightShift_uid28_divider(BITSELECT,220)@46
    rightShiftStage1Idx1Rng4_uid221_prodPostRightShift_uid28_divider_b <= rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q(64 downto 4);

    -- rightShiftStage1Idx1_uid223_prodPostRightShift_uid28_divider(BITJOIN,222)@46
    rightShiftStage1Idx1_uid223_prodPostRightShift_uid28_divider_q <= zs_uid57_zCount_uid9_divider_q & rightShiftStage1Idx1Rng4_uid221_prodPostRightShift_uid28_divider_b;

    -- leftShiftStage2Idx3Pad3_uid176_normY_uid10_divider(CONSTANT,175)
    leftShiftStage2Idx3Pad3_uid176_normY_uid10_divider_q <= "000";

    -- rightShiftStage0Idx3Rng3_uid216_prodPostRightShift_uid28_divider(BITSELECT,215)@46
    rightShiftStage0Idx3Rng3_uid216_prodPostRightShift_uid28_divider_in <= prodXInvY_uid27_divider_result_add_0_0_BitJoin_for_q_q(64 downto 0);
    rightShiftStage0Idx3Rng3_uid216_prodPostRightShift_uid28_divider_b <= rightShiftStage0Idx3Rng3_uid216_prodPostRightShift_uid28_divider_in(64 downto 3);

    -- rightShiftStage0Idx3_uid218_prodPostRightShift_uid28_divider(BITJOIN,217)@46
    rightShiftStage0Idx3_uid218_prodPostRightShift_uid28_divider_q <= leftShiftStage2Idx3Pad3_uid176_normY_uid10_divider_q & rightShiftStage0Idx3Rng3_uid216_prodPostRightShift_uid28_divider_b;

    -- zs_uid63_zCount_uid9_divider(CONSTANT,62)
    zs_uid63_zCount_uid9_divider_q <= "00";

    -- rightShiftStage0Idx2Rng2_uid213_prodPostRightShift_uid28_divider(BITSELECT,212)@46
    rightShiftStage0Idx2Rng2_uid213_prodPostRightShift_uid28_divider_in <= prodXInvY_uid27_divider_result_add_0_0_BitJoin_for_q_q(64 downto 0);
    rightShiftStage0Idx2Rng2_uid213_prodPostRightShift_uid28_divider_b <= rightShiftStage0Idx2Rng2_uid213_prodPostRightShift_uid28_divider_in(64 downto 2);

    -- rightShiftStage0Idx2_uid215_prodPostRightShift_uid28_divider(BITJOIN,214)@46
    rightShiftStage0Idx2_uid215_prodPostRightShift_uid28_divider_q <= zs_uid63_zCount_uid9_divider_q & rightShiftStage0Idx2Rng2_uid213_prodPostRightShift_uid28_divider_b;

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- rightShiftStage0Idx1Rng1_uid210_prodPostRightShift_uid28_divider(BITSELECT,209)@46
    rightShiftStage0Idx1Rng1_uid210_prodPostRightShift_uid28_divider_in <= prodXInvY_uid27_divider_result_add_0_0_BitJoin_for_q_q(64 downto 0);
    rightShiftStage0Idx1Rng1_uid210_prodPostRightShift_uid28_divider_b <= rightShiftStage0Idx1Rng1_uid210_prodPostRightShift_uid28_divider_in(64 downto 1);

    -- rightShiftStage0Idx1_uid212_prodPostRightShift_uid28_divider(BITJOIN,211)@46
    rightShiftStage0Idx1_uid212_prodPostRightShift_uid28_divider_q <= GND_q & rightShiftStage0Idx1Rng1_uid210_prodPostRightShift_uid28_divider_b;

    -- redist69_in_rsrvd_fix_numerator_37_split_0_notEnable(LOGICAL,490)
    redist69_in_rsrvd_fix_numerator_37_split_0_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist69_in_rsrvd_fix_numerator_37_split_0_nor(LOGICAL,491)
    redist69_in_rsrvd_fix_numerator_37_split_0_nor_q <= not (redist69_in_rsrvd_fix_numerator_37_split_0_notEnable_q or redist69_in_rsrvd_fix_numerator_37_split_0_sticky_ena_q);

    -- redist69_in_rsrvd_fix_numerator_37_split_0_mem_last(CONSTANT,487)
    redist69_in_rsrvd_fix_numerator_37_split_0_mem_last_q <= "011010";

    -- redist69_in_rsrvd_fix_numerator_37_split_0_cmp(LOGICAL,488)
    redist69_in_rsrvd_fix_numerator_37_split_0_cmp_b <= STD_LOGIC_VECTOR("0" & redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_q);
    redist69_in_rsrvd_fix_numerator_37_split_0_cmp_q <= "1" WHEN redist69_in_rsrvd_fix_numerator_37_split_0_mem_last_q = redist69_in_rsrvd_fix_numerator_37_split_0_cmp_b ELSE "0";

    -- redist69_in_rsrvd_fix_numerator_37_split_0_cmpReg(REG,489)
    redist69_in_rsrvd_fix_numerator_37_split_0_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist69_in_rsrvd_fix_numerator_37_split_0_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist69_in_rsrvd_fix_numerator_37_split_0_cmpReg_q <= STD_LOGIC_VECTOR(redist69_in_rsrvd_fix_numerator_37_split_0_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist69_in_rsrvd_fix_numerator_37_split_0_sticky_ena(REG,492)
    redist69_in_rsrvd_fix_numerator_37_split_0_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist69_in_rsrvd_fix_numerator_37_split_0_sticky_ena_q <= "0";
            ELSE
                IF (redist69_in_rsrvd_fix_numerator_37_split_0_nor_q = "1") THEN
                    redist69_in_rsrvd_fix_numerator_37_split_0_sticky_ena_q <= STD_LOGIC_VECTOR(redist69_in_rsrvd_fix_numerator_37_split_0_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist69_in_rsrvd_fix_numerator_37_split_0_enaAnd(LOGICAL,493)
    redist69_in_rsrvd_fix_numerator_37_split_0_enaAnd_q <= redist69_in_rsrvd_fix_numerator_37_split_0_sticky_ena_q and en;

    -- redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt(COUNTER,484)
    -- low=0, high=27, step=1, init=0
    redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_i = TO_UNSIGNED(26, 5)) THEN
                        redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_eq <= '1';
                    ELSE
                        redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_eq <= '0';
                    END IF;
                    IF (redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_eq = '1') THEN
                        redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_i <= redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_i + 5;
                    ELSE
                        redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_i <= redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_i, 5)));

    -- redist69_in_rsrvd_fix_numerator_37_split_0_rdmux(MUX,485)
    redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_s <= en;
    redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_combproc: PROCESS (redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_s, redist69_in_rsrvd_fix_numerator_37_split_0_wraddr_q, redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_q)
    BEGIN
        CASE (redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_s) IS
            WHEN "0" => redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_q <= redist69_in_rsrvd_fix_numerator_37_split_0_wraddr_q;
            WHEN "1" => redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_q <= redist69_in_rsrvd_fix_numerator_37_split_0_rdcnt_q;
            WHEN OTHERS => redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist69_in_rsrvd_fix_numerator_37_split_0_inputreg0(DELAY,479)
    redist69_in_rsrvd_fix_numerator_37_split_0_inputreg0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => numerator, xout => redist69_in_rsrvd_fix_numerator_37_split_0_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist69_in_rsrvd_fix_numerator_37_split_0_wraddr(REG,486)
    redist69_in_rsrvd_fix_numerator_37_split_0_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist69_in_rsrvd_fix_numerator_37_split_0_wraddr_q <= "11011";
            ELSE
                redist69_in_rsrvd_fix_numerator_37_split_0_wraddr_q <= STD_LOGIC_VECTOR(redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist69_in_rsrvd_fix_numerator_37_split_0_mem(DUALMEM,483)
    redist69_in_rsrvd_fix_numerator_37_split_0_mem_ia <= STD_LOGIC_VECTOR(redist69_in_rsrvd_fix_numerator_37_split_0_inputreg0_q);
    redist69_in_rsrvd_fix_numerator_37_split_0_mem_aa <= redist69_in_rsrvd_fix_numerator_37_split_0_wraddr_q;
    redist69_in_rsrvd_fix_numerator_37_split_0_mem_ab <= redist69_in_rsrvd_fix_numerator_37_split_0_rdmux_q;
    redist69_in_rsrvd_fix_numerator_37_split_0_mem_reset0 <= rst;
    redist69_in_rsrvd_fix_numerator_37_split_0_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 5,
        numwords_a => 28,
        width_b => 32,
        widthad_b => 5,
        numwords_b => 28,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken1 => redist69_in_rsrvd_fix_numerator_37_split_0_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist69_in_rsrvd_fix_numerator_37_split_0_mem_reset0,
        clock1 => clk,
        address_a => redist69_in_rsrvd_fix_numerator_37_split_0_mem_aa,
        data_a => redist69_in_rsrvd_fix_numerator_37_split_0_mem_ia,
        wren_a => en(0),
        address_b => redist69_in_rsrvd_fix_numerator_37_split_0_mem_ab,
        q_b => redist69_in_rsrvd_fix_numerator_37_split_0_mem_iq
    );
    redist69_in_rsrvd_fix_numerator_37_split_0_mem_q <= redist69_in_rsrvd_fix_numerator_37_split_0_mem_iq(31 downto 0);
    redist69_in_rsrvd_fix_numerator_37_split_0_mem_enaOr_rst <= redist69_in_rsrvd_fix_numerator_37_split_0_enaAnd_q(0) or redist69_in_rsrvd_fix_numerator_37_split_0_mem_reset0;

    -- redist69_in_rsrvd_fix_numerator_37_split_0_outputreg0(DELAY,482)
    redist69_in_rsrvd_fix_numerator_37_split_0_outputreg0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist69_in_rsrvd_fix_numerator_37_split_0_mem_q, xout => redist69_in_rsrvd_fix_numerator_37_split_0_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist69_in_rsrvd_fix_numerator_37_split_0_outputreg1(DELAY,481)
    redist69_in_rsrvd_fix_numerator_37_split_0_outputreg1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist69_in_rsrvd_fix_numerator_37_split_0_outputreg0_q, xout => redist69_in_rsrvd_fix_numerator_37_split_0_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist69_in_rsrvd_fix_numerator_37_split_0_outputreg2(DELAY,480)
    redist69_in_rsrvd_fix_numerator_37_split_0_outputreg2 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist69_in_rsrvd_fix_numerator_37_split_0_outputreg1_q, xout => redist69_in_rsrvd_fix_numerator_37_split_0_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist69_in_rsrvd_fix_numerator_37_inputreg2(DELAY,454)
    redist69_in_rsrvd_fix_numerator_37_inputreg2 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist69_in_rsrvd_fix_numerator_37_split_0_outputreg2_q, xout => redist69_in_rsrvd_fix_numerator_37_inputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist69_in_rsrvd_fix_numerator_37(DELAY,436)
    redist69_in_rsrvd_fix_numerator_37 : dspba_delay
    GENERIC MAP ( width => 32, depth => 3, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist69_in_rsrvd_fix_numerator_37_inputreg2_q, xout => redist69_in_rsrvd_fix_numerator_37_q, ena => en(0), clk => clk, aclr => rst );

    -- prodXInvY_uid27_divider_bs4(BITSELECT,192)@37
    prodXInvY_uid27_divider_bs4_in <= STD_LOGIC_VECTOR(redist69_in_rsrvd_fix_numerator_37_q(17 downto 0));
    prodXInvY_uid27_divider_bs4_b <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_bs4_in(17 downto 0));

    -- prodXInvY_uid27_divider_bjA5(BITJOIN,193)@37
    prodXInvY_uid27_divider_bjA5_q <= GND_q & prodXInvY_uid27_divider_bs4_b;

    -- oneInvRes_uid23_divider(CONSTANT,22)
    oneInvRes_uid23_divider_q <= "100000000000000000000000000000000";

    -- leftShiftStage2Idx3Rng3_uid177_normY_uid10_divider(BITSELECT,176)@8
    leftShiftStage2Idx3Rng3_uid177_normY_uid10_divider_in <= leftShiftStage1_uid169_normY_uid10_divider_q(28 downto 0);
    leftShiftStage2Idx3Rng3_uid177_normY_uid10_divider_b <= leftShiftStage2Idx3Rng3_uid177_normY_uid10_divider_in(28 downto 0);

    -- leftShiftStage2Idx3_uid178_normY_uid10_divider(BITJOIN,177)@8
    leftShiftStage2Idx3_uid178_normY_uid10_divider_q <= leftShiftStage2Idx3Rng3_uid177_normY_uid10_divider_b & leftShiftStage2Idx3Pad3_uid176_normY_uid10_divider_q;

    -- leftShiftStage2Idx2Rng2_uid174_normY_uid10_divider(BITSELECT,173)@8
    leftShiftStage2Idx2Rng2_uid174_normY_uid10_divider_in <= leftShiftStage1_uid169_normY_uid10_divider_q(29 downto 0);
    leftShiftStage2Idx2Rng2_uid174_normY_uid10_divider_b <= leftShiftStage2Idx2Rng2_uid174_normY_uid10_divider_in(29 downto 0);

    -- leftShiftStage2Idx2_uid175_normY_uid10_divider(BITJOIN,174)@8
    leftShiftStage2Idx2_uid175_normY_uid10_divider_q <= leftShiftStage2Idx2Rng2_uid174_normY_uid10_divider_b & zs_uid63_zCount_uid9_divider_q;

    -- leftShiftStage2Idx1Rng1_uid171_normY_uid10_divider(BITSELECT,170)@8
    leftShiftStage2Idx1Rng1_uid171_normY_uid10_divider_in <= leftShiftStage1_uid169_normY_uid10_divider_q(30 downto 0);
    leftShiftStage2Idx1Rng1_uid171_normY_uid10_divider_b <= leftShiftStage2Idx1Rng1_uid171_normY_uid10_divider_in(30 downto 0);

    -- leftShiftStage2Idx1_uid172_normY_uid10_divider(BITJOIN,171)@8
    leftShiftStage2Idx1_uid172_normY_uid10_divider_q <= leftShiftStage2Idx1Rng1_uid171_normY_uid10_divider_b & GND_q;

    -- leftShiftStage1Idx3Rng12_uid166_normY_uid10_divider(BITSELECT,165)@8
    leftShiftStage1Idx3Rng12_uid166_normY_uid10_divider_in <= leftShiftStage0_uid158_normY_uid10_divider_q(19 downto 0);
    leftShiftStage1Idx3Rng12_uid166_normY_uid10_divider_b <= leftShiftStage1Idx3Rng12_uid166_normY_uid10_divider_in(19 downto 0);

    -- leftShiftStage1Idx3_uid167_normY_uid10_divider(BITJOIN,166)@8
    leftShiftStage1Idx3_uid167_normY_uid10_divider_q <= leftShiftStage1Idx3Rng12_uid166_normY_uid10_divider_b & rightBottomX_bottomExtension_uid136_pT3_uid103_invPolyEval_q;

    -- leftShiftStage1Idx2Rng8_uid163_normY_uid10_divider(BITSELECT,162)@8
    leftShiftStage1Idx2Rng8_uid163_normY_uid10_divider_in <= leftShiftStage0_uid158_normY_uid10_divider_q(23 downto 0);
    leftShiftStage1Idx2Rng8_uid163_normY_uid10_divider_b <= leftShiftStage1Idx2Rng8_uid163_normY_uid10_divider_in(23 downto 0);

    -- leftShiftStage1Idx2_uid164_normY_uid10_divider(BITJOIN,163)@8
    leftShiftStage1Idx2_uid164_normY_uid10_divider_q <= leftShiftStage1Idx2Rng8_uid163_normY_uid10_divider_b & zs_uid51_zCount_uid9_divider_q;

    -- leftShiftStage1Idx1Rng4_uid160_normY_uid10_divider(BITSELECT,159)@8
    leftShiftStage1Idx1Rng4_uid160_normY_uid10_divider_in <= leftShiftStage0_uid158_normY_uid10_divider_q(27 downto 0);
    leftShiftStage1Idx1Rng4_uid160_normY_uid10_divider_b <= leftShiftStage1Idx1Rng4_uid160_normY_uid10_divider_in(27 downto 0);

    -- leftShiftStage1Idx1_uid161_normY_uid10_divider(BITJOIN,160)@8
    leftShiftStage1Idx1_uid161_normY_uid10_divider_q <= leftShiftStage1Idx1Rng4_uid160_normY_uid10_divider_b & zs_uid57_zCount_uid9_divider_q;

    -- leftShiftStage0Idx1Rng16_uid153_normY_uid10_divider(BITSELECT,152)@7
    leftShiftStage0Idx1Rng16_uid153_normY_uid10_divider_in <= redist71_in_rsrvd_fix_denominator_7_outputreg1_q(15 downto 0);
    leftShiftStage0Idx1Rng16_uid153_normY_uid10_divider_b <= leftShiftStage0Idx1Rng16_uid153_normY_uid10_divider_in(15 downto 0);

    -- leftShiftStage0Idx1_uid154_normY_uid10_divider(BITJOIN,153)@7
    leftShiftStage0Idx1_uid154_normY_uid10_divider_q <= leftShiftStage0Idx1Rng16_uid153_normY_uid10_divider_b & zs_uid45_zCount_uid9_divider_q;

    -- redist71_in_rsrvd_fix_denominator_7_notEnable(LOGICAL,464)
    redist71_in_rsrvd_fix_denominator_7_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist71_in_rsrvd_fix_denominator_7_nor(LOGICAL,465)
    redist71_in_rsrvd_fix_denominator_7_nor_q <= not (redist71_in_rsrvd_fix_denominator_7_notEnable_q or redist71_in_rsrvd_fix_denominator_7_sticky_ena_q);

    -- redist71_in_rsrvd_fix_denominator_7_mem_last(CONSTANT,461)
    redist71_in_rsrvd_fix_denominator_7_mem_last_q <= "01";

    -- redist71_in_rsrvd_fix_denominator_7_cmp(LOGICAL,462)
    redist71_in_rsrvd_fix_denominator_7_cmp_q <= "1" WHEN redist71_in_rsrvd_fix_denominator_7_mem_last_q = redist71_in_rsrvd_fix_denominator_7_rdmux_q ELSE "0";

    -- redist71_in_rsrvd_fix_denominator_7_cmpReg(REG,463)
    redist71_in_rsrvd_fix_denominator_7_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist71_in_rsrvd_fix_denominator_7_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist71_in_rsrvd_fix_denominator_7_cmpReg_q <= STD_LOGIC_VECTOR(redist71_in_rsrvd_fix_denominator_7_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist71_in_rsrvd_fix_denominator_7_sticky_ena(REG,466)
    redist71_in_rsrvd_fix_denominator_7_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist71_in_rsrvd_fix_denominator_7_sticky_ena_q <= "0";
            ELSE
                IF (redist71_in_rsrvd_fix_denominator_7_nor_q = "1") THEN
                    redist71_in_rsrvd_fix_denominator_7_sticky_ena_q <= STD_LOGIC_VECTOR(redist71_in_rsrvd_fix_denominator_7_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist71_in_rsrvd_fix_denominator_7_enaAnd(LOGICAL,467)
    redist71_in_rsrvd_fix_denominator_7_enaAnd_q <= redist71_in_rsrvd_fix_denominator_7_sticky_ena_q and en;

    -- redist71_in_rsrvd_fix_denominator_7_rdcnt(COUNTER,458)
    -- low=0, high=2, step=1, init=0
    redist71_in_rsrvd_fix_denominator_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist71_in_rsrvd_fix_denominator_7_rdcnt_i <= TO_UNSIGNED(0, 2);
                redist71_in_rsrvd_fix_denominator_7_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist71_in_rsrvd_fix_denominator_7_rdcnt_i = TO_UNSIGNED(1, 2)) THEN
                        redist71_in_rsrvd_fix_denominator_7_rdcnt_eq <= '1';
                    ELSE
                        redist71_in_rsrvd_fix_denominator_7_rdcnt_eq <= '0';
                    END IF;
                    IF (redist71_in_rsrvd_fix_denominator_7_rdcnt_eq = '1') THEN
                        redist71_in_rsrvd_fix_denominator_7_rdcnt_i <= redist71_in_rsrvd_fix_denominator_7_rdcnt_i + 2;
                    ELSE
                        redist71_in_rsrvd_fix_denominator_7_rdcnt_i <= redist71_in_rsrvd_fix_denominator_7_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist71_in_rsrvd_fix_denominator_7_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist71_in_rsrvd_fix_denominator_7_rdcnt_i, 2)));

    -- redist71_in_rsrvd_fix_denominator_7_rdmux(MUX,459)
    redist71_in_rsrvd_fix_denominator_7_rdmux_s <= en;
    redist71_in_rsrvd_fix_denominator_7_rdmux_combproc: PROCESS (redist71_in_rsrvd_fix_denominator_7_rdmux_s, redist71_in_rsrvd_fix_denominator_7_wraddr_q, redist71_in_rsrvd_fix_denominator_7_rdcnt_q)
    BEGIN
        CASE (redist71_in_rsrvd_fix_denominator_7_rdmux_s) IS
            WHEN "0" => redist71_in_rsrvd_fix_denominator_7_rdmux_q <= redist71_in_rsrvd_fix_denominator_7_wraddr_q;
            WHEN "1" => redist71_in_rsrvd_fix_denominator_7_rdmux_q <= redist71_in_rsrvd_fix_denominator_7_rdcnt_q;
            WHEN OTHERS => redist71_in_rsrvd_fix_denominator_7_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist70_in_rsrvd_fix_denominator_1(DELAY,437)
    redist70_in_rsrvd_fix_denominator_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => denominator, xout => redist70_in_rsrvd_fix_denominator_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist71_in_rsrvd_fix_denominator_7_wraddr(REG,460)
    redist71_in_rsrvd_fix_denominator_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist71_in_rsrvd_fix_denominator_7_wraddr_q <= "10";
            ELSE
                redist71_in_rsrvd_fix_denominator_7_wraddr_q <= STD_LOGIC_VECTOR(redist71_in_rsrvd_fix_denominator_7_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist71_in_rsrvd_fix_denominator_7_mem(DUALMEM,457)
    redist71_in_rsrvd_fix_denominator_7_mem_ia <= STD_LOGIC_VECTOR(redist70_in_rsrvd_fix_denominator_1_q);
    redist71_in_rsrvd_fix_denominator_7_mem_aa <= redist71_in_rsrvd_fix_denominator_7_wraddr_q;
    redist71_in_rsrvd_fix_denominator_7_mem_ab <= redist71_in_rsrvd_fix_denominator_7_rdmux_q;
    redist71_in_rsrvd_fix_denominator_7_mem_reset0 <= rst;
    redist71_in_rsrvd_fix_denominator_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 2,
        numwords_a => 3,
        width_b => 32,
        widthad_b => 2,
        numwords_b => 3,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken1 => redist71_in_rsrvd_fix_denominator_7_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist71_in_rsrvd_fix_denominator_7_mem_reset0,
        clock1 => clk,
        address_a => redist71_in_rsrvd_fix_denominator_7_mem_aa,
        data_a => redist71_in_rsrvd_fix_denominator_7_mem_ia,
        wren_a => en(0),
        address_b => redist71_in_rsrvd_fix_denominator_7_mem_ab,
        q_b => redist71_in_rsrvd_fix_denominator_7_mem_iq
    );
    redist71_in_rsrvd_fix_denominator_7_mem_q <= redist71_in_rsrvd_fix_denominator_7_mem_iq(31 downto 0);
    redist71_in_rsrvd_fix_denominator_7_mem_enaOr_rst <= redist71_in_rsrvd_fix_denominator_7_enaAnd_q(0) or redist71_in_rsrvd_fix_denominator_7_mem_reset0;

    -- redist71_in_rsrvd_fix_denominator_7_outputreg0(DELAY,456)
    redist71_in_rsrvd_fix_denominator_7_outputreg0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist71_in_rsrvd_fix_denominator_7_mem_q, xout => redist71_in_rsrvd_fix_denominator_7_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist71_in_rsrvd_fix_denominator_7_outputreg1(DELAY,455)
    redist71_in_rsrvd_fix_denominator_7_outputreg1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist71_in_rsrvd_fix_denominator_7_outputreg0_q, xout => redist71_in_rsrvd_fix_denominator_7_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- vCount_uid41_zCount_uid9_divider(LOGICAL,40)@0 + 1
    vCount_uid41_zCount_uid9_divider_qi <= "1" WHEN denominator = zs_uid39_zCount_uid9_divider_q ELSE "0";
    vCount_uid41_zCount_uid9_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid41_zCount_uid9_divider_qi, xout => vCount_uid41_zCount_uid9_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- redist55_vCount_uid41_zCount_uid9_divider_q_7(DELAY,422)
    redist55_vCount_uid41_zCount_uid9_divider_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid41_zCount_uid9_divider_q, xout => redist55_vCount_uid41_zCount_uid9_divider_q_7_q, ena => en(0), clk => clk, aclr => rst );

    -- vStagei_uid44_zCount_uid9_divider(MUX,43)@1 + 1
    vStagei_uid44_zCount_uid9_divider_s <= vCount_uid41_zCount_uid9_divider_q;
    vStagei_uid44_zCount_uid9_divider_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                vStagei_uid44_zCount_uid9_divider_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (vStagei_uid44_zCount_uid9_divider_s) IS
                        WHEN "0" => vStagei_uid44_zCount_uid9_divider_q <= redist70_in_rsrvd_fix_denominator_1_q;
                        WHEN "1" => vStagei_uid44_zCount_uid9_divider_q <= cstValOvf_uid36_divider_q;
                        WHEN OTHERS => vStagei_uid44_zCount_uid9_divider_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid46_zCount_uid9_divider_merged_bit_select(BITSELECT,359)@2
    rVStage_uid46_zCount_uid9_divider_merged_bit_select_b <= vStagei_uid44_zCount_uid9_divider_q(31 downto 16);
    rVStage_uid46_zCount_uid9_divider_merged_bit_select_c <= vStagei_uid44_zCount_uid9_divider_q(15 downto 0);

    -- vCount_uid47_zCount_uid9_divider(LOGICAL,46)@2 + 1
    vCount_uid47_zCount_uid9_divider_qi <= "1" WHEN rVStage_uid46_zCount_uid9_divider_merged_bit_select_b = zs_uid45_zCount_uid9_divider_q ELSE "0";
    vCount_uid47_zCount_uid9_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid47_zCount_uid9_divider_qi, xout => vCount_uid47_zCount_uid9_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- redist54_vCount_uid47_zCount_uid9_divider_q_5(DELAY,421)
    redist54_vCount_uid47_zCount_uid9_divider_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid47_zCount_uid9_divider_q, xout => redist54_vCount_uid47_zCount_uid9_divider_q_5_q, ena => en(0), clk => clk, aclr => rst );

    -- redist10_rVStage_uid46_zCount_uid9_divider_merged_bit_select_c_1(DELAY,377)
    redist10_rVStage_uid46_zCount_uid9_divider_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid46_zCount_uid9_divider_merged_bit_select_c, xout => redist10_rVStage_uid46_zCount_uid9_divider_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist9_rVStage_uid46_zCount_uid9_divider_merged_bit_select_b_1(DELAY,376)
    redist9_rVStage_uid46_zCount_uid9_divider_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid46_zCount_uid9_divider_merged_bit_select_b, xout => redist9_rVStage_uid46_zCount_uid9_divider_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- vStagei_uid50_zCount_uid9_divider(MUX,49)@3 + 1
    vStagei_uid50_zCount_uid9_divider_s <= vCount_uid47_zCount_uid9_divider_q;
    vStagei_uid50_zCount_uid9_divider_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                vStagei_uid50_zCount_uid9_divider_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (vStagei_uid50_zCount_uid9_divider_s) IS
                        WHEN "0" => vStagei_uid50_zCount_uid9_divider_q <= redist9_rVStage_uid46_zCount_uid9_divider_merged_bit_select_b_1_q;
                        WHEN "1" => vStagei_uid50_zCount_uid9_divider_q <= redist10_rVStage_uid46_zCount_uid9_divider_merged_bit_select_c_1_q;
                        WHEN OTHERS => vStagei_uid50_zCount_uid9_divider_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid52_zCount_uid9_divider_merged_bit_select(BITSELECT,360)@4
    rVStage_uid52_zCount_uid9_divider_merged_bit_select_b <= vStagei_uid50_zCount_uid9_divider_q(15 downto 8);
    rVStage_uid52_zCount_uid9_divider_merged_bit_select_c <= vStagei_uid50_zCount_uid9_divider_q(7 downto 0);

    -- vCount_uid53_zCount_uid9_divider(LOGICAL,52)@4 + 1
    vCount_uid53_zCount_uid9_divider_qi <= "1" WHEN rVStage_uid52_zCount_uid9_divider_merged_bit_select_b = zs_uid51_zCount_uid9_divider_q ELSE "0";
    vCount_uid53_zCount_uid9_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid53_zCount_uid9_divider_qi, xout => vCount_uid53_zCount_uid9_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- redist53_vCount_uid53_zCount_uid9_divider_q_3(DELAY,420)
    redist53_vCount_uid53_zCount_uid9_divider_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid53_zCount_uid9_divider_q, xout => redist53_vCount_uid53_zCount_uid9_divider_q_3_q, ena => en(0), clk => clk, aclr => rst );

    -- redist8_rVStage_uid52_zCount_uid9_divider_merged_bit_select_c_1(DELAY,375)
    redist8_rVStage_uid52_zCount_uid9_divider_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid52_zCount_uid9_divider_merged_bit_select_c, xout => redist8_rVStage_uid52_zCount_uid9_divider_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist7_rVStage_uid52_zCount_uid9_divider_merged_bit_select_b_1(DELAY,374)
    redist7_rVStage_uid52_zCount_uid9_divider_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid52_zCount_uid9_divider_merged_bit_select_b, xout => redist7_rVStage_uid52_zCount_uid9_divider_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- vStagei_uid56_zCount_uid9_divider(MUX,55)@5
    vStagei_uid56_zCount_uid9_divider_s <= vCount_uid53_zCount_uid9_divider_q;
    vStagei_uid56_zCount_uid9_divider_combproc: PROCESS (vStagei_uid56_zCount_uid9_divider_s, redist7_rVStage_uid52_zCount_uid9_divider_merged_bit_select_b_1_q, redist8_rVStage_uid52_zCount_uid9_divider_merged_bit_select_c_1_q)
    BEGIN
        CASE (vStagei_uid56_zCount_uid9_divider_s) IS
            WHEN "0" => vStagei_uid56_zCount_uid9_divider_q <= redist7_rVStage_uid52_zCount_uid9_divider_merged_bit_select_b_1_q;
            WHEN "1" => vStagei_uid56_zCount_uid9_divider_q <= redist8_rVStage_uid52_zCount_uid9_divider_merged_bit_select_c_1_q;
            WHEN OTHERS => vStagei_uid56_zCount_uid9_divider_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid58_zCount_uid9_divider_merged_bit_select(BITSELECT,361)@5
    rVStage_uid58_zCount_uid9_divider_merged_bit_select_b <= vStagei_uid56_zCount_uid9_divider_q(7 downto 4);
    rVStage_uid58_zCount_uid9_divider_merged_bit_select_c <= vStagei_uid56_zCount_uid9_divider_q(3 downto 0);

    -- vCount_uid59_zCount_uid9_divider(LOGICAL,58)@5 + 1
    vCount_uid59_zCount_uid9_divider_qi <= "1" WHEN rVStage_uid58_zCount_uid9_divider_merged_bit_select_b = zs_uid57_zCount_uid9_divider_q ELSE "0";
    vCount_uid59_zCount_uid9_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid59_zCount_uid9_divider_qi, xout => vCount_uid59_zCount_uid9_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- redist52_vCount_uid59_zCount_uid9_divider_q_2(DELAY,419)
    redist52_vCount_uid59_zCount_uid9_divider_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid59_zCount_uid9_divider_q, xout => redist52_vCount_uid59_zCount_uid9_divider_q_2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist6_rVStage_uid58_zCount_uid9_divider_merged_bit_select_c_1(DELAY,373)
    redist6_rVStage_uid58_zCount_uid9_divider_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 4, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid58_zCount_uid9_divider_merged_bit_select_c, xout => redist6_rVStage_uid58_zCount_uid9_divider_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist5_rVStage_uid58_zCount_uid9_divider_merged_bit_select_b_1(DELAY,372)
    redist5_rVStage_uid58_zCount_uid9_divider_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 4, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid58_zCount_uid9_divider_merged_bit_select_b, xout => redist5_rVStage_uid58_zCount_uid9_divider_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- vStagei_uid62_zCount_uid9_divider(MUX,61)@6
    vStagei_uid62_zCount_uid9_divider_s <= vCount_uid59_zCount_uid9_divider_q;
    vStagei_uid62_zCount_uid9_divider_combproc: PROCESS (vStagei_uid62_zCount_uid9_divider_s, redist5_rVStage_uid58_zCount_uid9_divider_merged_bit_select_b_1_q, redist6_rVStage_uid58_zCount_uid9_divider_merged_bit_select_c_1_q)
    BEGIN
        CASE (vStagei_uid62_zCount_uid9_divider_s) IS
            WHEN "0" => vStagei_uid62_zCount_uid9_divider_q <= redist5_rVStage_uid58_zCount_uid9_divider_merged_bit_select_b_1_q;
            WHEN "1" => vStagei_uid62_zCount_uid9_divider_q <= redist6_rVStage_uid58_zCount_uid9_divider_merged_bit_select_c_1_q;
            WHEN OTHERS => vStagei_uid62_zCount_uid9_divider_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid64_zCount_uid9_divider_merged_bit_select(BITSELECT,362)@6
    rVStage_uid64_zCount_uid9_divider_merged_bit_select_b <= vStagei_uid62_zCount_uid9_divider_q(3 downto 2);
    rVStage_uid64_zCount_uid9_divider_merged_bit_select_c <= vStagei_uid62_zCount_uid9_divider_q(1 downto 0);

    -- vCount_uid65_zCount_uid9_divider(LOGICAL,64)@6 + 1
    vCount_uid65_zCount_uid9_divider_qi <= "1" WHEN rVStage_uid64_zCount_uid9_divider_merged_bit_select_b = zs_uid63_zCount_uid9_divider_q ELSE "0";
    vCount_uid65_zCount_uid9_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid65_zCount_uid9_divider_qi, xout => vCount_uid65_zCount_uid9_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- redist4_rVStage_uid64_zCount_uid9_divider_merged_bit_select_c_1(DELAY,371)
    redist4_rVStage_uid64_zCount_uid9_divider_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid64_zCount_uid9_divider_merged_bit_select_c, xout => redist4_rVStage_uid64_zCount_uid9_divider_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist3_rVStage_uid64_zCount_uid9_divider_merged_bit_select_b_1(DELAY,370)
    redist3_rVStage_uid64_zCount_uid9_divider_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid64_zCount_uid9_divider_merged_bit_select_b, xout => redist3_rVStage_uid64_zCount_uid9_divider_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- vStagei_uid68_zCount_uid9_divider(MUX,67)@7
    vStagei_uid68_zCount_uid9_divider_s <= vCount_uid65_zCount_uid9_divider_q;
    vStagei_uid68_zCount_uid9_divider_combproc: PROCESS (vStagei_uid68_zCount_uid9_divider_s, redist3_rVStage_uid64_zCount_uid9_divider_merged_bit_select_b_1_q, redist4_rVStage_uid64_zCount_uid9_divider_merged_bit_select_c_1_q)
    BEGIN
        CASE (vStagei_uid68_zCount_uid9_divider_s) IS
            WHEN "0" => vStagei_uid68_zCount_uid9_divider_q <= redist3_rVStage_uid64_zCount_uid9_divider_merged_bit_select_b_1_q;
            WHEN "1" => vStagei_uid68_zCount_uid9_divider_q <= redist4_rVStage_uid64_zCount_uid9_divider_merged_bit_select_c_1_q;
            WHEN OTHERS => vStagei_uid68_zCount_uid9_divider_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid70_zCount_uid9_divider(BITSELECT,69)@7
    rVStage_uid70_zCount_uid9_divider_b <= vStagei_uid68_zCount_uid9_divider_q(1 downto 1);

    -- vCount_uid71_zCount_uid9_divider(LOGICAL,70)@7
    vCount_uid71_zCount_uid9_divider_q <= "1" WHEN rVStage_uid70_zCount_uid9_divider_b = GND_q ELSE "0";

    -- r_uid72_zCount_uid9_divider(BITJOIN,71)@7
    r_uid72_zCount_uid9_divider_q <= redist55_vCount_uid41_zCount_uid9_divider_q_7_q & redist54_vCount_uid47_zCount_uid9_divider_q_5_q & redist53_vCount_uid53_zCount_uid9_divider_q_3_q & redist52_vCount_uid59_zCount_uid9_divider_q_2_q & vCount_uid65_zCount_uid9_divider_q & vCount_uid71_zCount_uid9_divider_q;

    -- leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select(BITSELECT,363)@7
    leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_b <= r_uid72_zCount_uid9_divider_q(5 downto 4);
    leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_c <= r_uid72_zCount_uid9_divider_q(3 downto 2);
    leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_d <= r_uid72_zCount_uid9_divider_q(1 downto 0);

    -- leftShiftStage0_uid158_normY_uid10_divider(MUX,157)@7 + 1
    leftShiftStage0_uid158_normY_uid10_divider_s <= leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_b;
    leftShiftStage0_uid158_normY_uid10_divider_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                leftShiftStage0_uid158_normY_uid10_divider_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (leftShiftStage0_uid158_normY_uid10_divider_s) IS
                        WHEN "00" => leftShiftStage0_uid158_normY_uid10_divider_q <= redist71_in_rsrvd_fix_denominator_7_outputreg1_q;
                        WHEN "01" => leftShiftStage0_uid158_normY_uid10_divider_q <= leftShiftStage0Idx1_uid154_normY_uid10_divider_q;
                        WHEN "10" => leftShiftStage0_uid158_normY_uid10_divider_q <= zs_uid39_zCount_uid9_divider_q;
                        WHEN "11" => leftShiftStage0_uid158_normY_uid10_divider_q <= zs_uid39_zCount_uid9_divider_q;
                        WHEN OTHERS => leftShiftStage0_uid158_normY_uid10_divider_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist1_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_c_1(DELAY,368)
    redist1_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_c, xout => redist1_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- leftShiftStage1_uid169_normY_uid10_divider(MUX,168)@8
    leftShiftStage1_uid169_normY_uid10_divider_s <= redist1_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_c_1_q;
    leftShiftStage1_uid169_normY_uid10_divider_combproc: PROCESS (leftShiftStage1_uid169_normY_uid10_divider_s, leftShiftStage0_uid158_normY_uid10_divider_q, leftShiftStage1Idx1_uid161_normY_uid10_divider_q, leftShiftStage1Idx2_uid164_normY_uid10_divider_q, leftShiftStage1Idx3_uid167_normY_uid10_divider_q)
    BEGIN
        CASE (leftShiftStage1_uid169_normY_uid10_divider_s) IS
            WHEN "00" => leftShiftStage1_uid169_normY_uid10_divider_q <= leftShiftStage0_uid158_normY_uid10_divider_q;
            WHEN "01" => leftShiftStage1_uid169_normY_uid10_divider_q <= leftShiftStage1Idx1_uid161_normY_uid10_divider_q;
            WHEN "10" => leftShiftStage1_uid169_normY_uid10_divider_q <= leftShiftStage1Idx2_uid164_normY_uid10_divider_q;
            WHEN "11" => leftShiftStage1_uid169_normY_uid10_divider_q <= leftShiftStage1Idx3_uid167_normY_uid10_divider_q;
            WHEN OTHERS => leftShiftStage1_uid169_normY_uid10_divider_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist2_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_d_1(DELAY,369)
    redist2_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_d_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_d, xout => redist2_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_d_1_q, ena => en(0), clk => clk, aclr => rst );

    -- leftShiftStage2_uid180_normY_uid10_divider(MUX,179)@8
    leftShiftStage2_uid180_normY_uid10_divider_s <= redist2_leftShiftStageSel0Dto4_uid157_normY_uid10_divider_merged_bit_select_d_1_q;
    leftShiftStage2_uid180_normY_uid10_divider_combproc: PROCESS (leftShiftStage2_uid180_normY_uid10_divider_s, leftShiftStage1_uid169_normY_uid10_divider_q, leftShiftStage2Idx1_uid172_normY_uid10_divider_q, leftShiftStage2Idx2_uid175_normY_uid10_divider_q, leftShiftStage2Idx3_uid178_normY_uid10_divider_q)
    BEGIN
        CASE (leftShiftStage2_uid180_normY_uid10_divider_s) IS
            WHEN "00" => leftShiftStage2_uid180_normY_uid10_divider_q <= leftShiftStage1_uid169_normY_uid10_divider_q;
            WHEN "01" => leftShiftStage2_uid180_normY_uid10_divider_q <= leftShiftStage2Idx1_uid172_normY_uid10_divider_q;
            WHEN "10" => leftShiftStage2_uid180_normY_uid10_divider_q <= leftShiftStage2Idx2_uid175_normY_uid10_divider_q;
            WHEN "11" => leftShiftStage2_uid180_normY_uid10_divider_q <= leftShiftStage2Idx3_uid178_normY_uid10_divider_q;
            WHEN OTHERS => leftShiftStage2_uid180_normY_uid10_divider_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- normYNoLeadOne_uid11_divider(BITSELECT,10)@8
    normYNoLeadOne_uid11_divider_in <= leftShiftStage2_uid180_normY_uid10_divider_q(30 downto 0);
    normYNoLeadOne_uid11_divider_b <= normYNoLeadOne_uid11_divider_in(30 downto 0);

    -- redist68_normYNoLeadOne_uid11_divider_b_1(DELAY,435)
    redist68_normYNoLeadOne_uid11_divider_b_1 : dspba_delay
    GENERIC MAP ( width => 31, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => normYNoLeadOne_uid11_divider_b, xout => redist68_normYNoLeadOne_uid11_divider_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- yPPolyEval_uid20_divider(BITSELECT,19)@9
    yPPolyEval_uid20_divider_in <= redist68_normYNoLeadOne_uid11_divider_b_1_q(22 downto 0);
    yPPolyEval_uid20_divider_b <= yPPolyEval_uid20_divider_in(22 downto 0);

    -- redist59_yPPolyEval_uid20_divider_b_3(DELAY,426)
    redist59_yPPolyEval_uid20_divider_b_3 : dspba_delay
    GENERIC MAP ( width => 23, depth => 3, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => yPPolyEval_uid20_divider_b, xout => redist59_yPPolyEval_uid20_divider_b_3_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_yPPolyEval_uid20_divider_b_10_inputreg0(DELAY,441)
    redist60_yPPolyEval_uid20_divider_b_10_inputreg0 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist59_yPPolyEval_uid20_divider_b_3_q, xout => redist60_yPPolyEval_uid20_divider_b_10_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_yPPolyEval_uid20_divider_b_10(DELAY,427)
    redist60_yPPolyEval_uid20_divider_b_10 : dspba_delay
    GENERIC MAP ( width => 23, depth => 4, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_yPPolyEval_uid20_divider_b_10_inputreg0_q, xout => redist60_yPPolyEval_uid20_divider_b_10_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_yPPolyEval_uid20_divider_b_10_outputreg1(DELAY,443)
    redist60_yPPolyEval_uid20_divider_b_10_outputreg1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_yPPolyEval_uid20_divider_b_10_q, xout => redist60_yPPolyEval_uid20_divider_b_10_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_yPPolyEval_uid20_divider_b_10_outputreg2(DELAY,442)
    redist60_yPPolyEval_uid20_divider_b_10_outputreg2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_yPPolyEval_uid20_divider_b_10_outputreg1_q, xout => redist60_yPPolyEval_uid20_divider_b_10_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist61_yPPolyEval_uid20_divider_b_17_inputreg2(DELAY,444)
    redist61_yPPolyEval_uid20_divider_b_17_inputreg2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_yPPolyEval_uid20_divider_b_10_outputreg2_q, xout => redist61_yPPolyEval_uid20_divider_b_17_inputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist61_yPPolyEval_uid20_divider_b_17_inputreg1(DELAY,446)
    redist61_yPPolyEval_uid20_divider_b_17_inputreg1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist61_yPPolyEval_uid20_divider_b_17_inputreg2_q, xout => redist61_yPPolyEval_uid20_divider_b_17_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist61_yPPolyEval_uid20_divider_b_17(DELAY,428)
    redist61_yPPolyEval_uid20_divider_b_17 : dspba_delay
    GENERIC MAP ( width => 23, depth => 4, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist61_yPPolyEval_uid20_divider_b_17_inputreg1_q, xout => redist61_yPPolyEval_uid20_divider_b_17_q, ena => en(0), clk => clk, aclr => rst );

    -- redist61_yPPolyEval_uid20_divider_b_17_outputreg2(DELAY,445)
    redist61_yPPolyEval_uid20_divider_b_17_outputreg2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist61_yPPolyEval_uid20_divider_b_17_q, xout => redist61_yPPolyEval_uid20_divider_b_17_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- nx_mergedSignalTM_uid127_pT3_uid103_invPolyEval(BITJOIN,126)@26
    nx_mergedSignalTM_uid127_pT3_uid103_invPolyEval_q <= GND_q & redist61_yPPolyEval_uid20_divider_b_17_outputreg2_q;

    -- topRangeX_uid129_pT3_uid103_invPolyEval_merged_bit_select(BITSELECT,365)@26
    topRangeX_uid129_pT3_uid103_invPolyEval_merged_bit_select_b <= STD_LOGIC_VECTOR(nx_mergedSignalTM_uid127_pT3_uid103_invPolyEval_q(23 downto 6));
    topRangeX_uid129_pT3_uid103_invPolyEval_merged_bit_select_c <= STD_LOGIC_VECTOR(nx_mergedSignalTM_uid127_pT3_uid103_invPolyEval_q(5 downto 0));

    -- aboveLeftY_bottomExtension_uid132_pT3_uid103_invPolyEval(CONSTANT,131)
    aboveLeftY_bottomExtension_uid132_pT3_uid103_invPolyEval_q <= "00000";

    -- aboveLeftY_mergedSignalTM_uid134_pT3_uid103_invPolyEval(BITJOIN,133)@26
    aboveLeftY_mergedSignalTM_uid134_pT3_uid103_invPolyEval_q <= topRangeY_uid130_pT3_uid103_invPolyEval_merged_bit_select_c & aboveLeftY_bottomExtension_uid132_pT3_uid103_invPolyEval_q;

    -- yAddr_uid19_divider(BITSELECT,18)@9
    yAddr_uid19_divider_b <= redist68_normYNoLeadOne_uid11_divider_b_1_q(30 downto 23);

    -- memoryC3_uid83_invTabGen_lutmem(DUALMEM,251)@9 + 2
    -- in j@20000000
    memoryC3_uid83_invTabGen_lutmem_aa <= yAddr_uid19_divider_b;
    memoryC3_uid83_invTabGen_lutmem_reset0 <= rst;
    memoryC3_uid83_invTabGen_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 14,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FIX_DIV_altera_fxp_functions_180_z7uu2xi_memoryC3_uid83_invTabGen_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken0 => en(0),
        sclr => memoryC3_uid83_invTabGen_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC3_uid83_invTabGen_lutmem_aa,
        q_a => memoryC3_uid83_invTabGen_lutmem_ir
    );
    memoryC3_uid83_invTabGen_lutmem_r <= memoryC3_uid83_invTabGen_lutmem_ir(13 downto 0);
    memoryC3_uid83_invTabGen_lutmem_enaOr_rst <= en(0) or memoryC3_uid83_invTabGen_lutmem_reset0;

    -- redist41_memoryC3_uid83_invTabGen_lutmem_r_1(DELAY,408)
    redist41_memoryC3_uid83_invTabGen_lutmem_r_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => memoryC3_uid83_invTabGen_lutmem_r, xout => redist41_memoryC3_uid83_invTabGen_lutmem_r_1_q, ena => en(0), clk => clk, aclr => rst );

    -- yT1_uid90_invPolyEval(BITSELECT,89)@12
    yT1_uid90_invPolyEval_b <= redist59_yPPolyEval_uid20_divider_b_3_q(22 downto 9);

    -- prodXY_uid109_pT1_uid91_invPolyEval_cma(CHAINMULTADD,350)@12 + 5
    -- out q@18
    prodXY_uid109_pT1_uid91_invPolyEval_cma_reset <= rst;
    prodXY_uid109_pT1_uid91_invPolyEval_cma_ena0 <= en(0) or prodXY_uid109_pT1_uid91_invPolyEval_cma_reset;
    prodXY_uid109_pT1_uid91_invPolyEval_cma_ena1 <= prodXY_uid109_pT1_uid91_invPolyEval_cma_ena0;
    prodXY_uid109_pT1_uid91_invPolyEval_cma_ena2 <= prodXY_uid109_pT1_uid91_invPolyEval_cma_ena0;
    prodXY_uid109_pT1_uid91_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    prodXY_uid109_pT1_uid91_invPolyEval_cma_ah(0) <= RESIZE(UNSIGNED(yT1_uid90_invPolyEval_b),14);
                    prodXY_uid109_pT1_uid91_invPolyEval_cma_ch(0) <= RESIZE(SIGNED(redist41_memoryC3_uid83_invTabGen_lutmem_r_1_q),14);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    prodXY_uid109_pT1_uid91_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(prodXY_uid109_pT1_uid91_invPolyEval_cma_ah(0));
    prodXY_uid109_pT1_uid91_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(prodXY_uid109_pT1_uid91_invPolyEval_cma_ch(0));
    prodXY_uid109_pT1_uid91_invPolyEval_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 14,
        ax_clock => "0",
        ax_width => 14,
        signed_may => "false",
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
        ena(0) => prodXY_uid109_pT1_uid91_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid109_pT1_uid91_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid109_pT1_uid91_invPolyEval_cma_ena2,
        clr(0) => prodXY_uid109_pT1_uid91_invPolyEval_cma_reset,
        clr(1) => prodXY_uid109_pT1_uid91_invPolyEval_cma_reset,
        ay => prodXY_uid109_pT1_uid91_invPolyEval_cma_a0,
        ax => prodXY_uid109_pT1_uid91_invPolyEval_cma_c0,
        resulta => prodXY_uid109_pT1_uid91_invPolyEval_cma_s0
    );
    prodXY_uid109_pT1_uid91_invPolyEval_cma_delay : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid109_pT1_uid91_invPolyEval_cma_s0, xout => prodXY_uid109_pT1_uid91_invPolyEval_cma_qq, ena => en(0), clk => clk, aclr => rst );
    prodXY_uid109_pT1_uid91_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid109_pT1_uid91_invPolyEval_cma_qq(27 downto 0));

    -- osig_uid110_pT1_uid91_invPolyEval(BITSELECT,109)@18
    osig_uid110_pT1_uid91_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid109_pT1_uid91_invPolyEval_cma_q(27 downto 14));

    -- redist49_osig_uid110_pT1_uid91_invPolyEval_b_1(DELAY,416)
    redist49_osig_uid110_pT1_uid91_invPolyEval_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => osig_uid110_pT1_uid91_invPolyEval_b, xout => redist49_osig_uid110_pT1_uid91_invPolyEval_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- highBBits_uid93_invPolyEval(BITSELECT,92)@19
    highBBits_uid93_invPolyEval_b <= STD_LOGIC_VECTOR(redist49_osig_uid110_pT1_uid91_invPolyEval_b_1_q(13 downto 1));

    -- redist62_yAddr_uid19_divider_b_7_inputreg1(DELAY,447)
    redist62_yAddr_uid19_divider_b_7_inputreg1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => yAddr_uid19_divider_b, xout => redist62_yAddr_uid19_divider_b_7_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist62_yAddr_uid19_divider_b_7(DELAY,429)
    redist62_yAddr_uid19_divider_b_7 : dspba_delay
    GENERIC MAP ( width => 8, depth => 5, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist62_yAddr_uid19_divider_b_7_inputreg1_q, xout => redist62_yAddr_uid19_divider_b_7_q, ena => en(0), clk => clk, aclr => rst );

    -- redist62_yAddr_uid19_divider_b_7_outputreg2(DELAY,448)
    redist62_yAddr_uid19_divider_b_7_outputreg2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist62_yAddr_uid19_divider_b_7_q, xout => redist62_yAddr_uid19_divider_b_7_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- memoryC2_uid80_invTabGen_lutmem(DUALMEM,250)@16 + 2
    -- in j@20000000
    memoryC2_uid80_invTabGen_lutmem_aa <= redist62_yAddr_uid19_divider_b_7_outputreg2_q;
    memoryC2_uid80_invTabGen_lutmem_reset0 <= rst;
    memoryC2_uid80_invTabGen_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 21,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FIX_DIV_altera_fxp_functions_180_z7uu2xi_memoryC2_uid80_invTabGen_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken0 => en(0),
        sclr => memoryC2_uid80_invTabGen_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC2_uid80_invTabGen_lutmem_aa,
        q_a => memoryC2_uid80_invTabGen_lutmem_ir
    );
    memoryC2_uid80_invTabGen_lutmem_r <= memoryC2_uid80_invTabGen_lutmem_ir(20 downto 0);
    memoryC2_uid80_invTabGen_lutmem_enaOr_rst <= en(0) or memoryC2_uid80_invTabGen_lutmem_reset0;

    -- redist42_memoryC2_uid80_invTabGen_lutmem_r_1(DELAY,409)
    redist42_memoryC2_uid80_invTabGen_lutmem_r_1 : dspba_delay
    GENERIC MAP ( width => 21, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => memoryC2_uid80_invTabGen_lutmem_r, xout => redist42_memoryC2_uid80_invTabGen_lutmem_r_1_q, ena => en(0), clk => clk, aclr => rst );

    -- s1sumAHighB_uid94_invPolyEval(ADD,93)@19
    s1sumAHighB_uid94_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => redist42_memoryC2_uid80_invTabGen_lutmem_r_1_q(20)) & redist42_memoryC2_uid80_invTabGen_lutmem_r_1_q));
    s1sumAHighB_uid94_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 13 => highBBits_uid93_invPolyEval_b(12)) & highBBits_uid93_invPolyEval_b));
    s1sumAHighB_uid94_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s1sumAHighB_uid94_invPolyEval_a) + SIGNED(s1sumAHighB_uid94_invPolyEval_b));
    s1sumAHighB_uid94_invPolyEval_q <= s1sumAHighB_uid94_invPolyEval_o(21 downto 0);

    -- lowRangeB_uid92_invPolyEval(BITSELECT,91)@19
    lowRangeB_uid92_invPolyEval_in <= redist49_osig_uid110_pT1_uid91_invPolyEval_b_1_q(0 downto 0);
    lowRangeB_uid92_invPolyEval_b <= lowRangeB_uid92_invPolyEval_in(0 downto 0);

    -- s1_uid95_invPolyEval(BITJOIN,94)@19
    s1_uid95_invPolyEval_q <= s1sumAHighB_uid94_invPolyEval_q & lowRangeB_uid92_invPolyEval_b;

    -- yT2_uid96_invPolyEval(BITSELECT,95)@19
    yT2_uid96_invPolyEval_b <= redist60_yPPolyEval_uid20_divider_b_10_outputreg2_q(22 downto 2);

    -- prodXY_uid112_pT2_uid97_invPolyEval_cma(CHAINMULTADD,351)@19 + 5
    -- out q@25
    prodXY_uid112_pT2_uid97_invPolyEval_cma_reset <= rst;
    prodXY_uid112_pT2_uid97_invPolyEval_cma_ena0 <= en(0) or prodXY_uid112_pT2_uid97_invPolyEval_cma_reset;
    prodXY_uid112_pT2_uid97_invPolyEval_cma_ena1 <= prodXY_uid112_pT2_uid97_invPolyEval_cma_ena0;
    prodXY_uid112_pT2_uid97_invPolyEval_cma_ena2 <= prodXY_uid112_pT2_uid97_invPolyEval_cma_ena0;
    prodXY_uid112_pT2_uid97_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    prodXY_uid112_pT2_uid97_invPolyEval_cma_ah(0) <= RESIZE(UNSIGNED(yT2_uid96_invPolyEval_b),21);
                    prodXY_uid112_pT2_uid97_invPolyEval_cma_ch(0) <= RESIZE(SIGNED(s1_uid95_invPolyEval_q),23);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    prodXY_uid112_pT2_uid97_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(prodXY_uid112_pT2_uid97_invPolyEval_cma_ah(0));
    prodXY_uid112_pT2_uid97_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(prodXY_uid112_pT2_uid97_invPolyEval_cma_ch(0));
    prodXY_uid112_pT2_uid97_invPolyEval_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 21,
        ax_clock => "0",
        ax_width => 23,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 44
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXY_uid112_pT2_uid97_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid112_pT2_uid97_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid112_pT2_uid97_invPolyEval_cma_ena2,
        clr(0) => prodXY_uid112_pT2_uid97_invPolyEval_cma_reset,
        clr(1) => prodXY_uid112_pT2_uid97_invPolyEval_cma_reset,
        ay => prodXY_uid112_pT2_uid97_invPolyEval_cma_a0,
        ax => prodXY_uid112_pT2_uid97_invPolyEval_cma_c0,
        resulta => prodXY_uid112_pT2_uid97_invPolyEval_cma_s0
    );
    prodXY_uid112_pT2_uid97_invPolyEval_cma_delay : dspba_delay
    GENERIC MAP ( width => 44, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid112_pT2_uid97_invPolyEval_cma_s0, xout => prodXY_uid112_pT2_uid97_invPolyEval_cma_qq, ena => en(0), clk => clk, aclr => rst );
    prodXY_uid112_pT2_uid97_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid112_pT2_uid97_invPolyEval_cma_qq(43 downto 0));

    -- osig_uid113_pT2_uid97_invPolyEval(BITSELECT,112)@25
    osig_uid113_pT2_uid97_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid112_pT2_uid97_invPolyEval_cma_q(43 downto 21));

    -- redist48_osig_uid113_pT2_uid97_invPolyEval_b_1(DELAY,415)
    redist48_osig_uid113_pT2_uid97_invPolyEval_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => osig_uid113_pT2_uid97_invPolyEval_b, xout => redist48_osig_uid113_pT2_uid97_invPolyEval_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- highBBits_uid99_invPolyEval(BITSELECT,98)@26
    highBBits_uid99_invPolyEval_b <= STD_LOGIC_VECTOR(redist48_osig_uid113_pT2_uid97_invPolyEval_b_1_q(22 downto 1));

    -- redist63_yAddr_uid19_divider_b_14_inputreg2(DELAY,449)
    redist63_yAddr_uid19_divider_b_14_inputreg2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist62_yAddr_uid19_divider_b_7_outputreg2_q, xout => redist63_yAddr_uid19_divider_b_14_inputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist63_yAddr_uid19_divider_b_14(DELAY,430)
    redist63_yAddr_uid19_divider_b_14 : dspba_delay
    GENERIC MAP ( width => 8, depth => 5, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist63_yAddr_uid19_divider_b_14_inputreg2_q, xout => redist63_yAddr_uid19_divider_b_14_q, ena => en(0), clk => clk, aclr => rst );

    -- redist63_yAddr_uid19_divider_b_14_outputreg2(DELAY,450)
    redist63_yAddr_uid19_divider_b_14_outputreg2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist63_yAddr_uid19_divider_b_14_q, xout => redist63_yAddr_uid19_divider_b_14_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- memoryC1_uid77_invTabGen_lutmem(DUALMEM,249)@23 + 2
    -- in j@20000000
    memoryC1_uid77_invTabGen_lutmem_aa <= redist63_yAddr_uid19_divider_b_14_outputreg2_q;
    memoryC1_uid77_invTabGen_lutmem_reset0 <= rst;
    memoryC1_uid77_invTabGen_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 29,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FIX_DIV_altera_fxp_functions_180_z7uu2xi_memoryC1_uid77_invTabGen_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken0 => en(0),
        sclr => memoryC1_uid77_invTabGen_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC1_uid77_invTabGen_lutmem_aa,
        q_a => memoryC1_uid77_invTabGen_lutmem_ir
    );
    memoryC1_uid77_invTabGen_lutmem_r <= memoryC1_uid77_invTabGen_lutmem_ir(28 downto 0);
    memoryC1_uid77_invTabGen_lutmem_enaOr_rst <= en(0) or memoryC1_uid77_invTabGen_lutmem_reset0;

    -- redist43_memoryC1_uid77_invTabGen_lutmem_r_1(DELAY,410)
    redist43_memoryC1_uid77_invTabGen_lutmem_r_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => memoryC1_uid77_invTabGen_lutmem_r, xout => redist43_memoryC1_uid77_invTabGen_lutmem_r_1_q, ena => en(0), clk => clk, aclr => rst );

    -- s2sumAHighB_uid100_invPolyEval(ADD,99)@26
    s2sumAHighB_uid100_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => redist43_memoryC1_uid77_invTabGen_lutmem_r_1_q(28)) & redist43_memoryC1_uid77_invTabGen_lutmem_r_1_q));
    s2sumAHighB_uid100_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 22 => highBBits_uid99_invPolyEval_b(21)) & highBBits_uid99_invPolyEval_b));
    s2sumAHighB_uid100_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s2sumAHighB_uid100_invPolyEval_a) + SIGNED(s2sumAHighB_uid100_invPolyEval_b));
    s2sumAHighB_uid100_invPolyEval_q <= s2sumAHighB_uid100_invPolyEval_o(29 downto 0);

    -- lowRangeB_uid98_invPolyEval(BITSELECT,97)@26
    lowRangeB_uid98_invPolyEval_in <= redist48_osig_uid113_pT2_uid97_invPolyEval_b_1_q(0 downto 0);
    lowRangeB_uid98_invPolyEval_b <= lowRangeB_uid98_invPolyEval_in(0 downto 0);

    -- s2_uid101_invPolyEval(BITJOIN,100)@26
    s2_uid101_invPolyEval_q <= s2sumAHighB_uid100_invPolyEval_q & lowRangeB_uid98_invPolyEval_b;

    -- topRangeY_uid130_pT3_uid103_invPolyEval_merged_bit_select(BITSELECT,364)@26
    topRangeY_uid130_pT3_uid103_invPolyEval_merged_bit_select_b <= STD_LOGIC_VECTOR(s2_uid101_invPolyEval_q(30 downto 13));
    topRangeY_uid130_pT3_uid103_invPolyEval_merged_bit_select_c <= STD_LOGIC_VECTOR(s2_uid101_invPolyEval_q(12 downto 0));

    -- rightBottomX_mergedSignalTM_uid138_pT3_uid103_invPolyEval(BITJOIN,137)@26
    rightBottomX_mergedSignalTM_uid138_pT3_uid103_invPolyEval_q <= topRangeX_uid129_pT3_uid103_invPolyEval_merged_bit_select_c & rightBottomX_bottomExtension_uid136_pT3_uid103_invPolyEval_q;

    -- multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma(CHAINMULTADD,355)@26 + 5
    -- out q@32
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_reset <= rst;
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena0 <= en(0) or multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_reset;
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena1 <= multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena0;
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena2 <= multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena0;
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ah(0) <= RESIZE(UNSIGNED(rightBottomX_mergedSignalTM_uid138_pT3_uid103_invPolyEval_q),18);
                    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ah(1) <= RESIZE(UNSIGNED(aboveLeftY_mergedSignalTM_uid134_pT3_uid103_invPolyEval_q),18);
                    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ch(0) <= RESIZE(SIGNED(topRangeY_uid130_pT3_uid103_invPolyEval_merged_bit_select_b),18);
                    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ch(1) <= RESIZE(SIGNED(topRangeX_uid129_pT3_uid103_invPolyEval_merged_bit_select_b),18);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ah(0));
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ch(0));
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_a1 <= STD_LOGIC_VECTOR(multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ah(1));
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_c1 <= STD_LOGIC_VECTOR(multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ch(1));
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_sumof2",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 18,
        by_clock => "0",
        by_width => 18,
        ax_clock => "0",
        bx_clock => "0",
        ax_width => 18,
        bx_width => 18,
        signed_may => "false",
        signed_mby => "false",
        signed_max => "true",
        signed_mbx => "true",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 37
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena0,
        ena(1) => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena1,
        ena(2) => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_ena2,
        clr(0) => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_reset,
        clr(1) => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_reset,
        ay => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_a1,
        by => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_a0,
        ax => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_c1,
        bx => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_c0,
        resulta => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_s0
    );
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_delay : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_s0, xout => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_qq, ena => en(0), clk => clk, aclr => rst );
    multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q <= STD_LOGIC_VECTOR(multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_qq(36 downto 0));

    -- redist14_multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q_1(DELAY,381)
    redist14_multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q, xout => redist14_multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1(BITSELECT,307)@33
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b <= STD_LOGIC_VECTOR(redist14_multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q_1_q(36 downto 36));

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_0(BITSELECT,306)@33
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_0_b <= STD_LOGIC_VECTOR(redist14_multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q_1_q(36 downto 18));

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_BitJoin_for_b(BITJOIN,323)@33
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_BitJoin_for_b_q <= lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_0_b;

    -- sm0_uid141_pT3_uid103_invPolyEval_cma(CHAINMULTADD,352)@26 + 5
    -- out q@32
    sm0_uid141_pT3_uid103_invPolyEval_cma_reset <= rst;
    sm0_uid141_pT3_uid103_invPolyEval_cma_ena0 <= en(0) or sm0_uid141_pT3_uid103_invPolyEval_cma_reset;
    sm0_uid141_pT3_uid103_invPolyEval_cma_ena1 <= sm0_uid141_pT3_uid103_invPolyEval_cma_ena0;
    sm0_uid141_pT3_uid103_invPolyEval_cma_ena2 <= sm0_uid141_pT3_uid103_invPolyEval_cma_ena0;
    sm0_uid141_pT3_uid103_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    sm0_uid141_pT3_uid103_invPolyEval_cma_ah(0) <= RESIZE(SIGNED(topRangeX_uid129_pT3_uid103_invPolyEval_merged_bit_select_b),18);
                    sm0_uid141_pT3_uid103_invPolyEval_cma_ch(0) <= RESIZE(SIGNED(topRangeY_uid130_pT3_uid103_invPolyEval_merged_bit_select_b),18);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    sm0_uid141_pT3_uid103_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(sm0_uid141_pT3_uid103_invPolyEval_cma_ah(0));
    sm0_uid141_pT3_uid103_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(sm0_uid141_pT3_uid103_invPolyEval_cma_ch(0));
    sm0_uid141_pT3_uid103_invPolyEval_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 18,
        ax_clock => "0",
        ax_width => 18,
        signed_may => "true",
        signed_max => "true",
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
        ena(0) => sm0_uid141_pT3_uid103_invPolyEval_cma_ena0,
        ena(1) => sm0_uid141_pT3_uid103_invPolyEval_cma_ena1,
        ena(2) => sm0_uid141_pT3_uid103_invPolyEval_cma_ena2,
        clr(0) => sm0_uid141_pT3_uid103_invPolyEval_cma_reset,
        clr(1) => sm0_uid141_pT3_uid103_invPolyEval_cma_reset,
        ay => sm0_uid141_pT3_uid103_invPolyEval_cma_a0,
        ax => sm0_uid141_pT3_uid103_invPolyEval_cma_c0,
        resulta => sm0_uid141_pT3_uid103_invPolyEval_cma_s0
    );
    sm0_uid141_pT3_uid103_invPolyEval_cma_delay : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => sm0_uid141_pT3_uid103_invPolyEval_cma_s0, xout => sm0_uid141_pT3_uid103_invPolyEval_cma_qq, ena => en(0), clk => clk, aclr => rst );
    sm0_uid141_pT3_uid103_invPolyEval_cma_q <= STD_LOGIC_VECTOR(sm0_uid141_pT3_uid103_invPolyEval_cma_qq(35 downto 0));

    -- redist17_sm0_uid141_pT3_uid103_invPolyEval_cma_q_1(DELAY,384)
    redist17_sm0_uid141_pT3_uid103_invPolyEval_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sm0_uid141_pT3_uid103_invPolyEval_cma_q, xout => redist17_sm0_uid141_pT3_uid103_invPolyEval_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel0_0(BITSELECT,301)@33
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel0_0_b <= STD_LOGIC_VECTOR(redist17_sm0_uid141_pT3_uid103_invPolyEval_cma_q_1_q(34 downto 0));

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2(ADD,271)@33 + 1
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_a <= STD_LOGIC_VECTOR("0" & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel0_0_b);
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_b <= STD_LOGIC_VECTOR("0" & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_BitJoin_for_b_q);
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_a) + UNSIGNED(lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_c(0) <= lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_o(35);
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q <= lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_o(34 downto 0);

    -- s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_1(BITSELECT,290)@34
    s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_1_b <= STD_LOGIC_VECTOR(lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q(34 downto 34));

    -- s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_0(BITSELECT,289)@34
    s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_0_b <= STD_LOGIC_VECTOR(lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q(34 downto 5));

    -- s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_BitJoin_for_b(BITJOIN,295)@34
    s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_BitJoin_for_b_q <= s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_1_b & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_1_b & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_1_b & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_1_b & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_1_b & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel0_0_b;

    -- redist64_yAddr_uid19_divider_b_22_inputreg2(DELAY,451)
    redist64_yAddr_uid19_divider_b_22_inputreg2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist63_yAddr_uid19_divider_b_14_outputreg2_q, xout => redist64_yAddr_uid19_divider_b_22_inputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist64_yAddr_uid19_divider_b_22_inputreg1(DELAY,453)
    redist64_yAddr_uid19_divider_b_22_inputreg1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist64_yAddr_uid19_divider_b_22_inputreg2_q, xout => redist64_yAddr_uid19_divider_b_22_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist64_yAddr_uid19_divider_b_22(DELAY,431)
    redist64_yAddr_uid19_divider_b_22 : dspba_delay
    GENERIC MAP ( width => 8, depth => 5, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist64_yAddr_uid19_divider_b_22_inputreg1_q, xout => redist64_yAddr_uid19_divider_b_22_q, ena => en(0), clk => clk, aclr => rst );

    -- redist64_yAddr_uid19_divider_b_22_outputreg2(DELAY,452)
    redist64_yAddr_uid19_divider_b_22_outputreg2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist64_yAddr_uid19_divider_b_22_q, xout => redist64_yAddr_uid19_divider_b_22_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- memoryC0_uid74_invTabGen_lutmem(DUALMEM,248)@31 + 2
    -- in j@20000000
    memoryC0_uid74_invTabGen_lutmem_aa <= redist64_yAddr_uid19_divider_b_22_outputreg2_q;
    memoryC0_uid74_invTabGen_lutmem_reset0 <= rst;
    memoryC0_uid74_invTabGen_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 38,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FIX_DIV_altera_fxp_functions_180_z7uu2xi_memoryC0_uid74_invTabGen_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken0 => en(0),
        sclr => memoryC0_uid74_invTabGen_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC0_uid74_invTabGen_lutmem_aa,
        q_a => memoryC0_uid74_invTabGen_lutmem_ir
    );
    memoryC0_uid74_invTabGen_lutmem_r <= memoryC0_uid74_invTabGen_lutmem_ir(37 downto 0);
    memoryC0_uid74_invTabGen_lutmem_enaOr_rst <= en(0) or memoryC0_uid74_invTabGen_lutmem_reset0;

    -- redist44_memoryC0_uid74_invTabGen_lutmem_r_1(DELAY,411)
    redist44_memoryC0_uid74_invTabGen_lutmem_r_1 : dspba_delay
    GENERIC MAP ( width => 38, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => memoryC0_uid74_invTabGen_lutmem_r, xout => redist44_memoryC0_uid74_invTabGen_lutmem_r_1_q, ena => en(0), clk => clk, aclr => rst );

    -- s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel0_0(BITSELECT,284)@34
    s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel0_0_b <= STD_LOGIC_VECTOR(redist44_memoryC0_uid74_invTabGen_lutmem_r_1_q(34 downto 0));

    -- s3sumAHighB_uid106_invPolyEval_p1_of_2(ADD,260)@34 + 1
    s3sumAHighB_uid106_invPolyEval_p1_of_2_a <= STD_LOGIC_VECTOR("0" & s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel0_0_b);
    s3sumAHighB_uid106_invPolyEval_p1_of_2_b <= STD_LOGIC_VECTOR("0" & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_BitJoin_for_b_q);
    s3sumAHighB_uid106_invPolyEval_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                s3sumAHighB_uid106_invPolyEval_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    s3sumAHighB_uid106_invPolyEval_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(s3sumAHighB_uid106_invPolyEval_p1_of_2_a) + UNSIGNED(s3sumAHighB_uid106_invPolyEval_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    s3sumAHighB_uid106_invPolyEval_p1_of_2_c(0) <= s3sumAHighB_uid106_invPolyEval_p1_of_2_o(35);
    s3sumAHighB_uid106_invPolyEval_p1_of_2_q <= s3sumAHighB_uid106_invPolyEval_p1_of_2_o(34 downto 0);

    -- redist39_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q_1(DELAY,406)
    redist39_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q, xout => redist39_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel1_0(BITSELECT,296)@35
    s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel1_0_b <= STD_LOGIC_VECTOR(redist39_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q_1_q(34 downto 34));

    -- s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_BitJoin_for_c(BITJOIN,300)@35
    s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_BitJoin_for_c_q <= s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel1_0_b & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel1_0_b & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel1_0_b & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_tessel1_0_b;

    -- s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_1(BITSELECT,287)@34
    s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_1_b <= STD_LOGIC_VECTOR(redist44_memoryC0_uid74_invTabGen_lutmem_r_1_q(37 downto 37));

    -- redist36_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_1_b_1(DELAY,403)
    redist36_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_1_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_1_b, xout => redist36_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_1_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_0(BITSELECT,286)@34
    s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_0_b <= STD_LOGIC_VECTOR(redist44_memoryC0_uid74_invTabGen_lutmem_r_1_q(37 downto 35));

    -- redist37_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_0_b_1(DELAY,404)
    redist37_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_0_b_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_0_b, xout => redist37_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_0_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_BitJoin_for_c(BITJOIN,288)@35
    s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_BitJoin_for_c_q <= redist36_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_1_b_1_q & redist37_s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_tessel1_0_b_1_q;

    -- s3sumAHighB_uid106_invPolyEval_p2_of_2(ADD,261)@35 + 1
    s3sumAHighB_uid106_invPolyEval_p2_of_2_cin <= s3sumAHighB_uid106_invPolyEval_p1_of_2_c;
    s3sumAHighB_uid106_invPolyEval_p2_of_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((4 downto 4 => s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_BitJoin_for_c_q(3)) & s3sumAHighB_uid106_invPolyEval_BitSelect_for_a_BitJoin_for_c_q) & '1');
    s3sumAHighB_uid106_invPolyEval_p2_of_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((4 downto 4 => s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_BitJoin_for_c_q(3)) & s3sumAHighB_uid106_invPolyEval_BitSelect_for_b_BitJoin_for_c_q) & s3sumAHighB_uid106_invPolyEval_p2_of_2_cin(0));
    s3sumAHighB_uid106_invPolyEval_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                s3sumAHighB_uid106_invPolyEval_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    s3sumAHighB_uid106_invPolyEval_p2_of_2_o <= STD_LOGIC_VECTOR(SIGNED(s3sumAHighB_uid106_invPolyEval_p2_of_2_a) + SIGNED(s3sumAHighB_uid106_invPolyEval_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    s3sumAHighB_uid106_invPolyEval_p2_of_2_q <= s3sumAHighB_uid106_invPolyEval_p2_of_2_o(4 downto 1);

    -- redist40_s3sumAHighB_uid106_invPolyEval_p1_of_2_q_1(DELAY,407)
    redist40_s3sumAHighB_uid106_invPolyEval_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => s3sumAHighB_uid106_invPolyEval_p1_of_2_q, xout => redist40_s3sumAHighB_uid106_invPolyEval_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- s3sumAHighB_uid106_invPolyEval_BitJoin_for_q(BITJOIN,262)@36
    s3sumAHighB_uid106_invPolyEval_BitJoin_for_q_q <= s3sumAHighB_uid106_invPolyEval_p2_of_2_q & redist40_s3sumAHighB_uid106_invPolyEval_p1_of_2_q_1_q;

    -- redist32_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel1_1_b_1(DELAY,399)
    redist32_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel1_1_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel0_1_b, xout => redist32_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel1_1_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_BitJoin_for_c(BITJOIN,326)@34
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_BitJoin_for_c_q <= redist32_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel1_1_b_1_q & redist32_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_tessel1_1_b_1_q;

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_0(BITSELECT,303)@33
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_0_b <= STD_LOGIC_VECTOR(redist17_sm0_uid141_pT3_uid103_invPolyEval_cma_q_1_q(35 downto 35));

    -- redist34_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_1_b_1(DELAY,401)
    redist34_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_1_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_0_b, xout => redist34_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_1_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_BitJoin_for_c(BITJOIN,305)@34
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_BitJoin_for_c_q <= redist34_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_1_b_1_q & redist34_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_tessel1_1_b_1_q;

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2(ADD,272)@34 + 1
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_cin <= lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_c;
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((2 downto 2 => lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_BitJoin_for_c_q(1)) & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_a_BitJoin_for_c_q) & '1');
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((2 downto 2 => lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_BitJoin_for_c_q(1)) & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitSelect_for_b_BitJoin_for_c_q) & lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_cin(0));
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_o <= STD_LOGIC_VECTOR(SIGNED(lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_a) + SIGNED(lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_q <= lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_o(2 downto 1);

    -- lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitJoin_for_q(BITJOIN,273)@35
    lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitJoin_for_q_q <= lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p2_of_2_q & redist39_lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_p1_of_2_q_1_q;

    -- lowRangeB_uid144_pT3_uid103_invPolyEval(BITSELECT,143)@33
    lowRangeB_uid144_pT3_uid103_invPolyEval_in <= redist14_multSumOfTwoTS_uid142_pT3_uid103_invPolyEval_cma_q_1_q(17 downto 0);
    lowRangeB_uid144_pT3_uid103_invPolyEval_b <= lowRangeB_uid144_pT3_uid103_invPolyEval_in(17 downto 0);

    -- redist47_lowRangeB_uid144_pT3_uid103_invPolyEval_b_2(DELAY,414)
    redist47_lowRangeB_uid144_pT3_uid103_invPolyEval_b_2 : dspba_delay
    GENERIC MAP ( width => 18, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lowRangeB_uid144_pT3_uid103_invPolyEval_b, xout => redist47_lowRangeB_uid144_pT3_uid103_invPolyEval_b_2_q, ena => en(0), clk => clk, aclr => rst );

    -- lev1_a0_uid147_pT3_uid103_invPolyEval(BITJOIN,146)@35
    lev1_a0_uid147_pT3_uid103_invPolyEval_q <= lev1_a0sumAHighB_uid146_pT3_uid103_invPolyEval_BitJoin_for_q_q & redist47_lowRangeB_uid144_pT3_uid103_invPolyEval_b_2_q;

    -- os_uid148_pT3_uid103_invPolyEval(BITSELECT,147)@35
    os_uid148_pT3_uid103_invPolyEval_in <= STD_LOGIC_VECTOR(lev1_a0_uid147_pT3_uid103_invPolyEval_q(52 downto 0));
    os_uid148_pT3_uid103_invPolyEval_b <= STD_LOGIC_VECTOR(os_uid148_pT3_uid103_invPolyEval_in(52 downto 21));

    -- lowRangeB_uid104_invPolyEval(BITSELECT,103)@35
    lowRangeB_uid104_invPolyEval_in <= os_uid148_pT3_uid103_invPolyEval_b(1 downto 0);
    lowRangeB_uid104_invPolyEval_b <= lowRangeB_uid104_invPolyEval_in(1 downto 0);

    -- redist50_lowRangeB_uid104_invPolyEval_b_1(DELAY,417)
    redist50_lowRangeB_uid104_invPolyEval_b_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lowRangeB_uid104_invPolyEval_b, xout => redist50_lowRangeB_uid104_invPolyEval_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- s3_uid107_invPolyEval(BITJOIN,106)@36
    s3_uid107_invPolyEval_q <= s3sumAHighB_uid106_invPolyEval_BitJoin_for_q_q & redist50_lowRangeB_uid104_invPolyEval_b_1_q;

    -- fxpInverseRes_uid22_divider(BITSELECT,21)@36
    fxpInverseRes_uid22_divider_in <= s3_uid107_invPolyEval_q(38 downto 0);
    fxpInverseRes_uid22_divider_b <= fxpInverseRes_uid22_divider_in(38 downto 6);

    -- paddingY_uid12_divider(CONSTANT,11)
    paddingY_uid12_divider_q <= "0000000000000000000000000000000";

    -- updatedY_uid13_divider(BITJOIN,12)@9
    updatedY_uid13_divider_q <= GND_q & paddingY_uid12_divider_q;

    -- y0_uid183_normYIsOneC2_uid12_divider_merged_bit_select(BITSELECT,357)@9
    y0_uid183_normYIsOneC2_uid12_divider_merged_bit_select_b <= updatedY_uid13_divider_q(15 downto 0);
    y0_uid183_normYIsOneC2_uid12_divider_merged_bit_select_c <= updatedY_uid13_divider_q(31 downto 16);

    -- x1_uid185_normYIsOneC2_uid12_divider(BITSELECT,184)@9
    x1_uid185_normYIsOneC2_uid12_divider_b <= redist68_normYNoLeadOne_uid11_divider_b_1_q(30 downto 16);

    -- eq1_uid187_normYIsOneC2_uid12_divider(LOGICAL,186)@9 + 1
    eq1_uid187_normYIsOneC2_uid12_divider_a <= STD_LOGIC_VECTOR("0" & x1_uid185_normYIsOneC2_uid12_divider_b);
    eq1_uid187_normYIsOneC2_uid12_divider_qi <= "1" WHEN eq1_uid187_normYIsOneC2_uid12_divider_a = y0_uid183_normYIsOneC2_uid12_divider_merged_bit_select_c ELSE "0";
    eq1_uid187_normYIsOneC2_uid12_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => eq1_uid187_normYIsOneC2_uid12_divider_qi, xout => eq1_uid187_normYIsOneC2_uid12_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- x0_uid182_normYIsOneC2_uid12_divider(BITSELECT,181)@9
    x0_uid182_normYIsOneC2_uid12_divider_in <= redist68_normYNoLeadOne_uid11_divider_b_1_q(15 downto 0);
    x0_uid182_normYIsOneC2_uid12_divider_b <= x0_uid182_normYIsOneC2_uid12_divider_in(15 downto 0);

    -- eq0_uid184_normYIsOneC2_uid12_divider(LOGICAL,183)@9 + 1
    eq0_uid184_normYIsOneC2_uid12_divider_qi <= "1" WHEN x0_uid182_normYIsOneC2_uid12_divider_b = y0_uid183_normYIsOneC2_uid12_divider_merged_bit_select_b ELSE "0";
    eq0_uid184_normYIsOneC2_uid12_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => eq0_uid184_normYIsOneC2_uid12_divider_qi, xout => eq0_uid184_normYIsOneC2_uid12_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- andEq_uid188_normYIsOneC2_uid12_divider(LOGICAL,187)@10
    andEq_uid188_normYIsOneC2_uid12_divider_q <= eq0_uid184_normYIsOneC2_uid12_divider_q and eq1_uid187_normYIsOneC2_uid12_divider_q;

    -- normYIsOneC2_uid15_divider(BITSELECT,14)@8
    normYIsOneC2_uid15_divider_b <= STD_LOGIC_VECTOR(leftShiftStage2_uid180_normY_uid10_divider_q(31 downto 31));

    -- redist67_normYIsOneC2_uid15_divider_b_2(DELAY,434)
    redist67_normYIsOneC2_uid15_divider_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => normYIsOneC2_uid15_divider_b, xout => redist67_normYIsOneC2_uid15_divider_b_2_q, ena => en(0), clk => clk, aclr => rst );

    -- normYIsOne_uid16_divider(LOGICAL,15)@10 + 1
    normYIsOne_uid16_divider_qi <= redist67_normYIsOneC2_uid15_divider_b_2_q and andEq_uid188_normYIsOneC2_uid12_divider_q;
    normYIsOne_uid16_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => normYIsOne_uid16_divider_qi, xout => normYIsOne_uid16_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- redist66_normYIsOne_uid16_divider_q_26(DELAY,433)
    redist66_normYIsOne_uid16_divider_q_26 : dspba_delay
    GENERIC MAP ( width => 1, depth => 25, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => normYIsOne_uid16_divider_q, xout => redist66_normYIsOne_uid16_divider_q_26_q, ena => en(0), clk => clk, aclr => rst );

    -- invResPostOneHandling2_uid24_divider(MUX,23)@36 + 1
    invResPostOneHandling2_uid24_divider_s <= redist66_normYIsOne_uid16_divider_q_26_q;
    invResPostOneHandling2_uid24_divider_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                invResPostOneHandling2_uid24_divider_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (invResPostOneHandling2_uid24_divider_s) IS
                        WHEN "0" => invResPostOneHandling2_uid24_divider_q <= fxpInverseRes_uid22_divider_b;
                        WHEN "1" => invResPostOneHandling2_uid24_divider_q <= oneInvRes_uid23_divider_q;
                        WHEN OTHERS => invResPostOneHandling2_uid24_divider_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- prodXInvY_uid27_divider_bs6(BITSELECT,194)@37
    prodXInvY_uid27_divider_bs6_b <= STD_LOGIC_VECTOR(invResPostOneHandling2_uid24_divider_q(32 downto 18));

    -- prodXInvY_uid27_divider_bjB7(BITJOIN,195)@37
    prodXInvY_uid27_divider_bjB7_q <= GND_q & prodXInvY_uid27_divider_bs6_b;

    -- prodXInvY_uid27_divider_bs10(BITSELECT,198)@37
    prodXInvY_uid27_divider_bs10_in <= STD_LOGIC_VECTOR(invResPostOneHandling2_uid24_divider_q(17 downto 0));
    prodXInvY_uid27_divider_bs10_b <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_bs10_in(17 downto 0));

    -- prodXInvY_uid27_divider_bjB11(BITJOIN,199)@37
    prodXInvY_uid27_divider_bjB11_q <= GND_q & prodXInvY_uid27_divider_bs10_b;

    -- prodXInvY_uid27_divider_bs8(BITSELECT,196)@37
    prodXInvY_uid27_divider_bs8_b <= STD_LOGIC_VECTOR(redist69_in_rsrvd_fix_numerator_37_q(31 downto 18));

    -- prodXInvY_uid27_divider_bjA9(BITJOIN,197)@37
    prodXInvY_uid27_divider_bjA9_q <= GND_q & prodXInvY_uid27_divider_bs8_b;

    -- prodXInvY_uid27_divider_ma3_cma(CHAINMULTADD,356)@37 + 5
    -- out q@43
    prodXInvY_uid27_divider_ma3_cma_reset <= rst;
    prodXInvY_uid27_divider_ma3_cma_ena0 <= en(0) or prodXInvY_uid27_divider_ma3_cma_reset;
    prodXInvY_uid27_divider_ma3_cma_ena1 <= prodXInvY_uid27_divider_ma3_cma_ena0;
    prodXInvY_uid27_divider_ma3_cma_ena2 <= prodXInvY_uid27_divider_ma3_cma_ena0;
    prodXInvY_uid27_divider_ma3_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    prodXInvY_uid27_divider_ma3_cma_ah(0) <= RESIZE(SIGNED(prodXInvY_uid27_divider_bjA9_q),16);
                    prodXInvY_uid27_divider_ma3_cma_ah(1) <= RESIZE(SIGNED(prodXInvY_uid27_divider_bjB7_q),16);
                    prodXInvY_uid27_divider_ma3_cma_ch(0) <= RESIZE(SIGNED(prodXInvY_uid27_divider_bjB11_q),19);
                    prodXInvY_uid27_divider_ma3_cma_ch(1) <= RESIZE(SIGNED(prodXInvY_uid27_divider_bjA5_q),19);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    prodXInvY_uid27_divider_ma3_cma_a0 <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_ma3_cma_ah(0));
    prodXInvY_uid27_divider_ma3_cma_c0 <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_ma3_cma_ch(0));
    prodXInvY_uid27_divider_ma3_cma_a1 <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_ma3_cma_ah(1));
    prodXInvY_uid27_divider_ma3_cma_c1 <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_ma3_cma_ch(1));
    prodXInvY_uid27_divider_ma3_cma_DSP0 : fourteennm_mac
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
        ax_width => 16,
        bx_width => 16,
        signed_may => "true",
        signed_mby => "true",
        signed_max => "true",
        signed_mbx => "true",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 36
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXInvY_uid27_divider_ma3_cma_ena0,
        ena(1) => prodXInvY_uid27_divider_ma3_cma_ena1,
        ena(2) => prodXInvY_uid27_divider_ma3_cma_ena2,
        clr(0) => prodXInvY_uid27_divider_ma3_cma_reset,
        clr(1) => prodXInvY_uid27_divider_ma3_cma_reset,
        ay => prodXInvY_uid27_divider_ma3_cma_c1,
        by => prodXInvY_uid27_divider_ma3_cma_c0,
        ax => prodXInvY_uid27_divider_ma3_cma_a1,
        bx => prodXInvY_uid27_divider_ma3_cma_a0,
        resulta => prodXInvY_uid27_divider_ma3_cma_s0
    );
    prodXInvY_uid27_divider_ma3_cma_delay : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_ma3_cma_s0, xout => prodXInvY_uid27_divider_ma3_cma_qq, ena => en(0), clk => clk, aclr => rst );
    prodXInvY_uid27_divider_ma3_cma_q <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_ma3_cma_qq(35 downto 0));

    -- redist13_prodXInvY_uid27_divider_ma3_cma_q_1(DELAY,380)
    redist13_prodXInvY_uid27_divider_ma3_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_ma3_cma_q, xout => redist13_prodXInvY_uid27_divider_ma3_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- prodXInvY_uid27_divider_align_16(BITSHIFT,204)@44
    prodXInvY_uid27_divider_align_16_qint <= redist13_prodXInvY_uid27_divider_ma3_cma_q_1_q & "000000000000000000";
    prodXInvY_uid27_divider_align_16_q <= prodXInvY_uid27_divider_align_16_qint(53 downto 0);

    -- prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel0_0(BITSELECT,333)@44
    prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel0_0_b <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_align_16_q(34 downto 0));

    -- prodXInvY_uid27_divider_bs2(BITSELECT,190)@37
    prodXInvY_uid27_divider_bs2_in <= invResPostOneHandling2_uid24_divider_q(17 downto 0);
    prodXInvY_uid27_divider_bs2_b <= prodXInvY_uid27_divider_bs2_in(17 downto 0);

    -- prodXInvY_uid27_divider_bs1(BITSELECT,189)@37
    prodXInvY_uid27_divider_bs1_in <= redist69_in_rsrvd_fix_numerator_37_q(17 downto 0);
    prodXInvY_uid27_divider_bs1_b <= prodXInvY_uid27_divider_bs1_in(17 downto 0);

    -- prodXInvY_uid27_divider_im0_cma(CHAINMULTADD,353)@37 + 5
    -- out q@43
    prodXInvY_uid27_divider_im0_cma_reset <= rst;
    prodXInvY_uid27_divider_im0_cma_ena0 <= en(0) or prodXInvY_uid27_divider_im0_cma_reset;
    prodXInvY_uid27_divider_im0_cma_ena1 <= prodXInvY_uid27_divider_im0_cma_ena0;
    prodXInvY_uid27_divider_im0_cma_ena2 <= prodXInvY_uid27_divider_im0_cma_ena0;
    prodXInvY_uid27_divider_im0_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    prodXInvY_uid27_divider_im0_cma_ah(0) <= RESIZE(UNSIGNED(prodXInvY_uid27_divider_bs1_b),18);
                    prodXInvY_uid27_divider_im0_cma_ch(0) <= RESIZE(UNSIGNED(prodXInvY_uid27_divider_bs2_b),18);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    prodXInvY_uid27_divider_im0_cma_a0 <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_im0_cma_ah(0));
    prodXInvY_uid27_divider_im0_cma_c0 <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_im0_cma_ch(0));
    prodXInvY_uid27_divider_im0_cma_DSP0 : fourteennm_mac
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
        ena(0) => prodXInvY_uid27_divider_im0_cma_ena0,
        ena(1) => prodXInvY_uid27_divider_im0_cma_ena1,
        ena(2) => prodXInvY_uid27_divider_im0_cma_ena2,
        clr(0) => prodXInvY_uid27_divider_im0_cma_reset,
        clr(1) => prodXInvY_uid27_divider_im0_cma_reset,
        ay => prodXInvY_uid27_divider_im0_cma_a0,
        ax => prodXInvY_uid27_divider_im0_cma_c0,
        resulta => prodXInvY_uid27_divider_im0_cma_s0
    );
    prodXInvY_uid27_divider_im0_cma_delay : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_im0_cma_s0, xout => prodXInvY_uid27_divider_im0_cma_qq, ena => en(0), clk => clk, aclr => rst );
    prodXInvY_uid27_divider_im0_cma_q <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_im0_cma_qq(35 downto 0));

    -- redist16_prodXInvY_uid27_divider_im0_cma_q_1(DELAY,383)
    redist16_prodXInvY_uid27_divider_im0_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_im0_cma_q, xout => redist16_prodXInvY_uid27_divider_im0_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select(BITSELECT,366)@44
    prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(redist16_prodXInvY_uid27_divider_im0_cma_q_1_q(34 downto 0));
    prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(redist16_prodXInvY_uid27_divider_im0_cma_q_1_q(35 downto 35));

    -- prodXInvY_uid27_divider_result_add_0_0_p1_of_2(ADD,281)@44 + 1
    prodXInvY_uid27_divider_result_add_0_0_p1_of_2_a <= STD_LOGIC_VECTOR("0" & prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b);
    prodXInvY_uid27_divider_result_add_0_0_p1_of_2_b <= STD_LOGIC_VECTOR("0" & prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel0_0_b);
    prodXInvY_uid27_divider_result_add_0_0_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                prodXInvY_uid27_divider_result_add_0_0_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    prodXInvY_uid27_divider_result_add_0_0_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXInvY_uid27_divider_result_add_0_0_p1_of_2_a) + UNSIGNED(prodXInvY_uid27_divider_result_add_0_0_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    prodXInvY_uid27_divider_result_add_0_0_p1_of_2_c(0) <= prodXInvY_uid27_divider_result_add_0_0_p1_of_2_o(35);
    prodXInvY_uid27_divider_result_add_0_0_p1_of_2_q <= prodXInvY_uid27_divider_result_add_0_0_p1_of_2_o(34 downto 0);

    -- prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_1(BITSELECT,336)@44
    prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_1_b <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_align_16_q(53 downto 53));

    -- redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1(DELAY,385)
    redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_1_b, xout => redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_0(BITSELECT,335)@44
    prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_0_b <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_align_16_q(53 downto 35));

    -- redist31_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_0_b_1(DELAY,398)
    redist31_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_0_b_1 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_0_b, xout => redist31_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_0_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_BitJoin_for_c(BITJOIN,349)@45
    prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q <= redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist18_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist31_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_tessel1_0_b_1_q;

    -- prodXInvY_uid27_divider_bs13(BITSELECT,201)@37
    prodXInvY_uid27_divider_bs13_b <= redist69_in_rsrvd_fix_numerator_37_q(31 downto 18);

    -- redist46_prodXInvY_uid27_divider_bs13_b_1(DELAY,413)
    redist46_prodXInvY_uid27_divider_bs13_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_bs13_b, xout => redist46_prodXInvY_uid27_divider_bs13_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- prodXInvY_uid27_divider_bs14(BITSELECT,202)@37
    prodXInvY_uid27_divider_bs14_b <= invResPostOneHandling2_uid24_divider_q(32 downto 18);

    -- redist45_prodXInvY_uid27_divider_bs14_b_1(DELAY,412)
    redist45_prodXInvY_uid27_divider_bs14_b_1 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_bs14_b, xout => redist45_prodXInvY_uid27_divider_bs14_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- prodXInvY_uid27_divider_im12_cma(CHAINMULTADD,354)@38 + 5
    -- out q@44
    prodXInvY_uid27_divider_im12_cma_reset <= rst;
    prodXInvY_uid27_divider_im12_cma_ena0 <= en(0) or prodXInvY_uid27_divider_im12_cma_reset;
    prodXInvY_uid27_divider_im12_cma_ena1 <= prodXInvY_uid27_divider_im12_cma_ena0;
    prodXInvY_uid27_divider_im12_cma_ena2 <= prodXInvY_uid27_divider_im12_cma_ena0;
    prodXInvY_uid27_divider_im12_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    prodXInvY_uid27_divider_im12_cma_ah(0) <= RESIZE(UNSIGNED(redist45_prodXInvY_uid27_divider_bs14_b_1_q),15);
                    prodXInvY_uid27_divider_im12_cma_ch(0) <= RESIZE(UNSIGNED(redist46_prodXInvY_uid27_divider_bs13_b_1_q),14);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    prodXInvY_uid27_divider_im12_cma_a0 <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_im12_cma_ah(0));
    prodXInvY_uid27_divider_im12_cma_c0 <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_im12_cma_ch(0));
    prodXInvY_uid27_divider_im12_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 15,
        ax_clock => "0",
        ax_width => 14,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 29,
        bx_width => 1,
        by_width => 1,
        result_b_width => 1
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXInvY_uid27_divider_im12_cma_ena0,
        ena(1) => prodXInvY_uid27_divider_im12_cma_ena1,
        ena(2) => prodXInvY_uid27_divider_im12_cma_ena2,
        clr(0) => prodXInvY_uid27_divider_im12_cma_reset,
        clr(1) => prodXInvY_uid27_divider_im12_cma_reset,
        ay => prodXInvY_uid27_divider_im12_cma_a0,
        ax => prodXInvY_uid27_divider_im12_cma_c0,
        resulta => prodXInvY_uid27_divider_im12_cma_s0
    );
    prodXInvY_uid27_divider_im12_cma_delay : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_im12_cma_s0, xout => prodXInvY_uid27_divider_im12_cma_qq, ena => en(0), clk => clk, aclr => rst );
    prodXInvY_uid27_divider_im12_cma_q <= STD_LOGIC_VECTOR(prodXInvY_uid27_divider_im12_cma_qq(28 downto 0));

    -- redist15_prodXInvY_uid27_divider_im12_cma_q_1(DELAY,382)
    redist15_prodXInvY_uid27_divider_im12_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_im12_cma_q, xout => redist15_prodXInvY_uid27_divider_im12_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist0_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1(DELAY,367)
    redist0_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c, xout => redist0_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_BitJoin_for_c(BITJOIN,332)@45
    prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q <= zs_uid63_zCount_uid9_divider_q & redist15_prodXInvY_uid27_divider_im12_cma_q_1_q & redist0_prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q;

    -- prodXInvY_uid27_divider_result_add_0_0_p2_of_2(ADD,282)@45 + 1
    prodXInvY_uid27_divider_result_add_0_0_p2_of_2_cin <= prodXInvY_uid27_divider_result_add_0_0_p1_of_2_c;
    prodXInvY_uid27_divider_result_add_0_0_p2_of_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q) & '1');
    prodXInvY_uid27_divider_result_add_0_0_p2_of_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q(31)) & prodXInvY_uid27_divider_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q) & prodXInvY_uid27_divider_result_add_0_0_p2_of_2_cin(0));
    prodXInvY_uid27_divider_result_add_0_0_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                prodXInvY_uid27_divider_result_add_0_0_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    prodXInvY_uid27_divider_result_add_0_0_p2_of_2_o <= STD_LOGIC_VECTOR(SIGNED(prodXInvY_uid27_divider_result_add_0_0_p2_of_2_a) + SIGNED(prodXInvY_uid27_divider_result_add_0_0_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    prodXInvY_uid27_divider_result_add_0_0_p2_of_2_q <= prodXInvY_uid27_divider_result_add_0_0_p2_of_2_o(32 downto 1);

    -- redist38_prodXInvY_uid27_divider_result_add_0_0_p1_of_2_q_1(DELAY,405)
    redist38_prodXInvY_uid27_divider_result_add_0_0_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid27_divider_result_add_0_0_p1_of_2_q, xout => redist38_prodXInvY_uid27_divider_result_add_0_0_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- prodXInvY_uid27_divider_result_add_0_0_BitJoin_for_q(BITJOIN,283)@46
    prodXInvY_uid27_divider_result_add_0_0_BitJoin_for_q_q <= prodXInvY_uid27_divider_result_add_0_0_p2_of_2_q & redist38_prodXInvY_uid27_divider_result_add_0_0_p1_of_2_q_1_q;

    -- rightShiftStage0_uid220_prodPostRightShift_uid28_divider(MUX,219)@46
    rightShiftStage0_uid220_prodPostRightShift_uid28_divider_s <= rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_b;
    rightShiftStage0_uid220_prodPostRightShift_uid28_divider_combproc: PROCESS (rightShiftStage0_uid220_prodPostRightShift_uid28_divider_s, prodXInvY_uid27_divider_result_add_0_0_BitJoin_for_q_q, rightShiftStage0Idx1_uid212_prodPostRightShift_uid28_divider_q, rightShiftStage0Idx2_uid215_prodPostRightShift_uid28_divider_q, rightShiftStage0Idx3_uid218_prodPostRightShift_uid28_divider_q)
    BEGIN
        CASE (rightShiftStage0_uid220_prodPostRightShift_uid28_divider_s) IS
            WHEN "00" => rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q <= prodXInvY_uid27_divider_result_add_0_0_BitJoin_for_q_q(64 downto 0);
            WHEN "01" => rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q <= rightShiftStage0Idx1_uid212_prodPostRightShift_uid28_divider_q;
            WHEN "10" => rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q <= rightShiftStage0Idx2_uid215_prodPostRightShift_uid28_divider_q;
            WHEN "11" => rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q <= rightShiftStage0Idx3_uid218_prodPostRightShift_uid28_divider_q;
            WHEN OTHERS => rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_notEnable(LOGICAL,475)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_nor(LOGICAL,476)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_nor_q <= not (redist51_r_uid72_zCount_uid9_divider_q_38_split_0_notEnable_q or redist51_r_uid72_zCount_uid9_divider_q_38_split_0_sticky_ena_q);

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_last(CONSTANT,472)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_last_q <= "011110";

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmp(LOGICAL,473)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmp_b <= STD_LOGIC_VECTOR("0" & redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_q);
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmp_q <= "1" WHEN redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_last_q = redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmp_b ELSE "0";

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmpReg(REG,474)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmpReg_q <= STD_LOGIC_VECTOR(redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_sticky_ena(REG,477)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist51_r_uid72_zCount_uid9_divider_q_38_split_0_sticky_ena_q <= "0";
            ELSE
                IF (redist51_r_uid72_zCount_uid9_divider_q_38_split_0_nor_q = "1") THEN
                    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_sticky_ena_q <= STD_LOGIC_VECTOR(redist51_r_uid72_zCount_uid9_divider_q_38_split_0_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_enaAnd(LOGICAL,478)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_enaAnd_q <= redist51_r_uid72_zCount_uid9_divider_q_38_split_0_sticky_ena_q and en;

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt(COUNTER,469)
    -- low=0, high=31, step=1, init=0
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_i <= TO_UNSIGNED(0, 5);
            ELSE
                IF (en = "1") THEN
                    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_i <= redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_i, 5)));

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux(MUX,470)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_s <= en;
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_combproc: PROCESS (redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_s, redist51_r_uid72_zCount_uid9_divider_q_38_split_0_wraddr_q, redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_q)
    BEGIN
        CASE (redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_s) IS
            WHEN "0" => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_q <= redist51_r_uid72_zCount_uid9_divider_q_38_split_0_wraddr_q;
            WHEN "1" => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_q <= redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdcnt_q;
            WHEN OTHERS => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_wraddr(REG,471)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist51_r_uid72_zCount_uid9_divider_q_38_split_0_wraddr_q <= "11111";
            ELSE
                redist51_r_uid72_zCount_uid9_divider_q_38_split_0_wraddr_q <= STD_LOGIC_VECTOR(redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem(DUALMEM,468)
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_ia <= STD_LOGIC_VECTOR(r_uid72_zCount_uid9_divider_q);
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_aa <= redist51_r_uid72_zCount_uid9_divider_q_38_split_0_wraddr_q;
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_ab <= redist51_r_uid72_zCount_uid9_divider_q_38_split_0_rdmux_q;
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_reset0 <= rst;
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 6,
        widthad_a => 5,
        numwords_a => 32,
        width_b => 6,
        widthad_b => 5,
        numwords_b => 32,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken1 => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_reset0,
        clock1 => clk,
        address_a => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_aa,
        data_a => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_ia,
        wren_a => en(0),
        address_b => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_ab,
        q_b => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_iq
    );
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_q <= redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_iq(5 downto 0);
    redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_enaOr_rst <= redist51_r_uid72_zCount_uid9_divider_q_38_split_0_enaAnd_q(0) or redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_reset0;

    -- redist51_r_uid72_zCount_uid9_divider_q_38(DELAY,418)
    redist51_r_uid72_zCount_uid9_divider_q_38 : dspba_delay
    GENERIC MAP ( width => 6, depth => 5, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist51_r_uid72_zCount_uid9_divider_q_38_split_0_mem_q, xout => redist51_r_uid72_zCount_uid9_divider_q_38_q, ena => en(0), clk => clk, aclr => rst );

    -- cWOut_uid25_divider(CONSTANT,24)
    cWOut_uid25_divider_q <= "11111";

    -- rShiftCount_uid26_divider(SUB,25)@45 + 1
    rShiftCount_uid26_divider_a <= STD_LOGIC_VECTOR("00" & cWOut_uid25_divider_q);
    rShiftCount_uid26_divider_b <= STD_LOGIC_VECTOR("0" & redist51_r_uid72_zCount_uid9_divider_q_38_q);
    rShiftCount_uid26_divider_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                rShiftCount_uid26_divider_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    rShiftCount_uid26_divider_o <= STD_LOGIC_VECTOR(UNSIGNED(rShiftCount_uid26_divider_a) - UNSIGNED(rShiftCount_uid26_divider_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    rShiftCount_uid26_divider_q <= rShiftCount_uid26_divider_o(6 downto 0);

    -- rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select(BITSELECT,358)@46
    rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_b <= rShiftCount_uid26_divider_q(1 downto 0);
    rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_c <= rShiftCount_uid26_divider_q(3 downto 2);
    rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_d <= rShiftCount_uid26_divider_q(5 downto 4);
    rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_e <= rShiftCount_uid26_divider_q(6 downto 6);

    -- rightShiftStage1_uid231_prodPostRightShift_uid28_divider(MUX,230)@46 + 1
    rightShiftStage1_uid231_prodPostRightShift_uid28_divider_s <= rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_c;
    rightShiftStage1_uid231_prodPostRightShift_uid28_divider_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (rightShiftStage1_uid231_prodPostRightShift_uid28_divider_s) IS
                        WHEN "00" => rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q <= rightShiftStage0_uid220_prodPostRightShift_uid28_divider_q;
                        WHEN "01" => rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q <= rightShiftStage1Idx1_uid223_prodPostRightShift_uid28_divider_q;
                        WHEN "10" => rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q <= rightShiftStage1Idx2_uid226_prodPostRightShift_uid28_divider_q;
                        WHEN "11" => rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q <= rightShiftStage1Idx3_uid229_prodPostRightShift_uid28_divider_q;
                        WHEN OTHERS => rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist11_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_d_1(DELAY,378)
    redist11_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_d_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_d, xout => redist11_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_d_1_q, ena => en(0), clk => clk, aclr => rst );

    -- rightShiftStage2_uid242_prodPostRightShift_uid28_divider(MUX,241)@47
    rightShiftStage2_uid242_prodPostRightShift_uid28_divider_s <= redist11_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_d_1_q;
    rightShiftStage2_uid242_prodPostRightShift_uid28_divider_combproc: PROCESS (rightShiftStage2_uid242_prodPostRightShift_uid28_divider_s, rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q, rightShiftStage2Idx1_uid234_prodPostRightShift_uid28_divider_q, rightShiftStage2Idx2_uid237_prodPostRightShift_uid28_divider_q, rightShiftStage2Idx3_uid240_prodPostRightShift_uid28_divider_q)
    BEGIN
        CASE (rightShiftStage2_uid242_prodPostRightShift_uid28_divider_s) IS
            WHEN "00" => rightShiftStage2_uid242_prodPostRightShift_uid28_divider_q <= rightShiftStage1_uid231_prodPostRightShift_uid28_divider_q;
            WHEN "01" => rightShiftStage2_uid242_prodPostRightShift_uid28_divider_q <= rightShiftStage2Idx1_uid234_prodPostRightShift_uid28_divider_q;
            WHEN "10" => rightShiftStage2_uid242_prodPostRightShift_uid28_divider_q <= rightShiftStage2Idx2_uid237_prodPostRightShift_uid28_divider_q;
            WHEN "11" => rightShiftStage2_uid242_prodPostRightShift_uid28_divider_q <= rightShiftStage2Idx3_uid240_prodPostRightShift_uid28_divider_q;
            WHEN OTHERS => rightShiftStage2_uid242_prodPostRightShift_uid28_divider_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist12_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_e_1(DELAY,379)
    redist12_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_e_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_e, xout => redist12_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_e_1_q, ena => en(0), clk => clk, aclr => rst );

    -- rightShiftStage3_uid247_prodPostRightShift_uid28_divider(MUX,246)@47
    rightShiftStage3_uid247_prodPostRightShift_uid28_divider_s <= redist12_rightShiftStageSel0Dto0_uid219_prodPostRightShift_uid28_divider_merged_bit_select_e_1_q;
    rightShiftStage3_uid247_prodPostRightShift_uid28_divider_combproc: PROCESS (rightShiftStage3_uid247_prodPostRightShift_uid28_divider_s, rightShiftStage2_uid242_prodPostRightShift_uid28_divider_q, rightShiftStage3Idx1_uid245_prodPostRightShift_uid28_divider_q)
    BEGIN
        CASE (rightShiftStage3_uid247_prodPostRightShift_uid28_divider_s) IS
            WHEN "0" => rightShiftStage3_uid247_prodPostRightShift_uid28_divider_q <= rightShiftStage2_uid242_prodPostRightShift_uid28_divider_q;
            WHEN "1" => rightShiftStage3_uid247_prodPostRightShift_uid28_divider_q <= rightShiftStage3Idx1_uid245_prodPostRightShift_uid28_divider_q;
            WHEN OTHERS => rightShiftStage3_uid247_prodPostRightShift_uid28_divider_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- prodPostRightShiftPost_uid29_divider(BITSELECT,28)@47
    prodPostRightShiftPost_uid29_divider_in <= rightShiftStage3_uid247_prodPostRightShift_uid28_divider_q(63 downto 0);
    prodPostRightShiftPost_uid29_divider_b <= prodPostRightShiftPost_uid29_divider_in(63 downto 31);

    -- redist57_prodPostRightShiftPost_uid29_divider_b_1(DELAY,424)
    redist57_prodPostRightShiftPost_uid29_divider_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodPostRightShiftPost_uid29_divider_b, xout => redist57_prodPostRightShiftPost_uid29_divider_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- allOnes_uid30_divider(LOGICAL,29)@48 + 1
    allOnes_uid30_divider_qi <= "1" WHEN redist57_prodPostRightShiftPost_uid29_divider_b_1_q = "111111111111111111111111111111111" ELSE "0";
    allOnes_uid30_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => allOnes_uid30_divider_qi, xout => allOnes_uid30_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- invAllOnes_uid32_divider(LOGICAL,31)@49
    invAllOnes_uid32_divider_q <= not (allOnes_uid30_divider_q);

    -- addOp2_uid33_divider(LOGICAL,32)@49
    addOp2_uid33_divider_q <= invAllOnes_uid32_divider_q and VCC_q;

    -- redist58_prodPostRightShiftPost_uid29_divider_b_2(DELAY,425)
    redist58_prodPostRightShiftPost_uid29_divider_b_2 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist57_prodPostRightShiftPost_uid29_divider_b_1_q, xout => redist58_prodPostRightShiftPost_uid29_divider_b_2_q, ena => en(0), clk => clk, aclr => rst );

    -- prodPostRightShiftPostRnd_uid34_divider(ADD,33)@49
    prodPostRightShiftPostRnd_uid34_divider_a <= STD_LOGIC_VECTOR("0" & redist58_prodPostRightShiftPost_uid29_divider_b_2_q);
    prodPostRightShiftPostRnd_uid34_divider_b <= STD_LOGIC_VECTOR("000000000000000000000000000000000" & addOp2_uid33_divider_q);
    prodPostRightShiftPostRnd_uid34_divider_o <= STD_LOGIC_VECTOR(UNSIGNED(prodPostRightShiftPostRnd_uid34_divider_a) + UNSIGNED(prodPostRightShiftPostRnd_uid34_divider_b));
    prodPostRightShiftPostRnd_uid34_divider_q <= prodPostRightShiftPostRnd_uid34_divider_o(33 downto 0);

    -- prodPostRightShiftPostRndRange_uid35_divider(BITSELECT,34)@49
    prodPostRightShiftPostRndRange_uid35_divider_in <= prodPostRightShiftPostRnd_uid34_divider_q(32 downto 0);
    prodPostRightShiftPostRndRange_uid35_divider_b <= prodPostRightShiftPostRndRange_uid35_divider_in(32 downto 1);

    -- redist56_prodPostRightShiftPostRndRange_uid35_divider_b_1(DELAY,423)
    redist56_prodPostRightShiftPostRndRange_uid35_divider_b_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodPostRightShiftPostRndRange_uid35_divider_b, xout => redist56_prodPostRightShiftPostRndRange_uid35_divider_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- yIsZero_uid17_divider(LOGICAL,16)@7 + 1
    yIsZero_uid17_divider_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000" & GND_q);
    yIsZero_uid17_divider_qi <= "1" WHEN redist71_in_rsrvd_fix_denominator_7_outputreg1_q = yIsZero_uid17_divider_b ELSE "0";
    yIsZero_uid17_divider_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => yIsZero_uid17_divider_qi, xout => yIsZero_uid17_divider_q, ena => en(0), clk => clk, aclr => rst );

    -- redist65_yIsZero_uid17_divider_q_43(DELAY,432)
    redist65_yIsZero_uid17_divider_q_43 : dspba_delay
    GENERIC MAP ( width => 1, depth => 42, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => yIsZero_uid17_divider_q, xout => redist65_yIsZero_uid17_divider_q_43_q, ena => en(0), clk => clk, aclr => rst );

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- resFinal_uid37_divider(MUX,36)@50
    resFinal_uid37_divider_s <= redist65_yIsZero_uid17_divider_q_43_q;
    resFinal_uid37_divider_combproc: PROCESS (resFinal_uid37_divider_s, redist56_prodPostRightShiftPostRndRange_uid35_divider_b_1_q, cstValOvf_uid36_divider_q)
    BEGIN
        CASE (resFinal_uid37_divider_s) IS
            WHEN "0" => resFinal_uid37_divider_q <= redist56_prodPostRightShiftPostRndRange_uid35_divider_b_1_q;
            WHEN "1" => resFinal_uid37_divider_q <= cstValOvf_uid36_divider_q;
            WHEN OTHERS => resFinal_uid37_divider_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_rsrvd_fix(GPOUT,5)@50
    result <= resFinal_uid37_divider_q;

END normal;
