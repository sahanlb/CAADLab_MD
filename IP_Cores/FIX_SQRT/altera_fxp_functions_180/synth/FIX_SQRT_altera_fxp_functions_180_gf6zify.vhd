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

-- VHDL created from FIX_SQRT_altera_fxp_functions_180_gf6zify
-- VHDL created on Thu Mar 28 19:12:08 2019


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

entity FIX_SQRT_altera_fxp_functions_180_gf6zify is
    port (
        radical : in std_logic_vector(31 downto 0);  -- ufix32
        en : in std_logic_vector(0 downto 0);  -- ufix1
        result : out std_logic_vector(31 downto 0);  -- ufix32
        clk : in std_logic;
        rst : in std_logic
    );
end FIX_SQRT_altera_fxp_functions_180_gf6zify;

architecture normal of FIX_SQRT_altera_fxp_functions_180_gf6zify is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftConstant_uid8_sqrt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal inExponent_uid9_sqrt_a : STD_LOGIC_VECTOR (6 downto 0);
    signal inExponent_uid9_sqrt_b : STD_LOGIC_VECTOR (6 downto 0);
    signal inExponent_uid9_sqrt_o : STD_LOGIC_VECTOR (6 downto 0);
    signal inExponent_uid9_sqrt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal parityOddOriginal_uid12_sqrt_in : STD_LOGIC_VECTOR (0 downto 0);
    signal parityOddOriginal_uid12_sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal parityOddOriginalInv_uid13_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal outExponentOdd_uid17_sqrt_a : STD_LOGIC_VECTOR (8 downto 0);
    signal outExponentOdd_uid17_sqrt_b : STD_LOGIC_VECTOR (8 downto 0);
    signal outExponentOdd_uid17_sqrt_o : STD_LOGIC_VECTOR (8 downto 0);
    signal outExponentOdd_uid17_sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal outExponentOdd_uid18_sqrt_in : STD_LOGIC_VECTOR (6 downto 0);
    signal outExponentOdd_uid18_sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal outExponentEven_uid19_sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal outputExponent_uid20_sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal outputExponent_uid20_sqrt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftOutVal_uid22_sqrt_a : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftOutVal_uid22_sqrt_b : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftOutVal_uid22_sqrt_o : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftOutVal_uid22_sqrt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal x0_uid25_sqrt_in : STD_LOGIC_VECTOR (30 downto 0);
    signal x0_uid25_sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal x1_uid26_sqrt_in : STD_LOGIC_VECTOR (24 downto 0);
    signal x1_uid26_sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal x2_uid27_sqrt_in : STD_LOGIC_VECTOR (18 downto 0);
    signal x2_uid27_sqrt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal a0Addr_uid28_sqrt_q : STD_LOGIC_VECTOR (11 downto 0);
    signal x2_msb_uid29_sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal x2_xored_uid30_sqrt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal x2_xored_uid30_sqrt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal x2_xoredNoMsb_uid31_sqrt_in : STD_LOGIC_VECTOR (3 downto 0);
    signal x2_xoredNoMsb_uid31_sqrt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal a1Addr_uid32_sqrt_q : STD_LOGIC_VECTOR (9 downto 0);
    signal os_uid35_sqrt_q : STD_LOGIC_VECTOR (19 downto 0);
    signal a1TableOutSxt_uid40_sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal a1TableOut_xored_uid41_sqrt_b : STD_LOGIC_VECTOR (7 downto 0);
    signal a1TableOut_xored_uid41_sqrt_qi : STD_LOGIC_VECTOR (7 downto 0);
    signal a1TableOut_xored_uid41_sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal initApproxFull_uid43_sqrt_a : STD_LOGIC_VECTOR (22 downto 0);
    signal initApproxFull_uid43_sqrt_b : STD_LOGIC_VECTOR (22 downto 0);
    signal initApproxFull_uid43_sqrt_o : STD_LOGIC_VECTOR (22 downto 0);
    signal initApproxFull_uid43_sqrt_q : STD_LOGIC_VECTOR (21 downto 0);
    signal initApprox_uid44_sqrt_in : STD_LOGIC_VECTOR (19 downto 0);
    signal initApprox_uid44_sqrt_b : STD_LOGIC_VECTOR (19 downto 0);
    signal initApproxSquared_uid46_sqrt_in : STD_LOGIC_VECTOR (38 downto 0);
    signal initApproxSquared_uid46_sqrt_b : STD_LOGIC_VECTOR (38 downto 0);
    signal oneAndHalf_uid50_sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal padACst_uid51_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal oneAndHalfSubXMIAS_uid54_sqrt_in : STD_LOGIC_VECTOR (34 downto 0);
    signal oneAndHalfSubXMIAS_uid54_sqrt_b : STD_LOGIC_VECTOR (34 downto 0);
    signal resultPreMultX_uid56_sqrt_in : STD_LOGIC_VECTOR (53 downto 0);
    signal resultPreMultX_uid56_sqrt_b : STD_LOGIC_VECTOR (33 downto 0);
    signal result_uid58_sqrt_in : STD_LOGIC_VECTOR (64 downto 0);
    signal result_uid58_sqrt_b : STD_LOGIC_VECTOR (33 downto 0);
    signal finalMultLSBRange_uid60_sqrt_b : STD_LOGIC_VECTOR (32 downto 0);
    signal invNegShiftEven_uid61_sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal negShiftEven_uid62_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal negShiftOdd_uid63_sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal negShiftOdd_uid64_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal EvenBranchAndNegUpdate_uid66_sqrt_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal EvenBranchAndNegUpdate_uid66_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal OddBranchAndNegUpdate_uid67_sqrt_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal OddBranchAndNegUpdate_uid67_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftUpdateValue_uid68_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal negShiftEvenParityOdd_uid69_sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal finalMultBottomBits_uid70_sqrt_in : STD_LOGIC_VECTOR (32 downto 0);
    signal finalMultBottomBits_uid70_sqrt_b : STD_LOGIC_VECTOR (32 downto 0);
    signal resultBottomBits_uid71_sqrt_in : STD_LOGIC_VECTOR (32 downto 0);
    signal resultBottomBits_uid71_sqrt_b : STD_LOGIC_VECTOR (32 downto 0);
    signal resultUpperRange_uid73_sqrt_b : STD_LOGIC_VECTOR (32 downto 0);
    signal shifterInData_uid74_sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal shifterInData_uid74_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal shiftOutValUpdated_uid75_sqrt_a : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftOutValUpdated_uid75_sqrt_b : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftOutValUpdated_uid75_sqrt_o : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftOutValUpdated_uid75_sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal sat_uid76_sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal resultFinalPostRnd_uid82_sqrt_a : STD_LOGIC_VECTOR (33 downto 0);
    signal resultFinalPostRnd_uid82_sqrt_b : STD_LOGIC_VECTOR (33 downto 0);
    signal resultFinalPostRnd_uid82_sqrt_i : STD_LOGIC_VECTOR (33 downto 0);
    signal resultFinalPostRnd_uid82_sqrt_a1 : STD_LOGIC_VECTOR (33 downto 0);
    signal resultFinalPostRnd_uid82_sqrt_b1 : STD_LOGIC_VECTOR (33 downto 0);
    signal resultFinalPostRnd_uid82_sqrt_o : STD_LOGIC_VECTOR (33 downto 0);
    signal resultFinalPostRnd_uid82_sqrt_q : STD_LOGIC_VECTOR (33 downto 0);
    signal satOrOvfPostRnd_uid85_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal resultFinalPostOvf_uid86_sqrt_b : STD_LOGIC_VECTOR (31 downto 0);
    signal resultFinalPostOvf_uid86_sqrt_qi : STD_LOGIC_VECTOR (31 downto 0);
    signal resultFinalPostOvf_uid86_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal cstW_uid87_sqrt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal inputAllZeros_uid88_sqrt_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal inputAllZeros_uid88_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal inputNotAllZeros_uid89_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal resultFinal_uid90_sqrt_b : STD_LOGIC_VECTOR (31 downto 0);
    signal resultFinal_uid90_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid92_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vCount_uid94_leadingZeros_uid7_sqrt_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid94_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid95_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vStagei_uid97_leadingZeros_uid7_sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid98_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid100_leadingZeros_uid7_sqrt_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid100_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_leadingZeros_uid7_sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (15 downto 0);
    signal zs_uid104_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vCount_uid106_leadingZeros_uid7_sqrt_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid106_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid109_leadingZeros_uid7_sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid109_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid110_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid112_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid115_leadingZeros_uid7_sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid115_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid116_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid118_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid121_leadingZeros_uid7_sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid121_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid123_leadingZeros_uid7_sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid124_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid125_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal xv0_uid127_finalMult_uid59_sqrt_in : STD_LOGIC_VECTOR (5 downto 0);
    signal xv0_uid127_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv1_uid128_finalMult_uid59_sqrt_in : STD_LOGIC_VECTOR (11 downto 0);
    signal xv1_uid128_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv2_uid129_finalMult_uid59_sqrt_in : STD_LOGIC_VECTOR (17 downto 0);
    signal xv2_uid129_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv3_uid130_finalMult_uid59_sqrt_in : STD_LOGIC_VECTOR (23 downto 0);
    signal xv3_uid130_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv4_uid131_finalMult_uid59_sqrt_in : STD_LOGIC_VECTOR (29 downto 0);
    signal xv4_uid131_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv5_uid132_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal p5_uid133_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (37 downto 0);
    signal p4_uid134_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (33 downto 0);
    signal p3_uid135_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (27 downto 0);
    signal p2_uid136_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (21 downto 0);
    signal p1_uid137_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (15 downto 0);
    signal p0_uid138_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (9 downto 0);
    signal lev1_a1_uid143_finalMult_uid59_sqrt_a : STD_LOGIC_VECTOR (28 downto 0);
    signal lev1_a1_uid143_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (28 downto 0);
    signal lev1_a1_uid143_finalMult_uid59_sqrt_o : STD_LOGIC_VECTOR (28 downto 0);
    signal lev1_a1_uid143_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (28 downto 0);
    signal lev1_a2_uid144_finalMult_uid59_sqrt_a : STD_LOGIC_VECTOR (16 downto 0);
    signal lev1_a2_uid144_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (16 downto 0);
    signal lev1_a2_uid144_finalMult_uid59_sqrt_o : STD_LOGIC_VECTOR (16 downto 0);
    signal lev1_a2_uid144_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (16 downto 0);
    signal maxValInOutFormat_uid147_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (33 downto 0);
    signal minValueInFormat_uid148_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (33 downto 0);
    signal ovfudfcond_uid155_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal sR_uid156_finalMult_uid59_sqrt_in : STD_LOGIC_VECTOR (37 downto 0);
    signal sR_uid156_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (33 downto 0);
    signal sRA0_uid157_finalMult_uid59_sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal sRA0_uid157_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (33 downto 0);
    signal leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_in : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx1_uid191_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStageSel0Dto4_uid194_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid195_xLeftShift_uid23_sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_in : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx1_uid198_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_in : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2_uid201_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (11 downto 0);
    signal leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_in : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage1Idx3_uid204_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_in : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid206_xLeftShift_uid23_sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_in : STD_LOGIC_VECTOR (30 downto 0);
    signal leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (30 downto 0);
    signal leftShiftStage2Idx1_uid209_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_in : STD_LOGIC_VECTOR (29 downto 0);
    signal leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (29 downto 0);
    signal leftShiftStage2Idx2_uid212_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage2Idx3Pad3_uid213_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_in : STD_LOGIC_VECTOR (28 downto 0);
    signal leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (28 downto 0);
    signal leftShiftStage2Idx3_uid215_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt_in : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage2_uid217_xLeftShift_uid23_sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal a1Table_uid37_sqrt_lutmem_reset0 : std_logic;
    signal a1Table_uid37_sqrt_lutmem_ia : STD_LOGIC_VECTOR (6 downto 0);
    signal a1Table_uid37_sqrt_lutmem_aa : STD_LOGIC_VECTOR (9 downto 0);
    signal a1Table_uid37_sqrt_lutmem_ab : STD_LOGIC_VECTOR (9 downto 0);
    signal a1Table_uid37_sqrt_lutmem_ir : STD_LOGIC_VECTOR (6 downto 0);
    signal a1Table_uid37_sqrt_lutmem_r : STD_LOGIC_VECTOR (6 downto 0);
    signal a1Table_uid37_sqrt_lutmem_enaOr_rst : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs1_in : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs1_b : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs2_in : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs2_b : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs4_b : STD_LOGIC_VECTOR (13 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs5_b : STD_LOGIC_VECTOR (2 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs8_in : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs8_b : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs12_b : STD_LOGIC_VECTOR (13 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q : STD_LOGIC_VECTOR (14 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs14_in : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs14_b : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bjB15_q : STD_LOGIC_VECTOR (18 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs16_in : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs16_b : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q : STD_LOGIC_VECTOR (18 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bs18_b : STD_LOGIC_VECTOR (2 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_bjB19_q : STD_LOGIC_VECTOR (3 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_align_21_q : STD_LOGIC_VECTOR (54 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_align_21_qint : STD_LOGIC_VECTOR (54 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_align_23_q : STD_LOGIC_VECTOR (70 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_align_23_qint : STD_LOGIC_VECTOR (70 downto 0);
    signal resultFull_uid55_sqrt_align_7_q : STD_LOGIC_VECTOR (54 downto 0);
    signal resultFull_uid55_sqrt_align_7_qint : STD_LOGIC_VECTOR (54 downto 0);
    signal resultMultFull_uid57_sqrt_bs1_in : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_bs1_b : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_bs4_b : STD_LOGIC_VECTOR (15 downto 0);
    signal resultMultFull_uid57_sqrt_bjA5_q : STD_LOGIC_VECTOR (16 downto 0);
    signal resultMultFull_uid57_sqrt_bs8_in : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_bs8_b : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_bjA9_q : STD_LOGIC_VECTOR (18 downto 0);
    signal resultMultFull_uid57_sqrt_bs13_b : STD_LOGIC_VECTOR (15 downto 0);
    signal resultMultFull_uid57_sqrt_align_16_q : STD_LOGIC_VECTOR (54 downto 0);
    signal resultMultFull_uid57_sqrt_align_16_qint : STD_LOGIC_VECTOR (54 downto 0);
    signal wIntCst_uid280_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_a : STD_LOGIC_VECTOR (9 downto 0);
    signal shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (9 downto 0);
    signal shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_o : STD_LOGIC_VECTOR (9 downto 0);
    signal shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng1_uid282_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage0Idx1_uid284_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage0Idx2Rng2_uid285_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (30 downto 0);
    signal rightShiftStage0Idx2_uid287_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage0Idx3Rng3_uid288_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (29 downto 0);
    signal rightShiftStage0Idx3_uid290_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_in : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage1Idx1Rng4_uid293_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (28 downto 0);
    signal rightShiftStage1Idx1_uid295_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage1Idx2Rng8_uid296_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStage1Idx2_uid298_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage1Idx3Rng12_uid299_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (20 downto 0);
    signal rightShiftStage1Idx3_uid301_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_in : STD_LOGIC_VECTOR (3 downto 0);
    signal rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage2Idx1Rng16_uid304_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (16 downto 0);
    signal rightShiftStage2Idx1_uid306_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage2Idx2Rng32_uid307_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage2Idx2_uid309_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_in : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal a0Table_uid33_sqrt_lutmem_csA0_h : STD_LOGIC_VECTOR (0 downto 0);
    signal a0Table_uid33_sqrt_lutmem_csA1_h : STD_LOGIC_VECTOR (0 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part0_reset0 : std_logic;
    signal a0Table_uid33_sqrt_lutmem_part0_ia : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part0_aa : STD_LOGIC_VECTOR (10 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part0_ab : STD_LOGIC_VECTOR (10 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part0_ir : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part0_r : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part0_enaOr_rst : std_logic;
    signal a0Table_uid33_sqrt_lutmem_part1_reset0 : std_logic;
    signal a0Table_uid33_sqrt_lutmem_part1_ia : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part1_aa : STD_LOGIC_VECTOR (10 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part1_ab : STD_LOGIC_VECTOR (10 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part1_ir : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part1_r : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid33_sqrt_lutmem_part1_enaOr_rst : std_logic;
    signal a0Table_uid33_sqrt_lutmem_qA_l0_or0_qi : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid33_sqrt_lutmem_qA_l0_or0_q : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid34_sqrt_lutmem_csA0_h : STD_LOGIC_VECTOR (0 downto 0);
    signal a0Table_uid34_sqrt_lutmem_csA1_h : STD_LOGIC_VECTOR (0 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part0_reset0 : std_logic;
    signal a0Table_uid34_sqrt_lutmem_part0_ia : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part0_aa : STD_LOGIC_VECTOR (10 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part0_ab : STD_LOGIC_VECTOR (10 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part0_ir : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part0_r : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part0_enaOr_rst : std_logic;
    signal a0Table_uid34_sqrt_lutmem_part1_reset0 : std_logic;
    signal a0Table_uid34_sqrt_lutmem_part1_ia : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part1_aa : STD_LOGIC_VECTOR (10 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part1_ab : STD_LOGIC_VECTOR (10 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part1_ir : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part1_r : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid34_sqrt_lutmem_part1_enaOr_rst : std_logic;
    signal a0Table_uid34_sqrt_lutmem_qA_l0_or0_qi : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid34_sqrt_lutmem_qA_l0_or0_q : STD_LOGIC_VECTOR (9 downto 0);
    signal a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0_q : signal is true;
    signal a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1_q : signal is true;
    signal a0Table_uid33_sqrt_lutmem_addrA_lofan_reg0_q : STD_LOGIC_VECTOR (10 downto 0);
    attribute preserve_syn_only of a0Table_uid33_sqrt_lutmem_addrA_lofan_reg0_q : signal is true;
    signal a0Table_uid33_sqrt_lutmem_addrA_lofan_reg1_q : STD_LOGIC_VECTOR (10 downto 0);
    attribute preserve_syn_only of a0Table_uid33_sqrt_lutmem_addrA_lofan_reg1_q : signal is true;
    signal a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0_q : signal is true;
    signal a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1_q : signal is true;
    signal a0Table_uid34_sqrt_lutmem_addrA_lofan_reg0_q : STD_LOGIC_VECTOR (10 downto 0);
    attribute preserve_syn_only of a0Table_uid34_sqrt_lutmem_addrA_lofan_reg0_q : signal is true;
    signal a0Table_uid34_sqrt_lutmem_addrA_lofan_reg1_q : STD_LOGIC_VECTOR (10 downto 0);
    attribute preserve_syn_only of a0Table_uid34_sqrt_lutmem_addrA_lofan_reg1_q : signal is true;
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_a : STD_LOGIC_VECTOR (2 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_b : STD_LOGIC_VECTOR (2 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_o : STD_LOGIC_VECTOR (2 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_BitJoin_for_q_q : STD_LOGIC_VECTOR (35 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_UpperBits_for_b_q : STD_LOGIC_VECTOR (5 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_a : STD_LOGIC_VECTOR (5 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_b : STD_LOGIC_VECTOR (5 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_o : STD_LOGIC_VECTOR (5 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_q : STD_LOGIC_VECTOR (3 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_a : STD_LOGIC_VECTOR (7 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_b : STD_LOGIC_VECTOR (7 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_o : STD_LOGIC_VECTOR (7 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_q : STD_LOGIC_VECTOR (5 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_UpperBits_for_b_q : STD_LOGIC_VECTOR (24 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_a : STD_LOGIC_VECTOR (8 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_b : STD_LOGIC_VECTOR (8 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_o : STD_LOGIC_VECTOR (8 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_q : STD_LOGIC_VECTOR (6 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_BitJoin_for_q_q : STD_LOGIC_VECTOR (41 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_UpperBits_for_a_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_p2_of_2_a : STD_LOGIC_VECTOR (9 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_p2_of_2_b : STD_LOGIC_VECTOR (9 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_p2_of_2_o : STD_LOGIC_VECTOR (9 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_p2_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_p2_of_2_a : STD_LOGIC_VECTOR (9 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_p2_of_2_b : STD_LOGIC_VECTOR (9 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_p2_of_2_o : STD_LOGIC_VECTOR (9 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_p2_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_UpperBits_for_b_q : STD_LOGIC_VECTOR (16 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_c : STD_LOGIC_VECTOR (0 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_q : STD_LOGIC_VECTOR (34 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_a : STD_LOGIC_VECTOR (36 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_b : STD_LOGIC_VECTOR (36 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_o : STD_LOGIC_VECTOR (36 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_q : STD_LOGIC_VECTOR (34 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_c : STD_LOGIC_VECTOR (0 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_a : STD_LOGIC_VECTOR (36 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_b : STD_LOGIC_VECTOR (36 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_o : STD_LOGIC_VECTOR (36 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_q : STD_LOGIC_VECTOR (34 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_UpperBits_for_a_q : STD_LOGIC_VECTOR (8 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p2_of_2_a : STD_LOGIC_VECTOR (22 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p2_of_2_b : STD_LOGIC_VECTOR (22 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p2_of_2_o : STD_LOGIC_VECTOR (22 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_p2_of_2_q : STD_LOGIC_VECTOR (20 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_BitJoin_for_q_q : STD_LOGIC_VECTOR (55 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_a : STD_LOGIC_VECTOR (35 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_b : STD_LOGIC_VECTOR (35 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_o : STD_LOGIC_VECTOR (35 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_q : STD_LOGIC_VECTOR (34 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_a : STD_LOGIC_VECTOR (34 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_b : STD_LOGIC_VECTOR (34 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_o : STD_LOGIC_VECTOR (34 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_q : STD_LOGIC_VECTOR (32 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_BitJoin_for_q_q : STD_LOGIC_VECTOR (67 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_a_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_0_b : STD_LOGIC_VECTOR (33 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (3 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (5 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (6 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (7 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (7 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q : STD_LOGIC_VECTOR (34 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (7 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel1_1_b : STD_LOGIC_VECTOR (33 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (34 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel1_1_b : STD_LOGIC_VECTOR (14 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (34 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (20 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (20 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q : STD_LOGIC_VECTOR (32 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_b : STD_LOGIC_VECTOR (34 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_0_b : STD_LOGIC_VECTOR (19 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_1_b : STD_LOGIC_VECTOR (0 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (32 downto 0);
    signal initApproxSquaredFull_uid45_sqrt_cma_reset : std_logic;
    type initApproxSquaredFull_uid45_sqrt_cma_ahtype is array(NATURAL range <>) of UNSIGNED(19 downto 0);
    signal initApproxSquaredFull_uid45_sqrt_cma_ah : initApproxSquaredFull_uid45_sqrt_cma_ahtype(0 to 0);
    attribute preserve_syn_only of initApproxSquaredFull_uid45_sqrt_cma_ah : signal is true;
    signal initApproxSquaredFull_uid45_sqrt_cma_ch : initApproxSquaredFull_uid45_sqrt_cma_ahtype(0 to 0);
    attribute preserve_syn_only of initApproxSquaredFull_uid45_sqrt_cma_ch : signal is true;
    signal initApproxSquaredFull_uid45_sqrt_cma_a0 : STD_LOGIC_VECTOR (19 downto 0);
    signal initApproxSquaredFull_uid45_sqrt_cma_c0 : STD_LOGIC_VECTOR (19 downto 0);
    signal initApproxSquaredFull_uid45_sqrt_cma_s0 : STD_LOGIC_VECTOR (39 downto 0);
    signal initApproxSquaredFull_uid45_sqrt_cma_qq : STD_LOGIC_VECTOR (39 downto 0);
    signal initApproxSquaredFull_uid45_sqrt_cma_q : STD_LOGIC_VECTOR (39 downto 0);
    signal initApproxSquaredFull_uid45_sqrt_cma_ena0 : std_logic;
    signal initApproxSquaredFull_uid45_sqrt_cma_ena1 : std_logic;
    signal initApproxSquaredFull_uid45_sqrt_cma_ena2 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_reset : std_logic;
    type xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ahtype is array(NATURAL range <>) of UNSIGNED(17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ah : xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ah : signal is true;
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ch : xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ch : signal is true;
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_qq : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena0 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena1 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena2 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_reset : std_logic;
    type xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ahtype is array(NATURAL range <>) of UNSIGNED(13 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ah : xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ahtype(0 to 0);
    attribute preserve_syn_only of xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ah : signal is true;
    type xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_chtype is array(NATURAL range <>) of UNSIGNED(2 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ch : xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_chtype(0 to 0);
    attribute preserve_syn_only of xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ch : signal is true;
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_c0 : STD_LOGIC_VECTOR (2 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_s0 : STD_LOGIC_VECTOR (16 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_qq : STD_LOGIC_VECTOR (16 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q : STD_LOGIC_VECTOR (16 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena0 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena1 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena2 : std_logic;
    signal resultFull_uid55_sqrt_im0_cma_reset : std_logic;
    type resultFull_uid55_sqrt_im0_cma_ahtype is array(NATURAL range <>) of UNSIGNED(26 downto 0);
    signal resultFull_uid55_sqrt_im0_cma_ah : resultFull_uid55_sqrt_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of resultFull_uid55_sqrt_im0_cma_ah : signal is true;
    signal resultFull_uid55_sqrt_im0_cma_ch : initApproxSquaredFull_uid45_sqrt_cma_ahtype(0 to 0);
    attribute preserve_syn_only of resultFull_uid55_sqrt_im0_cma_ch : signal is true;
    signal resultFull_uid55_sqrt_im0_cma_a0 : STD_LOGIC_VECTOR (26 downto 0);
    signal resultFull_uid55_sqrt_im0_cma_c0 : STD_LOGIC_VECTOR (19 downto 0);
    signal resultFull_uid55_sqrt_im0_cma_s0 : STD_LOGIC_VECTOR (46 downto 0);
    signal resultFull_uid55_sqrt_im0_cma_qq : STD_LOGIC_VECTOR (46 downto 0);
    signal resultFull_uid55_sqrt_im0_cma_q : STD_LOGIC_VECTOR (46 downto 0);
    signal resultFull_uid55_sqrt_im0_cma_ena0 : std_logic;
    signal resultFull_uid55_sqrt_im0_cma_ena1 : std_logic;
    signal resultFull_uid55_sqrt_im0_cma_ena2 : std_logic;
    signal resultFull_uid55_sqrt_im3_cma_reset : std_logic;
    signal resultFull_uid55_sqrt_im3_cma_ah : initApproxSquaredFull_uid45_sqrt_cma_ahtype(0 to 0);
    attribute preserve_syn_only of resultFull_uid55_sqrt_im3_cma_ah : signal is true;
    type resultFull_uid55_sqrt_im3_cma_chtype is array(NATURAL range <>) of UNSIGNED(7 downto 0);
    signal resultFull_uid55_sqrt_im3_cma_ch : resultFull_uid55_sqrt_im3_cma_chtype(0 to 0);
    attribute preserve_syn_only of resultFull_uid55_sqrt_im3_cma_ch : signal is true;
    signal resultFull_uid55_sqrt_im3_cma_a0 : STD_LOGIC_VECTOR (19 downto 0);
    signal resultFull_uid55_sqrt_im3_cma_c0 : STD_LOGIC_VECTOR (7 downto 0);
    signal resultFull_uid55_sqrt_im3_cma_s0 : STD_LOGIC_VECTOR (27 downto 0);
    signal resultFull_uid55_sqrt_im3_cma_qq : STD_LOGIC_VECTOR (27 downto 0);
    signal resultFull_uid55_sqrt_im3_cma_q : STD_LOGIC_VECTOR (27 downto 0);
    signal resultFull_uid55_sqrt_im3_cma_ena0 : std_logic;
    signal resultFull_uid55_sqrt_im3_cma_ena1 : std_logic;
    signal resultFull_uid55_sqrt_im3_cma_ena2 : std_logic;
    signal resultMultFull_uid57_sqrt_im0_cma_reset : std_logic;
    signal resultMultFull_uid57_sqrt_im0_cma_ah : xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of resultMultFull_uid57_sqrt_im0_cma_ah : signal is true;
    signal resultMultFull_uid57_sqrt_im0_cma_ch : xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of resultMultFull_uid57_sqrt_im0_cma_ch : signal is true;
    signal resultMultFull_uid57_sqrt_im0_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_im0_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal resultMultFull_uid57_sqrt_im0_cma_qq : STD_LOGIC_VECTOR (35 downto 0);
    signal resultMultFull_uid57_sqrt_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal resultMultFull_uid57_sqrt_im0_cma_ena0 : std_logic;
    signal resultMultFull_uid57_sqrt_im0_cma_ena1 : std_logic;
    signal resultMultFull_uid57_sqrt_im0_cma_ena2 : std_logic;
    signal resultMultFull_uid57_sqrt_im12_cma_reset : std_logic;
    type resultMultFull_uid57_sqrt_im12_cma_ahtype is array(NATURAL range <>) of UNSIGNED(15 downto 0);
    signal resultMultFull_uid57_sqrt_im12_cma_ah : resultMultFull_uid57_sqrt_im12_cma_ahtype(0 to 0);
    attribute preserve_syn_only of resultMultFull_uid57_sqrt_im12_cma_ah : signal is true;
    signal resultMultFull_uid57_sqrt_im12_cma_ch : xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ahtype(0 to 0);
    attribute preserve_syn_only of resultMultFull_uid57_sqrt_im12_cma_ch : signal is true;
    signal resultMultFull_uid57_sqrt_im12_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal resultMultFull_uid57_sqrt_im12_cma_c0 : STD_LOGIC_VECTOR (13 downto 0);
    signal resultMultFull_uid57_sqrt_im12_cma_s0 : STD_LOGIC_VECTOR (29 downto 0);
    signal resultMultFull_uid57_sqrt_im12_cma_qq : STD_LOGIC_VECTOR (29 downto 0);
    signal resultMultFull_uid57_sqrt_im12_cma_q : STD_LOGIC_VECTOR (29 downto 0);
    signal resultMultFull_uid57_sqrt_im12_cma_ena0 : std_logic;
    signal resultMultFull_uid57_sqrt_im12_cma_ena1 : std_logic;
    signal resultMultFull_uid57_sqrt_im12_cma_ena2 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_reset : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ah : xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ahtype(0 to 1);
    attribute preserve_syn_only of xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ah : signal is true;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ch : xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ahtype(0 to 1);
    attribute preserve_syn_only of xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ch : signal is true;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_a1 : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_c1 : STD_LOGIC_VECTOR (17 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_s0 : STD_LOGIC_VECTOR (36 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_qq : STD_LOGIC_VECTOR (36 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q : STD_LOGIC_VECTOR (36 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena0 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena1 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena2 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_reset : std_logic;
    type xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ahtype is array(NATURAL range <>) of SIGNED(14 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ah : xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ahtype(0 to 1);
    attribute preserve_syn_only of xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ah : signal is true;
    type xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_chtype is array(NATURAL range <>) of SIGNED(18 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ch : xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_chtype(0 to 1);
    attribute preserve_syn_only of xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ch : signal is true;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_a0 : STD_LOGIC_VECTOR (14 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_c0 : STD_LOGIC_VECTOR (18 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_a1 : STD_LOGIC_VECTOR (14 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_c1 : STD_LOGIC_VECTOR (18 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_s0 : STD_LOGIC_VECTOR (34 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_qq : STD_LOGIC_VECTOR (34 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_q : STD_LOGIC_VECTOR (34 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena0 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena1 : std_logic;
    signal xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena2 : std_logic;
    signal resultMultFull_uid57_sqrt_ma3_cma_reset : std_logic;
    type resultMultFull_uid57_sqrt_ma3_cma_ahtype is array(NATURAL range <>) of SIGNED(16 downto 0);
    signal resultMultFull_uid57_sqrt_ma3_cma_ah : resultMultFull_uid57_sqrt_ma3_cma_ahtype(0 to 1);
    attribute preserve_syn_only of resultMultFull_uid57_sqrt_ma3_cma_ah : signal is true;
    signal resultMultFull_uid57_sqrt_ma3_cma_ch : xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_chtype(0 to 1);
    attribute preserve_syn_only of resultMultFull_uid57_sqrt_ma3_cma_ch : signal is true;
    signal resultMultFull_uid57_sqrt_ma3_cma_a0 : STD_LOGIC_VECTOR (16 downto 0);
    signal resultMultFull_uid57_sqrt_ma3_cma_c0 : STD_LOGIC_VECTOR (18 downto 0);
    signal resultMultFull_uid57_sqrt_ma3_cma_a1 : STD_LOGIC_VECTOR (16 downto 0);
    signal resultMultFull_uid57_sqrt_ma3_cma_c1 : STD_LOGIC_VECTOR (18 downto 0);
    signal resultMultFull_uid57_sqrt_ma3_cma_s0 : STD_LOGIC_VECTOR (36 downto 0);
    signal resultMultFull_uid57_sqrt_ma3_cma_qq : STD_LOGIC_VECTOR (36 downto 0);
    signal resultMultFull_uid57_sqrt_ma3_cma_q : STD_LOGIC_VECTOR (36 downto 0);
    signal resultMultFull_uid57_sqrt_ma3_cma_ena0 : std_logic;
    signal resultMultFull_uid57_sqrt_ma3_cma_ena1 : std_logic;
    signal resultMultFull_uid57_sqrt_ma3_cma_ena2 : std_logic;
    signal a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_c : STD_LOGIC_VECTOR (10 downto 0);
    signal resultFull_uid55_sqrt_bs2_merged_bit_select_b : STD_LOGIC_VECTOR (26 downto 0);
    signal resultFull_uid55_sqrt_bs2_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal resultFinalPreSat_uid83_sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (31 downto 0);
    signal resultFinalPreSat_uid83_sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (2 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (32 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_b : STD_LOGIC_VECTOR (30 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c : STD_LOGIC_VECTOR (2 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b : STD_LOGIC_VECTOR (30 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c : STD_LOGIC_VECTOR (2 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (19 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_in : STD_LOGIC_VECTOR (69 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (34 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (19 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_b : STD_LOGIC_VECTOR (33 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c : STD_LOGIC_VECTOR (6 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (11 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist2_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist6_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist7_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist9_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist10_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist11_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist12_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_resultFinalPreSat_uid83_sqrt_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist14_resultFinalPreSat_uid83_sqrt_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_resultMultFull_uid57_sqrt_ma3_cma_q_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist16_xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist17_resultMultFull_uid57_sqrt_im12_cma_q_1_q : STD_LOGIC_VECTOR (29 downto 0);
    signal redist18_resultMultFull_uid57_sqrt_im0_cma_q_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal redist19_resultFull_uid55_sqrt_im3_cma_q_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist20_resultFull_uid55_sqrt_im0_cma_q_1_q : STD_LOGIC_VECTOR (46 downto 0);
    signal redist21_xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q_1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal redist22_xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_0_b_1_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist37_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel1_1_b_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist38_resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_q_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist39_resultFull_uid55_sqrt_result_add_0_0_p1_of_2_q_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist40_lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist41_oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_q_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist42_rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist43_shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist44_resultMultFull_uid57_sqrt_bs13_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist45_xMulInitApproxSquaredFull_uid47_sqrt_bs18_b_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist47_xMulInitApproxSquaredFull_uid47_sqrt_bs16_b_1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist48_xMulInitApproxSquaredFull_uid47_sqrt_bs14_b_1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist50_xMulInitApproxSquaredFull_uid47_sqrt_bs12_b_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist51_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist52_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist55_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_sR_uid156_finalMult_uid59_sqrt_b_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist58_r_uid125_leadingZeros_uid7_sqrt_q_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist59_r_uid125_leadingZeros_uid7_sqrt_q_2_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist61_vCount_uid112_leadingZeros_uid7_sqrt_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_vCount_uid106_leadingZeros_uid7_sqrt_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_vCount_uid100_leadingZeros_uid7_sqrt_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_vCount_uid94_leadingZeros_uid7_sqrt_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_inputAllZeros_uid88_sqrt_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist66_sat_uid76_sqrt_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist67_shifterInData_uid74_sqrt_q_2_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist68_finalMultBottomBits_uid70_sqrt_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist69_shiftUpdateValue_uid68_sqrt_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_finalMultLSBRange_uid60_sqrt_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist71_result_uid58_sqrt_b_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist73_result_uid58_sqrt_b_7_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist74_initApprox_uid44_sqrt_b_1_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist76_x2_msb_uid29_sqrt_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist77_x0_uid25_sqrt_b_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist78_outExponentEven_uid19_sqrt_b_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist79_outExponentOdd_uid18_sqrt_b_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist80_parityOddOriginalInv_uid13_sqrt_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist81_parityOddOriginal_uid12_sqrt_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist82_in_rsrvd_fix_radical_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg2_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg0_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg0_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_reset0 : std_logic;
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_ia : STD_LOGIC_VECTOR (18 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_iq : STD_LOGIC_VECTOR (18 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_enaOr_rst : std_logic;
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_i : signal is true;
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_eq : signal is true;
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_sticky_ena_q : signal is true;
    signal redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg1_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg2_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg0_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg1_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg0_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_reset0 : std_logic;
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_ia : STD_LOGIC_VECTOR (14 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_iq : STD_LOGIC_VECTOR (14 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_enaOr_rst : std_logic;
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_i : signal is true;
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_eq : signal is true;
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_sticky_ena_q : signal is true;
    signal redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_reset0 : std_logic;
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_iq : STD_LOGIC_VECTOR (13 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_enaOr_rst : std_logic;
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_i : signal is true;
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_eq : signal is true;
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_sticky_ena_q : signal is true;
    signal redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg2_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg2_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_reset0 : std_logic;
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_ia : STD_LOGIC_VECTOR (17 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_iq : STD_LOGIC_VECTOR (17 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_enaOr_rst : std_logic;
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_i : signal is true;
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_eq : signal is true;
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_sticky_ena_q : signal is true;
    signal redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_reset0 : std_logic;
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_enaOr_rst : std_logic;
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_i : signal is true;
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_sticky_ena_q : signal is true;
    signal redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg2_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg0_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_reset0 : std_logic;
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_ia : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_iq : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_enaOr_rst : std_logic;
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_i : signal is true;
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_sticky_ena_q : signal is true;
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_result_uid58_sqrt_b_6_mem_reset0 : std_logic;
    signal redist72_result_uid58_sqrt_b_6_mem_ia : STD_LOGIC_VECTOR (33 downto 0);
    signal redist72_result_uid58_sqrt_b_6_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist72_result_uid58_sqrt_b_6_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist72_result_uid58_sqrt_b_6_mem_iq : STD_LOGIC_VECTOR (33 downto 0);
    signal redist72_result_uid58_sqrt_b_6_mem_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist72_result_uid58_sqrt_b_6_mem_enaOr_rst : std_logic;
    signal redist72_result_uid58_sqrt_b_6_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist72_result_uid58_sqrt_b_6_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of redist72_result_uid58_sqrt_b_6_rdcnt_i : signal is true;
    signal redist72_result_uid58_sqrt_b_6_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_result_uid58_sqrt_b_6_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist72_result_uid58_sqrt_b_6_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist72_result_uid58_sqrt_b_6_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist72_result_uid58_sqrt_b_6_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist72_result_uid58_sqrt_b_6_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_result_uid58_sqrt_b_6_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_result_uid58_sqrt_b_6_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_result_uid58_sqrt_b_6_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_result_uid58_sqrt_b_6_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist72_result_uid58_sqrt_b_6_sticky_ena_q : signal is true;
    signal redist72_result_uid58_sqrt_b_6_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_inputreg1_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_outputreg2_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_inputreg0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_outputreg1_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_outputreg0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_mem_reset0 : std_logic;
    signal redist75_initApprox_uid44_sqrt_b_19_mem_ia : STD_LOGIC_VECTOR (19 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_mem_iq : STD_LOGIC_VECTOR (19 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_mem_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_mem_enaOr_rst : std_logic;
    signal redist75_initApprox_uid44_sqrt_b_19_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist75_initApprox_uid44_sqrt_b_19_rdcnt_i : signal is true;
    signal redist75_initApprox_uid44_sqrt_b_19_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist75_initApprox_uid44_sqrt_b_19_rdcnt_eq : signal is true;
    signal redist75_initApprox_uid44_sqrt_b_19_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_initApprox_uid44_sqrt_b_19_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist75_initApprox_uid44_sqrt_b_19_sticky_ena_q : signal is true;
    signal redist75_initApprox_uid44_sqrt_b_19_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_outputreg2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_outputreg1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_mem_reset0 : std_logic;
    signal redist83_in_rsrvd_fix_radical_8_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_mem_enaOr_rst : std_logic;
    signal redist83_in_rsrvd_fix_radical_8_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of redist83_in_rsrvd_fix_radical_8_rdcnt_i : signal is true;
    signal redist83_in_rsrvd_fix_radical_8_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist83_in_rsrvd_fix_radical_8_rdcnt_eq : signal is true;
    signal redist83_in_rsrvd_fix_radical_8_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_mem_last_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist83_in_rsrvd_fix_radical_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist83_in_rsrvd_fix_radical_8_sticky_ena_q : signal is true;
    signal redist83_in_rsrvd_fix_radical_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg2_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg0_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_reset0 : std_logic;
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_ia : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_iq : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_enaOr_rst : std_logic;
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_i : signal is true;
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_eq : signal is true;
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_sticky_ena_q : signal is true;
    signal redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- cstW_uid87_sqrt(CONSTANT,86)
    cstW_uid87_sqrt_q <= "100000";

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_notEnable(LOGICAL,772)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_nor(LOGICAL,773)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_nor_q <= not (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_notEnable_q or redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_sticky_ena_q);

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_last(CONSTANT,769)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_last_q <= "0110";

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmp(LOGICAL,770)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmp_b <= STD_LOGIC_VECTOR("0" & redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_q);
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmp_q <= "1" WHEN redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_last_q = redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmp_b ELSE "0";

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmpReg(REG,771)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmpReg_q <= STD_LOGIC_VECTOR(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_sticky_ena(REG,774)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_sticky_ena_q <= "0";
            ELSE
                IF (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_nor_q = "1") THEN
                    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_sticky_ena_q <= STD_LOGIC_VECTOR(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_enaAnd(LOGICAL,775)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_enaAnd_q <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_sticky_ena_q and en;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt(COUNTER,766)
    -- low=0, high=7, step=1, init=0
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_i <= TO_UNSIGNED(0, 3);
            ELSE
                IF (en = "1") THEN
                    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_i <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_i, 3)));

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux(MUX,767)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_s <= en;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_combproc: PROCESS (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_s, redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_wraddr_q, redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_q)
    BEGIN
        CASE (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_s) IS
            WHEN "0" => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_q <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_wraddr_q;
            WHEN "1" => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_q <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdcnt_q;
            WHEN OTHERS => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_nor(LOGICAL,828)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_nor_q <= not (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_notEnable_q or redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_sticky_ena_q);

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_last(CONSTANT,824)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_last_q <= "011011";

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmp(LOGICAL,825)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmp_b <= STD_LOGIC_VECTOR("0" & redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_q);
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmp_q <= "1" WHEN redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_last_q = redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmp_b ELSE "0";

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmpReg(REG,826)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmpReg_q <= STD_LOGIC_VECTOR(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_sticky_ena(REG,829)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_sticky_ena_q <= "0";
            ELSE
                IF (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_nor_q = "1") THEN
                    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_sticky_ena_q <= STD_LOGIC_VECTOR(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_enaAnd(LOGICAL,830)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_enaAnd_q <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_sticky_ena_q and en;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt(COUNTER,821)
    -- low=0, high=28, step=1, init=0
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_i = TO_UNSIGNED(27, 5)) THEN
                        redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_eq <= '1';
                    ELSE
                        redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_eq <= '0';
                    END IF;
                    IF (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_eq = '1') THEN
                        redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_i <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_i + 4;
                    ELSE
                        redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_i <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_i, 5)));

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux(MUX,822)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_s <= en;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_combproc: PROCESS (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_s, redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_wraddr_q, redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_q)
    BEGIN
        CASE (redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_s) IS
            WHEN "0" => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_q <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_wraddr_q;
            WHEN "1" => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_q <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdcnt_q;
            WHEN OTHERS => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- zs_uid92_leadingZeros_uid7_sqrt(CONSTANT,91)
    zs_uid92_leadingZeros_uid7_sqrt_q <= "00000000000000000000000000000000";

    -- vCount_uid94_leadingZeros_uid7_sqrt(LOGICAL,93)@0 + 1
    vCount_uid94_leadingZeros_uid7_sqrt_qi <= "1" WHEN radical = zs_uid92_leadingZeros_uid7_sqrt_q ELSE "0";
    vCount_uid94_leadingZeros_uid7_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid94_leadingZeros_uid7_sqrt_qi, xout => vCount_uid94_leadingZeros_uid7_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- redist64_vCount_uid94_leadingZeros_uid7_sqrt_q_7(DELAY,660)
    redist64_vCount_uid94_leadingZeros_uid7_sqrt_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid94_leadingZeros_uid7_sqrt_q, xout => redist64_vCount_uid94_leadingZeros_uid7_sqrt_q_7_q, ena => en(0), clk => clk, aclr => rst );

    -- zs_uid98_leadingZeros_uid7_sqrt(CONSTANT,97)
    zs_uid98_leadingZeros_uid7_sqrt_q <= "0000000000000000";

    -- mO_uid95_leadingZeros_uid7_sqrt(CONSTANT,94)
    mO_uid95_leadingZeros_uid7_sqrt_q <= "11111111111111111111111111111111";

    -- redist82_in_rsrvd_fix_radical_1(DELAY,678)
    redist82_in_rsrvd_fix_radical_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => radical, xout => redist82_in_rsrvd_fix_radical_1_q, ena => en(0), clk => clk, aclr => rst );

    -- vStagei_uid97_leadingZeros_uid7_sqrt(MUX,96)@1 + 1
    vStagei_uid97_leadingZeros_uid7_sqrt_s <= vCount_uid94_leadingZeros_uid7_sqrt_q;
    vStagei_uid97_leadingZeros_uid7_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                vStagei_uid97_leadingZeros_uid7_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (vStagei_uid97_leadingZeros_uid7_sqrt_s) IS
                        WHEN "0" => vStagei_uid97_leadingZeros_uid7_sqrt_q <= redist82_in_rsrvd_fix_radical_1_q;
                        WHEN "1" => vStagei_uid97_leadingZeros_uid7_sqrt_q <= mO_uid95_leadingZeros_uid7_sqrt_q;
                        WHEN OTHERS => vStagei_uid97_leadingZeros_uid7_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select(BITSELECT,577)@2
    rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b <= vStagei_uid97_leadingZeros_uid7_sqrt_q(31 downto 16);
    rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c <= vStagei_uid97_leadingZeros_uid7_sqrt_q(15 downto 0);

    -- vCount_uid100_leadingZeros_uid7_sqrt(LOGICAL,99)@2 + 1
    vCount_uid100_leadingZeros_uid7_sqrt_qi <= "1" WHEN rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b = zs_uid98_leadingZeros_uid7_sqrt_q ELSE "0";
    vCount_uid100_leadingZeros_uid7_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid100_leadingZeros_uid7_sqrt_qi, xout => vCount_uid100_leadingZeros_uid7_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- redist63_vCount_uid100_leadingZeros_uid7_sqrt_q_5(DELAY,659)
    redist63_vCount_uid100_leadingZeros_uid7_sqrt_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid100_leadingZeros_uid7_sqrt_q, xout => redist63_vCount_uid100_leadingZeros_uid7_sqrt_q_5_q, ena => en(0), clk => clk, aclr => rst );

    -- zs_uid104_leadingZeros_uid7_sqrt(CONSTANT,103)
    zs_uid104_leadingZeros_uid7_sqrt_q <= "00000000";

    -- redist12_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c_1(DELAY,608)
    redist12_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c, xout => redist12_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist11_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b_1(DELAY,607)
    redist11_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b, xout => redist11_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- vStagei_uid103_leadingZeros_uid7_sqrt(MUX,102)@3 + 1
    vStagei_uid103_leadingZeros_uid7_sqrt_s <= vCount_uid100_leadingZeros_uid7_sqrt_q;
    vStagei_uid103_leadingZeros_uid7_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                vStagei_uid103_leadingZeros_uid7_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (vStagei_uid103_leadingZeros_uid7_sqrt_s) IS
                        WHEN "0" => vStagei_uid103_leadingZeros_uid7_sqrt_q <= redist11_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b_1_q;
                        WHEN "1" => vStagei_uid103_leadingZeros_uid7_sqrt_q <= redist12_rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c_1_q;
                        WHEN OTHERS => vStagei_uid103_leadingZeros_uid7_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select(BITSELECT,578)@4
    rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b <= vStagei_uid103_leadingZeros_uid7_sqrt_q(15 downto 8);
    rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c <= vStagei_uid103_leadingZeros_uid7_sqrt_q(7 downto 0);

    -- vCount_uid106_leadingZeros_uid7_sqrt(LOGICAL,105)@4 + 1
    vCount_uid106_leadingZeros_uid7_sqrt_qi <= "1" WHEN rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b = zs_uid104_leadingZeros_uid7_sqrt_q ELSE "0";
    vCount_uid106_leadingZeros_uid7_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid106_leadingZeros_uid7_sqrt_qi, xout => vCount_uid106_leadingZeros_uid7_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- redist62_vCount_uid106_leadingZeros_uid7_sqrt_q_3(DELAY,658)
    redist62_vCount_uid106_leadingZeros_uid7_sqrt_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid106_leadingZeros_uid7_sqrt_q, xout => redist62_vCount_uid106_leadingZeros_uid7_sqrt_q_3_q, ena => en(0), clk => clk, aclr => rst );

    -- zs_uid110_leadingZeros_uid7_sqrt(CONSTANT,109)
    zs_uid110_leadingZeros_uid7_sqrt_q <= "0000";

    -- redist10_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c_1(DELAY,606)
    redist10_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c, xout => redist10_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist9_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b_1(DELAY,605)
    redist9_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b, xout => redist9_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- vStagei_uid109_leadingZeros_uid7_sqrt(MUX,108)@5 + 1
    vStagei_uid109_leadingZeros_uid7_sqrt_s <= vCount_uid106_leadingZeros_uid7_sqrt_q;
    vStagei_uid109_leadingZeros_uid7_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                vStagei_uid109_leadingZeros_uid7_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (vStagei_uid109_leadingZeros_uid7_sqrt_s) IS
                        WHEN "0" => vStagei_uid109_leadingZeros_uid7_sqrt_q <= redist9_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b_1_q;
                        WHEN "1" => vStagei_uid109_leadingZeros_uid7_sqrt_q <= redist10_rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c_1_q;
                        WHEN OTHERS => vStagei_uid109_leadingZeros_uid7_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select(BITSELECT,579)@6
    rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_b <= vStagei_uid109_leadingZeros_uid7_sqrt_q(7 downto 4);
    rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_c <= vStagei_uid109_leadingZeros_uid7_sqrt_q(3 downto 0);

    -- vCount_uid112_leadingZeros_uid7_sqrt(LOGICAL,111)@6
    vCount_uid112_leadingZeros_uid7_sqrt_q <= "1" WHEN rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_b = zs_uid110_leadingZeros_uid7_sqrt_q ELSE "0";

    -- redist61_vCount_uid112_leadingZeros_uid7_sqrt_q_1(DELAY,657)
    redist61_vCount_uid112_leadingZeros_uid7_sqrt_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid112_leadingZeros_uid7_sqrt_q, xout => redist61_vCount_uid112_leadingZeros_uid7_sqrt_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- zs_uid116_leadingZeros_uid7_sqrt(CONSTANT,115)
    zs_uid116_leadingZeros_uid7_sqrt_q <= "00";

    -- vStagei_uid115_leadingZeros_uid7_sqrt(MUX,114)@6 + 1
    vStagei_uid115_leadingZeros_uid7_sqrt_s <= vCount_uid112_leadingZeros_uid7_sqrt_q;
    vStagei_uid115_leadingZeros_uid7_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                vStagei_uid115_leadingZeros_uid7_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (vStagei_uid115_leadingZeros_uid7_sqrt_s) IS
                        WHEN "0" => vStagei_uid115_leadingZeros_uid7_sqrt_q <= rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_b;
                        WHEN "1" => vStagei_uid115_leadingZeros_uid7_sqrt_q <= rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_c;
                        WHEN OTHERS => vStagei_uid115_leadingZeros_uid7_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select(BITSELECT,580)@7
    rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_b <= vStagei_uid115_leadingZeros_uid7_sqrt_q(3 downto 2);
    rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_c <= vStagei_uid115_leadingZeros_uid7_sqrt_q(1 downto 0);

    -- vCount_uid118_leadingZeros_uid7_sqrt(LOGICAL,117)@7
    vCount_uid118_leadingZeros_uid7_sqrt_q <= "1" WHEN rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_b = zs_uid116_leadingZeros_uid7_sqrt_q ELSE "0";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- vStagei_uid121_leadingZeros_uid7_sqrt(MUX,120)@7
    vStagei_uid121_leadingZeros_uid7_sqrt_s <= vCount_uid118_leadingZeros_uid7_sqrt_q;
    vStagei_uid121_leadingZeros_uid7_sqrt_combproc: PROCESS (vStagei_uid121_leadingZeros_uid7_sqrt_s, rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_b, rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid121_leadingZeros_uid7_sqrt_s) IS
            WHEN "0" => vStagei_uid121_leadingZeros_uid7_sqrt_q <= rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_b;
            WHEN "1" => vStagei_uid121_leadingZeros_uid7_sqrt_q <= rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid121_leadingZeros_uid7_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid123_leadingZeros_uid7_sqrt(BITSELECT,122)@7
    rVStage_uid123_leadingZeros_uid7_sqrt_b <= vStagei_uid121_leadingZeros_uid7_sqrt_q(1 downto 1);

    -- vCount_uid124_leadingZeros_uid7_sqrt(LOGICAL,123)@7
    vCount_uid124_leadingZeros_uid7_sqrt_q <= "1" WHEN rVStage_uid123_leadingZeros_uid7_sqrt_b = GND_q ELSE "0";

    -- r_uid125_leadingZeros_uid7_sqrt(BITJOIN,124)@7
    r_uid125_leadingZeros_uid7_sqrt_q <= redist64_vCount_uid94_leadingZeros_uid7_sqrt_q_7_q & redist63_vCount_uid100_leadingZeros_uid7_sqrt_q_5_q & redist62_vCount_uid106_leadingZeros_uid7_sqrt_q_3_q & redist61_vCount_uid112_leadingZeros_uid7_sqrt_q_1_q & vCount_uid118_leadingZeros_uid7_sqrt_q & vCount_uid124_leadingZeros_uid7_sqrt_q;

    -- redist58_r_uid125_leadingZeros_uid7_sqrt_q_1(DELAY,654)
    redist58_r_uid125_leadingZeros_uid7_sqrt_q_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => r_uid125_leadingZeros_uid7_sqrt_q, xout => redist58_r_uid125_leadingZeros_uid7_sqrt_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist59_r_uid125_leadingZeros_uid7_sqrt_q_2(DELAY,655)
    redist59_r_uid125_leadingZeros_uid7_sqrt_q_2 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist58_r_uid125_leadingZeros_uid7_sqrt_q_1_q, xout => redist59_r_uid125_leadingZeros_uid7_sqrt_q_2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_wraddr(REG,823)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_wraddr_q <= "11100";
            ELSE
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_wraddr_q <= STD_LOGIC_VECTOR(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem(DUALMEM,820)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_ia <= STD_LOGIC_VECTOR(redist59_r_uid125_leadingZeros_uid7_sqrt_q_2_q);
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_aa <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_wraddr_q;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_ab <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_rdmux_q;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_reset0 <= rst;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 6,
        widthad_a => 5,
        numwords_a => 29,
        width_b => 6,
        widthad_b => 5,
        numwords_b => 29,
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
        clocken1 => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_reset0,
        clock1 => clk,
        address_a => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_aa,
        data_a => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_ia,
        wren_a => en(0),
        address_b => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_ab,
        q_b => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_iq
    );
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_q <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_iq(5 downto 0);
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_enaOr_rst <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_enaAnd_q(0) or redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_reset0;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg0(DELAY,819)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg0 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_mem_q, xout => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg1(DELAY,818)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg0_q, xout => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg2(DELAY,817)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg2 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg1_q, xout => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg2(DELAY,762)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg2 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_split_0_outputreg2_q, xout => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg1(DELAY,763)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg2_q, xout => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg0(DELAY,764)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg0 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg1_q, xout => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_wraddr(REG,768)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_wraddr_q <= "111";
            ELSE
                redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_wraddr_q <= STD_LOGIC_VECTOR(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem(DUALMEM,765)
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_ia <= STD_LOGIC_VECTOR(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_inputreg0_q);
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_aa <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_wraddr_q;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_ab <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_rdmux_q;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_reset0 <= rst;
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 6,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 6,
        widthad_b => 3,
        numwords_b => 8,
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
        clocken1 => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_reset0,
        clock1 => clk,
        address_a => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_aa,
        data_a => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_ia,
        wren_a => en(0),
        address_b => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_ab,
        q_b => redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_iq
    );
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_q <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_iq(5 downto 0);
    redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_enaOr_rst <= redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_enaAnd_q(0) or redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_reset0;

    -- inputAllZeros_uid88_sqrt(LOGICAL,87)@54 + 1
    inputAllZeros_uid88_sqrt_qi <= "1" WHEN redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_q = cstW_uid87_sqrt_q ELSE "0";
    inputAllZeros_uid88_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => inputAllZeros_uid88_sqrt_qi, xout => inputAllZeros_uid88_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- redist65_inputAllZeros_uid88_sqrt_q_9(DELAY,661)
    redist65_inputAllZeros_uid88_sqrt_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => inputAllZeros_uid88_sqrt_q, xout => redist65_inputAllZeros_uid88_sqrt_q_9_q, ena => en(0), clk => clk, aclr => rst );

    -- inputNotAllZeros_uid89_sqrt(LOGICAL,88)@63
    inputNotAllZeros_uid89_sqrt_q <= not (redist65_inputAllZeros_uid88_sqrt_q_9_q);

    -- wIntCst_uid280_xRightShiftFinal_uid78_sqrt(CONSTANT,279)
    wIntCst_uid280_xRightShiftFinal_uid78_sqrt_q <= "100001";

    -- redist72_result_uid58_sqrt_b_6_notEnable(LOGICAL,783)
    redist72_result_uid58_sqrt_b_6_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist72_result_uid58_sqrt_b_6_nor(LOGICAL,784)
    redist72_result_uid58_sqrt_b_6_nor_q <= not (redist72_result_uid58_sqrt_b_6_notEnable_q or redist72_result_uid58_sqrt_b_6_sticky_ena_q);

    -- redist72_result_uid58_sqrt_b_6_mem_last(CONSTANT,780)
    redist72_result_uid58_sqrt_b_6_mem_last_q <= "010";

    -- redist72_result_uid58_sqrt_b_6_cmp(LOGICAL,781)
    redist72_result_uid58_sqrt_b_6_cmp_b <= STD_LOGIC_VECTOR("0" & redist72_result_uid58_sqrt_b_6_rdmux_q);
    redist72_result_uid58_sqrt_b_6_cmp_q <= "1" WHEN redist72_result_uid58_sqrt_b_6_mem_last_q = redist72_result_uid58_sqrt_b_6_cmp_b ELSE "0";

    -- redist72_result_uid58_sqrt_b_6_cmpReg(REG,782)
    redist72_result_uid58_sqrt_b_6_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist72_result_uid58_sqrt_b_6_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist72_result_uid58_sqrt_b_6_cmpReg_q <= STD_LOGIC_VECTOR(redist72_result_uid58_sqrt_b_6_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist72_result_uid58_sqrt_b_6_sticky_ena(REG,785)
    redist72_result_uid58_sqrt_b_6_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist72_result_uid58_sqrt_b_6_sticky_ena_q <= "0";
            ELSE
                IF (redist72_result_uid58_sqrt_b_6_nor_q = "1") THEN
                    redist72_result_uid58_sqrt_b_6_sticky_ena_q <= STD_LOGIC_VECTOR(redist72_result_uid58_sqrt_b_6_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist72_result_uid58_sqrt_b_6_enaAnd(LOGICAL,786)
    redist72_result_uid58_sqrt_b_6_enaAnd_q <= redist72_result_uid58_sqrt_b_6_sticky_ena_q and en;

    -- redist72_result_uid58_sqrt_b_6_rdcnt(COUNTER,777)
    -- low=0, high=3, step=1, init=0
    redist72_result_uid58_sqrt_b_6_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist72_result_uid58_sqrt_b_6_rdcnt_i <= TO_UNSIGNED(0, 2);
            ELSE
                IF (en = "1") THEN
                    redist72_result_uid58_sqrt_b_6_rdcnt_i <= redist72_result_uid58_sqrt_b_6_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist72_result_uid58_sqrt_b_6_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist72_result_uid58_sqrt_b_6_rdcnt_i, 2)));

    -- redist72_result_uid58_sqrt_b_6_rdmux(MUX,778)
    redist72_result_uid58_sqrt_b_6_rdmux_s <= en;
    redist72_result_uid58_sqrt_b_6_rdmux_combproc: PROCESS (redist72_result_uid58_sqrt_b_6_rdmux_s, redist72_result_uid58_sqrt_b_6_wraddr_q, redist72_result_uid58_sqrt_b_6_rdcnt_q)
    BEGIN
        CASE (redist72_result_uid58_sqrt_b_6_rdmux_s) IS
            WHEN "0" => redist72_result_uid58_sqrt_b_6_rdmux_q <= redist72_result_uid58_sqrt_b_6_wraddr_q;
            WHEN "1" => redist72_result_uid58_sqrt_b_6_rdmux_q <= redist72_result_uid58_sqrt_b_6_rdcnt_q;
            WHEN OTHERS => redist72_result_uid58_sqrt_b_6_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_notEnable(LOGICAL,693)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_nor(LOGICAL,694)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_nor_q <= not (redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_notEnable_q or redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_sticky_ena_q);

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_last(CONSTANT,690)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_last_q <= "01100";

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmp(LOGICAL,691)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmp_b <= STD_LOGIC_VECTOR("0" & redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_q);
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmp_q <= "1" WHEN redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_last_q = redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmp_b ELSE "0";

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmpReg(REG,692)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmpReg_q <= STD_LOGIC_VECTOR(redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_sticky_ena(REG,695)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_sticky_ena_q <= "0";
            ELSE
                IF (redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_nor_q = "1") THEN
                    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_sticky_ena_q <= STD_LOGIC_VECTOR(redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_enaAnd(LOGICAL,696)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_enaAnd_q <= redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_sticky_ena_q and en;

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt(COUNTER,687)
    -- low=0, high=13, step=1, init=0
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_i = TO_UNSIGNED(12, 4)) THEN
                        redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_eq <= '1';
                    ELSE
                        redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_eq <= '0';
                    END IF;
                    IF (redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_eq = '1') THEN
                        redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_i <= redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_i + 3;
                    ELSE
                        redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_i <= redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_i, 4)));

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux(MUX,688)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_s <= en;
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_combproc: PROCESS (redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_s, redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_wraddr_q, redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_q)
    BEGIN
        CASE (redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_s) IS
            WHEN "0" => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_q <= redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_wraddr_q;
            WHEN "1" => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_q <= redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdcnt_q;
            WHEN OTHERS => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_notEnable(LOGICAL,758)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_nor(LOGICAL,759)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_nor_q <= not (redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_notEnable_q or redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_sticky_ena_q);

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_last(CONSTANT,755)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_last_q <= "010";

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmp(LOGICAL,756)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmp_b <= STD_LOGIC_VECTOR("0" & redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_q);
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmp_q <= "1" WHEN redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_last_q = redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmp_b ELSE "0";

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmpReg(REG,757)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmpReg_q <= STD_LOGIC_VECTOR(redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_sticky_ena(REG,760)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_sticky_ena_q <= "0";
            ELSE
                IF (redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_nor_q = "1") THEN
                    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_sticky_ena_q <= STD_LOGIC_VECTOR(redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_enaAnd(LOGICAL,761)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_enaAnd_q <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_sticky_ena_q and en;

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt(COUNTER,752)
    -- low=0, high=3, step=1, init=0
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_i <= TO_UNSIGNED(0, 2);
            ELSE
                IF (en = "1") THEN
                    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_i <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_i, 2)));

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux(MUX,753)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_s <= en;
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_combproc: PROCESS (redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_s, redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_wraddr_q, redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_q)
    BEGIN
        CASE (redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_s) IS
            WHEN "0" => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_q <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_wraddr_q;
            WHEN "1" => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_q <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdcnt_q;
            WHEN OTHERS => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt(BITSELECT,213)@9
    leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_in <= leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q(28 downto 0);
    leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_b <= leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_in(28 downto 0);

    -- leftShiftStage2Idx3Pad3_uid213_xLeftShift_uid23_sqrt(CONSTANT,212)
    leftShiftStage2Idx3Pad3_uid213_xLeftShift_uid23_sqrt_q <= "000";

    -- leftShiftStage2Idx3_uid215_xLeftShift_uid23_sqrt(BITJOIN,214)@9
    leftShiftStage2Idx3_uid215_xLeftShift_uid23_sqrt_q <= leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_b & leftShiftStage2Idx3Pad3_uid213_xLeftShift_uid23_sqrt_q;

    -- leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt(BITSELECT,210)@9
    leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_in <= leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q(29 downto 0);
    leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_b <= leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_in(29 downto 0);

    -- leftShiftStage2Idx2_uid212_xLeftShift_uid23_sqrt(BITJOIN,211)@9
    leftShiftStage2Idx2_uid212_xLeftShift_uid23_sqrt_q <= leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_b & zs_uid116_leadingZeros_uid7_sqrt_q;

    -- leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt(BITSELECT,207)@9
    leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_in <= leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q(30 downto 0);
    leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_b <= leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_in(30 downto 0);

    -- leftShiftStage2Idx1_uid209_xLeftShift_uid23_sqrt(BITJOIN,208)@9
    leftShiftStage2Idx1_uid209_xLeftShift_uid23_sqrt_q <= leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_b & GND_q;

    -- leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt(BITSELECT,202)@8
    leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_in <= leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q(19 downto 0);
    leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_b <= leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_in(19 downto 0);

    -- leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt(CONSTANT,201)
    leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt_q <= "000000000000";

    -- leftShiftStage1Idx3_uid204_xLeftShift_uid23_sqrt(BITJOIN,203)@8
    leftShiftStage1Idx3_uid204_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_b & leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt_q;

    -- leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt(BITSELECT,199)@8
    leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_in <= leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q(23 downto 0);
    leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_b <= leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_in(23 downto 0);

    -- leftShiftStage1Idx2_uid201_xLeftShift_uid23_sqrt(BITJOIN,200)@8
    leftShiftStage1Idx2_uid201_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_b & zs_uid104_leadingZeros_uid7_sqrt_q;

    -- leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt(BITSELECT,196)@8
    leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_in <= leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q(27 downto 0);
    leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_b <= leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_in(27 downto 0);

    -- leftShiftStage1Idx1_uid198_xLeftShift_uid23_sqrt(BITJOIN,197)@8
    leftShiftStage1Idx1_uid198_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_b & zs_uid110_leadingZeros_uid7_sqrt_q;

    -- leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt(BITSELECT,189)@8
    leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_in <= redist83_in_rsrvd_fix_radical_8_outputreg2_q(15 downto 0);
    leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_b <= leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_in(15 downto 0);

    -- leftShiftStage0Idx1_uid191_xLeftShift_uid23_sqrt(BITJOIN,190)@8
    leftShiftStage0Idx1_uid191_xLeftShift_uid23_sqrt_q <= leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_b & zs_uid98_leadingZeros_uid7_sqrt_q;

    -- redist83_in_rsrvd_fix_radical_8_notEnable(LOGICAL,813)
    redist83_in_rsrvd_fix_radical_8_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist83_in_rsrvd_fix_radical_8_nor(LOGICAL,814)
    redist83_in_rsrvd_fix_radical_8_nor_q <= not (redist83_in_rsrvd_fix_radical_8_notEnable_q or redist83_in_rsrvd_fix_radical_8_sticky_ena_q);

    -- redist83_in_rsrvd_fix_radical_8_mem_last(CONSTANT,810)
    redist83_in_rsrvd_fix_radical_8_mem_last_q <= "01";

    -- redist83_in_rsrvd_fix_radical_8_cmp(LOGICAL,811)
    redist83_in_rsrvd_fix_radical_8_cmp_q <= "1" WHEN redist83_in_rsrvd_fix_radical_8_mem_last_q = redist83_in_rsrvd_fix_radical_8_rdmux_q ELSE "0";

    -- redist83_in_rsrvd_fix_radical_8_cmpReg(REG,812)
    redist83_in_rsrvd_fix_radical_8_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist83_in_rsrvd_fix_radical_8_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist83_in_rsrvd_fix_radical_8_cmpReg_q <= STD_LOGIC_VECTOR(redist83_in_rsrvd_fix_radical_8_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist83_in_rsrvd_fix_radical_8_sticky_ena(REG,815)
    redist83_in_rsrvd_fix_radical_8_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist83_in_rsrvd_fix_radical_8_sticky_ena_q <= "0";
            ELSE
                IF (redist83_in_rsrvd_fix_radical_8_nor_q = "1") THEN
                    redist83_in_rsrvd_fix_radical_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist83_in_rsrvd_fix_radical_8_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist83_in_rsrvd_fix_radical_8_enaAnd(LOGICAL,816)
    redist83_in_rsrvd_fix_radical_8_enaAnd_q <= redist83_in_rsrvd_fix_radical_8_sticky_ena_q and en;

    -- redist83_in_rsrvd_fix_radical_8_rdcnt(COUNTER,807)
    -- low=0, high=2, step=1, init=0
    redist83_in_rsrvd_fix_radical_8_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist83_in_rsrvd_fix_radical_8_rdcnt_i <= TO_UNSIGNED(0, 2);
                redist83_in_rsrvd_fix_radical_8_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist83_in_rsrvd_fix_radical_8_rdcnt_i = TO_UNSIGNED(1, 2)) THEN
                        redist83_in_rsrvd_fix_radical_8_rdcnt_eq <= '1';
                    ELSE
                        redist83_in_rsrvd_fix_radical_8_rdcnt_eq <= '0';
                    END IF;
                    IF (redist83_in_rsrvd_fix_radical_8_rdcnt_eq = '1') THEN
                        redist83_in_rsrvd_fix_radical_8_rdcnt_i <= redist83_in_rsrvd_fix_radical_8_rdcnt_i + 2;
                    ELSE
                        redist83_in_rsrvd_fix_radical_8_rdcnt_i <= redist83_in_rsrvd_fix_radical_8_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist83_in_rsrvd_fix_radical_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist83_in_rsrvd_fix_radical_8_rdcnt_i, 2)));

    -- redist83_in_rsrvd_fix_radical_8_rdmux(MUX,808)
    redist83_in_rsrvd_fix_radical_8_rdmux_s <= en;
    redist83_in_rsrvd_fix_radical_8_rdmux_combproc: PROCESS (redist83_in_rsrvd_fix_radical_8_rdmux_s, redist83_in_rsrvd_fix_radical_8_wraddr_q, redist83_in_rsrvd_fix_radical_8_rdcnt_q)
    BEGIN
        CASE (redist83_in_rsrvd_fix_radical_8_rdmux_s) IS
            WHEN "0" => redist83_in_rsrvd_fix_radical_8_rdmux_q <= redist83_in_rsrvd_fix_radical_8_wraddr_q;
            WHEN "1" => redist83_in_rsrvd_fix_radical_8_rdmux_q <= redist83_in_rsrvd_fix_radical_8_rdcnt_q;
            WHEN OTHERS => redist83_in_rsrvd_fix_radical_8_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist83_in_rsrvd_fix_radical_8_wraddr(REG,809)
    redist83_in_rsrvd_fix_radical_8_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist83_in_rsrvd_fix_radical_8_wraddr_q <= "10";
            ELSE
                redist83_in_rsrvd_fix_radical_8_wraddr_q <= STD_LOGIC_VECTOR(redist83_in_rsrvd_fix_radical_8_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist83_in_rsrvd_fix_radical_8_mem(DUALMEM,806)
    redist83_in_rsrvd_fix_radical_8_mem_ia <= STD_LOGIC_VECTOR(redist82_in_rsrvd_fix_radical_1_q);
    redist83_in_rsrvd_fix_radical_8_mem_aa <= redist83_in_rsrvd_fix_radical_8_wraddr_q;
    redist83_in_rsrvd_fix_radical_8_mem_ab <= redist83_in_rsrvd_fix_radical_8_rdmux_q;
    redist83_in_rsrvd_fix_radical_8_mem_reset0 <= rst;
    redist83_in_rsrvd_fix_radical_8_mem_dmem : altera_syncram
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
        clocken1 => redist83_in_rsrvd_fix_radical_8_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist83_in_rsrvd_fix_radical_8_mem_reset0,
        clock1 => clk,
        address_a => redist83_in_rsrvd_fix_radical_8_mem_aa,
        data_a => redist83_in_rsrvd_fix_radical_8_mem_ia,
        wren_a => en(0),
        address_b => redist83_in_rsrvd_fix_radical_8_mem_ab,
        q_b => redist83_in_rsrvd_fix_radical_8_mem_iq
    );
    redist83_in_rsrvd_fix_radical_8_mem_q <= redist83_in_rsrvd_fix_radical_8_mem_iq(31 downto 0);
    redist83_in_rsrvd_fix_radical_8_mem_enaOr_rst <= redist83_in_rsrvd_fix_radical_8_enaAnd_q(0) or redist83_in_rsrvd_fix_radical_8_mem_reset0;

    -- redist83_in_rsrvd_fix_radical_8_outputreg0(DELAY,805)
    redist83_in_rsrvd_fix_radical_8_outputreg0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist83_in_rsrvd_fix_radical_8_mem_q, xout => redist83_in_rsrvd_fix_radical_8_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist83_in_rsrvd_fix_radical_8_outputreg1(DELAY,804)
    redist83_in_rsrvd_fix_radical_8_outputreg1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist83_in_rsrvd_fix_radical_8_outputreg0_q, xout => redist83_in_rsrvd_fix_radical_8_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist83_in_rsrvd_fix_radical_8_outputreg2(DELAY,803)
    redist83_in_rsrvd_fix_radical_8_outputreg2 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist83_in_rsrvd_fix_radical_8_outputreg1_q, xout => redist83_in_rsrvd_fix_radical_8_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- leftShiftStageSel0Dto4_uid194_xLeftShift_uid23_sqrt(BITSELECT,193)@8
    leftShiftStageSel0Dto4_uid194_xLeftShift_uid23_sqrt_b <= redist58_r_uid125_leadingZeros_uid7_sqrt_q_1_q(5 downto 4);

    -- leftShiftStage0_uid195_xLeftShift_uid23_sqrt(MUX,194)@8
    leftShiftStage0_uid195_xLeftShift_uid23_sqrt_s <= leftShiftStageSel0Dto4_uid194_xLeftShift_uid23_sqrt_b;
    leftShiftStage0_uid195_xLeftShift_uid23_sqrt_combproc: PROCESS (leftShiftStage0_uid195_xLeftShift_uid23_sqrt_s, redist83_in_rsrvd_fix_radical_8_outputreg2_q, leftShiftStage0Idx1_uid191_xLeftShift_uid23_sqrt_q, zs_uid92_leadingZeros_uid7_sqrt_q)
    BEGIN
        CASE (leftShiftStage0_uid195_xLeftShift_uid23_sqrt_s) IS
            WHEN "00" => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= redist83_in_rsrvd_fix_radical_8_outputreg2_q;
            WHEN "01" => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= leftShiftStage0Idx1_uid191_xLeftShift_uid23_sqrt_q;
            WHEN "10" => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= zs_uid92_leadingZeros_uid7_sqrt_q;
            WHEN "11" => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= zs_uid92_leadingZeros_uid7_sqrt_q;
            WHEN OTHERS => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt(BITSELECT,204)@8
    leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_in <= redist58_r_uid125_leadingZeros_uid7_sqrt_q_1_q(3 downto 0);
    leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_b <= leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_in(3 downto 2);

    -- leftShiftStage1_uid206_xLeftShift_uid23_sqrt(MUX,205)@8 + 1
    leftShiftStage1_uid206_xLeftShift_uid23_sqrt_s <= leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_b;
    leftShiftStage1_uid206_xLeftShift_uid23_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (leftShiftStage1_uid206_xLeftShift_uid23_sqrt_s) IS
                        WHEN "00" => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q;
                        WHEN "01" => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx1_uid198_xLeftShift_uid23_sqrt_q;
                        WHEN "10" => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx2_uid201_xLeftShift_uid23_sqrt_q;
                        WHEN "11" => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx3_uid204_xLeftShift_uid23_sqrt_q;
                        WHEN OTHERS => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt(BITSELECT,215)@9
    leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt_in <= redist59_r_uid125_leadingZeros_uid7_sqrt_q_2_q(1 downto 0);
    leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt_b <= leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt_in(1 downto 0);

    -- leftShiftStage2_uid217_xLeftShift_uid23_sqrt(MUX,216)@9
    leftShiftStage2_uid217_xLeftShift_uid23_sqrt_s <= leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt_b;
    leftShiftStage2_uid217_xLeftShift_uid23_sqrt_combproc: PROCESS (leftShiftStage2_uid217_xLeftShift_uid23_sqrt_s, leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q, leftShiftStage2Idx1_uid209_xLeftShift_uid23_sqrt_q, leftShiftStage2Idx2_uid212_xLeftShift_uid23_sqrt_q, leftShiftStage2Idx3_uid215_xLeftShift_uid23_sqrt_q)
    BEGIN
        CASE (leftShiftStage2_uid217_xLeftShift_uid23_sqrt_s) IS
            WHEN "00" => leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q <= leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q;
            WHEN "01" => leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q <= leftShiftStage2Idx1_uid209_xLeftShift_uid23_sqrt_q;
            WHEN "10" => leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q <= leftShiftStage2Idx2_uid212_xLeftShift_uid23_sqrt_q;
            WHEN "11" => leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q <= leftShiftStage2Idx3_uid215_xLeftShift_uid23_sqrt_q;
            WHEN OTHERS => leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist55_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1(DELAY,651)
    redist55_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q, xout => redist55_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg1(DELAY,746)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist55_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1_q, xout => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg0(DELAY,748)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg1_q, xout => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_wraddr(REG,754)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_wraddr_q <= "11";
            ELSE
                redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_wraddr_q <= STD_LOGIC_VECTOR(redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem(DUALMEM,751)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_ia <= STD_LOGIC_VECTOR(redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_inputreg0_q);
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_aa <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_wraddr_q;
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_ab <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_rdmux_q;
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_reset0 <= rst;
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 32,
        widthad_b => 2,
        numwords_b => 4,
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
        clocken1 => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_reset0,
        clock1 => clk,
        address_a => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_aa,
        data_a => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_ia,
        wren_a => en(0),
        address_b => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_ab,
        q_b => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_iq
    );
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_q <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_iq(31 downto 0);
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_enaOr_rst <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_enaAnd_q(0) or redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_reset0;

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg0(DELAY,750)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_mem_q, xout => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg1(DELAY,749)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg0_q, xout => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg2(DELAY,747)
    redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg2 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg1_q, xout => redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs16(BITSELECT,237)@20
    xMulInitApproxSquaredFull_uid47_sqrt_bs16_in <= STD_LOGIC_VECTOR(redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg2_q(17 downto 0));
    xMulInitApproxSquaredFull_uid47_sqrt_bs16_b <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_bs16_in(17 downto 0));

    -- redist47_xMulInitApproxSquaredFull_uid47_sqrt_bs16_b_1(DELAY,643)
    redist47_xMulInitApproxSquaredFull_uid47_sqrt_bs16_b_1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs16_b, xout => redist47_xMulInitApproxSquaredFull_uid47_sqrt_bs16_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_bjA17(BITJOIN,238)@21
    xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q <= GND_q & redist47_xMulInitApproxSquaredFull_uid47_sqrt_bs16_b_1_q;

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg1(DELAY,681)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg1 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q, xout => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg0(DELAY,683)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg0 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg1_q, xout => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_wraddr(REG,689)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_wraddr_q <= "1101";
            ELSE
                redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_wraddr_q <= STD_LOGIC_VECTOR(redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem(DUALMEM,686)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_ia <= STD_LOGIC_VECTOR(redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_inputreg0_q);
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_aa <= redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_wraddr_q;
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_ab <= redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_rdmux_q;
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_reset0 <= rst;
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 19,
        widthad_a => 4,
        numwords_a => 14,
        width_b => 19,
        widthad_b => 4,
        numwords_b => 14,
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
        clocken1 => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_reset0,
        clock1 => clk,
        address_a => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_aa,
        data_a => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_ia,
        wren_a => en(0),
        address_b => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_ab,
        q_b => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_iq
    );
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_q <= redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_iq(18 downto 0);
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_enaOr_rst <= redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_enaAnd_q(0) or redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_reset0;

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg0(DELAY,685)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg0 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_mem_q, xout => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg1(DELAY,684)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg1 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg0_q, xout => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg2(DELAY,682)
    redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg2 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg1_q, xout => redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- x2_uid27_sqrt(BITSELECT,26)@10
    x2_uid27_sqrt_in <= redist55_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1_q(18 downto 0);
    x2_uid27_sqrt_b <= x2_uid27_sqrt_in(18 downto 14);

    -- x2_msb_uid29_sqrt(BITSELECT,28)@10
    x2_msb_uid29_sqrt_b <= STD_LOGIC_VECTOR(x2_uid27_sqrt_b(4 downto 4));

    -- redist76_x2_msb_uid29_sqrt_b_2(DELAY,672)
    redist76_x2_msb_uid29_sqrt_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => x2_msb_uid29_sqrt_b, xout => redist76_x2_msb_uid29_sqrt_b_2_q, ena => en(0), clk => clk, aclr => rst );

    -- x0_uid25_sqrt(BITSELECT,24)@9
    x0_uid25_sqrt_in <= leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q(30 downto 0);
    x0_uid25_sqrt_b <= x0_uid25_sqrt_in(30 downto 25);

    -- redist77_x0_uid25_sqrt_b_1(DELAY,673)
    redist77_x0_uid25_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => x0_uid25_sqrt_b, xout => redist77_x0_uid25_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- x2_xored_uid30_sqrt(LOGICAL,29)@10
    x2_xored_uid30_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((4 downto 1 => x2_msb_uid29_sqrt_b(0)) & x2_msb_uid29_sqrt_b));
    x2_xored_uid30_sqrt_q <= x2_uid27_sqrt_b xor x2_xored_uid30_sqrt_b;

    -- x2_xoredNoMsb_uid31_sqrt(BITSELECT,30)@10
    x2_xoredNoMsb_uid31_sqrt_in <= x2_xored_uid30_sqrt_q(3 downto 0);
    x2_xoredNoMsb_uid31_sqrt_b <= x2_xoredNoMsb_uid31_sqrt_in(3 downto 0);

    -- a1Addr_uid32_sqrt(BITJOIN,31)@10
    a1Addr_uid32_sqrt_q <= redist77_x0_uid25_sqrt_b_1_q & x2_xoredNoMsb_uid31_sqrt_b;

    -- a1Table_uid37_sqrt_lutmem(DUALMEM,220)@10 + 2
    -- in j@20000000
    a1Table_uid37_sqrt_lutmem_aa <= a1Addr_uid32_sqrt_q;
    a1Table_uid37_sqrt_lutmem_reset0 <= rst;
    a1Table_uid37_sqrt_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 7,
        widthad_a => 10,
        numwords_a => 1024,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FIX_SQRT_altera_fxp_functions_180_gf6zify_a1Table_uid37_sqrt_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken0 => en(0),
        sclr => a1Table_uid37_sqrt_lutmem_reset0,
        clock0 => clk,
        address_a => a1Table_uid37_sqrt_lutmem_aa,
        q_a => a1Table_uid37_sqrt_lutmem_ir
    );
    a1Table_uid37_sqrt_lutmem_r <= a1Table_uid37_sqrt_lutmem_ir(6 downto 0);
    a1Table_uid37_sqrt_lutmem_enaOr_rst <= en(0) or a1Table_uid37_sqrt_lutmem_reset0;

    -- a1TableOutSxt_uid40_sqrt(BITJOIN,39)@12
    a1TableOutSxt_uid40_sqrt_q <= GND_q & a1Table_uid37_sqrt_lutmem_r;

    -- a1TableOut_xored_uid41_sqrt(LOGICAL,40)@12 + 1
    a1TableOut_xored_uid41_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((7 downto 1 => redist76_x2_msb_uid29_sqrt_b_2_q(0)) & redist76_x2_msb_uid29_sqrt_b_2_q));
    a1TableOut_xored_uid41_sqrt_qi <= a1TableOutSxt_uid40_sqrt_q xor a1TableOut_xored_uid41_sqrt_b;
    a1TableOut_xored_uid41_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => a1TableOut_xored_uid41_sqrt_qi, xout => a1TableOut_xored_uid41_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- x1_uid26_sqrt(BITSELECT,25)@9
    x1_uid26_sqrt_in <= leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q(24 downto 0);
    x1_uid26_sqrt_b <= x1_uid26_sqrt_in(24 downto 19);

    -- a0Addr_uid28_sqrt(BITJOIN,27)@9
    a0Addr_uid28_sqrt_q <= x0_uid25_sqrt_b & x1_uid26_sqrt_b;

    -- a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select(BITSELECT,574)@9
    a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_b <= STD_LOGIC_VECTOR(a0Addr_uid28_sqrt_q(11 downto 11));
    a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_c <= STD_LOGIC_VECTOR(a0Addr_uid28_sqrt_q(10 downto 0));

    -- a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1(REG,338)@9 + 1
    a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1_q <= STD_LOGIC_VECTOR(a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_b);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- a0Table_uid34_sqrt_lutmem_csA1(LOOKUP,327)@10
    a0Table_uid34_sqrt_lutmem_csA1_combproc: PROCESS (a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1_q) IS
            WHEN "1" => a0Table_uid34_sqrt_lutmem_csA1_h <= "1";
            WHEN OTHERS => a0Table_uid34_sqrt_lutmem_csA1_h <= "0";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- a0Table_uid34_sqrt_lutmem_addrA_lofan_reg1(REG,340)@9 + 1
    a0Table_uid34_sqrt_lutmem_addrA_lofan_reg1_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    a0Table_uid34_sqrt_lutmem_addrA_lofan_reg1_q <= STD_LOGIC_VECTOR(a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_c);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- a0Table_uid34_sqrt_lutmem_part1(DUALMEM,331)@10 + 2
    a0Table_uid34_sqrt_lutmem_part1_aa <= a0Table_uid34_sqrt_lutmem_addrA_lofan_reg1_q;
    a0Table_uid34_sqrt_lutmem_part1_reset0 <= rst;
    a0Table_uid34_sqrt_lutmem_part1_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 10,
        widthad_a => 11,
        numwords_a => 2048,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FIX_SQRT_altera_fxp_functions_180_gf6zify_a0Table_uid34_sqrt_lutmem_part1.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10",
        enable_force_to_zero => "TRUE"
    )
    PORT MAP (
        clocken0 => en(0),
        sclr => a0Table_uid34_sqrt_lutmem_part1_reset0,
        clock0 => clk,
        address_a => a0Table_uid34_sqrt_lutmem_part1_aa,
        q_a => a0Table_uid34_sqrt_lutmem_part1_ir,
        rden_a => a0Table_uid34_sqrt_lutmem_csA1_h(0)
    );
    a0Table_uid34_sqrt_lutmem_part1_r <= a0Table_uid34_sqrt_lutmem_part1_ir(9 downto 0);
    a0Table_uid34_sqrt_lutmem_part1_enaOr_rst <= en(0) or a0Table_uid34_sqrt_lutmem_part1_reset0;

    -- a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0(REG,337)@9 + 1
    a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0_q <= STD_LOGIC_VECTOR(a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_b);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- a0Table_uid34_sqrt_lutmem_csA0(LOOKUP,326)@10
    a0Table_uid34_sqrt_lutmem_csA0_combproc: PROCESS (a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0_q)
    BEGIN
        -- Begin reserved scope level
        CASE (a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0_q) IS
            WHEN "0" => a0Table_uid34_sqrt_lutmem_csA0_h <= "1";
            WHEN OTHERS => a0Table_uid34_sqrt_lutmem_csA0_h <= "0";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- a0Table_uid34_sqrt_lutmem_addrA_lofan_reg0(REG,339)@9 + 1
    a0Table_uid34_sqrt_lutmem_addrA_lofan_reg0_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    a0Table_uid34_sqrt_lutmem_addrA_lofan_reg0_q <= STD_LOGIC_VECTOR(a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_c);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- a0Table_uid34_sqrt_lutmem_part0(DUALMEM,330)@10 + 2
    a0Table_uid34_sqrt_lutmem_part0_aa <= a0Table_uid34_sqrt_lutmem_addrA_lofan_reg0_q;
    a0Table_uid34_sqrt_lutmem_part0_reset0 <= rst;
    a0Table_uid34_sqrt_lutmem_part0_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 10,
        widthad_a => 11,
        numwords_a => 2048,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FIX_SQRT_altera_fxp_functions_180_gf6zify_a0Table_uid34_sqrt_lutmem_part0.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10",
        enable_force_to_zero => "TRUE"
    )
    PORT MAP (
        clocken0 => en(0),
        sclr => a0Table_uid34_sqrt_lutmem_part0_reset0,
        clock0 => clk,
        address_a => a0Table_uid34_sqrt_lutmem_part0_aa,
        q_a => a0Table_uid34_sqrt_lutmem_part0_ir,
        rden_a => a0Table_uid34_sqrt_lutmem_csA0_h(0)
    );
    a0Table_uid34_sqrt_lutmem_part0_r <= a0Table_uid34_sqrt_lutmem_part0_ir(9 downto 0);
    a0Table_uid34_sqrt_lutmem_part0_enaOr_rst <= en(0) or a0Table_uid34_sqrt_lutmem_part0_reset0;

    -- a0Table_uid34_sqrt_lutmem_qA_l0_or0(LOGICAL,332)@12 + 1
    a0Table_uid34_sqrt_lutmem_qA_l0_or0_qi <= a0Table_uid34_sqrt_lutmem_part0_r or a0Table_uid34_sqrt_lutmem_part1_r;
    a0Table_uid34_sqrt_lutmem_qA_l0_or0_delay : dspba_delay
    GENERIC MAP ( width => 10, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => a0Table_uid34_sqrt_lutmem_qA_l0_or0_qi, xout => a0Table_uid34_sqrt_lutmem_qA_l0_or0_q, ena => en(0), clk => clk, aclr => rst );

    -- a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1(REG,334)@9 + 1
    a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1_q <= STD_LOGIC_VECTOR(a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_b);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- a0Table_uid33_sqrt_lutmem_csA1(LOOKUP,318)@10
    a0Table_uid33_sqrt_lutmem_csA1_combproc: PROCESS (a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1_q) IS
            WHEN "1" => a0Table_uid33_sqrt_lutmem_csA1_h <= "1";
            WHEN OTHERS => a0Table_uid33_sqrt_lutmem_csA1_h <= "0";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- a0Table_uid33_sqrt_lutmem_addrA_lofan_reg1(REG,336)@9 + 1
    a0Table_uid33_sqrt_lutmem_addrA_lofan_reg1_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    a0Table_uid33_sqrt_lutmem_addrA_lofan_reg1_q <= STD_LOGIC_VECTOR(a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_c);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- a0Table_uid33_sqrt_lutmem_part1(DUALMEM,322)@10 + 2
    a0Table_uid33_sqrt_lutmem_part1_aa <= a0Table_uid33_sqrt_lutmem_addrA_lofan_reg1_q;
    a0Table_uid33_sqrt_lutmem_part1_reset0 <= rst;
    a0Table_uid33_sqrt_lutmem_part1_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 10,
        widthad_a => 11,
        numwords_a => 2048,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FIX_SQRT_altera_fxp_functions_180_gf6zify_a0Table_uid33_sqrt_lutmem_part1.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10",
        enable_force_to_zero => "TRUE"
    )
    PORT MAP (
        clocken0 => en(0),
        sclr => a0Table_uid33_sqrt_lutmem_part1_reset0,
        clock0 => clk,
        address_a => a0Table_uid33_sqrt_lutmem_part1_aa,
        q_a => a0Table_uid33_sqrt_lutmem_part1_ir,
        rden_a => a0Table_uid33_sqrt_lutmem_csA1_h(0)
    );
    a0Table_uid33_sqrt_lutmem_part1_r <= a0Table_uid33_sqrt_lutmem_part1_ir(9 downto 0);
    a0Table_uid33_sqrt_lutmem_part1_enaOr_rst <= en(0) or a0Table_uid33_sqrt_lutmem_part1_reset0;

    -- a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0(REG,333)@9 + 1
    a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0_q <= STD_LOGIC_VECTOR(a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_b);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- a0Table_uid33_sqrt_lutmem_csA0(LOOKUP,317)@10
    a0Table_uid33_sqrt_lutmem_csA0_combproc: PROCESS (a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0_q)
    BEGIN
        -- Begin reserved scope level
        CASE (a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0_q) IS
            WHEN "0" => a0Table_uid33_sqrt_lutmem_csA0_h <= "1";
            WHEN OTHERS => a0Table_uid33_sqrt_lutmem_csA0_h <= "0";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- a0Table_uid33_sqrt_lutmem_addrA_lofan_reg0(REG,335)@9 + 1
    a0Table_uid33_sqrt_lutmem_addrA_lofan_reg0_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    a0Table_uid33_sqrt_lutmem_addrA_lofan_reg0_q <= STD_LOGIC_VECTOR(a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_c);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- a0Table_uid33_sqrt_lutmem_part0(DUALMEM,321)@10 + 2
    a0Table_uid33_sqrt_lutmem_part0_aa <= a0Table_uid33_sqrt_lutmem_addrA_lofan_reg0_q;
    a0Table_uid33_sqrt_lutmem_part0_reset0 <= rst;
    a0Table_uid33_sqrt_lutmem_part0_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 10,
        widthad_a => 11,
        numwords_a => 2048,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FIX_SQRT_altera_fxp_functions_180_gf6zify_a0Table_uid33_sqrt_lutmem_part0.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10",
        enable_force_to_zero => "TRUE"
    )
    PORT MAP (
        clocken0 => en(0),
        sclr => a0Table_uid33_sqrt_lutmem_part0_reset0,
        clock0 => clk,
        address_a => a0Table_uid33_sqrt_lutmem_part0_aa,
        q_a => a0Table_uid33_sqrt_lutmem_part0_ir,
        rden_a => a0Table_uid33_sqrt_lutmem_csA0_h(0)
    );
    a0Table_uid33_sqrt_lutmem_part0_r <= a0Table_uid33_sqrt_lutmem_part0_ir(9 downto 0);
    a0Table_uid33_sqrt_lutmem_part0_enaOr_rst <= en(0) or a0Table_uid33_sqrt_lutmem_part0_reset0;

    -- a0Table_uid33_sqrt_lutmem_qA_l0_or0(LOGICAL,323)@12 + 1
    a0Table_uid33_sqrt_lutmem_qA_l0_or0_qi <= a0Table_uid33_sqrt_lutmem_part0_r or a0Table_uid33_sqrt_lutmem_part1_r;
    a0Table_uid33_sqrt_lutmem_qA_l0_or0_delay : dspba_delay
    GENERIC MAP ( width => 10, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => a0Table_uid33_sqrt_lutmem_qA_l0_or0_qi, xout => a0Table_uid33_sqrt_lutmem_qA_l0_or0_q, ena => en(0), clk => clk, aclr => rst );

    -- os_uid35_sqrt(BITJOIN,34)@13
    os_uid35_sqrt_q <= a0Table_uid34_sqrt_lutmem_qA_l0_or0_q & a0Table_uid33_sqrt_lutmem_qA_l0_or0_q;

    -- initApproxFull_uid43_sqrt(ADD,42)@13
    initApproxFull_uid43_sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & os_uid35_sqrt_q));
    initApproxFull_uid43_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 8 => a1TableOut_xored_uid41_sqrt_q(7)) & a1TableOut_xored_uid41_sqrt_q));
    initApproxFull_uid43_sqrt_o <= STD_LOGIC_VECTOR(SIGNED(initApproxFull_uid43_sqrt_a) + SIGNED(initApproxFull_uid43_sqrt_b));
    initApproxFull_uid43_sqrt_q <= initApproxFull_uid43_sqrt_o(21 downto 0);

    -- initApprox_uid44_sqrt(BITSELECT,43)@13
    initApprox_uid44_sqrt_in <= initApproxFull_uid43_sqrt_q(19 downto 0);
    initApprox_uid44_sqrt_b <= initApprox_uid44_sqrt_in(19 downto 0);

    -- redist74_initApprox_uid44_sqrt_b_1(DELAY,670)
    redist74_initApprox_uid44_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => initApprox_uid44_sqrt_b, xout => redist74_initApprox_uid44_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- initApproxSquaredFull_uid45_sqrt_cma(CHAINMULTADD,564)@14 + 5
    -- out q@20
    initApproxSquaredFull_uid45_sqrt_cma_reset <= rst;
    initApproxSquaredFull_uid45_sqrt_cma_ena0 <= en(0) or initApproxSquaredFull_uid45_sqrt_cma_reset;
    initApproxSquaredFull_uid45_sqrt_cma_ena1 <= initApproxSquaredFull_uid45_sqrt_cma_ena0;
    initApproxSquaredFull_uid45_sqrt_cma_ena2 <= initApproxSquaredFull_uid45_sqrt_cma_ena0;
    initApproxSquaredFull_uid45_sqrt_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    initApproxSquaredFull_uid45_sqrt_cma_ah(0) <= RESIZE(UNSIGNED(redist74_initApprox_uid44_sqrt_b_1_q),20);
                    initApproxSquaredFull_uid45_sqrt_cma_ch(0) <= RESIZE(UNSIGNED(redist74_initApprox_uid44_sqrt_b_1_q),20);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    initApproxSquaredFull_uid45_sqrt_cma_a0 <= STD_LOGIC_VECTOR(initApproxSquaredFull_uid45_sqrt_cma_ah(0));
    initApproxSquaredFull_uid45_sqrt_cma_c0 <= STD_LOGIC_VECTOR(initApproxSquaredFull_uid45_sqrt_cma_ch(0));
    initApproxSquaredFull_uid45_sqrt_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 20,
        ax_clock => "0",
        ax_width => 20,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 40
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => initApproxSquaredFull_uid45_sqrt_cma_ena0,
        ena(1) => initApproxSquaredFull_uid45_sqrt_cma_ena1,
        ena(2) => initApproxSquaredFull_uid45_sqrt_cma_ena2,
        clr(0) => initApproxSquaredFull_uid45_sqrt_cma_reset,
        clr(1) => initApproxSquaredFull_uid45_sqrt_cma_reset,
        ay => initApproxSquaredFull_uid45_sqrt_cma_a0,
        ax => initApproxSquaredFull_uid45_sqrt_cma_c0,
        resulta => initApproxSquaredFull_uid45_sqrt_cma_s0
    );
    initApproxSquaredFull_uid45_sqrt_cma_delay : dspba_delay
    GENERIC MAP ( width => 40, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => initApproxSquaredFull_uid45_sqrt_cma_s0, xout => initApproxSquaredFull_uid45_sqrt_cma_qq, ena => en(0), clk => clk, aclr => rst );
    initApproxSquaredFull_uid45_sqrt_cma_q <= STD_LOGIC_VECTOR(initApproxSquaredFull_uid45_sqrt_cma_qq(39 downto 0));

    -- initApproxSquared_uid46_sqrt(BITSELECT,45)@20
    initApproxSquared_uid46_sqrt_in <= initApproxSquaredFull_uid45_sqrt_cma_q(38 downto 0);
    initApproxSquared_uid46_sqrt_b <= initApproxSquared_uid46_sqrt_in(38 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs5(BITSELECT,226)@20
    xMulInitApproxSquaredFull_uid47_sqrt_bs5_b <= initApproxSquared_uid46_sqrt_b(38 downto 36);

    -- redist51_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1(DELAY,647)
    redist51_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs5_b, xout => redist51_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs4(BITSELECT,225)@20
    xMulInitApproxSquaredFull_uid47_sqrt_bs4_b <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg2_q(31 downto 18);

    -- redist52_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1(DELAY,648)
    redist52_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs4_b, xout => redist52_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_im3_cma(CHAINMULTADD,566)@21 + 5
    -- out q@27
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_reset <= rst;
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena0 <= en(0) or xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_reset;
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena1 <= xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena0;
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena2 <= xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena0;
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ah(0) <= RESIZE(UNSIGNED(redist52_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1_q),14);
                    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ch(0) <= RESIZE(UNSIGNED(redist51_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1_q),3);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_a0 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ah(0));
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_c0 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ch(0));
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 14,
        ax_clock => "0",
        ax_width => 3,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 17,
        bx_width => 1,
        by_width => 1,
        result_b_width => 1
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena0,
        ena(1) => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena1,
        ena(2) => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ena2,
        clr(0) => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_reset,
        clr(1) => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_reset,
        ay => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_a0,
        ax => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_c0,
        resulta => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_s0
    );
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_delay : dspba_delay
    GENERIC MAP ( width => 17, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_s0, xout => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_qq, ena => en(0), clk => clk, aclr => rst );
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_qq(16 downto 0));

    -- redist21_xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q_1(DELAY,617)
    redist21_xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 17, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q, xout => redist21_xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_align_23(BITSHIFT,244)@28
    xMulInitApproxSquaredFull_uid47_sqrt_align_23_qint <= redist21_xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q_1_q & "000000000000000000000000000000000000000000000000000000";
    xMulInitApproxSquaredFull_uid47_sqrt_align_23_q <= xMulInitApproxSquaredFull_uid47_sqrt_align_23_qint(70 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select(BITSELECT,586)@28
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_in <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_align_23_q(69 downto 0));
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_in(34 downto 0));
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_in(69 downto 35));

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs1(BITSELECT,222)@20
    xMulInitApproxSquaredFull_uid47_sqrt_bs1_in <= redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg2_q(17 downto 0);
    xMulInitApproxSquaredFull_uid47_sqrt_bs1_b <= xMulInitApproxSquaredFull_uid47_sqrt_bs1_in(17 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs8(BITSELECT,229)@20
    xMulInitApproxSquaredFull_uid47_sqrt_bs8_in <= initApproxSquared_uid46_sqrt_b(35 downto 0);
    xMulInitApproxSquaredFull_uid47_sqrt_bs8_b <= xMulInitApproxSquaredFull_uid47_sqrt_bs8_in(35 downto 18);

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs2(BITSELECT,223)@20
    xMulInitApproxSquaredFull_uid47_sqrt_bs2_in <= initApproxSquared_uid46_sqrt_b(17 downto 0);
    xMulInitApproxSquaredFull_uid47_sqrt_bs2_b <= xMulInitApproxSquaredFull_uid47_sqrt_bs2_in(17 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma(CHAINMULTADD,571)@20 + 5
    -- out q@26
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_reset <= rst;
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena0 <= en(0) or xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_reset;
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena1 <= xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena0;
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena2 <= xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena0;
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ah(0) <= RESIZE(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bs4_b),18);
                    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ah(1) <= RESIZE(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bs8_b),18);
                    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ch(0) <= RESIZE(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bs2_b),18);
                    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ch(1) <= RESIZE(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bs1_b),18);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_a0 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ah(0));
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_c0 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ch(0));
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_a1 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ah(1));
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_c1 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ch(1));
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_DSP0 : fourteennm_mac
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
        signed_max => "false",
        signed_mbx => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 37
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena0,
        ena(1) => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena1,
        ena(2) => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_ena2,
        clr(0) => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_reset,
        clr(1) => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_reset,
        ay => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_a1,
        by => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_a0,
        ax => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_c1,
        bx => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_c0,
        resulta => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_s0
    );
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_delay : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_s0, xout => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_qq, ena => en(0), clk => clk, aclr => rst );
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_qq(36 downto 0));

    -- redist16_xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q_1(DELAY,612)
    redist16_xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q, xout => redist16_xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_align_21(BITSHIFT,242)@27
    xMulInitApproxSquaredFull_uid47_sqrt_align_21_qint <= redist16_xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q_1_q & "000000000000000000";
    xMulInitApproxSquaredFull_uid47_sqrt_align_21_q <= xMulInitApproxSquaredFull_uid47_sqrt_align_21_qint(54 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select(BITSELECT,585)@27
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_align_21_q(34 downto 0));
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_align_21_q(54 downto 35));

    -- xMulInitApproxSquaredFull_uid47_sqrt_im0_cma(CHAINMULTADD,565)@20 + 5
    -- out q@26
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_reset <= rst;
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena0 <= en(0) or xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_reset;
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena1 <= xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena0;
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena2 <= xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena0;
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ah(0) <= RESIZE(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bs1_b),18);
                    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ch(0) <= RESIZE(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bs2_b),18);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_a0 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ah(0));
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_c0 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ch(0));
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_DSP0 : fourteennm_mac
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
        ena(0) => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena0,
        ena(1) => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena1,
        ena(2) => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_ena2,
        clr(0) => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_reset,
        clr(1) => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_reset,
        ay => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_a0,
        ax => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_c0,
        resulta => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_s0
    );
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_delay : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_s0, xout => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_qq, ena => en(0), clk => clk, aclr => rst );
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_qq(35 downto 0));

    -- redist22_xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q_1(DELAY,618)
    redist22_xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q, xout => redist22_xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select(BITSELECT,593)@27
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(redist22_xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q_1_q(34 downto 0));
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(redist22_xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q_1_q(35 downto 35));

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3(ADD,404)@27 + 1
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_a <= STD_LOGIC_VECTOR("0" & xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b);
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_b <= STD_LOGIC_VECTOR("0" & xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_b);
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_o <= STD_LOGIC_VECTOR(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_a) + UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_c(0) <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_o(35);
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_q <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_o(34 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3(ADD,415)@28 + 1
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_a <= STD_LOGIC_VECTOR("0" & xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_q);
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_b <= STD_LOGIC_VECTOR("0" & xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_b);
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_o <= STD_LOGIC_VECTOR(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_a) + UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_c(0) <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_o(35);

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1(DELAY,601)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_c, xout => redist5_xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_UpperBits_for_b(CONSTANT,401)
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_UpperBits_for_b_q <= "00000000000000000";

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel1_1(BITSELECT,513)
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel1_1_b <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_UpperBits_for_b_q(14 downto 0));

    -- redist6_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1(DELAY,602)
    redist6_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c, xout => redist6_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c(BITJOIN,514)@28
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel1_1_b & redist6_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q;

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs14(BITSELECT,235)@20
    xMulInitApproxSquaredFull_uid47_sqrt_bs14_in <= STD_LOGIC_VECTOR(initApproxSquared_uid46_sqrt_b(35 downto 0));
    xMulInitApproxSquaredFull_uid47_sqrt_bs14_b <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_bs14_in(35 downto 18));

    -- redist48_xMulInitApproxSquaredFull_uid47_sqrt_bs14_b_1(DELAY,644)
    redist48_xMulInitApproxSquaredFull_uid47_sqrt_bs14_b_1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs14_b, xout => redist48_xMulInitApproxSquaredFull_uid47_sqrt_bs14_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_bjB15(BITJOIN,236)@21
    xMulInitApproxSquaredFull_uid47_sqrt_bjB15_q <= GND_q & redist48_xMulInitApproxSquaredFull_uid47_sqrt_bs14_b_1_q;

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs12(BITSELECT,233)@20
    xMulInitApproxSquaredFull_uid47_sqrt_bs12_b <= STD_LOGIC_VECTOR(redist56_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_11_outputreg2_q(31 downto 18));

    -- redist50_xMulInitApproxSquaredFull_uid47_sqrt_bs12_b_1(DELAY,646)
    redist50_xMulInitApproxSquaredFull_uid47_sqrt_bs12_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs12_b, xout => redist50_xMulInitApproxSquaredFull_uid47_sqrt_bs12_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_bjA13(BITJOIN,234)@21
    xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q <= GND_q & redist50_xMulInitApproxSquaredFull_uid47_sqrt_bs12_b_1_q;

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs18(BITSELECT,239)@20
    xMulInitApproxSquaredFull_uid47_sqrt_bs18_b <= STD_LOGIC_VECTOR(initApproxSquared_uid46_sqrt_b(38 downto 36));

    -- redist45_xMulInitApproxSquaredFull_uid47_sqrt_bs18_b_1(DELAY,641)
    redist45_xMulInitApproxSquaredFull_uid47_sqrt_bs18_b_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs18_b, xout => redist45_xMulInitApproxSquaredFull_uid47_sqrt_bs18_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_bjB19(BITJOIN,240)@21
    xMulInitApproxSquaredFull_uid47_sqrt_bjB19_q <= GND_q & redist45_xMulInitApproxSquaredFull_uid47_sqrt_bs18_b_1_q;

    -- xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma(CHAINMULTADD,572)@21 + 5
    -- out q@27
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_reset <= rst;
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena0 <= en(0) or xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_reset;
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena1 <= xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena0;
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena2 <= xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena0;
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ah(0) <= RESIZE(SIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bjB19_q),15);
                    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ah(1) <= RESIZE(SIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q),15);
                    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ch(0) <= RESIZE(SIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q),19);
                    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ch(1) <= RESIZE(SIGNED(xMulInitApproxSquaredFull_uid47_sqrt_bjB15_q),19);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_a0 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ah(0));
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_c0 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ch(0));
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_a1 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ah(1));
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_c1 <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ch(1));
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_DSP0 : fourteennm_mac
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
        ax_width => 15,
        bx_width => 15,
        signed_may => "true",
        signed_mby => "true",
        signed_max => "true",
        signed_mbx => "true",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 35
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena0,
        ena(1) => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena1,
        ena(2) => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_ena2,
        clr(0) => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_reset,
        clr(1) => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_reset,
        ay => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_c1,
        by => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_c0,
        ax => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_a1,
        bx => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_a0,
        resulta => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_s0
    );
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_delay : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_s0, xout => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_qq, ena => en(0), clk => clk, aclr => rst );
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_q <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_qq(34 downto 0));

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel1_1(BITSELECT,505)@27
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel1_1_b <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_q(33 downto 0));

    -- redist37_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel1_1_b_1(DELAY,633)
    redist37_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel1_1_b_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel1_1_b, xout => redist37_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel1_1_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist2_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1(DELAY,598)
    redist2_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c, xout => redist2_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c(BITJOIN,506)@28
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q <= redist37_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel1_1_b_1_q & redist2_xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q;

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3(ADD,405)@28 + 1
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_cin <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p1_of_3_c;
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_a <= STD_LOGIC_VECTOR("0" & xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q) & '1';
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_b <= STD_LOGIC_VECTOR("0" & xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q) & xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_cin(0);
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_o <= STD_LOGIC_VECTOR(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_a) + UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_q <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_o(35 downto 1);

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3(ADD,416)@29 + 1
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_cin <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p1_of_3_c;
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_a <= STD_LOGIC_VECTOR("0" & xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_p2_of_3_q) & '1';
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_b <= STD_LOGIC_VECTOR("0" & redist5_xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q) & xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_cin(0);
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_o <= STD_LOGIC_VECTOR(UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_a) + UNSIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_q <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_o(35 downto 1);

    -- oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_0(BITSELECT,443)@30
    oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_0_b <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_p2_of_3_q(34 downto 1));

    -- oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_BitJoin_for_b(BITJOIN,445)@30
    oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_BitJoin_for_b_q <= oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b & oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_0_b;

    -- oneAndHalf_uid50_sqrt(CONSTANT,49)
    oneAndHalf_uid50_sqrt_q <= "11";

    -- padACst_uid51_sqrt(CONSTANT,50)
    padACst_uid51_sqrt_q <= "000000000000000000000000000000000";

    -- oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_a_BitJoin_for_b(BITJOIN,440)@30
    oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_a_BitJoin_for_b_q <= oneAndHalf_uid50_sqrt_q & padACst_uid51_sqrt_q;

    -- oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2(SUB,347)@30 + 1
    oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_a <= STD_LOGIC_VECTOR("0" & oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_a_BitJoin_for_b_q);
    oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_b <= STD_LOGIC_VECTOR("0" & oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_BitJoin_for_b_q);
    oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_a) - UNSIGNED(oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_c(0) <= oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_o(35);
    oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_q <= oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_o(34 downto 0);

    -- oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select(BITSELECT,588)
    oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b <= STD_LOGIC_VECTOR(zs_uid116_leadingZeros_uid7_sqrt_q(0 downto 0));
    oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c <= STD_LOGIC_VECTOR(zs_uid116_leadingZeros_uid7_sqrt_q(1 downto 1));

    -- oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2(SUB,348)@31 + 1
    oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_cin <= oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_c;
    oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_a <= STD_LOGIC_VECTOR("0" & GND_q) & '0';
    oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_b <= STD_LOGIC_VECTOR("0" & oneAndHalfSubXMIASFull_uid53_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c) & oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_cin(0);
    oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_a) - UNSIGNED(oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_q <= oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_o(1 downto 1);

    -- redist41_oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_q_1(DELAY,637)
    redist41_oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_q, xout => redist41_oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- oneAndHalfSubXMIASFull_uid53_sqrt_BitJoin_for_q(BITJOIN,349)@32
    oneAndHalfSubXMIASFull_uid53_sqrt_BitJoin_for_q_q <= oneAndHalfSubXMIASFull_uid53_sqrt_p2_of_2_q & redist41_oneAndHalfSubXMIASFull_uid53_sqrt_p1_of_2_q_1_q;

    -- oneAndHalfSubXMIAS_uid54_sqrt(BITSELECT,53)@32
    oneAndHalfSubXMIAS_uid54_sqrt_in <= oneAndHalfSubXMIASFull_uid53_sqrt_BitJoin_for_q_q(34 downto 0);
    oneAndHalfSubXMIAS_uid54_sqrt_b <= oneAndHalfSubXMIAS_uid54_sqrt_in(34 downto 0);

    -- resultFull_uid55_sqrt_bs2_merged_bit_select(BITSELECT,575)@32
    resultFull_uid55_sqrt_bs2_merged_bit_select_b <= oneAndHalfSubXMIAS_uid54_sqrt_b(26 downto 0);
    resultFull_uid55_sqrt_bs2_merged_bit_select_c <= oneAndHalfSubXMIAS_uid54_sqrt_b(34 downto 27);

    -- redist75_initApprox_uid44_sqrt_b_19_notEnable(LOGICAL,799)
    redist75_initApprox_uid44_sqrt_b_19_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist75_initApprox_uid44_sqrt_b_19_nor(LOGICAL,800)
    redist75_initApprox_uid44_sqrt_b_19_nor_q <= not (redist75_initApprox_uid44_sqrt_b_19_notEnable_q or redist75_initApprox_uid44_sqrt_b_19_sticky_ena_q);

    -- redist75_initApprox_uid44_sqrt_b_19_mem_last(CONSTANT,796)
    redist75_initApprox_uid44_sqrt_b_19_mem_last_q <= "01010";

    -- redist75_initApprox_uid44_sqrt_b_19_cmp(LOGICAL,797)
    redist75_initApprox_uid44_sqrt_b_19_cmp_b <= STD_LOGIC_VECTOR("0" & redist75_initApprox_uid44_sqrt_b_19_rdmux_q);
    redist75_initApprox_uid44_sqrt_b_19_cmp_q <= "1" WHEN redist75_initApprox_uid44_sqrt_b_19_mem_last_q = redist75_initApprox_uid44_sqrt_b_19_cmp_b ELSE "0";

    -- redist75_initApprox_uid44_sqrt_b_19_cmpReg(REG,798)
    redist75_initApprox_uid44_sqrt_b_19_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist75_initApprox_uid44_sqrt_b_19_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist75_initApprox_uid44_sqrt_b_19_cmpReg_q <= STD_LOGIC_VECTOR(redist75_initApprox_uid44_sqrt_b_19_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist75_initApprox_uid44_sqrt_b_19_sticky_ena(REG,801)
    redist75_initApprox_uid44_sqrt_b_19_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist75_initApprox_uid44_sqrt_b_19_sticky_ena_q <= "0";
            ELSE
                IF (redist75_initApprox_uid44_sqrt_b_19_nor_q = "1") THEN
                    redist75_initApprox_uid44_sqrt_b_19_sticky_ena_q <= STD_LOGIC_VECTOR(redist75_initApprox_uid44_sqrt_b_19_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist75_initApprox_uid44_sqrt_b_19_enaAnd(LOGICAL,802)
    redist75_initApprox_uid44_sqrt_b_19_enaAnd_q <= redist75_initApprox_uid44_sqrt_b_19_sticky_ena_q and en;

    -- redist75_initApprox_uid44_sqrt_b_19_rdcnt(COUNTER,793)
    -- low=0, high=11, step=1, init=0
    redist75_initApprox_uid44_sqrt_b_19_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist75_initApprox_uid44_sqrt_b_19_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist75_initApprox_uid44_sqrt_b_19_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist75_initApprox_uid44_sqrt_b_19_rdcnt_i = TO_UNSIGNED(10, 4)) THEN
                        redist75_initApprox_uid44_sqrt_b_19_rdcnt_eq <= '1';
                    ELSE
                        redist75_initApprox_uid44_sqrt_b_19_rdcnt_eq <= '0';
                    END IF;
                    IF (redist75_initApprox_uid44_sqrt_b_19_rdcnt_eq = '1') THEN
                        redist75_initApprox_uid44_sqrt_b_19_rdcnt_i <= redist75_initApprox_uid44_sqrt_b_19_rdcnt_i + 5;
                    ELSE
                        redist75_initApprox_uid44_sqrt_b_19_rdcnt_i <= redist75_initApprox_uid44_sqrt_b_19_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist75_initApprox_uid44_sqrt_b_19_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist75_initApprox_uid44_sqrt_b_19_rdcnt_i, 4)));

    -- redist75_initApprox_uid44_sqrt_b_19_rdmux(MUX,794)
    redist75_initApprox_uid44_sqrt_b_19_rdmux_s <= en;
    redist75_initApprox_uid44_sqrt_b_19_rdmux_combproc: PROCESS (redist75_initApprox_uid44_sqrt_b_19_rdmux_s, redist75_initApprox_uid44_sqrt_b_19_wraddr_q, redist75_initApprox_uid44_sqrt_b_19_rdcnt_q)
    BEGIN
        CASE (redist75_initApprox_uid44_sqrt_b_19_rdmux_s) IS
            WHEN "0" => redist75_initApprox_uid44_sqrt_b_19_rdmux_q <= redist75_initApprox_uid44_sqrt_b_19_wraddr_q;
            WHEN "1" => redist75_initApprox_uid44_sqrt_b_19_rdmux_q <= redist75_initApprox_uid44_sqrt_b_19_rdcnt_q;
            WHEN OTHERS => redist75_initApprox_uid44_sqrt_b_19_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist75_initApprox_uid44_sqrt_b_19_inputreg1(DELAY,787)
    redist75_initApprox_uid44_sqrt_b_19_inputreg1 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist74_initApprox_uid44_sqrt_b_1_q, xout => redist75_initApprox_uid44_sqrt_b_19_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist75_initApprox_uid44_sqrt_b_19_inputreg0(DELAY,789)
    redist75_initApprox_uid44_sqrt_b_19_inputreg0 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist75_initApprox_uid44_sqrt_b_19_inputreg1_q, xout => redist75_initApprox_uid44_sqrt_b_19_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist75_initApprox_uid44_sqrt_b_19_wraddr(REG,795)
    redist75_initApprox_uid44_sqrt_b_19_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist75_initApprox_uid44_sqrt_b_19_wraddr_q <= "1011";
            ELSE
                redist75_initApprox_uid44_sqrt_b_19_wraddr_q <= STD_LOGIC_VECTOR(redist75_initApprox_uid44_sqrt_b_19_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist75_initApprox_uid44_sqrt_b_19_mem(DUALMEM,792)
    redist75_initApprox_uid44_sqrt_b_19_mem_ia <= STD_LOGIC_VECTOR(redist75_initApprox_uid44_sqrt_b_19_inputreg0_q);
    redist75_initApprox_uid44_sqrt_b_19_mem_aa <= redist75_initApprox_uid44_sqrt_b_19_wraddr_q;
    redist75_initApprox_uid44_sqrt_b_19_mem_ab <= redist75_initApprox_uid44_sqrt_b_19_rdmux_q;
    redist75_initApprox_uid44_sqrt_b_19_mem_reset0 <= rst;
    redist75_initApprox_uid44_sqrt_b_19_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 20,
        widthad_a => 4,
        numwords_a => 12,
        width_b => 20,
        widthad_b => 4,
        numwords_b => 12,
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
        clocken1 => redist75_initApprox_uid44_sqrt_b_19_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist75_initApprox_uid44_sqrt_b_19_mem_reset0,
        clock1 => clk,
        address_a => redist75_initApprox_uid44_sqrt_b_19_mem_aa,
        data_a => redist75_initApprox_uid44_sqrt_b_19_mem_ia,
        wren_a => en(0),
        address_b => redist75_initApprox_uid44_sqrt_b_19_mem_ab,
        q_b => redist75_initApprox_uid44_sqrt_b_19_mem_iq
    );
    redist75_initApprox_uid44_sqrt_b_19_mem_q <= redist75_initApprox_uid44_sqrt_b_19_mem_iq(19 downto 0);
    redist75_initApprox_uid44_sqrt_b_19_mem_enaOr_rst <= redist75_initApprox_uid44_sqrt_b_19_enaAnd_q(0) or redist75_initApprox_uid44_sqrt_b_19_mem_reset0;

    -- redist75_initApprox_uid44_sqrt_b_19_outputreg0(DELAY,791)
    redist75_initApprox_uid44_sqrt_b_19_outputreg0 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist75_initApprox_uid44_sqrt_b_19_mem_q, xout => redist75_initApprox_uid44_sqrt_b_19_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist75_initApprox_uid44_sqrt_b_19_outputreg1(DELAY,790)
    redist75_initApprox_uid44_sqrt_b_19_outputreg1 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist75_initApprox_uid44_sqrt_b_19_outputreg0_q, xout => redist75_initApprox_uid44_sqrt_b_19_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist75_initApprox_uid44_sqrt_b_19_outputreg2(DELAY,788)
    redist75_initApprox_uid44_sqrt_b_19_outputreg2 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist75_initApprox_uid44_sqrt_b_19_outputreg1_q, xout => redist75_initApprox_uid44_sqrt_b_19_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- resultFull_uid55_sqrt_im3_cma(CHAINMULTADD,568)@32 + 5
    -- out q@38
    resultFull_uid55_sqrt_im3_cma_reset <= rst;
    resultFull_uid55_sqrt_im3_cma_ena0 <= en(0) or resultFull_uid55_sqrt_im3_cma_reset;
    resultFull_uid55_sqrt_im3_cma_ena1 <= resultFull_uid55_sqrt_im3_cma_ena0;
    resultFull_uid55_sqrt_im3_cma_ena2 <= resultFull_uid55_sqrt_im3_cma_ena0;
    resultFull_uid55_sqrt_im3_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    resultFull_uid55_sqrt_im3_cma_ah(0) <= RESIZE(UNSIGNED(redist75_initApprox_uid44_sqrt_b_19_outputreg2_q),20);
                    resultFull_uid55_sqrt_im3_cma_ch(0) <= RESIZE(UNSIGNED(resultFull_uid55_sqrt_bs2_merged_bit_select_c),8);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    resultFull_uid55_sqrt_im3_cma_a0 <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_im3_cma_ah(0));
    resultFull_uid55_sqrt_im3_cma_c0 <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_im3_cma_ch(0));
    resultFull_uid55_sqrt_im3_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 20,
        ax_clock => "0",
        ax_width => 8,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 28
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => resultFull_uid55_sqrt_im3_cma_ena0,
        ena(1) => resultFull_uid55_sqrt_im3_cma_ena1,
        ena(2) => resultFull_uid55_sqrt_im3_cma_ena2,
        clr(0) => resultFull_uid55_sqrt_im3_cma_reset,
        clr(1) => resultFull_uid55_sqrt_im3_cma_reset,
        ay => resultFull_uid55_sqrt_im3_cma_a0,
        ax => resultFull_uid55_sqrt_im3_cma_c0,
        resulta => resultFull_uid55_sqrt_im3_cma_s0
    );
    resultFull_uid55_sqrt_im3_cma_delay : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFull_uid55_sqrt_im3_cma_s0, xout => resultFull_uid55_sqrt_im3_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultFull_uid55_sqrt_im3_cma_q <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_im3_cma_qq(27 downto 0));

    -- redist19_resultFull_uid55_sqrt_im3_cma_q_1(DELAY,615)
    redist19_resultFull_uid55_sqrt_im3_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFull_uid55_sqrt_im3_cma_q, xout => redist19_resultFull_uid55_sqrt_im3_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultFull_uid55_sqrt_align_7(BITSHIFT,255)@39
    resultFull_uid55_sqrt_align_7_qint <= redist19_resultFull_uid55_sqrt_im3_cma_q_1_q & "000000000000000000000000000";
    resultFull_uid55_sqrt_align_7_q <= resultFull_uid55_sqrt_align_7_qint(54 downto 0);

    -- resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select(BITSELECT,587)@39
    resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_align_7_q(34 downto 0));
    resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_align_7_q(54 downto 35));

    -- resultFull_uid55_sqrt_im0_cma(CHAINMULTADD,567)@32 + 5
    -- out q@38
    resultFull_uid55_sqrt_im0_cma_reset <= rst;
    resultFull_uid55_sqrt_im0_cma_ena0 <= en(0) or resultFull_uid55_sqrt_im0_cma_reset;
    resultFull_uid55_sqrt_im0_cma_ena1 <= resultFull_uid55_sqrt_im0_cma_ena0;
    resultFull_uid55_sqrt_im0_cma_ena2 <= resultFull_uid55_sqrt_im0_cma_ena0;
    resultFull_uid55_sqrt_im0_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    resultFull_uid55_sqrt_im0_cma_ah(0) <= RESIZE(UNSIGNED(resultFull_uid55_sqrt_bs2_merged_bit_select_b),27);
                    resultFull_uid55_sqrt_im0_cma_ch(0) <= RESIZE(UNSIGNED(redist75_initApprox_uid44_sqrt_b_19_outputreg2_q),20);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    resultFull_uid55_sqrt_im0_cma_a0 <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_im0_cma_ah(0));
    resultFull_uid55_sqrt_im0_cma_c0 <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_im0_cma_ch(0));
    resultFull_uid55_sqrt_im0_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 27,
        ax_clock => "0",
        ax_width => 20,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 47
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => resultFull_uid55_sqrt_im0_cma_ena0,
        ena(1) => resultFull_uid55_sqrt_im0_cma_ena1,
        ena(2) => resultFull_uid55_sqrt_im0_cma_ena2,
        clr(0) => resultFull_uid55_sqrt_im0_cma_reset,
        clr(1) => resultFull_uid55_sqrt_im0_cma_reset,
        ay => resultFull_uid55_sqrt_im0_cma_a0,
        ax => resultFull_uid55_sqrt_im0_cma_c0,
        resulta => resultFull_uid55_sqrt_im0_cma_s0
    );
    resultFull_uid55_sqrt_im0_cma_delay : dspba_delay
    GENERIC MAP ( width => 47, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFull_uid55_sqrt_im0_cma_s0, xout => resultFull_uid55_sqrt_im0_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultFull_uid55_sqrt_im0_cma_q <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_im0_cma_qq(46 downto 0));

    -- redist20_resultFull_uid55_sqrt_im0_cma_q_1(DELAY,616)
    redist20_resultFull_uid55_sqrt_im0_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 47, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFull_uid55_sqrt_im0_cma_q, xout => redist20_resultFull_uid55_sqrt_im0_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select(BITSELECT,594)@39
    resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(redist20_resultFull_uid55_sqrt_im0_cma_q_1_q(34 downto 0));
    resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(redist20_resultFull_uid55_sqrt_im0_cma_q_1_q(46 downto 35));

    -- resultFull_uid55_sqrt_result_add_0_0_p1_of_2(ADD,425)@39 + 1
    resultFull_uid55_sqrt_result_add_0_0_p1_of_2_a <= STD_LOGIC_VECTOR("0" & resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b);
    resultFull_uid55_sqrt_result_add_0_0_p1_of_2_b <= STD_LOGIC_VECTOR("0" & resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_b);
    resultFull_uid55_sqrt_result_add_0_0_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                resultFull_uid55_sqrt_result_add_0_0_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    resultFull_uid55_sqrt_result_add_0_0_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(resultFull_uid55_sqrt_result_add_0_0_p1_of_2_a) + UNSIGNED(resultFull_uid55_sqrt_result_add_0_0_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    resultFull_uid55_sqrt_result_add_0_0_p1_of_2_c(0) <= resultFull_uid55_sqrt_result_add_0_0_p1_of_2_o(35);
    resultFull_uid55_sqrt_result_add_0_0_p1_of_2_q <= resultFull_uid55_sqrt_result_add_0_0_p1_of_2_o(34 downto 0);

    -- redist4_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1(DELAY,600)
    redist4_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c, xout => redist4_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c(BITJOIN,540)@40
    resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q <= GND_q & redist4_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q;

    -- resultFull_uid55_sqrt_result_add_0_0_UpperBits_for_a(CONSTANT,420)
    resultFull_uid55_sqrt_result_add_0_0_UpperBits_for_a_q <= "000000000";

    -- redist1_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1(DELAY,597)
    redist1_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c, xout => redist1_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c(BITJOIN,535)@40
    resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q <= resultFull_uid55_sqrt_result_add_0_0_UpperBits_for_a_q & redist1_resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q;

    -- resultFull_uid55_sqrt_result_add_0_0_p2_of_2(ADD,426)@40 + 1
    resultFull_uid55_sqrt_result_add_0_0_p2_of_2_cin <= resultFull_uid55_sqrt_result_add_0_0_p1_of_2_c;
    resultFull_uid55_sqrt_result_add_0_0_p2_of_2_a <= STD_LOGIC_VECTOR("0" & resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q) & '1';
    resultFull_uid55_sqrt_result_add_0_0_p2_of_2_b <= STD_LOGIC_VECTOR("0" & resultFull_uid55_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q) & resultFull_uid55_sqrt_result_add_0_0_p2_of_2_cin(0);
    resultFull_uid55_sqrt_result_add_0_0_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                resultFull_uid55_sqrt_result_add_0_0_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    resultFull_uid55_sqrt_result_add_0_0_p2_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(resultFull_uid55_sqrt_result_add_0_0_p2_of_2_a) + UNSIGNED(resultFull_uid55_sqrt_result_add_0_0_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    resultFull_uid55_sqrt_result_add_0_0_p2_of_2_q <= resultFull_uid55_sqrt_result_add_0_0_p2_of_2_o(21 downto 1);

    -- redist39_resultFull_uid55_sqrt_result_add_0_0_p1_of_2_q_1(DELAY,635)
    redist39_resultFull_uid55_sqrt_result_add_0_0_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFull_uid55_sqrt_result_add_0_0_p1_of_2_q, xout => redist39_resultFull_uid55_sqrt_result_add_0_0_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultFull_uid55_sqrt_result_add_0_0_BitJoin_for_q(BITJOIN,427)@41
    resultFull_uid55_sqrt_result_add_0_0_BitJoin_for_q_q <= resultFull_uid55_sqrt_result_add_0_0_p2_of_2_q & redist39_resultFull_uid55_sqrt_result_add_0_0_p1_of_2_q_1_q;

    -- resultPreMultX_uid56_sqrt(BITSELECT,55)@41
    resultPreMultX_uid56_sqrt_in <= resultFull_uid55_sqrt_result_add_0_0_BitJoin_for_q_q(53 downto 0);
    resultPreMultX_uid56_sqrt_b <= resultPreMultX_uid56_sqrt_in(53 downto 20);

    -- resultMultFull_uid57_sqrt_bs4(BITSELECT,262)@41
    resultMultFull_uid57_sqrt_bs4_b <= STD_LOGIC_VECTOR(resultPreMultX_uid56_sqrt_b(33 downto 18));

    -- resultMultFull_uid57_sqrt_bjA5(BITJOIN,263)@41
    resultMultFull_uid57_sqrt_bjA5_q <= GND_q & resultMultFull_uid57_sqrt_bs4_b;

    -- resultMultFull_uid57_sqrt_bs8(BITSELECT,266)@41
    resultMultFull_uid57_sqrt_bs8_in <= STD_LOGIC_VECTOR(resultPreMultX_uid56_sqrt_b(17 downto 0));
    resultMultFull_uid57_sqrt_bs8_b <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_bs8_in(17 downto 0));

    -- resultMultFull_uid57_sqrt_bjA9(BITJOIN,267)@41
    resultMultFull_uid57_sqrt_bjA9_q <= GND_q & resultMultFull_uid57_sqrt_bs8_b;

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_notEnable(LOGICAL,709)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_nor(LOGICAL,710)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_nor_q <= not (redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_notEnable_q or redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_sticky_ena_q);

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_last(CONSTANT,706)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_last_q <= "01100";

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmp(LOGICAL,707)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmp_b <= STD_LOGIC_VECTOR("0" & redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_q);
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmp_q <= "1" WHEN redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_last_q = redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmp_b ELSE "0";

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmpReg(REG,708)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmpReg_q <= STD_LOGIC_VECTOR(redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_sticky_ena(REG,711)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_sticky_ena_q <= "0";
            ELSE
                IF (redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_nor_q = "1") THEN
                    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_sticky_ena_q <= STD_LOGIC_VECTOR(redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_enaAnd(LOGICAL,712)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_enaAnd_q <= redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_sticky_ena_q and en;

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt(COUNTER,703)
    -- low=0, high=13, step=1, init=0
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_i = TO_UNSIGNED(12, 4)) THEN
                        redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_eq <= '1';
                    ELSE
                        redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_eq <= '0';
                    END IF;
                    IF (redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_eq = '1') THEN
                        redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_i <= redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_i + 3;
                    ELSE
                        redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_i <= redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_i, 4)));

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux(MUX,704)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_s <= en;
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_combproc: PROCESS (redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_s, redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_wraddr_q, redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_q)
    BEGIN
        CASE (redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_s) IS
            WHEN "0" => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_q <= redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_wraddr_q;
            WHEN "1" => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_q <= redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdcnt_q;
            WHEN OTHERS => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg1(DELAY,697)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg1 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q, xout => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg0(DELAY,699)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg0 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg1_q, xout => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_wraddr(REG,705)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_wraddr_q <= "1101";
            ELSE
                redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_wraddr_q <= STD_LOGIC_VECTOR(redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem(DUALMEM,702)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_ia <= STD_LOGIC_VECTOR(redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_inputreg0_q);
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_aa <= redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_wraddr_q;
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_ab <= redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_rdmux_q;
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_reset0 <= rst;
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 15,
        widthad_a => 4,
        numwords_a => 14,
        width_b => 15,
        widthad_b => 4,
        numwords_b => 14,
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
        clocken1 => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_reset0,
        clock1 => clk,
        address_a => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_aa,
        data_a => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_ia,
        wren_a => en(0),
        address_b => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_ab,
        q_b => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_iq
    );
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_q <= redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_iq(14 downto 0);
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_enaOr_rst <= redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_enaAnd_q(0) or redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_reset0;

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg0(DELAY,701)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg0 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_mem_q, xout => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg1(DELAY,700)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg1 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg0_q, xout => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg2(DELAY,698)
    redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg2 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg1_q, xout => redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_ma3_cma(CHAINMULTADD,573)@41 + 5
    -- out q@47
    resultMultFull_uid57_sqrt_ma3_cma_reset <= rst;
    resultMultFull_uid57_sqrt_ma3_cma_ena0 <= en(0) or resultMultFull_uid57_sqrt_ma3_cma_reset;
    resultMultFull_uid57_sqrt_ma3_cma_ena1 <= resultMultFull_uid57_sqrt_ma3_cma_ena0;
    resultMultFull_uid57_sqrt_ma3_cma_ena2 <= resultMultFull_uid57_sqrt_ma3_cma_ena0;
    resultMultFull_uid57_sqrt_ma3_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    resultMultFull_uid57_sqrt_ma3_cma_ah(0) <= RESIZE(SIGNED(redist49_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_20_outputreg2_q),17);
                    resultMultFull_uid57_sqrt_ma3_cma_ah(1) <= RESIZE(SIGNED(resultMultFull_uid57_sqrt_bjA5_q),17);
                    resultMultFull_uid57_sqrt_ma3_cma_ch(0) <= RESIZE(SIGNED(resultMultFull_uid57_sqrt_bjA9_q),19);
                    resultMultFull_uid57_sqrt_ma3_cma_ch(1) <= RESIZE(SIGNED(redist46_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_20_outputreg2_q),19);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    resultMultFull_uid57_sqrt_ma3_cma_a0 <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_ma3_cma_ah(0));
    resultMultFull_uid57_sqrt_ma3_cma_c0 <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_ma3_cma_ch(0));
    resultMultFull_uid57_sqrt_ma3_cma_a1 <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_ma3_cma_ah(1));
    resultMultFull_uid57_sqrt_ma3_cma_c1 <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_ma3_cma_ch(1));
    resultMultFull_uid57_sqrt_ma3_cma_DSP0 : fourteennm_mac
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
        ax_width => 17,
        bx_width => 17,
        signed_may => "true",
        signed_mby => "true",
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
        ena(0) => resultMultFull_uid57_sqrt_ma3_cma_ena0,
        ena(1) => resultMultFull_uid57_sqrt_ma3_cma_ena1,
        ena(2) => resultMultFull_uid57_sqrt_ma3_cma_ena2,
        clr(0) => resultMultFull_uid57_sqrt_ma3_cma_reset,
        clr(1) => resultMultFull_uid57_sqrt_ma3_cma_reset,
        ay => resultMultFull_uid57_sqrt_ma3_cma_c1,
        by => resultMultFull_uid57_sqrt_ma3_cma_c0,
        ax => resultMultFull_uid57_sqrt_ma3_cma_a1,
        bx => resultMultFull_uid57_sqrt_ma3_cma_a0,
        resulta => resultMultFull_uid57_sqrt_ma3_cma_s0
    );
    resultMultFull_uid57_sqrt_ma3_cma_delay : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_ma3_cma_s0, xout => resultMultFull_uid57_sqrt_ma3_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultMultFull_uid57_sqrt_ma3_cma_q <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_ma3_cma_qq(36 downto 0));

    -- redist15_resultMultFull_uid57_sqrt_ma3_cma_q_1(DELAY,611)
    redist15_resultMultFull_uid57_sqrt_ma3_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_ma3_cma_q, xout => redist15_resultMultFull_uid57_sqrt_ma3_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_align_16(BITSHIFT,274)@48
    resultMultFull_uid57_sqrt_align_16_qint <= redist15_resultMultFull_uid57_sqrt_ma3_cma_q_1_q & "000000000000000000";
    resultMultFull_uid57_sqrt_align_16_q <= resultMultFull_uid57_sqrt_align_16_qint(54 downto 0);

    -- resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0(BITSELECT,547)@48
    resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_b <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_align_16_q(34 downto 0));

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_notEnable(LOGICAL,742)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_nor(LOGICAL,743)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_nor_q <= not (redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_notEnable_q or redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_sticky_ena_q);

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_last(CONSTANT,739)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_last_q <= "01100";

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmp(LOGICAL,740)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmp_b <= STD_LOGIC_VECTOR("0" & redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_q);
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmp_q <= "1" WHEN redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_last_q = redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmp_b ELSE "0";

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmpReg(REG,741)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmpReg_q <= STD_LOGIC_VECTOR(redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_sticky_ena(REG,744)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_sticky_ena_q <= "0";
            ELSE
                IF (redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_nor_q = "1") THEN
                    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_sticky_ena_q <= STD_LOGIC_VECTOR(redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_enaAnd(LOGICAL,745)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_enaAnd_q <= redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_sticky_ena_q and en;

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt(COUNTER,736)
    -- low=0, high=13, step=1, init=0
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_i = TO_UNSIGNED(12, 4)) THEN
                        redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_eq <= '1';
                    ELSE
                        redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_eq <= '0';
                    END IF;
                    IF (redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_eq = '1') THEN
                        redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_i <= redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_i + 3;
                    ELSE
                        redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_i <= redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_i, 4)));

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux(MUX,737)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_s <= en;
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_combproc: PROCESS (redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_s, redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_wraddr_q, redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_q)
    BEGIN
        CASE (redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_s) IS
            WHEN "0" => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_q <= redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_wraddr_q;
            WHEN "1" => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_q <= redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdcnt_q;
            WHEN OTHERS => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg2(DELAY,729)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg2 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs1_b, xout => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg1(DELAY,731)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg2_q, xout => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg0(DELAY,733)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg0 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg1_q, xout => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_wraddr(REG,738)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_wraddr_q <= "1101";
            ELSE
                redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_wraddr_q <= STD_LOGIC_VECTOR(redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem(DUALMEM,735)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_ia <= STD_LOGIC_VECTOR(redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_inputreg0_q);
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_aa <= redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_wraddr_q;
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_ab <= redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_rdmux_q;
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_reset0 <= rst;
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 18,
        widthad_a => 4,
        numwords_a => 14,
        width_b => 18,
        widthad_b => 4,
        numwords_b => 14,
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
        clocken1 => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_reset0,
        clock1 => clk,
        address_a => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_aa,
        data_a => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_ia,
        wren_a => en(0),
        address_b => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_ab,
        q_b => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_iq
    );
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_q <= redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_iq(17 downto 0);
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_enaOr_rst <= redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_enaAnd_q(0) or redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_reset0;

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg0(DELAY,734)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg0 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_mem_q, xout => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg1(DELAY,732)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg0_q, xout => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg2(DELAY,730)
    redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg2 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg1_q, xout => redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_bs1(BITSELECT,259)@41
    resultMultFull_uid57_sqrt_bs1_in <= resultPreMultX_uid56_sqrt_b(17 downto 0);
    resultMultFull_uid57_sqrt_bs1_b <= resultMultFull_uid57_sqrt_bs1_in(17 downto 0);

    -- resultMultFull_uid57_sqrt_im0_cma(CHAINMULTADD,569)@41 + 5
    -- out q@47
    resultMultFull_uid57_sqrt_im0_cma_reset <= rst;
    resultMultFull_uid57_sqrt_im0_cma_ena0 <= en(0) or resultMultFull_uid57_sqrt_im0_cma_reset;
    resultMultFull_uid57_sqrt_im0_cma_ena1 <= resultMultFull_uid57_sqrt_im0_cma_ena0;
    resultMultFull_uid57_sqrt_im0_cma_ena2 <= resultMultFull_uid57_sqrt_im0_cma_ena0;
    resultMultFull_uid57_sqrt_im0_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    resultMultFull_uid57_sqrt_im0_cma_ah(0) <= RESIZE(UNSIGNED(resultMultFull_uid57_sqrt_bs1_b),18);
                    resultMultFull_uid57_sqrt_im0_cma_ch(0) <= RESIZE(UNSIGNED(redist54_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_21_outputreg2_q),18);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    resultMultFull_uid57_sqrt_im0_cma_a0 <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_im0_cma_ah(0));
    resultMultFull_uid57_sqrt_im0_cma_c0 <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_im0_cma_ch(0));
    resultMultFull_uid57_sqrt_im0_cma_DSP0 : fourteennm_mac
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
        ena(0) => resultMultFull_uid57_sqrt_im0_cma_ena0,
        ena(1) => resultMultFull_uid57_sqrt_im0_cma_ena1,
        ena(2) => resultMultFull_uid57_sqrt_im0_cma_ena2,
        clr(0) => resultMultFull_uid57_sqrt_im0_cma_reset,
        clr(1) => resultMultFull_uid57_sqrt_im0_cma_reset,
        ay => resultMultFull_uid57_sqrt_im0_cma_a0,
        ax => resultMultFull_uid57_sqrt_im0_cma_c0,
        resulta => resultMultFull_uid57_sqrt_im0_cma_s0
    );
    resultMultFull_uid57_sqrt_im0_cma_delay : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_im0_cma_s0, xout => resultMultFull_uid57_sqrt_im0_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultMultFull_uid57_sqrt_im0_cma_q <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_im0_cma_qq(35 downto 0));

    -- redist18_resultMultFull_uid57_sqrt_im0_cma_q_1(DELAY,614)
    redist18_resultMultFull_uid57_sqrt_im0_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_im0_cma_q, xout => redist18_resultMultFull_uid57_sqrt_im0_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select(BITSELECT,595)@48
    resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(redist18_resultMultFull_uid57_sqrt_im0_cma_q_1_q(34 downto 0));
    resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(redist18_resultMultFull_uid57_sqrt_im0_cma_q_1_q(35 downto 35));

    -- resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2(ADD,435)@48 + 1
    resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_a <= STD_LOGIC_VECTOR("0" & resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_b);
    resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_b <= STD_LOGIC_VECTOR("0" & resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel0_0_b);
    resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_a) + UNSIGNED(resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_c(0) <= resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_o(35);
    resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_q <= resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_o(34 downto 0);

    -- resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_1(BITSELECT,550)@48
    resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_1_b <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_align_16_q(54 downto 54));

    -- redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1(DELAY,619)
    redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_1_b, xout => redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_0(BITSELECT,549)@48
    resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_0_b <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_align_16_q(54 downto 35));

    -- redist36_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_0_b_1(DELAY,632)
    redist36_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_0_b_1 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_0_b, xout => redist36_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_0_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c(BITJOIN,563)@49
    resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q <= redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist23_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_13_b_1_q & redist36_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_tessel1_0_b_1_q;

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_notEnable(LOGICAL,725)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_nor(LOGICAL,726)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_nor_q <= not (redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_notEnable_q or redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_sticky_ena_q);

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_last(CONSTANT,722)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_last_q <= "01101";

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmp(LOGICAL,723)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmp_b <= STD_LOGIC_VECTOR("0" & redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_q);
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmp_q <= "1" WHEN redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_last_q = redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmp_b ELSE "0";

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmpReg(REG,724)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmpReg_q <= STD_LOGIC_VECTOR(redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_sticky_ena(REG,727)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_sticky_ena_q <= "0";
            ELSE
                IF (redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_nor_q = "1") THEN
                    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_sticky_ena_q <= STD_LOGIC_VECTOR(redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_enaAnd(LOGICAL,728)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_enaAnd_q <= redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_sticky_ena_q and en;

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt(COUNTER,719)
    -- low=0, high=14, step=1, init=0
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_i = TO_UNSIGNED(13, 4)) THEN
                        redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_eq <= '1';
                    ELSE
                        redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_eq <= '0';
                    END IF;
                    IF (redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_eq = '1') THEN
                        redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_i <= redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_i + 2;
                    ELSE
                        redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_i <= redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_i, 4)));

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux(MUX,720)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_s <= en;
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_combproc: PROCESS (redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_s, redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_wraddr_q, redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_q)
    BEGIN
        CASE (redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_s) IS
            WHEN "0" => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_q <= redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_wraddr_q;
            WHEN "1" => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_q <= redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdcnt_q;
            WHEN OTHERS => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg1(DELAY,713)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist52_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1_q, xout => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg0(DELAY,715)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg0 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg1_q, xout => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_wraddr(REG,721)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_wraddr_q <= "1110";
            ELSE
                redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_wraddr_q <= STD_LOGIC_VECTOR(redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem(DUALMEM,718)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_ia <= STD_LOGIC_VECTOR(redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_inputreg0_q);
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_aa <= redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_wraddr_q;
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_ab <= redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_rdmux_q;
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_reset0 <= rst;
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 14,
        widthad_a => 4,
        numwords_a => 15,
        width_b => 14,
        widthad_b => 4,
        numwords_b => 15,
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
        clocken1 => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_reset0,
        clock1 => clk,
        address_a => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_aa,
        data_a => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_ia,
        wren_a => en(0),
        address_b => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_ab,
        q_b => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_iq
    );
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_q <= redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_iq(13 downto 0);
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_enaOr_rst <= redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_enaAnd_q(0) or redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_reset0;

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg0(DELAY,717)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg0 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_mem_q, xout => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg1(DELAY,716)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg0_q, xout => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg2(DELAY,714)
    redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg2 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg1_q, xout => redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg2_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_bs13(BITSELECT,271)@41
    resultMultFull_uid57_sqrt_bs13_b <= resultPreMultX_uid56_sqrt_b(33 downto 18);

    -- redist44_resultMultFull_uid57_sqrt_bs13_b_1(DELAY,640)
    redist44_resultMultFull_uid57_sqrt_bs13_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_bs13_b, xout => redist44_resultMultFull_uid57_sqrt_bs13_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_im12_cma(CHAINMULTADD,570)@42 + 5
    -- out q@48
    resultMultFull_uid57_sqrt_im12_cma_reset <= rst;
    resultMultFull_uid57_sqrt_im12_cma_ena0 <= en(0) or resultMultFull_uid57_sqrt_im12_cma_reset;
    resultMultFull_uid57_sqrt_im12_cma_ena1 <= resultMultFull_uid57_sqrt_im12_cma_ena0;
    resultMultFull_uid57_sqrt_im12_cma_ena2 <= resultMultFull_uid57_sqrt_im12_cma_ena0;
    resultMultFull_uid57_sqrt_im12_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                IF (en = "1") THEN
                    resultMultFull_uid57_sqrt_im12_cma_ah(0) <= RESIZE(UNSIGNED(redist44_resultMultFull_uid57_sqrt_bs13_b_1_q),16);
                    resultMultFull_uid57_sqrt_im12_cma_ch(0) <= RESIZE(UNSIGNED(redist53_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_22_outputreg2_q),14);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    resultMultFull_uid57_sqrt_im12_cma_a0 <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_im12_cma_ah(0));
    resultMultFull_uid57_sqrt_im12_cma_c0 <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_im12_cma_ch(0));
    resultMultFull_uid57_sqrt_im12_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 16,
        ax_clock => "0",
        ax_width => 14,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 30,
        bx_width => 1,
        by_width => 1,
        result_b_width => 1
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => resultMultFull_uid57_sqrt_im12_cma_ena0,
        ena(1) => resultMultFull_uid57_sqrt_im12_cma_ena1,
        ena(2) => resultMultFull_uid57_sqrt_im12_cma_ena2,
        clr(0) => resultMultFull_uid57_sqrt_im12_cma_reset,
        clr(1) => resultMultFull_uid57_sqrt_im12_cma_reset,
        ay => resultMultFull_uid57_sqrt_im12_cma_a0,
        ax => resultMultFull_uid57_sqrt_im12_cma_c0,
        resulta => resultMultFull_uid57_sqrt_im12_cma_s0
    );
    resultMultFull_uid57_sqrt_im12_cma_delay : dspba_delay
    GENERIC MAP ( width => 30, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_im12_cma_s0, xout => resultMultFull_uid57_sqrt_im12_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultMultFull_uid57_sqrt_im12_cma_q <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_im12_cma_qq(29 downto 0));

    -- redist17_resultMultFull_uid57_sqrt_im12_cma_q_1(DELAY,613)
    redist17_resultMultFull_uid57_sqrt_im12_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 30, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_im12_cma_q, xout => redist17_resultMultFull_uid57_sqrt_im12_cma_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist0_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1(DELAY,596)
    redist0_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c, xout => redist0_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c(BITJOIN,546)@49
    resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q <= zs_uid116_leadingZeros_uid7_sqrt_q & redist17_resultMultFull_uid57_sqrt_im12_cma_q_1_q & redist0_resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q;

    -- resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2(ADD,436)@49 + 1
    resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_cin <= resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_c;
    resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_a_BitJoin_for_c_q) & '1');
    resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q(32)) & resultMultFull_uid57_sqrt_result_add_0_0_BitSelect_for_b_BitJoin_for_c_q) & resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_cin(0));
    resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_o <= STD_LOGIC_VECTOR(SIGNED(resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_a) + SIGNED(resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_q <= resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_o(33 downto 1);

    -- redist38_resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_q_1(DELAY,634)
    redist38_resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_q, xout => redist38_resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_result_add_0_0_BitJoin_for_q(BITJOIN,437)@50
    resultMultFull_uid57_sqrt_result_add_0_0_BitJoin_for_q_q <= resultMultFull_uid57_sqrt_result_add_0_0_p2_of_2_q & redist38_resultMultFull_uid57_sqrt_result_add_0_0_p1_of_2_q_1_q;

    -- result_uid58_sqrt(BITSELECT,57)@50
    result_uid58_sqrt_in <= resultMultFull_uid57_sqrt_result_add_0_0_BitJoin_for_q_q(64 downto 0);
    result_uid58_sqrt_b <= result_uid58_sqrt_in(64 downto 31);

    -- redist71_result_uid58_sqrt_b_1(DELAY,667)
    redist71_result_uid58_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => result_uid58_sqrt_b, xout => redist71_result_uid58_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist72_result_uid58_sqrt_b_6_wraddr(REG,779)
    redist72_result_uid58_sqrt_b_6_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist72_result_uid58_sqrt_b_6_wraddr_q <= "11";
            ELSE
                redist72_result_uid58_sqrt_b_6_wraddr_q <= STD_LOGIC_VECTOR(redist72_result_uid58_sqrt_b_6_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist72_result_uid58_sqrt_b_6_mem(DUALMEM,776)
    redist72_result_uid58_sqrt_b_6_mem_ia <= STD_LOGIC_VECTOR(redist71_result_uid58_sqrt_b_1_q);
    redist72_result_uid58_sqrt_b_6_mem_aa <= redist72_result_uid58_sqrt_b_6_wraddr_q;
    redist72_result_uid58_sqrt_b_6_mem_ab <= redist72_result_uid58_sqrt_b_6_rdmux_q;
    redist72_result_uid58_sqrt_b_6_mem_reset0 <= rst;
    redist72_result_uid58_sqrt_b_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 34,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 34,
        widthad_b => 2,
        numwords_b => 4,
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
        clocken1 => redist72_result_uid58_sqrt_b_6_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist72_result_uid58_sqrt_b_6_mem_reset0,
        clock1 => clk,
        address_a => redist72_result_uid58_sqrt_b_6_mem_aa,
        data_a => redist72_result_uid58_sqrt_b_6_mem_ia,
        wren_a => en(0),
        address_b => redist72_result_uid58_sqrt_b_6_mem_ab,
        q_b => redist72_result_uid58_sqrt_b_6_mem_iq
    );
    redist72_result_uid58_sqrt_b_6_mem_q <= redist72_result_uid58_sqrt_b_6_mem_iq(33 downto 0);
    redist72_result_uid58_sqrt_b_6_mem_enaOr_rst <= redist72_result_uid58_sqrt_b_6_enaAnd_q(0) or redist72_result_uid58_sqrt_b_6_mem_reset0;

    -- invNegShiftEven_uid61_sqrt(BITSELECT,60)@56
    invNegShiftEven_uid61_sqrt_b <= STD_LOGIC_VECTOR(redist72_result_uid58_sqrt_b_6_mem_q(33 downto 33));

    -- negShiftEven_uid62_sqrt(LOGICAL,61)@56
    negShiftEven_uid62_sqrt_q <= not (invNegShiftEven_uid61_sqrt_b);

    -- parityOddOriginal_uid12_sqrt(BITSELECT,11)@54
    parityOddOriginal_uid12_sqrt_in <= STD_LOGIC_VECTOR(redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_q(0 downto 0));
    parityOddOriginal_uid12_sqrt_b <= STD_LOGIC_VECTOR(parityOddOriginal_uid12_sqrt_in(0 downto 0));

    -- redist81_parityOddOriginal_uid12_sqrt_b_2(DELAY,677)
    redist81_parityOddOriginal_uid12_sqrt_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => parityOddOriginal_uid12_sqrt_b, xout => redist81_parityOddOriginal_uid12_sqrt_b_2_q, ena => en(0), clk => clk, aclr => rst );

    -- EvenBranchAndNegUpdate_uid66_sqrt(LOGICAL,65)@56 + 1
    EvenBranchAndNegUpdate_uid66_sqrt_qi <= redist81_parityOddOriginal_uid12_sqrt_b_2_q and negShiftEven_uid62_sqrt_q;
    EvenBranchAndNegUpdate_uid66_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => EvenBranchAndNegUpdate_uid66_sqrt_qi, xout => EvenBranchAndNegUpdate_uid66_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- maxValInOutFormat_uid147_finalMult_uid59_sqrt(CONSTANT,146)
    maxValInOutFormat_uid147_finalMult_uid59_sqrt_q <= "1111111111111111111111111111111111";

    -- minValueInFormat_uid148_finalMult_uid59_sqrt(CONSTANT,147)
    minValueInFormat_uid148_finalMult_uid59_sqrt_q <= "0000000000000000000000000000000000";

    -- xv0_uid127_finalMult_uid59_sqrt(BITSELECT,126)@51
    xv0_uid127_finalMult_uid59_sqrt_in <= redist71_result_uid58_sqrt_b_1_q(5 downto 0);
    xv0_uid127_finalMult_uid59_sqrt_b <= xv0_uid127_finalMult_uid59_sqrt_in(5 downto 0);

    -- p0_uid138_finalMult_uid59_sqrt(LOOKUP,137)@51 + 1
    p0_uid138_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                p0_uid138_finalMult_uid59_sqrt_q <= "0000000000";
            ELSE
                IF (en = "1") THEN
                    CASE (xv0_uid127_finalMult_uid59_sqrt_b) IS
                        WHEN "000000" => p0_uid138_finalMult_uid59_sqrt_q <= "0000000000";
                        WHEN "000001" => p0_uid138_finalMult_uid59_sqrt_q <= "0000001011";
                        WHEN "000010" => p0_uid138_finalMult_uid59_sqrt_q <= "0000010110";
                        WHEN "000011" => p0_uid138_finalMult_uid59_sqrt_q <= "0000100001";
                        WHEN "000100" => p0_uid138_finalMult_uid59_sqrt_q <= "0000101101";
                        WHEN "000101" => p0_uid138_finalMult_uid59_sqrt_q <= "0000111000";
                        WHEN "000110" => p0_uid138_finalMult_uid59_sqrt_q <= "0001000011";
                        WHEN "000111" => p0_uid138_finalMult_uid59_sqrt_q <= "0001001111";
                        WHEN "001000" => p0_uid138_finalMult_uid59_sqrt_q <= "0001011010";
                        WHEN "001001" => p0_uid138_finalMult_uid59_sqrt_q <= "0001100101";
                        WHEN "001010" => p0_uid138_finalMult_uid59_sqrt_q <= "0001110001";
                        WHEN "001011" => p0_uid138_finalMult_uid59_sqrt_q <= "0001111100";
                        WHEN "001100" => p0_uid138_finalMult_uid59_sqrt_q <= "0010000111";
                        WHEN "001101" => p0_uid138_finalMult_uid59_sqrt_q <= "0010010011";
                        WHEN "001110" => p0_uid138_finalMult_uid59_sqrt_q <= "0010011110";
                        WHEN "001111" => p0_uid138_finalMult_uid59_sqrt_q <= "0010101001";
                        WHEN "010000" => p0_uid138_finalMult_uid59_sqrt_q <= "0010110101";
                        WHEN "010001" => p0_uid138_finalMult_uid59_sqrt_q <= "0011000000";
                        WHEN "010010" => p0_uid138_finalMult_uid59_sqrt_q <= "0011001011";
                        WHEN "010011" => p0_uid138_finalMult_uid59_sqrt_q <= "0011010110";
                        WHEN "010100" => p0_uid138_finalMult_uid59_sqrt_q <= "0011100010";
                        WHEN "010101" => p0_uid138_finalMult_uid59_sqrt_q <= "0011101101";
                        WHEN "010110" => p0_uid138_finalMult_uid59_sqrt_q <= "0011111000";
                        WHEN "010111" => p0_uid138_finalMult_uid59_sqrt_q <= "0100000100";
                        WHEN "011000" => p0_uid138_finalMult_uid59_sqrt_q <= "0100001111";
                        WHEN "011001" => p0_uid138_finalMult_uid59_sqrt_q <= "0100011010";
                        WHEN "011010" => p0_uid138_finalMult_uid59_sqrt_q <= "0100100110";
                        WHEN "011011" => p0_uid138_finalMult_uid59_sqrt_q <= "0100110001";
                        WHEN "011100" => p0_uid138_finalMult_uid59_sqrt_q <= "0100111100";
                        WHEN "011101" => p0_uid138_finalMult_uid59_sqrt_q <= "0101001000";
                        WHEN "011110" => p0_uid138_finalMult_uid59_sqrt_q <= "0101010011";
                        WHEN "011111" => p0_uid138_finalMult_uid59_sqrt_q <= "0101011110";
                        WHEN "100000" => p0_uid138_finalMult_uid59_sqrt_q <= "0101101010";
                        WHEN "100001" => p0_uid138_finalMult_uid59_sqrt_q <= "0101110101";
                        WHEN "100010" => p0_uid138_finalMult_uid59_sqrt_q <= "0110000000";
                        WHEN "100011" => p0_uid138_finalMult_uid59_sqrt_q <= "0110001011";
                        WHEN "100100" => p0_uid138_finalMult_uid59_sqrt_q <= "0110010111";
                        WHEN "100101" => p0_uid138_finalMult_uid59_sqrt_q <= "0110100010";
                        WHEN "100110" => p0_uid138_finalMult_uid59_sqrt_q <= "0110101101";
                        WHEN "100111" => p0_uid138_finalMult_uid59_sqrt_q <= "0110111001";
                        WHEN "101000" => p0_uid138_finalMult_uid59_sqrt_q <= "0111000100";
                        WHEN "101001" => p0_uid138_finalMult_uid59_sqrt_q <= "0111001111";
                        WHEN "101010" => p0_uid138_finalMult_uid59_sqrt_q <= "0111011011";
                        WHEN "101011" => p0_uid138_finalMult_uid59_sqrt_q <= "0111100110";
                        WHEN "101100" => p0_uid138_finalMult_uid59_sqrt_q <= "0111110001";
                        WHEN "101101" => p0_uid138_finalMult_uid59_sqrt_q <= "0111111101";
                        WHEN "101110" => p0_uid138_finalMult_uid59_sqrt_q <= "1000001000";
                        WHEN "101111" => p0_uid138_finalMult_uid59_sqrt_q <= "1000010011";
                        WHEN "110000" => p0_uid138_finalMult_uid59_sqrt_q <= "1000011111";
                        WHEN "110001" => p0_uid138_finalMult_uid59_sqrt_q <= "1000101010";
                        WHEN "110010" => p0_uid138_finalMult_uid59_sqrt_q <= "1000110101";
                        WHEN "110011" => p0_uid138_finalMult_uid59_sqrt_q <= "1001000000";
                        WHEN "110100" => p0_uid138_finalMult_uid59_sqrt_q <= "1001001100";
                        WHEN "110101" => p0_uid138_finalMult_uid59_sqrt_q <= "1001010111";
                        WHEN "110110" => p0_uid138_finalMult_uid59_sqrt_q <= "1001100010";
                        WHEN "110111" => p0_uid138_finalMult_uid59_sqrt_q <= "1001101110";
                        WHEN "111000" => p0_uid138_finalMult_uid59_sqrt_q <= "1001111001";
                        WHEN "111001" => p0_uid138_finalMult_uid59_sqrt_q <= "1010000100";
                        WHEN "111010" => p0_uid138_finalMult_uid59_sqrt_q <= "1010010000";
                        WHEN "111011" => p0_uid138_finalMult_uid59_sqrt_q <= "1010011011";
                        WHEN "111100" => p0_uid138_finalMult_uid59_sqrt_q <= "1010100110";
                        WHEN "111101" => p0_uid138_finalMult_uid59_sqrt_q <= "1010110010";
                        WHEN "111110" => p0_uid138_finalMult_uid59_sqrt_q <= "1010111101";
                        WHEN "111111" => p0_uid138_finalMult_uid59_sqrt_q <= "1011001000";
                        WHEN OTHERS => -- unreachable
                                       p0_uid138_finalMult_uid59_sqrt_q <= (others => '-');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- xv1_uid128_finalMult_uid59_sqrt(BITSELECT,127)@51
    xv1_uid128_finalMult_uid59_sqrt_in <= redist71_result_uid58_sqrt_b_1_q(11 downto 0);
    xv1_uid128_finalMult_uid59_sqrt_b <= xv1_uid128_finalMult_uid59_sqrt_in(11 downto 6);

    -- p1_uid137_finalMult_uid59_sqrt(LOOKUP,136)@51 + 1
    p1_uid137_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                p1_uid137_finalMult_uid59_sqrt_q <= "0000000000000000";
            ELSE
                IF (en = "1") THEN
                    CASE (xv1_uid128_finalMult_uid59_sqrt_b) IS
                        WHEN "000000" => p1_uid137_finalMult_uid59_sqrt_q <= "0000000000000000";
                        WHEN "000001" => p1_uid137_finalMult_uid59_sqrt_q <= "0000001011010100";
                        WHEN "000010" => p1_uid137_finalMult_uid59_sqrt_q <= "0000010110101000";
                        WHEN "000011" => p1_uid137_finalMult_uid59_sqrt_q <= "0000100001111100";
                        WHEN "000100" => p1_uid137_finalMult_uid59_sqrt_q <= "0000101101010000";
                        WHEN "000101" => p1_uid137_finalMult_uid59_sqrt_q <= "0000111000100100";
                        WHEN "000110" => p1_uid137_finalMult_uid59_sqrt_q <= "0001000011111000";
                        WHEN "000111" => p1_uid137_finalMult_uid59_sqrt_q <= "0001001111001100";
                        WHEN "001000" => p1_uid137_finalMult_uid59_sqrt_q <= "0001011010100000";
                        WHEN "001001" => p1_uid137_finalMult_uid59_sqrt_q <= "0001100101110100";
                        WHEN "001010" => p1_uid137_finalMult_uid59_sqrt_q <= "0001110001001000";
                        WHEN "001011" => p1_uid137_finalMult_uid59_sqrt_q <= "0001111100011100";
                        WHEN "001100" => p1_uid137_finalMult_uid59_sqrt_q <= "0010000111110000";
                        WHEN "001101" => p1_uid137_finalMult_uid59_sqrt_q <= "0010010011000101";
                        WHEN "001110" => p1_uid137_finalMult_uid59_sqrt_q <= "0010011110011001";
                        WHEN "001111" => p1_uid137_finalMult_uid59_sqrt_q <= "0010101001101101";
                        WHEN "010000" => p1_uid137_finalMult_uid59_sqrt_q <= "0010110101000001";
                        WHEN "010001" => p1_uid137_finalMult_uid59_sqrt_q <= "0011000000010101";
                        WHEN "010010" => p1_uid137_finalMult_uid59_sqrt_q <= "0011001011101001";
                        WHEN "010011" => p1_uid137_finalMult_uid59_sqrt_q <= "0011010110111101";
                        WHEN "010100" => p1_uid137_finalMult_uid59_sqrt_q <= "0011100010010001";
                        WHEN "010101" => p1_uid137_finalMult_uid59_sqrt_q <= "0011101101100101";
                        WHEN "010110" => p1_uid137_finalMult_uid59_sqrt_q <= "0011111000111001";
                        WHEN "010111" => p1_uid137_finalMult_uid59_sqrt_q <= "0100000100001101";
                        WHEN "011000" => p1_uid137_finalMult_uid59_sqrt_q <= "0100001111100001";
                        WHEN "011001" => p1_uid137_finalMult_uid59_sqrt_q <= "0100011010110101";
                        WHEN "011010" => p1_uid137_finalMult_uid59_sqrt_q <= "0100100110001010";
                        WHEN "011011" => p1_uid137_finalMult_uid59_sqrt_q <= "0100110001011110";
                        WHEN "011100" => p1_uid137_finalMult_uid59_sqrt_q <= "0100111100110010";
                        WHEN "011101" => p1_uid137_finalMult_uid59_sqrt_q <= "0101001000000110";
                        WHEN "011110" => p1_uid137_finalMult_uid59_sqrt_q <= "0101010011011010";
                        WHEN "011111" => p1_uid137_finalMult_uid59_sqrt_q <= "0101011110101110";
                        WHEN "100000" => p1_uid137_finalMult_uid59_sqrt_q <= "0101101010000010";
                        WHEN "100001" => p1_uid137_finalMult_uid59_sqrt_q <= "0101110101010110";
                        WHEN "100010" => p1_uid137_finalMult_uid59_sqrt_q <= "0110000000101010";
                        WHEN "100011" => p1_uid137_finalMult_uid59_sqrt_q <= "0110001011111110";
                        WHEN "100100" => p1_uid137_finalMult_uid59_sqrt_q <= "0110010111010010";
                        WHEN "100101" => p1_uid137_finalMult_uid59_sqrt_q <= "0110100010100110";
                        WHEN "100110" => p1_uid137_finalMult_uid59_sqrt_q <= "0110101101111010";
                        WHEN "100111" => p1_uid137_finalMult_uid59_sqrt_q <= "0110111001001111";
                        WHEN "101000" => p1_uid137_finalMult_uid59_sqrt_q <= "0111000100100011";
                        WHEN "101001" => p1_uid137_finalMult_uid59_sqrt_q <= "0111001111110111";
                        WHEN "101010" => p1_uid137_finalMult_uid59_sqrt_q <= "0111011011001011";
                        WHEN "101011" => p1_uid137_finalMult_uid59_sqrt_q <= "0111100110011111";
                        WHEN "101100" => p1_uid137_finalMult_uid59_sqrt_q <= "0111110001110011";
                        WHEN "101101" => p1_uid137_finalMult_uid59_sqrt_q <= "0111111101000111";
                        WHEN "101110" => p1_uid137_finalMult_uid59_sqrt_q <= "1000001000011011";
                        WHEN "101111" => p1_uid137_finalMult_uid59_sqrt_q <= "1000010011101111";
                        WHEN "110000" => p1_uid137_finalMult_uid59_sqrt_q <= "1000011111000011";
                        WHEN "110001" => p1_uid137_finalMult_uid59_sqrt_q <= "1000101010010111";
                        WHEN "110010" => p1_uid137_finalMult_uid59_sqrt_q <= "1000110101101011";
                        WHEN "110011" => p1_uid137_finalMult_uid59_sqrt_q <= "1001000000111111";
                        WHEN "110100" => p1_uid137_finalMult_uid59_sqrt_q <= "1001001100010100";
                        WHEN "110101" => p1_uid137_finalMult_uid59_sqrt_q <= "1001010111101000";
                        WHEN "110110" => p1_uid137_finalMult_uid59_sqrt_q <= "1001100010111100";
                        WHEN "110111" => p1_uid137_finalMult_uid59_sqrt_q <= "1001101110010000";
                        WHEN "111000" => p1_uid137_finalMult_uid59_sqrt_q <= "1001111001100100";
                        WHEN "111001" => p1_uid137_finalMult_uid59_sqrt_q <= "1010000100111000";
                        WHEN "111010" => p1_uid137_finalMult_uid59_sqrt_q <= "1010010000001100";
                        WHEN "111011" => p1_uid137_finalMult_uid59_sqrt_q <= "1010011011100000";
                        WHEN "111100" => p1_uid137_finalMult_uid59_sqrt_q <= "1010100110110100";
                        WHEN "111101" => p1_uid137_finalMult_uid59_sqrt_q <= "1010110010001000";
                        WHEN "111110" => p1_uid137_finalMult_uid59_sqrt_q <= "1010111101011100";
                        WHEN "111111" => p1_uid137_finalMult_uid59_sqrt_q <= "1011001000110000";
                        WHEN OTHERS => -- unreachable
                                       p1_uid137_finalMult_uid59_sqrt_q <= (others => '-');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- lev1_a2_uid144_finalMult_uid59_sqrt(ADD,143)@52 + 1
    lev1_a2_uid144_finalMult_uid59_sqrt_a <= STD_LOGIC_VECTOR("0" & p1_uid137_finalMult_uid59_sqrt_q);
    lev1_a2_uid144_finalMult_uid59_sqrt_b <= STD_LOGIC_VECTOR("0000000" & p0_uid138_finalMult_uid59_sqrt_q);
    lev1_a2_uid144_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev1_a2_uid144_finalMult_uid59_sqrt_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev1_a2_uid144_finalMult_uid59_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a2_uid144_finalMult_uid59_sqrt_a) + UNSIGNED(lev1_a2_uid144_finalMult_uid59_sqrt_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev1_a2_uid144_finalMult_uid59_sqrt_q <= lev1_a2_uid144_finalMult_uid59_sqrt_o(16 downto 0);

    -- lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b(BITJOIN,477)@53
    lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q <= lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b & lev1_a2_uid144_finalMult_uid59_sqrt_q;

    -- lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select(BITSELECT,591)
    lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b <= STD_LOGIC_VECTOR(leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt_q(5 downto 0));
    lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c <= STD_LOGIC_VECTOR(leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt_q(11 downto 6));

    -- xv2_uid129_finalMult_uid59_sqrt(BITSELECT,128)@50
    xv2_uid129_finalMult_uid59_sqrt_in <= result_uid58_sqrt_b(17 downto 0);
    xv2_uid129_finalMult_uid59_sqrt_b <= xv2_uid129_finalMult_uid59_sqrt_in(17 downto 12);

    -- p2_uid136_finalMult_uid59_sqrt(LOOKUP,135)@50 + 1
    p2_uid136_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                p2_uid136_finalMult_uid59_sqrt_q <= "0000000000000000000000";
            ELSE
                IF (en = "1") THEN
                    CASE (xv2_uid129_finalMult_uid59_sqrt_b) IS
                        WHEN "000000" => p2_uid136_finalMult_uid59_sqrt_q <= "0000000000000000000000";
                        WHEN "000001" => p2_uid136_finalMult_uid59_sqrt_q <= "0000001011010100000100";
                        WHEN "000010" => p2_uid136_finalMult_uid59_sqrt_q <= "0000010110101000001001";
                        WHEN "000011" => p2_uid136_finalMult_uid59_sqrt_q <= "0000100001111100001110";
                        WHEN "000100" => p2_uid136_finalMult_uid59_sqrt_q <= "0000101101010000010011";
                        WHEN "000101" => p2_uid136_finalMult_uid59_sqrt_q <= "0000111000100100011000";
                        WHEN "000110" => p2_uid136_finalMult_uid59_sqrt_q <= "0001000011111000011101";
                        WHEN "000111" => p2_uid136_finalMult_uid59_sqrt_q <= "0001001111001100100010";
                        WHEN "001000" => p2_uid136_finalMult_uid59_sqrt_q <= "0001011010100000100111";
                        WHEN "001001" => p2_uid136_finalMult_uid59_sqrt_q <= "0001100101110100101100";
                        WHEN "001010" => p2_uid136_finalMult_uid59_sqrt_q <= "0001110001001000110001";
                        WHEN "001011" => p2_uid136_finalMult_uid59_sqrt_q <= "0001111100011100110110";
                        WHEN "001100" => p2_uid136_finalMult_uid59_sqrt_q <= "0010000111110000111011";
                        WHEN "001101" => p2_uid136_finalMult_uid59_sqrt_q <= "0010010011000101000000";
                        WHEN "001110" => p2_uid136_finalMult_uid59_sqrt_q <= "0010011110011001000101";
                        WHEN "001111" => p2_uid136_finalMult_uid59_sqrt_q <= "0010101001101101001010";
                        WHEN "010000" => p2_uid136_finalMult_uid59_sqrt_q <= "0010110101000001001111";
                        WHEN "010001" => p2_uid136_finalMult_uid59_sqrt_q <= "0011000000010101010100";
                        WHEN "010010" => p2_uid136_finalMult_uid59_sqrt_q <= "0011001011101001011001";
                        WHEN "010011" => p2_uid136_finalMult_uid59_sqrt_q <= "0011010110111101011110";
                        WHEN "010100" => p2_uid136_finalMult_uid59_sqrt_q <= "0011100010010001100011";
                        WHEN "010101" => p2_uid136_finalMult_uid59_sqrt_q <= "0011101101100101100111";
                        WHEN "010110" => p2_uid136_finalMult_uid59_sqrt_q <= "0011111000111001101100";
                        WHEN "010111" => p2_uid136_finalMult_uid59_sqrt_q <= "0100000100001101110001";
                        WHEN "011000" => p2_uid136_finalMult_uid59_sqrt_q <= "0100001111100001110110";
                        WHEN "011001" => p2_uid136_finalMult_uid59_sqrt_q <= "0100011010110101111011";
                        WHEN "011010" => p2_uid136_finalMult_uid59_sqrt_q <= "0100100110001010000000";
                        WHEN "011011" => p2_uid136_finalMult_uid59_sqrt_q <= "0100110001011110000101";
                        WHEN "011100" => p2_uid136_finalMult_uid59_sqrt_q <= "0100111100110010001010";
                        WHEN "011101" => p2_uid136_finalMult_uid59_sqrt_q <= "0101001000000110001111";
                        WHEN "011110" => p2_uid136_finalMult_uid59_sqrt_q <= "0101010011011010010100";
                        WHEN "011111" => p2_uid136_finalMult_uid59_sqrt_q <= "0101011110101110011001";
                        WHEN "100000" => p2_uid136_finalMult_uid59_sqrt_q <= "0101101010000010011110";
                        WHEN "100001" => p2_uid136_finalMult_uid59_sqrt_q <= "0101110101010110100011";
                        WHEN "100010" => p2_uid136_finalMult_uid59_sqrt_q <= "0110000000101010101000";
                        WHEN "100011" => p2_uid136_finalMult_uid59_sqrt_q <= "0110001011111110101101";
                        WHEN "100100" => p2_uid136_finalMult_uid59_sqrt_q <= "0110010111010010110010";
                        WHEN "100101" => p2_uid136_finalMult_uid59_sqrt_q <= "0110100010100110110111";
                        WHEN "100110" => p2_uid136_finalMult_uid59_sqrt_q <= "0110101101111010111100";
                        WHEN "100111" => p2_uid136_finalMult_uid59_sqrt_q <= "0110111001001111000001";
                        WHEN "101000" => p2_uid136_finalMult_uid59_sqrt_q <= "0111000100100011000110";
                        WHEN "101001" => p2_uid136_finalMult_uid59_sqrt_q <= "0111001111110111001010";
                        WHEN "101010" => p2_uid136_finalMult_uid59_sqrt_q <= "0111011011001011001111";
                        WHEN "101011" => p2_uid136_finalMult_uid59_sqrt_q <= "0111100110011111010100";
                        WHEN "101100" => p2_uid136_finalMult_uid59_sqrt_q <= "0111110001110011011001";
                        WHEN "101101" => p2_uid136_finalMult_uid59_sqrt_q <= "0111111101000111011110";
                        WHEN "101110" => p2_uid136_finalMult_uid59_sqrt_q <= "1000001000011011100011";
                        WHEN "101111" => p2_uid136_finalMult_uid59_sqrt_q <= "1000010011101111101000";
                        WHEN "110000" => p2_uid136_finalMult_uid59_sqrt_q <= "1000011111000011101101";
                        WHEN "110001" => p2_uid136_finalMult_uid59_sqrt_q <= "1000101010010111110010";
                        WHEN "110010" => p2_uid136_finalMult_uid59_sqrt_q <= "1000110101101011110111";
                        WHEN "110011" => p2_uid136_finalMult_uid59_sqrt_q <= "1001000000111111111100";
                        WHEN "110100" => p2_uid136_finalMult_uid59_sqrt_q <= "1001001100010100000001";
                        WHEN "110101" => p2_uid136_finalMult_uid59_sqrt_q <= "1001010111101000000110";
                        WHEN "110110" => p2_uid136_finalMult_uid59_sqrt_q <= "1001100010111100001011";
                        WHEN "110111" => p2_uid136_finalMult_uid59_sqrt_q <= "1001101110010000010000";
                        WHEN "111000" => p2_uid136_finalMult_uid59_sqrt_q <= "1001111001100100010101";
                        WHEN "111001" => p2_uid136_finalMult_uid59_sqrt_q <= "1010000100111000011010";
                        WHEN "111010" => p2_uid136_finalMult_uid59_sqrt_q <= "1010010000001100011111";
                        WHEN "111011" => p2_uid136_finalMult_uid59_sqrt_q <= "1010011011100000100100";
                        WHEN "111100" => p2_uid136_finalMult_uid59_sqrt_q <= "1010100110110100101001";
                        WHEN "111101" => p2_uid136_finalMult_uid59_sqrt_q <= "1010110010001000101101";
                        WHEN "111110" => p2_uid136_finalMult_uid59_sqrt_q <= "1010111101011100110010";
                        WHEN "111111" => p2_uid136_finalMult_uid59_sqrt_q <= "1011001000110000110111";
                        WHEN OTHERS => -- unreachable
                                       p2_uid136_finalMult_uid59_sqrt_q <= (others => '-');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- xv3_uid130_finalMult_uid59_sqrt(BITSELECT,129)@50
    xv3_uid130_finalMult_uid59_sqrt_in <= result_uid58_sqrt_b(23 downto 0);
    xv3_uid130_finalMult_uid59_sqrt_b <= xv3_uid130_finalMult_uid59_sqrt_in(23 downto 18);

    -- p3_uid135_finalMult_uid59_sqrt(LOOKUP,134)@50 + 1
    p3_uid135_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                p3_uid135_finalMult_uid59_sqrt_q <= "0000000000000000000000000000";
            ELSE
                IF (en = "1") THEN
                    CASE (xv3_uid130_finalMult_uid59_sqrt_b) IS
                        WHEN "000000" => p3_uid135_finalMult_uid59_sqrt_q <= "0000000000000000000000000000";
                        WHEN "000001" => p3_uid135_finalMult_uid59_sqrt_q <= "0000001011010100000100111100";
                        WHEN "000010" => p3_uid135_finalMult_uid59_sqrt_q <= "0000010110101000001001111001";
                        WHEN "000011" => p3_uid135_finalMult_uid59_sqrt_q <= "0000100001111100001110110110";
                        WHEN "000100" => p3_uid135_finalMult_uid59_sqrt_q <= "0000101101010000010011110011";
                        WHEN "000101" => p3_uid135_finalMult_uid59_sqrt_q <= "0000111000100100011000110000";
                        WHEN "000110" => p3_uid135_finalMult_uid59_sqrt_q <= "0001000011111000011101101100";
                        WHEN "000111" => p3_uid135_finalMult_uid59_sqrt_q <= "0001001111001100100010101001";
                        WHEN "001000" => p3_uid135_finalMult_uid59_sqrt_q <= "0001011010100000100111100110";
                        WHEN "001001" => p3_uid135_finalMult_uid59_sqrt_q <= "0001100101110100101100100011";
                        WHEN "001010" => p3_uid135_finalMult_uid59_sqrt_q <= "0001110001001000110001100000";
                        WHEN "001011" => p3_uid135_finalMult_uid59_sqrt_q <= "0001111100011100110110011100";
                        WHEN "001100" => p3_uid135_finalMult_uid59_sqrt_q <= "0010000111110000111011011001";
                        WHEN "001101" => p3_uid135_finalMult_uid59_sqrt_q <= "0010010011000101000000010110";
                        WHEN "001110" => p3_uid135_finalMult_uid59_sqrt_q <= "0010011110011001000101010011";
                        WHEN "001111" => p3_uid135_finalMult_uid59_sqrt_q <= "0010101001101101001010010000";
                        WHEN "010000" => p3_uid135_finalMult_uid59_sqrt_q <= "0010110101000001001111001100";
                        WHEN "010001" => p3_uid135_finalMult_uid59_sqrt_q <= "0011000000010101010100001001";
                        WHEN "010010" => p3_uid135_finalMult_uid59_sqrt_q <= "0011001011101001011001000110";
                        WHEN "010011" => p3_uid135_finalMult_uid59_sqrt_q <= "0011010110111101011110000011";
                        WHEN "010100" => p3_uid135_finalMult_uid59_sqrt_q <= "0011100010010001100011000000";
                        WHEN "010101" => p3_uid135_finalMult_uid59_sqrt_q <= "0011101101100101100111111100";
                        WHEN "010110" => p3_uid135_finalMult_uid59_sqrt_q <= "0011111000111001101100111001";
                        WHEN "010111" => p3_uid135_finalMult_uid59_sqrt_q <= "0100000100001101110001110110";
                        WHEN "011000" => p3_uid135_finalMult_uid59_sqrt_q <= "0100001111100001110110110011";
                        WHEN "011001" => p3_uid135_finalMult_uid59_sqrt_q <= "0100011010110101111011110000";
                        WHEN "011010" => p3_uid135_finalMult_uid59_sqrt_q <= "0100100110001010000000101100";
                        WHEN "011011" => p3_uid135_finalMult_uid59_sqrt_q <= "0100110001011110000101101001";
                        WHEN "011100" => p3_uid135_finalMult_uid59_sqrt_q <= "0100111100110010001010100110";
                        WHEN "011101" => p3_uid135_finalMult_uid59_sqrt_q <= "0101001000000110001111100011";
                        WHEN "011110" => p3_uid135_finalMult_uid59_sqrt_q <= "0101010011011010010100100000";
                        WHEN "011111" => p3_uid135_finalMult_uid59_sqrt_q <= "0101011110101110011001011100";
                        WHEN "100000" => p3_uid135_finalMult_uid59_sqrt_q <= "0101101010000010011110011001";
                        WHEN "100001" => p3_uid135_finalMult_uid59_sqrt_q <= "0101110101010110100011010110";
                        WHEN "100010" => p3_uid135_finalMult_uid59_sqrt_q <= "0110000000101010101000010011";
                        WHEN "100011" => p3_uid135_finalMult_uid59_sqrt_q <= "0110001011111110101101010000";
                        WHEN "100100" => p3_uid135_finalMult_uid59_sqrt_q <= "0110010111010010110010001100";
                        WHEN "100101" => p3_uid135_finalMult_uid59_sqrt_q <= "0110100010100110110111001001";
                        WHEN "100110" => p3_uid135_finalMult_uid59_sqrt_q <= "0110101101111010111100000110";
                        WHEN "100111" => p3_uid135_finalMult_uid59_sqrt_q <= "0110111001001111000001000011";
                        WHEN "101000" => p3_uid135_finalMult_uid59_sqrt_q <= "0111000100100011000110000000";
                        WHEN "101001" => p3_uid135_finalMult_uid59_sqrt_q <= "0111001111110111001010111100";
                        WHEN "101010" => p3_uid135_finalMult_uid59_sqrt_q <= "0111011011001011001111111001";
                        WHEN "101011" => p3_uid135_finalMult_uid59_sqrt_q <= "0111100110011111010100110110";
                        WHEN "101100" => p3_uid135_finalMult_uid59_sqrt_q <= "0111110001110011011001110011";
                        WHEN "101101" => p3_uid135_finalMult_uid59_sqrt_q <= "0111111101000111011110110000";
                        WHEN "101110" => p3_uid135_finalMult_uid59_sqrt_q <= "1000001000011011100011101100";
                        WHEN "101111" => p3_uid135_finalMult_uid59_sqrt_q <= "1000010011101111101000101001";
                        WHEN "110000" => p3_uid135_finalMult_uid59_sqrt_q <= "1000011111000011101101100110";
                        WHEN "110001" => p3_uid135_finalMult_uid59_sqrt_q <= "1000101010010111110010100011";
                        WHEN "110010" => p3_uid135_finalMult_uid59_sqrt_q <= "1000110101101011110111100000";
                        WHEN "110011" => p3_uid135_finalMult_uid59_sqrt_q <= "1001000000111111111100011100";
                        WHEN "110100" => p3_uid135_finalMult_uid59_sqrt_q <= "1001001100010100000001011001";
                        WHEN "110101" => p3_uid135_finalMult_uid59_sqrt_q <= "1001010111101000000110010110";
                        WHEN "110110" => p3_uid135_finalMult_uid59_sqrt_q <= "1001100010111100001011010011";
                        WHEN "110111" => p3_uid135_finalMult_uid59_sqrt_q <= "1001101110010000010000010000";
                        WHEN "111000" => p3_uid135_finalMult_uid59_sqrt_q <= "1001111001100100010101001100";
                        WHEN "111001" => p3_uid135_finalMult_uid59_sqrt_q <= "1010000100111000011010001001";
                        WHEN "111010" => p3_uid135_finalMult_uid59_sqrt_q <= "1010010000001100011111000110";
                        WHEN "111011" => p3_uid135_finalMult_uid59_sqrt_q <= "1010011011100000100100000011";
                        WHEN "111100" => p3_uid135_finalMult_uid59_sqrt_q <= "1010100110110100101001000000";
                        WHEN "111101" => p3_uid135_finalMult_uid59_sqrt_q <= "1010110010001000101101111100";
                        WHEN "111110" => p3_uid135_finalMult_uid59_sqrt_q <= "1010111101011100110010111001";
                        WHEN "111111" => p3_uid135_finalMult_uid59_sqrt_q <= "1011001000110000110111110110";
                        WHEN OTHERS => -- unreachable
                                       p3_uid135_finalMult_uid59_sqrt_q <= (others => '-');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- lev1_a1_uid143_finalMult_uid59_sqrt(ADD,142)@51 + 1
    lev1_a1_uid143_finalMult_uid59_sqrt_a <= STD_LOGIC_VECTOR("0" & p3_uid135_finalMult_uid59_sqrt_q);
    lev1_a1_uid143_finalMult_uid59_sqrt_b <= STD_LOGIC_VECTOR("0000000" & p2_uid136_finalMult_uid59_sqrt_q);
    lev1_a1_uid143_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev1_a1_uid143_finalMult_uid59_sqrt_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev1_a1_uid143_finalMult_uid59_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a1_uid143_finalMult_uid59_sqrt_a) + UNSIGNED(lev1_a1_uid143_finalMult_uid59_sqrt_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev1_a1_uid143_finalMult_uid59_sqrt_q <= lev1_a1_uid143_finalMult_uid59_sqrt_o(28 downto 0);

    -- lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b(BITJOIN,467)@52
    lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q <= lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b & lev1_a1_uid143_finalMult_uid59_sqrt_q;

    -- lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_UpperBits_for_b(CONSTANT,353)
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_UpperBits_for_b_q <= "000000";

    -- lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select(BITSELECT,589)
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b <= STD_LOGIC_VECTOR(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_UpperBits_for_b_q(1 downto 0));
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c <= STD_LOGIC_VECTOR(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_UpperBits_for_b_q(5 downto 2));

    -- xv4_uid131_finalMult_uid59_sqrt(BITSELECT,130)@50
    xv4_uid131_finalMult_uid59_sqrt_in <= result_uid58_sqrt_b(29 downto 0);
    xv4_uid131_finalMult_uid59_sqrt_b <= xv4_uid131_finalMult_uid59_sqrt_in(29 downto 24);

    -- p4_uid134_finalMult_uid59_sqrt(LOOKUP,133)@50 + 1
    p4_uid134_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                p4_uid134_finalMult_uid59_sqrt_q <= "0000000000000000000000000000000000";
            ELSE
                IF (en = "1") THEN
                    CASE (xv4_uid131_finalMult_uid59_sqrt_b) IS
                        WHEN "000000" => p4_uid134_finalMult_uid59_sqrt_q <= "0000000000000000000000000000000000";
                        WHEN "000001" => p4_uid134_finalMult_uid59_sqrt_q <= "0000001011010100000100111100110011";
                        WHEN "000010" => p4_uid134_finalMult_uid59_sqrt_q <= "0000010110101000001001111001100110";
                        WHEN "000011" => p4_uid134_finalMult_uid59_sqrt_q <= "0000100001111100001110110110011001";
                        WHEN "000100" => p4_uid134_finalMult_uid59_sqrt_q <= "0000101101010000010011110011001100";
                        WHEN "000101" => p4_uid134_finalMult_uid59_sqrt_q <= "0000111000100100011000110000000000";
                        WHEN "000110" => p4_uid134_finalMult_uid59_sqrt_q <= "0001000011111000011101101100110011";
                        WHEN "000111" => p4_uid134_finalMult_uid59_sqrt_q <= "0001001111001100100010101001100110";
                        WHEN "001000" => p4_uid134_finalMult_uid59_sqrt_q <= "0001011010100000100111100110011001";
                        WHEN "001001" => p4_uid134_finalMult_uid59_sqrt_q <= "0001100101110100101100100011001101";
                        WHEN "001010" => p4_uid134_finalMult_uid59_sqrt_q <= "0001110001001000110001100000000000";
                        WHEN "001011" => p4_uid134_finalMult_uid59_sqrt_q <= "0001111100011100110110011100110011";
                        WHEN "001100" => p4_uid134_finalMult_uid59_sqrt_q <= "0010000111110000111011011001100110";
                        WHEN "001101" => p4_uid134_finalMult_uid59_sqrt_q <= "0010010011000101000000010110011010";
                        WHEN "001110" => p4_uid134_finalMult_uid59_sqrt_q <= "0010011110011001000101010011001101";
                        WHEN "001111" => p4_uid134_finalMult_uid59_sqrt_q <= "0010101001101101001010010000000000";
                        WHEN "010000" => p4_uid134_finalMult_uid59_sqrt_q <= "0010110101000001001111001100110011";
                        WHEN "010001" => p4_uid134_finalMult_uid59_sqrt_q <= "0011000000010101010100001001100111";
                        WHEN "010010" => p4_uid134_finalMult_uid59_sqrt_q <= "0011001011101001011001000110011010";
                        WHEN "010011" => p4_uid134_finalMult_uid59_sqrt_q <= "0011010110111101011110000011001101";
                        WHEN "010100" => p4_uid134_finalMult_uid59_sqrt_q <= "0011100010010001100011000000000000";
                        WHEN "010101" => p4_uid134_finalMult_uid59_sqrt_q <= "0011101101100101100111111100110100";
                        WHEN "010110" => p4_uid134_finalMult_uid59_sqrt_q <= "0011111000111001101100111001100111";
                        WHEN "010111" => p4_uid134_finalMult_uid59_sqrt_q <= "0100000100001101110001110110011010";
                        WHEN "011000" => p4_uid134_finalMult_uid59_sqrt_q <= "0100001111100001110110110011001101";
                        WHEN "011001" => p4_uid134_finalMult_uid59_sqrt_q <= "0100011010110101111011110000000001";
                        WHEN "011010" => p4_uid134_finalMult_uid59_sqrt_q <= "0100100110001010000000101100110100";
                        WHEN "011011" => p4_uid134_finalMult_uid59_sqrt_q <= "0100110001011110000101101001100111";
                        WHEN "011100" => p4_uid134_finalMult_uid59_sqrt_q <= "0100111100110010001010100110011010";
                        WHEN "011101" => p4_uid134_finalMult_uid59_sqrt_q <= "0101001000000110001111100011001110";
                        WHEN "011110" => p4_uid134_finalMult_uid59_sqrt_q <= "0101010011011010010100100000000001";
                        WHEN "011111" => p4_uid134_finalMult_uid59_sqrt_q <= "0101011110101110011001011100110100";
                        WHEN "100000" => p4_uid134_finalMult_uid59_sqrt_q <= "0101101010000010011110011001100111";
                        WHEN "100001" => p4_uid134_finalMult_uid59_sqrt_q <= "0101110101010110100011010110011011";
                        WHEN "100010" => p4_uid134_finalMult_uid59_sqrt_q <= "0110000000101010101000010011001110";
                        WHEN "100011" => p4_uid134_finalMult_uid59_sqrt_q <= "0110001011111110101101010000000001";
                        WHEN "100100" => p4_uid134_finalMult_uid59_sqrt_q <= "0110010111010010110010001100110100";
                        WHEN "100101" => p4_uid134_finalMult_uid59_sqrt_q <= "0110100010100110110111001001101000";
                        WHEN "100110" => p4_uid134_finalMult_uid59_sqrt_q <= "0110101101111010111100000110011011";
                        WHEN "100111" => p4_uid134_finalMult_uid59_sqrt_q <= "0110111001001111000001000011001110";
                        WHEN "101000" => p4_uid134_finalMult_uid59_sqrt_q <= "0111000100100011000110000000000001";
                        WHEN "101001" => p4_uid134_finalMult_uid59_sqrt_q <= "0111001111110111001010111100110101";
                        WHEN "101010" => p4_uid134_finalMult_uid59_sqrt_q <= "0111011011001011001111111001101000";
                        WHEN "101011" => p4_uid134_finalMult_uid59_sqrt_q <= "0111100110011111010100110110011011";
                        WHEN "101100" => p4_uid134_finalMult_uid59_sqrt_q <= "0111110001110011011001110011001110";
                        WHEN "101101" => p4_uid134_finalMult_uid59_sqrt_q <= "0111111101000111011110110000000010";
                        WHEN "101110" => p4_uid134_finalMult_uid59_sqrt_q <= "1000001000011011100011101100110101";
                        WHEN "101111" => p4_uid134_finalMult_uid59_sqrt_q <= "1000010011101111101000101001101000";
                        WHEN "110000" => p4_uid134_finalMult_uid59_sqrt_q <= "1000011111000011101101100110011011";
                        WHEN "110001" => p4_uid134_finalMult_uid59_sqrt_q <= "1000101010010111110010100011001111";
                        WHEN "110010" => p4_uid134_finalMult_uid59_sqrt_q <= "1000110101101011110111100000000010";
                        WHEN "110011" => p4_uid134_finalMult_uid59_sqrt_q <= "1001000000111111111100011100110101";
                        WHEN "110100" => p4_uid134_finalMult_uid59_sqrt_q <= "1001001100010100000001011001101000";
                        WHEN "110101" => p4_uid134_finalMult_uid59_sqrt_q <= "1001010111101000000110010110011100";
                        WHEN "110110" => p4_uid134_finalMult_uid59_sqrt_q <= "1001100010111100001011010011001111";
                        WHEN "110111" => p4_uid134_finalMult_uid59_sqrt_q <= "1001101110010000010000010000000010";
                        WHEN "111000" => p4_uid134_finalMult_uid59_sqrt_q <= "1001111001100100010101001100110101";
                        WHEN "111001" => p4_uid134_finalMult_uid59_sqrt_q <= "1010000100111000011010001001101001";
                        WHEN "111010" => p4_uid134_finalMult_uid59_sqrt_q <= "1010010000001100011111000110011100";
                        WHEN "111011" => p4_uid134_finalMult_uid59_sqrt_q <= "1010011011100000100100000011001111";
                        WHEN "111100" => p4_uid134_finalMult_uid59_sqrt_q <= "1010100110110100101001000000000010";
                        WHEN "111101" => p4_uid134_finalMult_uid59_sqrt_q <= "1010110010001000101101111100110110";
                        WHEN "111110" => p4_uid134_finalMult_uid59_sqrt_q <= "1010111101011100110010111001101001";
                        WHEN "111111" => p4_uid134_finalMult_uid59_sqrt_q <= "1011001000110000110111110110011100";
                        WHEN OTHERS => -- unreachable
                                       p4_uid134_finalMult_uid59_sqrt_q <= (others => '-');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select(BITSELECT,582)@51
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(p4_uid134_finalMult_uid59_sqrt_q(33 downto 1));
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(p4_uid134_finalMult_uid59_sqrt_q(0 downto 0));

    -- lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b(BITJOIN,455)@51
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q <= lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b & lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_b;

    -- xv5_uid132_finalMult_uid59_sqrt(BITSELECT,131)@50
    xv5_uid132_finalMult_uid59_sqrt_b <= result_uid58_sqrt_b(33 downto 30);

    -- p5_uid133_finalMult_uid59_sqrt(LOOKUP,132)@50 + 1
    p5_uid133_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                p5_uid133_finalMult_uid59_sqrt_q <= "00000000000000000000000000000000000100";
            ELSE
                IF (en = "1") THEN
                    CASE (xv5_uid132_finalMult_uid59_sqrt_b) IS
                        WHEN "0000" => p5_uid133_finalMult_uid59_sqrt_q <= "00000000000000000000000000000000000100";
                        WHEN "0001" => p5_uid133_finalMult_uid59_sqrt_q <= "00000101101010000010011110011001101011";
                        WHEN "0010" => p5_uid133_finalMult_uid59_sqrt_q <= "00001011010100000100111100110011010011";
                        WHEN "0011" => p5_uid133_finalMult_uid59_sqrt_q <= "00010000111110000111011011001100111011";
                        WHEN "0100" => p5_uid133_finalMult_uid59_sqrt_q <= "00010110101000001001111001100110100011";
                        WHEN "0101" => p5_uid133_finalMult_uid59_sqrt_q <= "00011100010010001100011000000000001011";
                        WHEN "0110" => p5_uid133_finalMult_uid59_sqrt_q <= "00100001111100001110110110011001110011";
                        WHEN "0111" => p5_uid133_finalMult_uid59_sqrt_q <= "00100111100110010001010100110011011011";
                        WHEN "1000" => p5_uid133_finalMult_uid59_sqrt_q <= "00101101010000010011110011001101000011";
                        WHEN "1001" => p5_uid133_finalMult_uid59_sqrt_q <= "00110010111010010110010001100110101011";
                        WHEN "1010" => p5_uid133_finalMult_uid59_sqrt_q <= "00111000100100011000110000000000010011";
                        WHEN "1011" => p5_uid133_finalMult_uid59_sqrt_q <= "00111110001110011011001110011001111011";
                        WHEN "1100" => p5_uid133_finalMult_uid59_sqrt_q <= "01000011111000011101101100110011100011";
                        WHEN "1101" => p5_uid133_finalMult_uid59_sqrt_q <= "01001001100010100000001011001101001011";
                        WHEN "1110" => p5_uid133_finalMult_uid59_sqrt_q <= "01001111001100100010101001100110110011";
                        WHEN "1111" => p5_uid133_finalMult_uid59_sqrt_q <= "01010100110110100101001000000000011011";
                        WHEN OTHERS => -- unreachable
                                       p5_uid133_finalMult_uid59_sqrt_q <= (others => '-');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select(BITSELECT,581)@51
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_b <= STD_LOGIC_VECTOR(p5_uid133_finalMult_uid59_sqrt_q(34 downto 0));
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_c <= STD_LOGIC_VECTOR(p5_uid133_finalMult_uid59_sqrt_q(37 downto 35));

    -- lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2(ADD,356)@51 + 1
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_a <= STD_LOGIC_VECTOR("0" & lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_b);
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_b <= STD_LOGIC_VECTOR("0" & lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q);
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_a) + UNSIGNED(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_c(0) <= lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_o(35);
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_q <= lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_o(34 downto 0);

    -- lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select(BITSELECT,590)@52
    lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_b <= STD_LOGIC_VECTOR(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_q(33 downto 0));
    lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c <= STD_LOGIC_VECTOR(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_q(34 downto 34));

    -- redist7_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_c_1(DELAY,603)
    redist7_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_c, xout => redist7_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_b(BITJOIN,460)@52
    lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_b_q <= lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_b & redist7_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_0_merged_bit_select_c_1_q;

    -- lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2(ADD,365)@52 + 1
    lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_a <= STD_LOGIC_VECTOR("0" & lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_b_q);
    lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_b <= STD_LOGIC_VECTOR("0" & lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q);
    lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_a) + UNSIGNED(lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_c(0) <= lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_o(35);
    lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_q <= lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_o(34 downto 0);

    -- lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2(ADD,374)@53 + 1
    lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_a <= STD_LOGIC_VECTOR("0" & lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_q);
    lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_b <= STD_LOGIC_VECTOR("0" & lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q);
    lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_a) + UNSIGNED(lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_c(0) <= lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_o(35);
    lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q <= lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_o(34 downto 0);

    -- lev3_a0_uid146_finalMult_uid59_sqrt_UpperBits_for_b(CONSTANT,371)
    lev3_a0_uid146_finalMult_uid59_sqrt_UpperBits_for_b_q <= "0000000000000000000000000";

    -- lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select(BITSELECT,592)
    lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b <= STD_LOGIC_VECTOR(lev3_a0_uid146_finalMult_uid59_sqrt_UpperBits_for_b_q(17 downto 0));
    lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c <= STD_LOGIC_VECTOR(lev3_a0_uid146_finalMult_uid59_sqrt_UpperBits_for_b_q(24 downto 18));

    -- redist8_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_c_1(DELAY,604)
    redist8_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_c, xout => redist8_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c(BITJOIN,452)@52
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q <= GND_q & redist8_lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_0_merged_bit_select_c_1_q;

    -- lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2(ADD,357)@52 + 1
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_cin <= lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p1_of_2_c;
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_a <= STD_LOGIC_VECTOR("0" & lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q) & '1';
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_b <= STD_LOGIC_VECTOR("0" & lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c) & lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_cin(0);
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_a) + UNSIGNED(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_q <= lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_o(4 downto 1);

    -- redist3_lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c_1(DELAY,599)
    redist3_lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c, xout => redist3_lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c(BITJOIN,464)@53
    lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q <= GND_q & lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_p2_of_2_q & redist3_lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c_1_q;

    -- lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2(ADD,366)@53 + 1
    lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_cin <= lev2_a0_uid145_finalMult_uid59_sqrt_p1_of_2_c;
    lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_a <= STD_LOGIC_VECTOR("0" & lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q) & '1';
    lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_b <= STD_LOGIC_VECTOR("0" & lev2_a0_uid145_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c) & lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_cin(0);
    lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_a) + UNSIGNED(lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_q <= lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_o(6 downto 1);

    -- lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c(BITJOIN,474)@54
    lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q <= GND_q & lev2_a0_uid145_finalMult_uid59_sqrt_p2_of_2_q;

    -- lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2(ADD,375)@54 + 1
    lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_cin <= lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_c;
    lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_a <= STD_LOGIC_VECTOR("0" & lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q) & '1';
    lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_b <= STD_LOGIC_VECTOR("0" & lev3_a0_uid146_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c) & lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_cin(0);
    lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_a) + UNSIGNED(lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_q <= lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_o(7 downto 1);

    -- redist40_lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q_1(DELAY,636)
    redist40_lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q, xout => redist40_lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- lev3_a0_uid146_finalMult_uid59_sqrt_BitJoin_for_q(BITJOIN,376)@55
    lev3_a0_uid146_finalMult_uid59_sqrt_BitJoin_for_q_q <= lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_q & redist40_lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q_1_q;

    -- sR_uid156_finalMult_uid59_sqrt(BITSELECT,155)@55
    sR_uid156_finalMult_uid59_sqrt_in <= lev3_a0_uid146_finalMult_uid59_sqrt_BitJoin_for_q_q(37 downto 0);
    sR_uid156_finalMult_uid59_sqrt_b <= sR_uid156_finalMult_uid59_sqrt_in(37 downto 4);

    -- redist57_sR_uid156_finalMult_uid59_sqrt_b_1(DELAY,653)
    redist57_sR_uid156_finalMult_uid59_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sR_uid156_finalMult_uid59_sqrt_b, xout => redist57_sR_uid156_finalMult_uid59_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select(BITSELECT,583)
    ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_b <= STD_LOGIC_VECTOR(maxValInOutFormat_uid147_finalMult_uid59_sqrt_q(30 downto 0));
    ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c <= STD_LOGIC_VECTOR(maxValInOutFormat_uid147_finalMult_uid59_sqrt_q(33 downto 31));

    -- ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_b(BITJOIN,482)@54
    ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_b_q <= ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_b & zs_uid110_leadingZeros_uid7_sqrt_q;

    -- ovf_uid149_finalMult_uid59_sqrt_p1_of_2(COMPARE,383)@54 + 1
    ovf_uid149_finalMult_uid59_sqrt_p1_of_2_a <= STD_LOGIC_VECTOR("0" & ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_b_q);
    ovf_uid149_finalMult_uid59_sqrt_p1_of_2_b <= STD_LOGIC_VECTOR("0" & lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q);
    ovf_uid149_finalMult_uid59_sqrt_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                ovf_uid149_finalMult_uid59_sqrt_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    ovf_uid149_finalMult_uid59_sqrt_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(ovf_uid149_finalMult_uid59_sqrt_p1_of_2_a) - UNSIGNED(ovf_uid149_finalMult_uid59_sqrt_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    ovf_uid149_finalMult_uid59_sqrt_p1_of_2_c(0) <= ovf_uid149_finalMult_uid59_sqrt_p1_of_2_o(35);

    -- ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_c(BITJOIN,490)@55
    ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_c_q <= GND_q & lev3_a0_uid146_finalMult_uid59_sqrt_p2_of_2_q;

    -- ovf_uid149_finalMult_uid59_sqrt_UpperBits_for_a(CONSTANT,378)
    ovf_uid149_finalMult_uid59_sqrt_UpperBits_for_a_q <= "00000";

    -- ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c(BITJOIN,485)@55
    ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q <= ovf_uid149_finalMult_uid59_sqrt_UpperBits_for_a_q & ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_tessel0_1_merged_bit_select_c;

    -- ovf_uid149_finalMult_uid59_sqrt_p2_of_2(COMPARE,384)@55 + 1
    ovf_uid149_finalMult_uid59_sqrt_p2_of_2_cin <= ovf_uid149_finalMult_uid59_sqrt_p1_of_2_c;
    ovf_uid149_finalMult_uid59_sqrt_p2_of_2_a <= STD_LOGIC_VECTOR("0" & ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_a_BitJoin_for_c_q) & '0';
    ovf_uid149_finalMult_uid59_sqrt_p2_of_2_b <= STD_LOGIC_VECTOR("0" & ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_c_q) & ovf_uid149_finalMult_uid59_sqrt_p2_of_2_cin(0);
    ovf_uid149_finalMult_uid59_sqrt_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                ovf_uid149_finalMult_uid59_sqrt_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    ovf_uid149_finalMult_uid59_sqrt_p2_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(ovf_uid149_finalMult_uid59_sqrt_p2_of_2_a) - UNSIGNED(ovf_uid149_finalMult_uid59_sqrt_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    ovf_uid149_finalMult_uid59_sqrt_p2_of_2_c(0) <= ovf_uid149_finalMult_uid59_sqrt_p2_of_2_o(9);

    -- udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select(BITSELECT,584)
    udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b <= STD_LOGIC_VECTOR(minValueInFormat_uid148_finalMult_uid59_sqrt_q(30 downto 0));
    udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c <= STD_LOGIC_VECTOR(minValueInFormat_uid148_finalMult_uid59_sqrt_q(33 downto 31));

    -- udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b(BITJOIN,498)@54
    udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q <= udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_b & zs_uid110_leadingZeros_uid7_sqrt_q;

    -- udf_uid152_finalMult_uid59_sqrt_p1_of_2(COMPARE,393)@54 + 1
    udf_uid152_finalMult_uid59_sqrt_p1_of_2_a <= STD_LOGIC_VECTOR("0" & lev3_a0_uid146_finalMult_uid59_sqrt_p1_of_2_q);
    udf_uid152_finalMult_uid59_sqrt_p1_of_2_b <= STD_LOGIC_VECTOR("0" & udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_b_q);
    udf_uid152_finalMult_uid59_sqrt_p1_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                udf_uid152_finalMult_uid59_sqrt_p1_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    udf_uid152_finalMult_uid59_sqrt_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(udf_uid152_finalMult_uid59_sqrt_p1_of_2_a) - UNSIGNED(udf_uid152_finalMult_uid59_sqrt_p1_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    udf_uid152_finalMult_uid59_sqrt_p1_of_2_c(0) <= udf_uid152_finalMult_uid59_sqrt_p1_of_2_o(35);

    -- udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_c(BITJOIN,501)@55
    udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_c_q <= ovf_uid149_finalMult_uid59_sqrt_UpperBits_for_a_q & udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_tessel0_1_merged_bit_select_c;

    -- udf_uid152_finalMult_uid59_sqrt_p2_of_2(COMPARE,394)@55 + 1
    udf_uid152_finalMult_uid59_sqrt_p2_of_2_cin <= udf_uid152_finalMult_uid59_sqrt_p1_of_2_c;
    udf_uid152_finalMult_uid59_sqrt_p2_of_2_a <= STD_LOGIC_VECTOR("0" & ovf_uid149_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_c_q) & '0';
    udf_uid152_finalMult_uid59_sqrt_p2_of_2_b <= STD_LOGIC_VECTOR("0" & udf_uid152_finalMult_uid59_sqrt_BitSelect_for_b_BitJoin_for_c_q) & udf_uid152_finalMult_uid59_sqrt_p2_of_2_cin(0);
    udf_uid152_finalMult_uid59_sqrt_p2_of_2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                udf_uid152_finalMult_uid59_sqrt_p2_of_2_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    udf_uid152_finalMult_uid59_sqrt_p2_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(udf_uid152_finalMult_uid59_sqrt_p2_of_2_a) - UNSIGNED(udf_uid152_finalMult_uid59_sqrt_p2_of_2_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    udf_uid152_finalMult_uid59_sqrt_p2_of_2_c(0) <= udf_uid152_finalMult_uid59_sqrt_p2_of_2_o(9);

    -- ovfudfcond_uid155_finalMult_uid59_sqrt(BITJOIN,154)@56
    ovfudfcond_uid155_finalMult_uid59_sqrt_q <= ovf_uid149_finalMult_uid59_sqrt_p2_of_2_c & udf_uid152_finalMult_uid59_sqrt_p2_of_2_c;

    -- sRA0_uid157_finalMult_uid59_sqrt(MUX,156)@56
    sRA0_uid157_finalMult_uid59_sqrt_s <= ovfudfcond_uid155_finalMult_uid59_sqrt_q;
    sRA0_uid157_finalMult_uid59_sqrt_combproc: PROCESS (sRA0_uid157_finalMult_uid59_sqrt_s, redist57_sR_uid156_finalMult_uid59_sqrt_b_1_q, minValueInFormat_uid148_finalMult_uid59_sqrt_q, maxValInOutFormat_uid147_finalMult_uid59_sqrt_q)
    BEGIN
        CASE (sRA0_uid157_finalMult_uid59_sqrt_s) IS
            WHEN "00" => sRA0_uid157_finalMult_uid59_sqrt_q <= redist57_sR_uid156_finalMult_uid59_sqrt_b_1_q;
            WHEN "01" => sRA0_uid157_finalMult_uid59_sqrt_q <= minValueInFormat_uid148_finalMult_uid59_sqrt_q;
            WHEN "10" => sRA0_uid157_finalMult_uid59_sqrt_q <= maxValInOutFormat_uid147_finalMult_uid59_sqrt_q;
            WHEN "11" => sRA0_uid157_finalMult_uid59_sqrt_q <= maxValInOutFormat_uid147_finalMult_uid59_sqrt_q;
            WHEN OTHERS => sRA0_uid157_finalMult_uid59_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- finalMultLSBRange_uid60_sqrt(BITSELECT,59)@56
    finalMultLSBRange_uid60_sqrt_b <= sRA0_uid157_finalMult_uid59_sqrt_q(33 downto 1);

    -- negShiftOdd_uid63_sqrt(BITSELECT,62)@56
    negShiftOdd_uid63_sqrt_b <= finalMultLSBRange_uid60_sqrt_b(32 downto 32);

    -- negShiftOdd_uid64_sqrt(LOGICAL,63)@56
    negShiftOdd_uid64_sqrt_q <= not (negShiftOdd_uid63_sqrt_b);

    -- parityOddOriginalInv_uid13_sqrt(LOGICAL,12)@56
    parityOddOriginalInv_uid13_sqrt_q <= not (redist81_parityOddOriginal_uid12_sqrt_b_2_q);

    -- OddBranchAndNegUpdate_uid67_sqrt(LOGICAL,66)@56 + 1
    OddBranchAndNegUpdate_uid67_sqrt_qi <= parityOddOriginalInv_uid13_sqrt_q and negShiftOdd_uid64_sqrt_q;
    OddBranchAndNegUpdate_uid67_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => OddBranchAndNegUpdate_uid67_sqrt_qi, xout => OddBranchAndNegUpdate_uid67_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- shiftUpdateValue_uid68_sqrt(LOGICAL,67)@57
    shiftUpdateValue_uid68_sqrt_q <= OddBranchAndNegUpdate_uid67_sqrt_q or EvenBranchAndNegUpdate_uid66_sqrt_q;

    -- redist69_shiftUpdateValue_uid68_sqrt_q_1(DELAY,665)
    redist69_shiftUpdateValue_uid68_sqrt_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => shiftUpdateValue_uid68_sqrt_q, xout => redist69_shiftUpdateValue_uid68_sqrt_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- inExponent_uid9_sqrt(SUB,8)@54 + 1
    inExponent_uid9_sqrt_a <= STD_LOGIC_VECTOR("0" & shiftConstant_uid8_sqrt_q);
    inExponent_uid9_sqrt_b <= STD_LOGIC_VECTOR("0" & redist60_r_uid125_leadingZeros_uid7_sqrt_q_47_mem_q);
    inExponent_uid9_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                inExponent_uid9_sqrt_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    inExponent_uid9_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(inExponent_uid9_sqrt_a) - UNSIGNED(inExponent_uid9_sqrt_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    inExponent_uid9_sqrt_q <= inExponent_uid9_sqrt_o(6 downto 0);

    -- outExponentOdd_uid17_sqrt(ADD,16)@55
    outExponentOdd_uid17_sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((8 downto 7 => inExponent_uid9_sqrt_q(6)) & inExponent_uid9_sqrt_q));
    outExponentOdd_uid17_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000" & VCC_q));
    outExponentOdd_uid17_sqrt_o <= STD_LOGIC_VECTOR(SIGNED(outExponentOdd_uid17_sqrt_a) + SIGNED(outExponentOdd_uid17_sqrt_b));
    outExponentOdd_uid17_sqrt_q <= outExponentOdd_uid17_sqrt_o(7 downto 0);

    -- outExponentOdd_uid18_sqrt(BITSELECT,17)@55
    outExponentOdd_uid18_sqrt_in <= STD_LOGIC_VECTOR(outExponentOdd_uid17_sqrt_q(6 downto 0));
    outExponentOdd_uid18_sqrt_b <= STD_LOGIC_VECTOR(outExponentOdd_uid18_sqrt_in(6 downto 1));

    -- redist79_outExponentOdd_uid18_sqrt_b_1(DELAY,675)
    redist79_outExponentOdd_uid18_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => outExponentOdd_uid18_sqrt_b, xout => redist79_outExponentOdd_uid18_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- outExponentEven_uid19_sqrt(BITSELECT,18)@55
    outExponentEven_uid19_sqrt_b <= STD_LOGIC_VECTOR(inExponent_uid9_sqrt_q(6 downto 1));

    -- redist78_outExponentEven_uid19_sqrt_b_1(DELAY,674)
    redist78_outExponentEven_uid19_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => outExponentEven_uid19_sqrt_b, xout => redist78_outExponentEven_uid19_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- outputExponent_uid20_sqrt(MUX,19)@56 + 1
    outputExponent_uid20_sqrt_s <= parityOddOriginalInv_uid13_sqrt_q;
    outputExponent_uid20_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                outputExponent_uid20_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (outputExponent_uid20_sqrt_s) IS
                        WHEN "0" => outputExponent_uid20_sqrt_q <= redist78_outExponentEven_uid19_sqrt_b_1_q;
                        WHEN "1" => outputExponent_uid20_sqrt_q <= redist79_outExponentOdd_uid18_sqrt_b_1_q;
                        WHEN OTHERS => outputExponent_uid20_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- shiftConstant_uid8_sqrt(CONSTANT,7)
    shiftConstant_uid8_sqrt_q <= "011111";

    -- shiftOutVal_uid22_sqrt(SUB,21)@57 + 1
    shiftOutVal_uid22_sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((6 downto 6 => shiftConstant_uid8_sqrt_q(5)) & shiftConstant_uid8_sqrt_q));
    shiftOutVal_uid22_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((6 downto 6 => outputExponent_uid20_sqrt_q(5)) & outputExponent_uid20_sqrt_q));
    shiftOutVal_uid22_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                shiftOutVal_uid22_sqrt_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    shiftOutVal_uid22_sqrt_o <= STD_LOGIC_VECTOR(SIGNED(shiftOutVal_uid22_sqrt_a) - SIGNED(shiftOutVal_uid22_sqrt_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    shiftOutVal_uid22_sqrt_q <= shiftOutVal_uid22_sqrt_o(6 downto 0);

    -- shiftOutValUpdated_uid75_sqrt(ADD,74)@58 + 1
    shiftOutValUpdated_uid75_sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((8 downto 7 => shiftOutVal_uid22_sqrt_q(6)) & shiftOutVal_uid22_sqrt_q));
    shiftOutValUpdated_uid75_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000" & redist69_shiftUpdateValue_uid68_sqrt_q_1_q));
    shiftOutValUpdated_uid75_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                shiftOutValUpdated_uid75_sqrt_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    shiftOutValUpdated_uid75_sqrt_o <= STD_LOGIC_VECTOR(SIGNED(shiftOutValUpdated_uid75_sqrt_a) + SIGNED(shiftOutValUpdated_uid75_sqrt_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    shiftOutValUpdated_uid75_sqrt_q <= shiftOutValUpdated_uid75_sqrt_o(7 downto 0);

    -- shiftedOut_uid281_xRightShiftFinal_uid78_sqrt(COMPARE,280)@59 + 1
    shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_a <= STD_LOGIC_VECTOR("00" & shiftOutValUpdated_uid75_sqrt_q);
    shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_b <= STD_LOGIC_VECTOR("0000" & wIntCst_uid280_xRightShiftFinal_uid78_sqrt_q);
    shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_a) - UNSIGNED(shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n(0) <= not (shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_o(9));

    -- redist43_shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n_2(DELAY,639)
    redist43_shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n, xout => redist43_shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n_2_q, ena => en(0), clk => clk, aclr => rst );

    -- rightShiftStage2Idx2Rng32_uid307_xRightShiftFinal_uid78_sqrt(BITSELECT,306)@60
    rightShiftStage2Idx2Rng32_uid307_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q(32 downto 32);

    -- rightShiftStage2Idx2_uid309_xRightShiftFinal_uid78_sqrt(BITJOIN,308)@60
    rightShiftStage2Idx2_uid309_xRightShiftFinal_uid78_sqrt_q <= zs_uid92_leadingZeros_uid7_sqrt_q & rightShiftStage2Idx2Rng32_uid307_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage2Idx1Rng16_uid304_xRightShiftFinal_uid78_sqrt(BITSELECT,303)@60
    rightShiftStage2Idx1Rng16_uid304_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q(32 downto 16);

    -- rightShiftStage2Idx1_uid306_xRightShiftFinal_uid78_sqrt(BITJOIN,305)@60
    rightShiftStage2Idx1_uid306_xRightShiftFinal_uid78_sqrt_q <= zs_uid98_leadingZeros_uid7_sqrt_q & rightShiftStage2Idx1Rng16_uid304_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage1Idx3Rng12_uid299_xRightShiftFinal_uid78_sqrt(BITSELECT,298)@59
    rightShiftStage1Idx3Rng12_uid299_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q(32 downto 12);

    -- rightShiftStage1Idx3_uid301_xRightShiftFinal_uid78_sqrt(BITJOIN,300)@59
    rightShiftStage1Idx3_uid301_xRightShiftFinal_uid78_sqrt_q <= leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt_q & rightShiftStage1Idx3Rng12_uid299_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage1Idx2Rng8_uid296_xRightShiftFinal_uid78_sqrt(BITSELECT,295)@59
    rightShiftStage1Idx2Rng8_uid296_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q(32 downto 8);

    -- rightShiftStage1Idx2_uid298_xRightShiftFinal_uid78_sqrt(BITJOIN,297)@59
    rightShiftStage1Idx2_uid298_xRightShiftFinal_uid78_sqrt_q <= zs_uid104_leadingZeros_uid7_sqrt_q & rightShiftStage1Idx2Rng8_uid296_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage1Idx1Rng4_uid293_xRightShiftFinal_uid78_sqrt(BITSELECT,292)@59
    rightShiftStage1Idx1Rng4_uid293_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q(32 downto 4);

    -- rightShiftStage1Idx1_uid295_xRightShiftFinal_uid78_sqrt(BITJOIN,294)@59
    rightShiftStage1Idx1_uid295_xRightShiftFinal_uid78_sqrt_q <= zs_uid110_leadingZeros_uid7_sqrt_q & rightShiftStage1Idx1Rng4_uid293_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage0Idx3Rng3_uid288_xRightShiftFinal_uid78_sqrt(BITSELECT,287)@59
    rightShiftStage0Idx3Rng3_uid288_xRightShiftFinal_uid78_sqrt_b <= redist67_shifterInData_uid74_sqrt_q_2_q(32 downto 3);

    -- rightShiftStage0Idx3_uid290_xRightShiftFinal_uid78_sqrt(BITJOIN,289)@59
    rightShiftStage0Idx3_uid290_xRightShiftFinal_uid78_sqrt_q <= leftShiftStage2Idx3Pad3_uid213_xLeftShift_uid23_sqrt_q & rightShiftStage0Idx3Rng3_uid288_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage0Idx2Rng2_uid285_xRightShiftFinal_uid78_sqrt(BITSELECT,284)@59
    rightShiftStage0Idx2Rng2_uid285_xRightShiftFinal_uid78_sqrt_b <= redist67_shifterInData_uid74_sqrt_q_2_q(32 downto 2);

    -- rightShiftStage0Idx2_uid287_xRightShiftFinal_uid78_sqrt(BITJOIN,286)@59
    rightShiftStage0Idx2_uid287_xRightShiftFinal_uid78_sqrt_q <= zs_uid116_leadingZeros_uid7_sqrt_q & rightShiftStage0Idx2Rng2_uid285_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage0Idx1Rng1_uid282_xRightShiftFinal_uid78_sqrt(BITSELECT,281)@59
    rightShiftStage0Idx1Rng1_uid282_xRightShiftFinal_uid78_sqrt_b <= redist67_shifterInData_uid74_sqrt_q_2_q(32 downto 1);

    -- rightShiftStage0Idx1_uid284_xRightShiftFinal_uid78_sqrt(BITJOIN,283)@59
    rightShiftStage0Idx1_uid284_xRightShiftFinal_uid78_sqrt_q <= GND_q & rightShiftStage0Idx1Rng1_uid282_xRightShiftFinal_uid78_sqrt_b;

    -- finalMultBottomBits_uid70_sqrt(BITSELECT,69)@56
    finalMultBottomBits_uid70_sqrt_in <= sRA0_uid157_finalMult_uid59_sqrt_q(32 downto 0);
    finalMultBottomBits_uid70_sqrt_b <= finalMultBottomBits_uid70_sqrt_in(32 downto 0);

    -- redist68_finalMultBottomBits_uid70_sqrt_b_1(DELAY,664)
    redist68_finalMultBottomBits_uid70_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => finalMultBottomBits_uid70_sqrt_b, xout => redist68_finalMultBottomBits_uid70_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist73_result_uid58_sqrt_b_7(DELAY,669)
    redist73_result_uid58_sqrt_b_7 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist72_result_uid58_sqrt_b_6_mem_q, xout => redist73_result_uid58_sqrt_b_7_q, ena => en(0), clk => clk, aclr => rst );

    -- resultBottomBits_uid71_sqrt(BITSELECT,70)@57
    resultBottomBits_uid71_sqrt_in <= redist73_result_uid58_sqrt_b_7_q(32 downto 0);
    resultBottomBits_uid71_sqrt_b <= resultBottomBits_uid71_sqrt_in(32 downto 0);

    -- redist70_finalMultLSBRange_uid60_sqrt_b_1(DELAY,666)
    redist70_finalMultLSBRange_uid60_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => finalMultLSBRange_uid60_sqrt_b, xout => redist70_finalMultLSBRange_uid60_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultUpperRange_uid73_sqrt(BITSELECT,72)@57
    resultUpperRange_uid73_sqrt_b <= redist73_result_uid58_sqrt_b_7_q(33 downto 1);

    -- redist80_parityOddOriginalInv_uid13_sqrt_q_1(DELAY,676)
    redist80_parityOddOriginalInv_uid13_sqrt_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => parityOddOriginalInv_uid13_sqrt_q, xout => redist80_parityOddOriginalInv_uid13_sqrt_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- negShiftEvenParityOdd_uid69_sqrt(BITJOIN,68)@57
    negShiftEvenParityOdd_uid69_sqrt_q <= shiftUpdateValue_uid68_sqrt_q & redist80_parityOddOriginalInv_uid13_sqrt_q_1_q;

    -- shifterInData_uid74_sqrt(MUX,73)@57 + 1
    shifterInData_uid74_sqrt_s <= negShiftEvenParityOdd_uid69_sqrt_q;
    shifterInData_uid74_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                shifterInData_uid74_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (shifterInData_uid74_sqrt_s) IS
                        WHEN "00" => shifterInData_uid74_sqrt_q <= resultUpperRange_uid73_sqrt_b;
                        WHEN "01" => shifterInData_uid74_sqrt_q <= redist70_finalMultLSBRange_uid60_sqrt_b_1_q;
                        WHEN "10" => shifterInData_uid74_sqrt_q <= resultBottomBits_uid71_sqrt_b;
                        WHEN "11" => shifterInData_uid74_sqrt_q <= redist68_finalMultBottomBits_uid70_sqrt_b_1_q;
                        WHEN OTHERS => shifterInData_uid74_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist67_shifterInData_uid74_sqrt_q_2(DELAY,663)
    redist67_shifterInData_uid74_sqrt_q_2 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => shifterInData_uid74_sqrt_q, xout => redist67_shifterInData_uid74_sqrt_q_2_q, ena => en(0), clk => clk, aclr => rst );

    -- rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt(BITSELECT,290)@59
    rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_in <= shiftOutValUpdated_uid75_sqrt_q(1 downto 0);
    rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_b <= rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_in(1 downto 0);

    -- rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt(MUX,291)@59
    rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_s <= rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_b;
    rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_combproc: PROCESS (rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_s, redist67_shifterInData_uid74_sqrt_q_2_q, rightShiftStage0Idx1_uid284_xRightShiftFinal_uid78_sqrt_q, rightShiftStage0Idx2_uid287_xRightShiftFinal_uid78_sqrt_q, rightShiftStage0Idx3_uid290_xRightShiftFinal_uid78_sqrt_q)
    BEGIN
        CASE (rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_s) IS
            WHEN "00" => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= redist67_shifterInData_uid74_sqrt_q_2_q;
            WHEN "01" => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage0Idx1_uid284_xRightShiftFinal_uid78_sqrt_q;
            WHEN "10" => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage0Idx2_uid287_xRightShiftFinal_uid78_sqrt_q;
            WHEN "11" => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage0Idx3_uid290_xRightShiftFinal_uid78_sqrt_q;
            WHEN OTHERS => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt(BITSELECT,301)@59
    rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_in <= shiftOutValUpdated_uid75_sqrt_q(3 downto 0);
    rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_b <= rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_in(3 downto 2);

    -- rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt(MUX,302)@59 + 1
    rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_s <= rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_b;
    rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_s) IS
                        WHEN "00" => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q;
                        WHEN "01" => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage1Idx1_uid295_xRightShiftFinal_uid78_sqrt_q;
                        WHEN "10" => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage1Idx2_uid298_xRightShiftFinal_uid78_sqrt_q;
                        WHEN "11" => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage1Idx3_uid301_xRightShiftFinal_uid78_sqrt_q;
                        WHEN OTHERS => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt(BITSELECT,310)@59
    rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_in <= shiftOutValUpdated_uid75_sqrt_q(5 downto 0);
    rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b <= rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_in(5 downto 4);

    -- redist42_rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b_1(DELAY,638)
    redist42_rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b, xout => redist42_rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt(MUX,311)@60 + 1
    rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_s <= redist42_rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b_1_q;
    rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_s) IS
                        WHEN "00" => rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q;
                        WHEN "01" => rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage2Idx1_uid306_xRightShiftFinal_uid78_sqrt_q;
                        WHEN "10" => rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage2Idx2_uid309_xRightShiftFinal_uid78_sqrt_q;
                        WHEN "11" => rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_q <= padACst_uid51_sqrt_q;
                        WHEN OTHERS => rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- resultFinalPostRnd_uid82_sqrt(ADD,81)@61
    resultFinalPostRnd_uid82_sqrt_a <= STD_LOGIC_VECTOR("0" & rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_q);
    resultFinalPostRnd_uid82_sqrt_b <= STD_LOGIC_VECTOR("000000000000000000000000000000000" & VCC_q);
    resultFinalPostRnd_uid82_sqrt_i <= resultFinalPostRnd_uid82_sqrt_b;
    resultFinalPostRnd_uid82_sqrt_a1 <= resultFinalPostRnd_uid82_sqrt_i WHEN redist43_shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n_2_q = "1" ELSE resultFinalPostRnd_uid82_sqrt_a;
    resultFinalPostRnd_uid82_sqrt_b1 <= (others => '0') WHEN redist43_shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n_2_q = "1" ELSE resultFinalPostRnd_uid82_sqrt_b;
    resultFinalPostRnd_uid82_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(resultFinalPostRnd_uid82_sqrt_a1) + UNSIGNED(resultFinalPostRnd_uid82_sqrt_b1));
    resultFinalPostRnd_uid82_sqrt_q <= resultFinalPostRnd_uid82_sqrt_o(33 downto 0);

    -- resultFinalPreSat_uid83_sqrt_merged_bit_select(BITSELECT,576)@61
    resultFinalPreSat_uid83_sqrt_merged_bit_select_b <= resultFinalPostRnd_uid82_sqrt_q(32 downto 1);
    resultFinalPreSat_uid83_sqrt_merged_bit_select_c <= resultFinalPostRnd_uid82_sqrt_q(33 downto 33);

    -- redist14_resultFinalPreSat_uid83_sqrt_merged_bit_select_c_1(DELAY,610)
    redist14_resultFinalPreSat_uid83_sqrt_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFinalPreSat_uid83_sqrt_merged_bit_select_c, xout => redist14_resultFinalPreSat_uid83_sqrt_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => rst );

    -- sat_uid76_sqrt(BITSELECT,75)@59
    sat_uid76_sqrt_b <= STD_LOGIC_VECTOR(shiftOutValUpdated_uid75_sqrt_q(7 downto 7));

    -- redist66_sat_uid76_sqrt_b_3(DELAY,662)
    redist66_sat_uid76_sqrt_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sat_uid76_sqrt_b, xout => redist66_sat_uid76_sqrt_b_3_q, ena => en(0), clk => clk, aclr => rst );

    -- satOrOvfPostRnd_uid85_sqrt(LOGICAL,84)@62
    satOrOvfPostRnd_uid85_sqrt_q <= redist66_sat_uid76_sqrt_b_3_q or redist14_resultFinalPreSat_uid83_sqrt_merged_bit_select_c_1_q;

    -- redist13_resultFinalPreSat_uid83_sqrt_merged_bit_select_b_1(DELAY,609)
    redist13_resultFinalPreSat_uid83_sqrt_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFinalPreSat_uid83_sqrt_merged_bit_select_b, xout => redist13_resultFinalPreSat_uid83_sqrt_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultFinalPostOvf_uid86_sqrt(LOGICAL,85)@62 + 1
    resultFinalPostOvf_uid86_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 1 => satOrOvfPostRnd_uid85_sqrt_q(0)) & satOrOvfPostRnd_uid85_sqrt_q));
    resultFinalPostOvf_uid86_sqrt_qi <= redist13_resultFinalPreSat_uid83_sqrt_merged_bit_select_b_1_q or resultFinalPostOvf_uid86_sqrt_b;
    resultFinalPostOvf_uid86_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFinalPostOvf_uid86_sqrt_qi, xout => resultFinalPostOvf_uid86_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- resultFinal_uid90_sqrt(LOGICAL,89)@63
    resultFinal_uid90_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 1 => inputNotAllZeros_uid89_sqrt_q(0)) & inputNotAllZeros_uid89_sqrt_q));
    resultFinal_uid90_sqrt_q <= resultFinalPostOvf_uid86_sqrt_q and resultFinal_uid90_sqrt_b;

    -- out_rsrvd_fix(GPOUT,4)@63
    result <= resultFinal_uid90_sqrt_q;

END normal;
