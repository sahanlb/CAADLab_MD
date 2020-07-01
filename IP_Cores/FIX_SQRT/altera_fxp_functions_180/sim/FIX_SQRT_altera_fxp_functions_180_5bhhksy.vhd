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

-- VHDL created from FIX_SQRT_altera_fxp_functions_180_5bhhksy
-- VHDL created on Thu Mar 28 19:10:29 2019


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

entity FIX_SQRT_altera_fxp_functions_180_5bhhksy is
    port (
        radical : in std_logic_vector(31 downto 0);  -- ufix32
        en : in std_logic_vector(0 downto 0);  -- ufix1
        result : out std_logic_vector(31 downto 0);  -- ufix32
        clk : in std_logic;
        rst : in std_logic
    );
end FIX_SQRT_altera_fxp_functions_180_5bhhksy;

architecture normal of FIX_SQRT_altera_fxp_functions_180_5bhhksy is

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
    signal a1TableOut_xored_uid41_sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal initApproxFull_uid43_sqrt_a : STD_LOGIC_VECTOR (22 downto 0);
    signal initApproxFull_uid43_sqrt_b : STD_LOGIC_VECTOR (22 downto 0);
    signal initApproxFull_uid43_sqrt_o : STD_LOGIC_VECTOR (22 downto 0);
    signal initApproxFull_uid43_sqrt_q : STD_LOGIC_VECTOR (21 downto 0);
    signal initApprox_uid44_sqrt_in : STD_LOGIC_VECTOR (19 downto 0);
    signal initApprox_uid44_sqrt_b : STD_LOGIC_VECTOR (19 downto 0);
    signal initApproxSquared_uid46_sqrt_in : STD_LOGIC_VECTOR (38 downto 0);
    signal initApproxSquared_uid46_sqrt_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xMulInitApproxSquared_uid48_sqrt_in : STD_LOGIC_VECTOR (69 downto 0);
    signal xMulInitApproxSquared_uid48_sqrt_b : STD_LOGIC_VECTOR (33 downto 0);
    signal oneAndHalf_uid50_sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal padACst_uid51_sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal aPostPad_uid52_sqrt_q : STD_LOGIC_VECTOR (34 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_a : STD_LOGIC_VECTOR (35 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_b : STD_LOGIC_VECTOR (35 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_o : STD_LOGIC_VECTOR (35 downto 0);
    signal oneAndHalfSubXMIASFull_uid53_sqrt_q : STD_LOGIC_VECTOR (35 downto 0);
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
    signal EvenBranchAndNegUpdate_uid66_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
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
    signal vCount_uid100_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_leadingZeros_uid7_sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (15 downto 0);
    signal zs_uid104_leadingZeros_uid7_sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
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
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_a : STD_LOGIC_VECTOR (38 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (38 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_o : STD_LOGIC_VECTOR (38 downto 0);
    signal lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (38 downto 0);
    signal lev1_a0_uid142_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (39 downto 0);
    signal lev1_a1_uid143_finalMult_uid59_sqrt_a : STD_LOGIC_VECTOR (28 downto 0);
    signal lev1_a1_uid143_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (28 downto 0);
    signal lev1_a1_uid143_finalMult_uid59_sqrt_o : STD_LOGIC_VECTOR (28 downto 0);
    signal lev1_a1_uid143_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (28 downto 0);
    signal lev1_a2_uid144_finalMult_uid59_sqrt_a : STD_LOGIC_VECTOR (16 downto 0);
    signal lev1_a2_uid144_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (16 downto 0);
    signal lev1_a2_uid144_finalMult_uid59_sqrt_o : STD_LOGIC_VECTOR (16 downto 0);
    signal lev1_a2_uid144_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (16 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_a : STD_LOGIC_VECTOR (40 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (40 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_o : STD_LOGIC_VECTOR (40 downto 0);
    signal lev2_a0_uid145_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (40 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_a : STD_LOGIC_VECTOR (41 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (41 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_o : STD_LOGIC_VECTOR (41 downto 0);
    signal lev3_a0_uid146_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (41 downto 0);
    signal maxValInOutFormat_uid147_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (33 downto 0);
    signal minValueInFormat_uid148_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (33 downto 0);
    signal updatedX_uid150_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (37 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_a : STD_LOGIC_VECTOR (43 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (43 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_o : STD_LOGIC_VECTOR (43 downto 0);
    signal ovf_uid149_finalMult_uid59_sqrt_c : STD_LOGIC_VECTOR (0 downto 0);
    signal updatedY_uid153_finalMult_uid59_sqrt_q : STD_LOGIC_VECTOR (37 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_a : STD_LOGIC_VECTOR (43 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_b : STD_LOGIC_VECTOR (43 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_o : STD_LOGIC_VECTOR (43 downto 0);
    signal udf_uid152_finalMult_uid59_sqrt_c : STD_LOGIC_VECTOR (0 downto 0);
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
    signal xMulInitApproxSquaredFull_uid47_sqrt_join_20_q : STD_LOGIC_VECTOR (70 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_align_21_q : STD_LOGIC_VECTOR (54 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_align_21_qint : STD_LOGIC_VECTOR (54 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_align_23_q : STD_LOGIC_VECTOR (70 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_align_23_qint : STD_LOGIC_VECTOR (70 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_a : STD_LOGIC_VECTOR (72 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_b : STD_LOGIC_VECTOR (72 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_o : STD_LOGIC_VECTOR (72 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_q : STD_LOGIC_VECTOR (71 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_a : STD_LOGIC_VECTOR (73 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_b : STD_LOGIC_VECTOR (73 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_o : STD_LOGIC_VECTOR (73 downto 0);
    signal xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_q : STD_LOGIC_VECTOR (72 downto 0);
    signal resultFull_uid55_sqrt_align_7_q : STD_LOGIC_VECTOR (54 downto 0);
    signal resultFull_uid55_sqrt_align_7_qint : STD_LOGIC_VECTOR (54 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_a : STD_LOGIC_VECTOR (55 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_b : STD_LOGIC_VECTOR (55 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_o : STD_LOGIC_VECTOR (55 downto 0);
    signal resultFull_uid55_sqrt_result_add_0_0_q : STD_LOGIC_VECTOR (55 downto 0);
    signal resultMultFull_uid57_sqrt_bs1_in : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_bs1_b : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_bs4_b : STD_LOGIC_VECTOR (15 downto 0);
    signal resultMultFull_uid57_sqrt_bjA5_q : STD_LOGIC_VECTOR (16 downto 0);
    signal resultMultFull_uid57_sqrt_bs8_in : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_bs8_b : STD_LOGIC_VECTOR (17 downto 0);
    signal resultMultFull_uid57_sqrt_bjA9_q : STD_LOGIC_VECTOR (18 downto 0);
    signal resultMultFull_uid57_sqrt_bs13_b : STD_LOGIC_VECTOR (15 downto 0);
    signal resultMultFull_uid57_sqrt_join_15_q : STD_LOGIC_VECTOR (65 downto 0);
    signal resultMultFull_uid57_sqrt_align_16_q : STD_LOGIC_VECTOR (54 downto 0);
    signal resultMultFull_uid57_sqrt_align_16_qint : STD_LOGIC_VECTOR (54 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_a : STD_LOGIC_VECTOR (68 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_b : STD_LOGIC_VECTOR (68 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_o : STD_LOGIC_VECTOR (68 downto 0);
    signal resultMultFull_uid57_sqrt_result_add_0_0_q : STD_LOGIC_VECTOR (67 downto 0);
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
    signal lowRangeB_uid139_finalMult_uid59_sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid139_finalMult_uid59_sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (32 downto 0);
    signal redist2_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist6_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist8_sR_uid156_finalMult_uid59_sqrt_b_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist10_vCount_uid112_leadingZeros_uid7_sqrt_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_vCount_uid106_leadingZeros_uid7_sqrt_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_vCount_uid100_leadingZeros_uid7_sqrt_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_vCount_uid94_leadingZeros_uid7_sqrt_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_inputAllZeros_uid88_sqrt_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_sat_uid76_sqrt_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_shiftUpdateValue_uid68_sqrt_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_result_uid58_sqrt_b_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist18_result_uid58_sqrt_b_3_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist19_resultPreMultX_uid56_sqrt_b_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist20_xMulInitApproxSquared_uid48_sqrt_b_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist22_x2_msb_uid29_sqrt_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_x0_uid25_sqrt_b_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist24_in_rsrvd_fix_radical_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist25_in_rsrvd_fix_radical_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_inputreg0_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_outputreg0_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_reset0 : std_logic;
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_ia : STD_LOGIC_VECTOR (18 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_iq : STD_LOGIC_VECTOR (18 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_enaOr_rst : std_logic;
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_i : signal is true;
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_eq : signal is true;
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_sticky_ena_q : signal is true;
    signal redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_inputreg0_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_outputreg0_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_reset0 : std_logic;
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_ia : STD_LOGIC_VECTOR (14 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_iq : STD_LOGIC_VECTOR (14 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_enaOr_rst : std_logic;
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_i : signal is true;
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_eq : signal is true;
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_sticky_ena_q : signal is true;
    signal redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_outputreg0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_reset0 : std_logic;
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_iq : STD_LOGIC_VECTOR (13 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_enaOr_rst : std_logic;
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_i : signal is true;
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_eq : signal is true;
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_sticky_ena_q : signal is true;
    signal redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_inputreg0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_outputreg0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_reset0 : std_logic;
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_ia : STD_LOGIC_VECTOR (17 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_iq : STD_LOGIC_VECTOR (17 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_enaOr_rst : std_logic;
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_i : signal is true;
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_eq : signal is true;
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_sticky_ena_q : signal is true;
    signal redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_reset0 : std_logic;
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_enaOr_rst : std_logic;
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_i : signal is true;
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_eq : signal is true;
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_sticky_ena_q : signal is true;
    signal redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_outputreg0_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_reset0 : std_logic;
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_ia : STD_LOGIC_VECTOR (5 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_iq : STD_LOGIC_VECTOR (5 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_enaOr_rst : std_logic;
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_i : signal is true;
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_eq : signal is true;
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_sticky_ena_q : signal is true;
    signal redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_inputreg0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_outputreg0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_mem_reset0 : std_logic;
    signal redist21_initApprox_uid44_sqrt_b_12_mem_ia : STD_LOGIC_VECTOR (19 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_mem_iq : STD_LOGIC_VECTOR (19 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_mem_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_mem_enaOr_rst : std_logic;
    signal redist21_initApprox_uid44_sqrt_b_12_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist21_initApprox_uid44_sqrt_b_12_rdcnt_i : signal is true;
    signal redist21_initApprox_uid44_sqrt_b_12_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist21_initApprox_uid44_sqrt_b_12_rdcnt_eq : signal is true;
    signal redist21_initApprox_uid44_sqrt_b_12_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_rdmux_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_initApprox_uid44_sqrt_b_12_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist21_initApprox_uid44_sqrt_b_12_sticky_ena_q : signal is true;
    signal redist21_initApprox_uid44_sqrt_b_12_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- cstW_uid87_sqrt(CONSTANT,86)
    cstW_uid87_sqrt_q <= "100000";

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_notEnable(LOGICAL,456)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_nor(LOGICAL,457)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_nor_q <= not (redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_notEnable_q or redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_sticky_ena_q);

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_last(CONSTANT,453)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_last_q <= "011001";

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmp(LOGICAL,454)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmp_b <= STD_LOGIC_VECTOR("0" & redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_q);
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmp_q <= "1" WHEN redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_last_q = redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmp_b ELSE "0";

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmpReg(REG,455)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmpReg_q <= STD_LOGIC_VECTOR(redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_sticky_ena(REG,458)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_sticky_ena_q <= "0";
            ELSE
                IF (redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_nor_q = "1") THEN
                    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_sticky_ena_q <= STD_LOGIC_VECTOR(redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_enaAnd(LOGICAL,459)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_enaAnd_q <= redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_sticky_ena_q and en;

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt(COUNTER,450)
    -- low=0, high=26, step=1, init=0
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_i = TO_UNSIGNED(25, 5)) THEN
                        redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_eq <= '1';
                    ELSE
                        redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_eq <= '0';
                    END IF;
                    IF (redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_eq = '1') THEN
                        redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_i <= redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_i + 6;
                    ELSE
                        redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_i <= redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_i, 5)));

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux(MUX,451)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_s <= en;
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_combproc: PROCESS (redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_s, redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_wraddr_q, redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_q)
    BEGIN
        CASE (redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_s) IS
            WHEN "0" => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_q <= redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_wraddr_q;
            WHEN "1" => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_q <= redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdcnt_q;
            WHEN OTHERS => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- zs_uid92_leadingZeros_uid7_sqrt(CONSTANT,91)
    zs_uid92_leadingZeros_uid7_sqrt_q <= "00000000000000000000000000000000";

    -- vCount_uid94_leadingZeros_uid7_sqrt(LOGICAL,93)@0 + 1
    vCount_uid94_leadingZeros_uid7_sqrt_qi <= "1" WHEN radical = zs_uid92_leadingZeros_uid7_sqrt_q ELSE "0";
    vCount_uid94_leadingZeros_uid7_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid94_leadingZeros_uid7_sqrt_qi, xout => vCount_uid94_leadingZeros_uid7_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- redist13_vCount_uid94_leadingZeros_uid7_sqrt_q_3(DELAY,372)
    redist13_vCount_uid94_leadingZeros_uid7_sqrt_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid94_leadingZeros_uid7_sqrt_q, xout => redist13_vCount_uid94_leadingZeros_uid7_sqrt_q_3_q, ena => en(0), clk => clk, aclr => rst );

    -- zs_uid98_leadingZeros_uid7_sqrt(CONSTANT,97)
    zs_uid98_leadingZeros_uid7_sqrt_q <= "0000000000000000";

    -- mO_uid95_leadingZeros_uid7_sqrt(CONSTANT,94)
    mO_uid95_leadingZeros_uid7_sqrt_q <= "11111111111111111111111111111111";

    -- redist24_in_rsrvd_fix_radical_1(DELAY,383)
    redist24_in_rsrvd_fix_radical_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => radical, xout => redist24_in_rsrvd_fix_radical_1_q, ena => en(0), clk => clk, aclr => rst );

    -- vStagei_uid97_leadingZeros_uid7_sqrt(MUX,96)@1
    vStagei_uid97_leadingZeros_uid7_sqrt_s <= vCount_uid94_leadingZeros_uid7_sqrt_q;
    vStagei_uid97_leadingZeros_uid7_sqrt_combproc: PROCESS (vStagei_uid97_leadingZeros_uid7_sqrt_s, redist24_in_rsrvd_fix_radical_1_q, mO_uid95_leadingZeros_uid7_sqrt_q)
    BEGIN
        CASE (vStagei_uid97_leadingZeros_uid7_sqrt_s) IS
            WHEN "0" => vStagei_uid97_leadingZeros_uid7_sqrt_q <= redist24_in_rsrvd_fix_radical_1_q;
            WHEN "1" => vStagei_uid97_leadingZeros_uid7_sqrt_q <= mO_uid95_leadingZeros_uid7_sqrt_q;
            WHEN OTHERS => vStagei_uid97_leadingZeros_uid7_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select(BITSELECT,354)@1
    rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b <= vStagei_uid97_leadingZeros_uid7_sqrt_q(31 downto 16);
    rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c <= vStagei_uid97_leadingZeros_uid7_sqrt_q(15 downto 0);

    -- vCount_uid100_leadingZeros_uid7_sqrt(LOGICAL,99)@1
    vCount_uid100_leadingZeros_uid7_sqrt_q <= "1" WHEN rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b = zs_uid98_leadingZeros_uid7_sqrt_q ELSE "0";

    -- redist12_vCount_uid100_leadingZeros_uid7_sqrt_q_2(DELAY,371)
    redist12_vCount_uid100_leadingZeros_uid7_sqrt_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid100_leadingZeros_uid7_sqrt_q, xout => redist12_vCount_uid100_leadingZeros_uid7_sqrt_q_2_q, ena => en(0), clk => clk, aclr => rst );

    -- zs_uid104_leadingZeros_uid7_sqrt(CONSTANT,103)
    zs_uid104_leadingZeros_uid7_sqrt_q <= "00000000";

    -- vStagei_uid103_leadingZeros_uid7_sqrt(MUX,102)@1 + 1
    vStagei_uid103_leadingZeros_uid7_sqrt_s <= vCount_uid100_leadingZeros_uid7_sqrt_q;
    vStagei_uid103_leadingZeros_uid7_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                vStagei_uid103_leadingZeros_uid7_sqrt_q <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    CASE (vStagei_uid103_leadingZeros_uid7_sqrt_s) IS
                        WHEN "0" => vStagei_uid103_leadingZeros_uid7_sqrt_q <= rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_b;
                        WHEN "1" => vStagei_uid103_leadingZeros_uid7_sqrt_q <= rVStage_uid99_leadingZeros_uid7_sqrt_merged_bit_select_c;
                        WHEN OTHERS => vStagei_uid103_leadingZeros_uid7_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select(BITSELECT,355)@2
    rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b <= vStagei_uid103_leadingZeros_uid7_sqrt_q(15 downto 8);
    rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c <= vStagei_uid103_leadingZeros_uid7_sqrt_q(7 downto 0);

    -- vCount_uid106_leadingZeros_uid7_sqrt(LOGICAL,105)@2
    vCount_uid106_leadingZeros_uid7_sqrt_q <= "1" WHEN rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b = zs_uid104_leadingZeros_uid7_sqrt_q ELSE "0";

    -- redist11_vCount_uid106_leadingZeros_uid7_sqrt_q_1(DELAY,370)
    redist11_vCount_uid106_leadingZeros_uid7_sqrt_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid106_leadingZeros_uid7_sqrt_q, xout => redist11_vCount_uid106_leadingZeros_uid7_sqrt_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- zs_uid110_leadingZeros_uid7_sqrt(CONSTANT,109)
    zs_uid110_leadingZeros_uid7_sqrt_q <= "0000";

    -- vStagei_uid109_leadingZeros_uid7_sqrt(MUX,108)@2
    vStagei_uid109_leadingZeros_uid7_sqrt_s <= vCount_uid106_leadingZeros_uid7_sqrt_q;
    vStagei_uid109_leadingZeros_uid7_sqrt_combproc: PROCESS (vStagei_uid109_leadingZeros_uid7_sqrt_s, rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b, rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid109_leadingZeros_uid7_sqrt_s) IS
            WHEN "0" => vStagei_uid109_leadingZeros_uid7_sqrt_q <= rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_b;
            WHEN "1" => vStagei_uid109_leadingZeros_uid7_sqrt_q <= rVStage_uid105_leadingZeros_uid7_sqrt_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid109_leadingZeros_uid7_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select(BITSELECT,356)@2
    rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_b <= vStagei_uid109_leadingZeros_uid7_sqrt_q(7 downto 4);
    rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_c <= vStagei_uid109_leadingZeros_uid7_sqrt_q(3 downto 0);

    -- vCount_uid112_leadingZeros_uid7_sqrt(LOGICAL,111)@2
    vCount_uid112_leadingZeros_uid7_sqrt_q <= "1" WHEN rVStage_uid111_leadingZeros_uid7_sqrt_merged_bit_select_b = zs_uid110_leadingZeros_uid7_sqrt_q ELSE "0";

    -- redist10_vCount_uid112_leadingZeros_uid7_sqrt_q_1(DELAY,369)
    redist10_vCount_uid112_leadingZeros_uid7_sqrt_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => vCount_uid112_leadingZeros_uid7_sqrt_q, xout => redist10_vCount_uid112_leadingZeros_uid7_sqrt_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- zs_uid116_leadingZeros_uid7_sqrt(CONSTANT,115)
    zs_uid116_leadingZeros_uid7_sqrt_q <= "00";

    -- vStagei_uid115_leadingZeros_uid7_sqrt(MUX,114)@2 + 1
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

    -- rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select(BITSELECT,357)@3
    rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_b <= vStagei_uid115_leadingZeros_uid7_sqrt_q(3 downto 2);
    rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_c <= vStagei_uid115_leadingZeros_uid7_sqrt_q(1 downto 0);

    -- vCount_uid118_leadingZeros_uid7_sqrt(LOGICAL,117)@3
    vCount_uid118_leadingZeros_uid7_sqrt_q <= "1" WHEN rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_b = zs_uid116_leadingZeros_uid7_sqrt_q ELSE "0";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- vStagei_uid121_leadingZeros_uid7_sqrt(MUX,120)@3
    vStagei_uid121_leadingZeros_uid7_sqrt_s <= vCount_uid118_leadingZeros_uid7_sqrt_q;
    vStagei_uid121_leadingZeros_uid7_sqrt_combproc: PROCESS (vStagei_uid121_leadingZeros_uid7_sqrt_s, rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_b, rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid121_leadingZeros_uid7_sqrt_s) IS
            WHEN "0" => vStagei_uid121_leadingZeros_uid7_sqrt_q <= rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_b;
            WHEN "1" => vStagei_uid121_leadingZeros_uid7_sqrt_q <= rVStage_uid117_leadingZeros_uid7_sqrt_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid121_leadingZeros_uid7_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid123_leadingZeros_uid7_sqrt(BITSELECT,122)@3
    rVStage_uid123_leadingZeros_uid7_sqrt_b <= vStagei_uid121_leadingZeros_uid7_sqrt_q(1 downto 1);

    -- vCount_uid124_leadingZeros_uid7_sqrt(LOGICAL,123)@3
    vCount_uid124_leadingZeros_uid7_sqrt_q <= "1" WHEN rVStage_uid123_leadingZeros_uid7_sqrt_b = GND_q ELSE "0";

    -- r_uid125_leadingZeros_uid7_sqrt(BITJOIN,124)@3
    r_uid125_leadingZeros_uid7_sqrt_q <= redist13_vCount_uid94_leadingZeros_uid7_sqrt_q_3_q & redist12_vCount_uid100_leadingZeros_uid7_sqrt_q_2_q & redist11_vCount_uid106_leadingZeros_uid7_sqrt_q_1_q & redist10_vCount_uid112_leadingZeros_uid7_sqrt_q_1_q & vCount_uid118_leadingZeros_uid7_sqrt_q & vCount_uid124_leadingZeros_uid7_sqrt_q;

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_wraddr(REG,452)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_wraddr_q <= "11010";
            ELSE
                redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_wraddr_q <= STD_LOGIC_VECTOR(redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem(DUALMEM,449)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_ia <= STD_LOGIC_VECTOR(r_uid125_leadingZeros_uid7_sqrt_q);
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_aa <= redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_wraddr_q;
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_ab <= redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_rdmux_q;
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_reset0 <= rst;
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 6,
        widthad_a => 5,
        numwords_a => 27,
        width_b => 6,
        widthad_b => 5,
        numwords_b => 27,
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
        clocken1 => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_reset0,
        clock1 => clk,
        address_a => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_aa,
        data_a => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_ia,
        wren_a => en(0),
        address_b => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_ab,
        q_b => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_iq
    );
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_q <= redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_iq(5 downto 0);
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_enaOr_rst <= redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_enaAnd_q(0) or redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_reset0;

    -- redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_outputreg0(DELAY,448)
    redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_outputreg0 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_mem_q, xout => redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- inputAllZeros_uid88_sqrt(LOGICAL,87)@32 + 1
    inputAllZeros_uid88_sqrt_qi <= "1" WHEN redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_outputreg0_q = cstW_uid87_sqrt_q ELSE "0";
    inputAllZeros_uid88_sqrt_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => inputAllZeros_uid88_sqrt_qi, xout => inputAllZeros_uid88_sqrt_q, ena => en(0), clk => clk, aclr => rst );

    -- redist14_inputAllZeros_uid88_sqrt_q_2(DELAY,373)
    redist14_inputAllZeros_uid88_sqrt_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => inputAllZeros_uid88_sqrt_q, xout => redist14_inputAllZeros_uid88_sqrt_q_2_q, ena => en(0), clk => clk, aclr => rst );

    -- inputNotAllZeros_uid89_sqrt(LOGICAL,88)@34
    inputNotAllZeros_uid89_sqrt_q <= not (redist14_inputAllZeros_uid88_sqrt_q_2_q);

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_notEnable(LOGICAL,394)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_nor(LOGICAL,395)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_nor_q <= not (redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_notEnable_q or redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_sticky_ena_q);

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_last(CONSTANT,391)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_last_q <= "01000";

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmp(LOGICAL,392)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmp_b <= STD_LOGIC_VECTOR("0" & redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_q);
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmp_q <= "1" WHEN redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_last_q = redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmp_b ELSE "0";

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmpReg(REG,393)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmpReg_q <= STD_LOGIC_VECTOR(redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_sticky_ena(REG,396)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_sticky_ena_q <= "0";
            ELSE
                IF (redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_nor_q = "1") THEN
                    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_sticky_ena_q <= STD_LOGIC_VECTOR(redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_enaAnd(LOGICAL,397)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_enaAnd_q <= redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_sticky_ena_q and en;

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt(COUNTER,388)
    -- low=0, high=9, step=1, init=0
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_i = TO_UNSIGNED(8, 4)) THEN
                        redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_eq <= '1';
                    ELSE
                        redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_eq <= '0';
                    END IF;
                    IF (redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_eq = '1') THEN
                        redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_i <= redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_i + 7;
                    ELSE
                        redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_i <= redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_i, 4)));

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux(MUX,389)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_s <= en;
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_combproc: PROCESS (redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_s, redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_wraddr_q, redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_q)
    BEGIN
        CASE (redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_s) IS
            WHEN "0" => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_q <= redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_wraddr_q;
            WHEN "1" => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_q <= redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdcnt_q;
            WHEN OTHERS => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_notEnable(LOGICAL,444)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_nor(LOGICAL,445)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_nor_q <= not (redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_notEnable_q or redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_sticky_ena_q);

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_last(CONSTANT,441)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_last_q <= "011";

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmp(LOGICAL,442)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmp_q <= "1" WHEN redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_last_q = redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_q ELSE "0";

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmpReg(REG,443)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmpReg_q <= STD_LOGIC_VECTOR(redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_sticky_ena(REG,446)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_sticky_ena_q <= "0";
            ELSE
                IF (redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_nor_q = "1") THEN
                    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_enaAnd(LOGICAL,447)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_enaAnd_q <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_sticky_ena_q and en;

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt(COUNTER,438)
    -- low=0, high=4, step=1, init=0
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                        redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_eq <= '1';
                    ELSE
                        redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_eq <= '0';
                    END IF;
                    IF (redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_eq = '1') THEN
                        redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_i <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_i + 4;
                    ELSE
                        redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_i <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_i, 3)));

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux(MUX,439)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_s <= en;
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_combproc: PROCESS (redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_s, redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_wraddr_q, redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_q)
    BEGIN
        CASE (redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_s) IS
            WHEN "0" => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_q <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_wraddr_q;
            WHEN "1" => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_q <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdcnt_q;
            WHEN OTHERS => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt(BITSELECT,213)@3
    leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_in <= leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q(28 downto 0);
    leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_b <= leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_in(28 downto 0);

    -- leftShiftStage2Idx3Pad3_uid213_xLeftShift_uid23_sqrt(CONSTANT,212)
    leftShiftStage2Idx3Pad3_uid213_xLeftShift_uid23_sqrt_q <= "000";

    -- leftShiftStage2Idx3_uid215_xLeftShift_uid23_sqrt(BITJOIN,214)@3
    leftShiftStage2Idx3_uid215_xLeftShift_uid23_sqrt_q <= leftShiftStage2Idx3Rng3_uid214_xLeftShift_uid23_sqrt_b & leftShiftStage2Idx3Pad3_uid213_xLeftShift_uid23_sqrt_q;

    -- leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt(BITSELECT,210)@3
    leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_in <= leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q(29 downto 0);
    leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_b <= leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_in(29 downto 0);

    -- leftShiftStage2Idx2_uid212_xLeftShift_uid23_sqrt(BITJOIN,211)@3
    leftShiftStage2Idx2_uid212_xLeftShift_uid23_sqrt_q <= leftShiftStage2Idx2Rng2_uid211_xLeftShift_uid23_sqrt_b & zs_uid116_leadingZeros_uid7_sqrt_q;

    -- leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt(BITSELECT,207)@3
    leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_in <= leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q(30 downto 0);
    leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_b <= leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_in(30 downto 0);

    -- leftShiftStage2Idx1_uid209_xLeftShift_uid23_sqrt(BITJOIN,208)@3
    leftShiftStage2Idx1_uid209_xLeftShift_uid23_sqrt_q <= leftShiftStage2Idx1Rng1_uid208_xLeftShift_uid23_sqrt_b & GND_q;

    -- leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt(BITSELECT,202)@3
    leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_in <= leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q(19 downto 0);
    leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_b <= leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_in(19 downto 0);

    -- leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt(CONSTANT,201)
    leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt_q <= "000000000000";

    -- leftShiftStage1Idx3_uid204_xLeftShift_uid23_sqrt(BITJOIN,203)@3
    leftShiftStage1Idx3_uid204_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx3Rng12_uid203_xLeftShift_uid23_sqrt_b & leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt_q;

    -- leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt(BITSELECT,199)@3
    leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_in <= leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q(23 downto 0);
    leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_b <= leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_in(23 downto 0);

    -- leftShiftStage1Idx2_uid201_xLeftShift_uid23_sqrt(BITJOIN,200)@3
    leftShiftStage1Idx2_uid201_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx2Rng8_uid200_xLeftShift_uid23_sqrt_b & zs_uid104_leadingZeros_uid7_sqrt_q;

    -- leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt(BITSELECT,196)@3
    leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_in <= leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q(27 downto 0);
    leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_b <= leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_in(27 downto 0);

    -- leftShiftStage1Idx1_uid198_xLeftShift_uid23_sqrt(BITJOIN,197)@3
    leftShiftStage1Idx1_uid198_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx1Rng4_uid197_xLeftShift_uid23_sqrt_b & zs_uid110_leadingZeros_uid7_sqrt_q;

    -- leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt(BITSELECT,189)@3
    leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_in <= redist25_in_rsrvd_fix_radical_3_q(15 downto 0);
    leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_b <= leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_in(15 downto 0);

    -- leftShiftStage0Idx1_uid191_xLeftShift_uid23_sqrt(BITJOIN,190)@3
    leftShiftStage0Idx1_uid191_xLeftShift_uid23_sqrt_q <= leftShiftStage0Idx1Rng16_uid190_xLeftShift_uid23_sqrt_b & zs_uid98_leadingZeros_uid7_sqrt_q;

    -- redist25_in_rsrvd_fix_radical_3(DELAY,384)
    redist25_in_rsrvd_fix_radical_3 : dspba_delay
    GENERIC MAP ( width => 32, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist24_in_rsrvd_fix_radical_1_q, xout => redist25_in_rsrvd_fix_radical_3_q, ena => en(0), clk => clk, aclr => rst );

    -- leftShiftStageSel0Dto4_uid194_xLeftShift_uid23_sqrt(BITSELECT,193)@3
    leftShiftStageSel0Dto4_uid194_xLeftShift_uid23_sqrt_b <= r_uid125_leadingZeros_uid7_sqrt_q(5 downto 4);

    -- leftShiftStage0_uid195_xLeftShift_uid23_sqrt(MUX,194)@3
    leftShiftStage0_uid195_xLeftShift_uid23_sqrt_s <= leftShiftStageSel0Dto4_uid194_xLeftShift_uid23_sqrt_b;
    leftShiftStage0_uid195_xLeftShift_uid23_sqrt_combproc: PROCESS (leftShiftStage0_uid195_xLeftShift_uid23_sqrt_s, redist25_in_rsrvd_fix_radical_3_q, leftShiftStage0Idx1_uid191_xLeftShift_uid23_sqrt_q, zs_uid92_leadingZeros_uid7_sqrt_q)
    BEGIN
        CASE (leftShiftStage0_uid195_xLeftShift_uid23_sqrt_s) IS
            WHEN "00" => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= redist25_in_rsrvd_fix_radical_3_q;
            WHEN "01" => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= leftShiftStage0Idx1_uid191_xLeftShift_uid23_sqrt_q;
            WHEN "10" => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= zs_uid92_leadingZeros_uid7_sqrt_q;
            WHEN "11" => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= zs_uid92_leadingZeros_uid7_sqrt_q;
            WHEN OTHERS => leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt(BITSELECT,204)@3
    leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_in <= r_uid125_leadingZeros_uid7_sqrt_q(3 downto 0);
    leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_b <= leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_in(3 downto 2);

    -- leftShiftStage1_uid206_xLeftShift_uid23_sqrt(MUX,205)@3
    leftShiftStage1_uid206_xLeftShift_uid23_sqrt_s <= leftShiftStageSel2Dto2_uid205_xLeftShift_uid23_sqrt_b;
    leftShiftStage1_uid206_xLeftShift_uid23_sqrt_combproc: PROCESS (leftShiftStage1_uid206_xLeftShift_uid23_sqrt_s, leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q, leftShiftStage1Idx1_uid198_xLeftShift_uid23_sqrt_q, leftShiftStage1Idx2_uid201_xLeftShift_uid23_sqrt_q, leftShiftStage1Idx3_uid204_xLeftShift_uid23_sqrt_q)
    BEGIN
        CASE (leftShiftStage1_uid206_xLeftShift_uid23_sqrt_s) IS
            WHEN "00" => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= leftShiftStage0_uid195_xLeftShift_uid23_sqrt_q;
            WHEN "01" => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx1_uid198_xLeftShift_uid23_sqrt_q;
            WHEN "10" => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx2_uid201_xLeftShift_uid23_sqrt_q;
            WHEN "11" => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= leftShiftStage1Idx3_uid204_xLeftShift_uid23_sqrt_q;
            WHEN OTHERS => leftShiftStage1_uid206_xLeftShift_uid23_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt(BITSELECT,215)@3
    leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt_in <= r_uid125_leadingZeros_uid7_sqrt_q(1 downto 0);
    leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt_b <= leftShiftStageSel4Dto0_uid216_xLeftShift_uid23_sqrt_in(1 downto 0);

    -- leftShiftStage2_uid217_xLeftShift_uid23_sqrt(MUX,216)@3
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

    -- redist6_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1(DELAY,365)
    redist6_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q, xout => redist6_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_wraddr(REG,440)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_wraddr_q <= "100";
            ELSE
                redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_wraddr_q <= STD_LOGIC_VECTOR(redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem(DUALMEM,437)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_ia <= STD_LOGIC_VECTOR(redist6_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1_q);
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_aa <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_wraddr_q;
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_ab <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_rdmux_q;
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_reset0 <= rst;
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 5,
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
        clocken1 => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_reset0,
        clock1 => clk,
        address_a => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_aa,
        data_a => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_ia,
        wren_a => en(0),
        address_b => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_ab,
        q_b => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_iq
    );
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_q <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_iq(31 downto 0);
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_enaOr_rst <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_enaAnd_q(0) or redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_reset0;

    -- redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_outputreg0(DELAY,436)
    redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_outputreg0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_mem_q, xout => redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs16(BITSELECT,237)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bs16_in <= STD_LOGIC_VECTOR(redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_outputreg0_q(17 downto 0));
    xMulInitApproxSquaredFull_uid47_sqrt_bs16_b <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_bs16_in(17 downto 0));

    -- xMulInitApproxSquaredFull_uid47_sqrt_bjA17(BITJOIN,238)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q <= GND_q & xMulInitApproxSquaredFull_uid47_sqrt_bs16_b;

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_inputreg0(DELAY,385)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_inputreg0 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q, xout => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_wraddr(REG,390)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_wraddr_q <= "1001";
            ELSE
                redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_wraddr_q <= STD_LOGIC_VECTOR(redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem(DUALMEM,387)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_ia <= STD_LOGIC_VECTOR(redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_inputreg0_q);
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_aa <= redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_wraddr_q;
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_ab <= redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_rdmux_q;
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_reset0 <= rst;
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 19,
        widthad_a => 4,
        numwords_a => 10,
        width_b => 19,
        widthad_b => 4,
        numwords_b => 10,
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
        clocken1 => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_reset0,
        clock1 => clk,
        address_a => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_aa,
        data_a => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_ia,
        wren_a => en(0),
        address_b => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_ab,
        q_b => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_iq
    );
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_q <= redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_iq(18 downto 0);
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_enaOr_rst <= redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_enaAnd_q(0) or redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_reset0;

    -- redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_outputreg0(DELAY,386)
    redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_outputreg0 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_mem_q, xout => redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- x2_uid27_sqrt(BITSELECT,26)@4
    x2_uid27_sqrt_in <= redist6_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_1_q(18 downto 0);
    x2_uid27_sqrt_b <= x2_uid27_sqrt_in(18 downto 14);

    -- x2_msb_uid29_sqrt(BITSELECT,28)@4
    x2_msb_uid29_sqrt_b <= STD_LOGIC_VECTOR(x2_uid27_sqrt_b(4 downto 4));

    -- redist22_x2_msb_uid29_sqrt_b_2(DELAY,381)
    redist22_x2_msb_uid29_sqrt_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => x2_msb_uid29_sqrt_b, xout => redist22_x2_msb_uid29_sqrt_b_2_q, ena => en(0), clk => clk, aclr => rst );

    -- x0_uid25_sqrt(BITSELECT,24)@3
    x0_uid25_sqrt_in <= leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q(30 downto 0);
    x0_uid25_sqrt_b <= x0_uid25_sqrt_in(30 downto 25);

    -- redist23_x0_uid25_sqrt_b_1(DELAY,382)
    redist23_x0_uid25_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => x0_uid25_sqrt_b, xout => redist23_x0_uid25_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- x2_xored_uid30_sqrt(LOGICAL,29)@4
    x2_xored_uid30_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((4 downto 1 => x2_msb_uid29_sqrt_b(0)) & x2_msb_uid29_sqrt_b));
    x2_xored_uid30_sqrt_q <= x2_uid27_sqrt_b xor x2_xored_uid30_sqrt_b;

    -- x2_xoredNoMsb_uid31_sqrt(BITSELECT,30)@4
    x2_xoredNoMsb_uid31_sqrt_in <= x2_xored_uid30_sqrt_q(3 downto 0);
    x2_xoredNoMsb_uid31_sqrt_b <= x2_xoredNoMsb_uid31_sqrt_in(3 downto 0);

    -- a1Addr_uid32_sqrt(BITJOIN,31)@4
    a1Addr_uid32_sqrt_q <= redist23_x0_uid25_sqrt_b_1_q & x2_xoredNoMsb_uid31_sqrt_b;

    -- a1Table_uid37_sqrt_lutmem(DUALMEM,220)@4 + 2
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
        init_file => "FIX_SQRT_altera_fxp_functions_180_5bhhksy_a1Table_uid37_sqrt_lutmem.hex",
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

    -- a1TableOutSxt_uid40_sqrt(BITJOIN,39)@6
    a1TableOutSxt_uid40_sqrt_q <= GND_q & a1Table_uid37_sqrt_lutmem_r;

    -- a1TableOut_xored_uid41_sqrt(LOGICAL,40)@6
    a1TableOut_xored_uid41_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((7 downto 1 => redist22_x2_msb_uid29_sqrt_b_2_q(0)) & redist22_x2_msb_uid29_sqrt_b_2_q));
    a1TableOut_xored_uid41_sqrt_q <= a1TableOutSxt_uid40_sqrt_q xor a1TableOut_xored_uid41_sqrt_b;

    -- x1_uid26_sqrt(BITSELECT,25)@3
    x1_uid26_sqrt_in <= leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q(24 downto 0);
    x1_uid26_sqrt_b <= x1_uid26_sqrt_in(24 downto 19);

    -- a0Addr_uid28_sqrt(BITJOIN,27)@3
    a0Addr_uid28_sqrt_q <= x0_uid25_sqrt_b & x1_uid26_sqrt_b;

    -- a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select(BITSELECT,351)@3
    a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_b <= STD_LOGIC_VECTOR(a0Addr_uid28_sqrt_q(11 downto 11));
    a0Table_uid33_sqrt_lutmem_addrA_hi_merged_bit_select_c <= STD_LOGIC_VECTOR(a0Addr_uid28_sqrt_q(10 downto 0));

    -- a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1(REG,338)@3 + 1
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

    -- a0Table_uid34_sqrt_lutmem_csA1(LOOKUP,327)@4
    a0Table_uid34_sqrt_lutmem_csA1_combproc: PROCESS (a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (a0Table_uid34_sqrt_lutmem_addrA_hifan_reg1_q) IS
            WHEN "1" => a0Table_uid34_sqrt_lutmem_csA1_h <= "1";
            WHEN OTHERS => a0Table_uid34_sqrt_lutmem_csA1_h <= "0";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- a0Table_uid34_sqrt_lutmem_addrA_lofan_reg1(REG,340)@3 + 1
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

    -- a0Table_uid34_sqrt_lutmem_part1(DUALMEM,331)@4 + 2
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
        init_file => "FIX_SQRT_altera_fxp_functions_180_5bhhksy_a0Table_uid34_sqrt_lutmem_part1.hex",
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

    -- a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0(REG,337)@3 + 1
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

    -- a0Table_uid34_sqrt_lutmem_csA0(LOOKUP,326)@4
    a0Table_uid34_sqrt_lutmem_csA0_combproc: PROCESS (a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0_q)
    BEGIN
        -- Begin reserved scope level
        CASE (a0Table_uid34_sqrt_lutmem_addrA_hifan_reg0_q) IS
            WHEN "0" => a0Table_uid34_sqrt_lutmem_csA0_h <= "1";
            WHEN OTHERS => a0Table_uid34_sqrt_lutmem_csA0_h <= "0";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- a0Table_uid34_sqrt_lutmem_addrA_lofan_reg0(REG,339)@3 + 1
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

    -- a0Table_uid34_sqrt_lutmem_part0(DUALMEM,330)@4 + 2
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
        init_file => "FIX_SQRT_altera_fxp_functions_180_5bhhksy_a0Table_uid34_sqrt_lutmem_part0.hex",
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

    -- a0Table_uid34_sqrt_lutmem_qA_l0_or0(LOGICAL,332)@6
    a0Table_uid34_sqrt_lutmem_qA_l0_or0_q <= a0Table_uid34_sqrt_lutmem_part0_r or a0Table_uid34_sqrt_lutmem_part1_r;

    -- a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1(REG,334)@3 + 1
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

    -- a0Table_uid33_sqrt_lutmem_csA1(LOOKUP,318)@4
    a0Table_uid33_sqrt_lutmem_csA1_combproc: PROCESS (a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (a0Table_uid33_sqrt_lutmem_addrA_hifan_reg1_q) IS
            WHEN "1" => a0Table_uid33_sqrt_lutmem_csA1_h <= "1";
            WHEN OTHERS => a0Table_uid33_sqrt_lutmem_csA1_h <= "0";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- a0Table_uid33_sqrt_lutmem_addrA_lofan_reg1(REG,336)@3 + 1
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

    -- a0Table_uid33_sqrt_lutmem_part1(DUALMEM,322)@4 + 2
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
        init_file => "FIX_SQRT_altera_fxp_functions_180_5bhhksy_a0Table_uid33_sqrt_lutmem_part1.hex",
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

    -- a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0(REG,333)@3 + 1
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

    -- a0Table_uid33_sqrt_lutmem_csA0(LOOKUP,317)@4
    a0Table_uid33_sqrt_lutmem_csA0_combproc: PROCESS (a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0_q)
    BEGIN
        -- Begin reserved scope level
        CASE (a0Table_uid33_sqrt_lutmem_addrA_hifan_reg0_q) IS
            WHEN "0" => a0Table_uid33_sqrt_lutmem_csA0_h <= "1";
            WHEN OTHERS => a0Table_uid33_sqrt_lutmem_csA0_h <= "0";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- a0Table_uid33_sqrt_lutmem_addrA_lofan_reg0(REG,335)@3 + 1
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

    -- a0Table_uid33_sqrt_lutmem_part0(DUALMEM,321)@4 + 2
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
        init_file => "FIX_SQRT_altera_fxp_functions_180_5bhhksy_a0Table_uid33_sqrt_lutmem_part0.hex",
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

    -- a0Table_uid33_sqrt_lutmem_qA_l0_or0(LOGICAL,323)@6
    a0Table_uid33_sqrt_lutmem_qA_l0_or0_q <= a0Table_uid33_sqrt_lutmem_part0_r or a0Table_uid33_sqrt_lutmem_part1_r;

    -- os_uid35_sqrt(BITJOIN,34)@6
    os_uid35_sqrt_q <= a0Table_uid34_sqrt_lutmem_qA_l0_or0_q & a0Table_uid33_sqrt_lutmem_qA_l0_or0_q;

    -- initApproxFull_uid43_sqrt(ADD,42)@6
    initApproxFull_uid43_sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & os_uid35_sqrt_q));
    initApproxFull_uid43_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 8 => a1TableOut_xored_uid41_sqrt_q(7)) & a1TableOut_xored_uid41_sqrt_q));
    initApproxFull_uid43_sqrt_o <= STD_LOGIC_VECTOR(SIGNED(initApproxFull_uid43_sqrt_a) + SIGNED(initApproxFull_uid43_sqrt_b));
    initApproxFull_uid43_sqrt_q <= initApproxFull_uid43_sqrt_o(21 downto 0);

    -- initApprox_uid44_sqrt(BITSELECT,43)@6
    initApprox_uid44_sqrt_in <= initApproxFull_uid43_sqrt_q(19 downto 0);
    initApprox_uid44_sqrt_b <= initApprox_uid44_sqrt_in(19 downto 0);

    -- initApproxSquaredFull_uid45_sqrt_cma(CHAINMULTADD,341)@6 + 4
    -- out q@11
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
                    initApproxSquaredFull_uid45_sqrt_cma_ah(0) <= RESIZE(UNSIGNED(initApprox_uid44_sqrt_b),20);
                    initApproxSquaredFull_uid45_sqrt_cma_ch(0) <= RESIZE(UNSIGNED(initApprox_uid44_sqrt_b),20);
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
    GENERIC MAP ( width => 40, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => initApproxSquaredFull_uid45_sqrt_cma_s0, xout => initApproxSquaredFull_uid45_sqrt_cma_qq, ena => en(0), clk => clk, aclr => rst );
    initApproxSquaredFull_uid45_sqrt_cma_q <= STD_LOGIC_VECTOR(initApproxSquaredFull_uid45_sqrt_cma_qq(39 downto 0));

    -- initApproxSquared_uid46_sqrt(BITSELECT,45)@11
    initApproxSquared_uid46_sqrt_in <= initApproxSquaredFull_uid45_sqrt_cma_q(38 downto 0);
    initApproxSquared_uid46_sqrt_b <= initApproxSquared_uid46_sqrt_in(38 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs5(BITSELECT,226)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bs5_b <= initApproxSquared_uid46_sqrt_b(38 downto 36);

    -- redist2_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1(DELAY,361)
    redist2_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs5_b, xout => redist2_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs4(BITSELECT,225)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bs4_b <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_outputreg0_q(31 downto 18);

    -- redist3_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1(DELAY,362)
    redist3_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs4_b, xout => redist3_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- xMulInitApproxSquaredFull_uid47_sqrt_im3_cma(CHAINMULTADD,343)@12 + 4
    -- out q@17
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
                    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ah(0) <= RESIZE(UNSIGNED(redist3_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1_q),14);
                    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_ch(0) <= RESIZE(UNSIGNED(redist2_xMulInitApproxSquaredFull_uid47_sqrt_bs5_b_1_q),3);
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
    GENERIC MAP ( width => 17, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_s0, xout => xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_qq, ena => en(0), clk => clk, aclr => rst );
    xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_qq(16 downto 0));

    -- xMulInitApproxSquaredFull_uid47_sqrt_align_23(BITSHIFT,244)@17
    xMulInitApproxSquaredFull_uid47_sqrt_align_23_qint <= xMulInitApproxSquaredFull_uid47_sqrt_im3_cma_q & "000000000000000000000000000000000000000000000000000000";
    xMulInitApproxSquaredFull_uid47_sqrt_align_23_q <= xMulInitApproxSquaredFull_uid47_sqrt_align_23_qint(70 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs1(BITSELECT,222)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bs1_in <= redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_outputreg0_q(17 downto 0);
    xMulInitApproxSquaredFull_uid47_sqrt_bs1_b <= xMulInitApproxSquaredFull_uid47_sqrt_bs1_in(17 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs8(BITSELECT,229)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bs8_in <= initApproxSquared_uid46_sqrt_b(35 downto 0);
    xMulInitApproxSquaredFull_uid47_sqrt_bs8_b <= xMulInitApproxSquaredFull_uid47_sqrt_bs8_in(35 downto 18);

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs2(BITSELECT,223)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bs2_in <= initApproxSquared_uid46_sqrt_b(17 downto 0);
    xMulInitApproxSquaredFull_uid47_sqrt_bs2_b <= xMulInitApproxSquaredFull_uid47_sqrt_bs2_in(17 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma(CHAINMULTADD,348)@11 + 4
    -- out q@16
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
    GENERIC MAP ( width => 37, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_s0, xout => xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_qq, ena => en(0), clk => clk, aclr => rst );
    xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_qq(36 downto 0));

    -- xMulInitApproxSquaredFull_uid47_sqrt_align_21(BITSHIFT,242)@16
    xMulInitApproxSquaredFull_uid47_sqrt_align_21_qint <= xMulInitApproxSquaredFull_uid47_sqrt_ma6_cma_q & "000000000000000000";
    xMulInitApproxSquaredFull_uid47_sqrt_align_21_q <= xMulInitApproxSquaredFull_uid47_sqrt_align_21_qint(54 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs14(BITSELECT,235)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bs14_in <= STD_LOGIC_VECTOR(initApproxSquared_uid46_sqrt_b(35 downto 0));
    xMulInitApproxSquaredFull_uid47_sqrt_bs14_b <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_bs14_in(35 downto 18));

    -- xMulInitApproxSquaredFull_uid47_sqrt_bjB15(BITJOIN,236)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bjB15_q <= GND_q & xMulInitApproxSquaredFull_uid47_sqrt_bs14_b;

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs12(BITSELECT,233)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bs12_b <= STD_LOGIC_VECTOR(redist7_leftShiftStage2_uid217_xLeftShift_uid23_sqrt_q_8_outputreg0_q(31 downto 18));

    -- xMulInitApproxSquaredFull_uid47_sqrt_bjA13(BITJOIN,234)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q <= GND_q & xMulInitApproxSquaredFull_uid47_sqrt_bs12_b;

    -- xMulInitApproxSquaredFull_uid47_sqrt_bs18(BITSELECT,239)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bs18_b <= STD_LOGIC_VECTOR(initApproxSquared_uid46_sqrt_b(38 downto 36));

    -- xMulInitApproxSquaredFull_uid47_sqrt_bjB19(BITJOIN,240)@11
    xMulInitApproxSquaredFull_uid47_sqrt_bjB19_q <= GND_q & xMulInitApproxSquaredFull_uid47_sqrt_bs18_b;

    -- xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma(CHAINMULTADD,349)@11 + 4
    -- out q@16
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
    GENERIC MAP ( width => 35, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_s0, xout => xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_qq, ena => en(0), clk => clk, aclr => rst );
    xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_q <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_qq(34 downto 0));

    -- xMulInitApproxSquaredFull_uid47_sqrt_im0_cma(CHAINMULTADD,342)@11 + 4
    -- out q@16
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
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_s0, xout => xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_qq, ena => en(0), clk => clk, aclr => rst );
    xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q <= STD_LOGIC_VECTOR(xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_qq(35 downto 0));

    -- xMulInitApproxSquaredFull_uid47_sqrt_join_20(BITJOIN,241)@16
    xMulInitApproxSquaredFull_uid47_sqrt_join_20_q <= xMulInitApproxSquaredFull_uid47_sqrt_ma11_cma_q & xMulInitApproxSquaredFull_uid47_sqrt_im0_cma_q;

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0(ADD,246)@16 + 1
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((72 downto 71 => xMulInitApproxSquaredFull_uid47_sqrt_join_20_q(70)) & xMulInitApproxSquaredFull_uid47_sqrt_join_20_q));
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000000" & xMulInitApproxSquaredFull_uid47_sqrt_align_21_q));
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_o <= STD_LOGIC_VECTOR(SIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_a) + SIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_q <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_o(71 downto 0);

    -- xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0(ADD,247)@17
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((73 downto 72 => xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_q(71)) & xMulInitApproxSquaredFull_uid47_sqrt_result_add_0_0_q));
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xMulInitApproxSquaredFull_uid47_sqrt_align_23_q));
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_o <= STD_LOGIC_VECTOR(SIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_a) + SIGNED(xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_b));
    xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_q <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_o(72 downto 0);

    -- xMulInitApproxSquared_uid48_sqrt(BITSELECT,47)@17
    xMulInitApproxSquared_uid48_sqrt_in <= xMulInitApproxSquaredFull_uid47_sqrt_result_add_1_0_q(69 downto 0);
    xMulInitApproxSquared_uid48_sqrt_b <= xMulInitApproxSquared_uid48_sqrt_in(69 downto 36);

    -- redist20_xMulInitApproxSquared_uid48_sqrt_b_1(DELAY,379)
    redist20_xMulInitApproxSquared_uid48_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquared_uid48_sqrt_b, xout => redist20_xMulInitApproxSquared_uid48_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- oneAndHalf_uid50_sqrt(CONSTANT,49)
    oneAndHalf_uid50_sqrt_q <= "11";

    -- padACst_uid51_sqrt(CONSTANT,50)
    padACst_uid51_sqrt_q <= "000000000000000000000000000000000";

    -- aPostPad_uid52_sqrt(BITJOIN,51)@18
    aPostPad_uid52_sqrt_q <= oneAndHalf_uid50_sqrt_q & padACst_uid51_sqrt_q;

    -- oneAndHalfSubXMIASFull_uid53_sqrt(SUB,52)@18
    oneAndHalfSubXMIASFull_uid53_sqrt_a <= STD_LOGIC_VECTOR("0" & aPostPad_uid52_sqrt_q);
    oneAndHalfSubXMIASFull_uid53_sqrt_b <= STD_LOGIC_VECTOR("00" & redist20_xMulInitApproxSquared_uid48_sqrt_b_1_q);
    oneAndHalfSubXMIASFull_uid53_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(oneAndHalfSubXMIASFull_uid53_sqrt_a) - UNSIGNED(oneAndHalfSubXMIASFull_uid53_sqrt_b));
    oneAndHalfSubXMIASFull_uid53_sqrt_q <= oneAndHalfSubXMIASFull_uid53_sqrt_o(35 downto 0);

    -- oneAndHalfSubXMIAS_uid54_sqrt(BITSELECT,53)@18
    oneAndHalfSubXMIAS_uid54_sqrt_in <= oneAndHalfSubXMIASFull_uid53_sqrt_q(34 downto 0);
    oneAndHalfSubXMIAS_uid54_sqrt_b <= oneAndHalfSubXMIAS_uid54_sqrt_in(34 downto 0);

    -- resultFull_uid55_sqrt_bs2_merged_bit_select(BITSELECT,352)@18
    resultFull_uid55_sqrt_bs2_merged_bit_select_b <= oneAndHalfSubXMIAS_uid54_sqrt_b(26 downto 0);
    resultFull_uid55_sqrt_bs2_merged_bit_select_c <= oneAndHalfSubXMIAS_uid54_sqrt_b(34 downto 27);

    -- redist21_initApprox_uid44_sqrt_b_12_notEnable(LOGICAL,469)
    redist21_initApprox_uid44_sqrt_b_12_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist21_initApprox_uid44_sqrt_b_12_nor(LOGICAL,470)
    redist21_initApprox_uid44_sqrt_b_12_nor_q <= not (redist21_initApprox_uid44_sqrt_b_12_notEnable_q or redist21_initApprox_uid44_sqrt_b_12_sticky_ena_q);

    -- redist21_initApprox_uid44_sqrt_b_12_mem_last(CONSTANT,466)
    redist21_initApprox_uid44_sqrt_b_12_mem_last_q <= "0111";

    -- redist21_initApprox_uid44_sqrt_b_12_cmp(LOGICAL,467)
    redist21_initApprox_uid44_sqrt_b_12_cmp_q <= "1" WHEN redist21_initApprox_uid44_sqrt_b_12_mem_last_q = redist21_initApprox_uid44_sqrt_b_12_rdmux_q ELSE "0";

    -- redist21_initApprox_uid44_sqrt_b_12_cmpReg(REG,468)
    redist21_initApprox_uid44_sqrt_b_12_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist21_initApprox_uid44_sqrt_b_12_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist21_initApprox_uid44_sqrt_b_12_cmpReg_q <= STD_LOGIC_VECTOR(redist21_initApprox_uid44_sqrt_b_12_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist21_initApprox_uid44_sqrt_b_12_sticky_ena(REG,471)
    redist21_initApprox_uid44_sqrt_b_12_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist21_initApprox_uid44_sqrt_b_12_sticky_ena_q <= "0";
            ELSE
                IF (redist21_initApprox_uid44_sqrt_b_12_nor_q = "1") THEN
                    redist21_initApprox_uid44_sqrt_b_12_sticky_ena_q <= STD_LOGIC_VECTOR(redist21_initApprox_uid44_sqrt_b_12_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist21_initApprox_uid44_sqrt_b_12_enaAnd(LOGICAL,472)
    redist21_initApprox_uid44_sqrt_b_12_enaAnd_q <= redist21_initApprox_uid44_sqrt_b_12_sticky_ena_q and en;

    -- redist21_initApprox_uid44_sqrt_b_12_rdcnt(COUNTER,463)
    -- low=0, high=8, step=1, init=0
    redist21_initApprox_uid44_sqrt_b_12_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist21_initApprox_uid44_sqrt_b_12_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist21_initApprox_uid44_sqrt_b_12_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist21_initApprox_uid44_sqrt_b_12_rdcnt_i = TO_UNSIGNED(7, 4)) THEN
                        redist21_initApprox_uid44_sqrt_b_12_rdcnt_eq <= '1';
                    ELSE
                        redist21_initApprox_uid44_sqrt_b_12_rdcnt_eq <= '0';
                    END IF;
                    IF (redist21_initApprox_uid44_sqrt_b_12_rdcnt_eq = '1') THEN
                        redist21_initApprox_uid44_sqrt_b_12_rdcnt_i <= redist21_initApprox_uid44_sqrt_b_12_rdcnt_i + 8;
                    ELSE
                        redist21_initApprox_uid44_sqrt_b_12_rdcnt_i <= redist21_initApprox_uid44_sqrt_b_12_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist21_initApprox_uid44_sqrt_b_12_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist21_initApprox_uid44_sqrt_b_12_rdcnt_i, 4)));

    -- redist21_initApprox_uid44_sqrt_b_12_rdmux(MUX,464)
    redist21_initApprox_uid44_sqrt_b_12_rdmux_s <= en;
    redist21_initApprox_uid44_sqrt_b_12_rdmux_combproc: PROCESS (redist21_initApprox_uid44_sqrt_b_12_rdmux_s, redist21_initApprox_uid44_sqrt_b_12_wraddr_q, redist21_initApprox_uid44_sqrt_b_12_rdcnt_q)
    BEGIN
        CASE (redist21_initApprox_uid44_sqrt_b_12_rdmux_s) IS
            WHEN "0" => redist21_initApprox_uid44_sqrt_b_12_rdmux_q <= redist21_initApprox_uid44_sqrt_b_12_wraddr_q;
            WHEN "1" => redist21_initApprox_uid44_sqrt_b_12_rdmux_q <= redist21_initApprox_uid44_sqrt_b_12_rdcnt_q;
            WHEN OTHERS => redist21_initApprox_uid44_sqrt_b_12_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist21_initApprox_uid44_sqrt_b_12_inputreg0(DELAY,460)
    redist21_initApprox_uid44_sqrt_b_12_inputreg0 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => initApprox_uid44_sqrt_b, xout => redist21_initApprox_uid44_sqrt_b_12_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist21_initApprox_uid44_sqrt_b_12_wraddr(REG,465)
    redist21_initApprox_uid44_sqrt_b_12_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist21_initApprox_uid44_sqrt_b_12_wraddr_q <= "1000";
            ELSE
                redist21_initApprox_uid44_sqrt_b_12_wraddr_q <= STD_LOGIC_VECTOR(redist21_initApprox_uid44_sqrt_b_12_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist21_initApprox_uid44_sqrt_b_12_mem(DUALMEM,462)
    redist21_initApprox_uid44_sqrt_b_12_mem_ia <= STD_LOGIC_VECTOR(redist21_initApprox_uid44_sqrt_b_12_inputreg0_q);
    redist21_initApprox_uid44_sqrt_b_12_mem_aa <= redist21_initApprox_uid44_sqrt_b_12_wraddr_q;
    redist21_initApprox_uid44_sqrt_b_12_mem_ab <= redist21_initApprox_uid44_sqrt_b_12_rdmux_q;
    redist21_initApprox_uid44_sqrt_b_12_mem_reset0 <= rst;
    redist21_initApprox_uid44_sqrt_b_12_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 20,
        widthad_a => 4,
        numwords_a => 9,
        width_b => 20,
        widthad_b => 4,
        numwords_b => 9,
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
        clocken1 => redist21_initApprox_uid44_sqrt_b_12_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist21_initApprox_uid44_sqrt_b_12_mem_reset0,
        clock1 => clk,
        address_a => redist21_initApprox_uid44_sqrt_b_12_mem_aa,
        data_a => redist21_initApprox_uid44_sqrt_b_12_mem_ia,
        wren_a => en(0),
        address_b => redist21_initApprox_uid44_sqrt_b_12_mem_ab,
        q_b => redist21_initApprox_uid44_sqrt_b_12_mem_iq
    );
    redist21_initApprox_uid44_sqrt_b_12_mem_q <= redist21_initApprox_uid44_sqrt_b_12_mem_iq(19 downto 0);
    redist21_initApprox_uid44_sqrt_b_12_mem_enaOr_rst <= redist21_initApprox_uid44_sqrt_b_12_enaAnd_q(0) or redist21_initApprox_uid44_sqrt_b_12_mem_reset0;

    -- redist21_initApprox_uid44_sqrt_b_12_outputreg0(DELAY,461)
    redist21_initApprox_uid44_sqrt_b_12_outputreg0 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist21_initApprox_uid44_sqrt_b_12_mem_q, xout => redist21_initApprox_uid44_sqrt_b_12_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- resultFull_uid55_sqrt_im3_cma(CHAINMULTADD,345)@18 + 4
    -- out q@23
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
                    resultFull_uid55_sqrt_im3_cma_ah(0) <= RESIZE(UNSIGNED(redist21_initApprox_uid44_sqrt_b_12_outputreg0_q),20);
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
    GENERIC MAP ( width => 28, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFull_uid55_sqrt_im3_cma_s0, xout => resultFull_uid55_sqrt_im3_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultFull_uid55_sqrt_im3_cma_q <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_im3_cma_qq(27 downto 0));

    -- resultFull_uid55_sqrt_align_7(BITSHIFT,255)@23
    resultFull_uid55_sqrt_align_7_qint <= resultFull_uid55_sqrt_im3_cma_q & "000000000000000000000000000";
    resultFull_uid55_sqrt_align_7_q <= resultFull_uid55_sqrt_align_7_qint(54 downto 0);

    -- resultFull_uid55_sqrt_im0_cma(CHAINMULTADD,344)@18 + 4
    -- out q@23
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
                    resultFull_uid55_sqrt_im0_cma_ch(0) <= RESIZE(UNSIGNED(redist21_initApprox_uid44_sqrt_b_12_outputreg0_q),20);
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
    GENERIC MAP ( width => 47, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultFull_uid55_sqrt_im0_cma_s0, xout => resultFull_uid55_sqrt_im0_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultFull_uid55_sqrt_im0_cma_q <= STD_LOGIC_VECTOR(resultFull_uid55_sqrt_im0_cma_qq(46 downto 0));

    -- resultFull_uid55_sqrt_result_add_0_0(ADD,257)@23
    resultFull_uid55_sqrt_result_add_0_0_a <= STD_LOGIC_VECTOR("000000000" & resultFull_uid55_sqrt_im0_cma_q);
    resultFull_uid55_sqrt_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & resultFull_uid55_sqrt_align_7_q);
    resultFull_uid55_sqrt_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(resultFull_uid55_sqrt_result_add_0_0_a) + UNSIGNED(resultFull_uid55_sqrt_result_add_0_0_b));
    resultFull_uid55_sqrt_result_add_0_0_q <= resultFull_uid55_sqrt_result_add_0_0_o(55 downto 0);

    -- resultPreMultX_uid56_sqrt(BITSELECT,55)@23
    resultPreMultX_uid56_sqrt_in <= resultFull_uid55_sqrt_result_add_0_0_q(53 downto 0);
    resultPreMultX_uid56_sqrt_b <= resultPreMultX_uid56_sqrt_in(53 downto 20);

    -- redist19_resultPreMultX_uid56_sqrt_b_1(DELAY,378)
    redist19_resultPreMultX_uid56_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultPreMultX_uid56_sqrt_b, xout => redist19_resultPreMultX_uid56_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_bs4(BITSELECT,262)@24
    resultMultFull_uid57_sqrt_bs4_b <= STD_LOGIC_VECTOR(redist19_resultPreMultX_uid56_sqrt_b_1_q(33 downto 18));

    -- resultMultFull_uid57_sqrt_bjA5(BITJOIN,263)@24
    resultMultFull_uid57_sqrt_bjA5_q <= GND_q & resultMultFull_uid57_sqrt_bs4_b;

    -- resultMultFull_uid57_sqrt_bs8(BITSELECT,266)@24
    resultMultFull_uid57_sqrt_bs8_in <= STD_LOGIC_VECTOR(redist19_resultPreMultX_uid56_sqrt_b_1_q(17 downto 0));
    resultMultFull_uid57_sqrt_bs8_b <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_bs8_in(17 downto 0));

    -- resultMultFull_uid57_sqrt_bjA9(BITJOIN,267)@24
    resultMultFull_uid57_sqrt_bjA9_q <= GND_q & resultMultFull_uid57_sqrt_bs8_b;

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_notEnable(LOGICAL,407)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_nor(LOGICAL,408)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_nor_q <= not (redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_notEnable_q or redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_sticky_ena_q);

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_last(CONSTANT,404)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_last_q <= "01000";

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmp(LOGICAL,405)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmp_b <= STD_LOGIC_VECTOR("0" & redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_q);
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmp_q <= "1" WHEN redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_last_q = redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmp_b ELSE "0";

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmpReg(REG,406)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmpReg_q <= STD_LOGIC_VECTOR(redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_sticky_ena(REG,409)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_sticky_ena_q <= "0";
            ELSE
                IF (redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_nor_q = "1") THEN
                    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_sticky_ena_q <= STD_LOGIC_VECTOR(redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_enaAnd(LOGICAL,410)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_enaAnd_q <= redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_sticky_ena_q and en;

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt(COUNTER,401)
    -- low=0, high=9, step=1, init=0
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_i = TO_UNSIGNED(8, 4)) THEN
                        redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_eq <= '1';
                    ELSE
                        redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_eq <= '0';
                    END IF;
                    IF (redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_eq = '1') THEN
                        redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_i <= redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_i + 7;
                    ELSE
                        redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_i <= redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_i, 4)));

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux(MUX,402)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_s <= en;
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_combproc: PROCESS (redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_s, redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_wraddr_q, redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_q)
    BEGIN
        CASE (redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_s) IS
            WHEN "0" => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_q <= redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_wraddr_q;
            WHEN "1" => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_q <= redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdcnt_q;
            WHEN OTHERS => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_inputreg0(DELAY,398)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_inputreg0 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q, xout => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_wraddr(REG,403)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_wraddr_q <= "1001";
            ELSE
                redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_wraddr_q <= STD_LOGIC_VECTOR(redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem(DUALMEM,400)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_ia <= STD_LOGIC_VECTOR(redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_inputreg0_q);
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_aa <= redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_wraddr_q;
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_ab <= redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_rdmux_q;
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_reset0 <= rst;
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 15,
        widthad_a => 4,
        numwords_a => 10,
        width_b => 15,
        widthad_b => 4,
        numwords_b => 10,
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
        clocken1 => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_reset0,
        clock1 => clk,
        address_a => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_aa,
        data_a => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_ia,
        wren_a => en(0),
        address_b => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_ab,
        q_b => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_iq
    );
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_q <= redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_iq(14 downto 0);
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_enaOr_rst <= redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_enaAnd_q(0) or redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_reset0;

    -- redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_outputreg0(DELAY,399)
    redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_outputreg0 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_mem_q, xout => redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_ma3_cma(CHAINMULTADD,350)@24 + 4
    -- out q@29
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
                    resultMultFull_uid57_sqrt_ma3_cma_ah(0) <= RESIZE(SIGNED(redist1_xMulInitApproxSquaredFull_uid47_sqrt_bjA13_q_13_outputreg0_q),17);
                    resultMultFull_uid57_sqrt_ma3_cma_ah(1) <= RESIZE(SIGNED(resultMultFull_uid57_sqrt_bjA5_q),17);
                    resultMultFull_uid57_sqrt_ma3_cma_ch(0) <= RESIZE(SIGNED(resultMultFull_uid57_sqrt_bjA9_q),19);
                    resultMultFull_uid57_sqrt_ma3_cma_ch(1) <= RESIZE(SIGNED(redist0_xMulInitApproxSquaredFull_uid47_sqrt_bjA17_q_13_outputreg0_q),19);
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
    GENERIC MAP ( width => 37, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_ma3_cma_s0, xout => resultMultFull_uid57_sqrt_ma3_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultMultFull_uid57_sqrt_ma3_cma_q <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_ma3_cma_qq(36 downto 0));

    -- resultMultFull_uid57_sqrt_align_16(BITSHIFT,274)@29
    resultMultFull_uid57_sqrt_align_16_qint <= resultMultFull_uid57_sqrt_ma3_cma_q & "000000000000000000";
    resultMultFull_uid57_sqrt_align_16_q <= resultMultFull_uid57_sqrt_align_16_qint(54 downto 0);

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_notEnable(LOGICAL,419)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_nor(LOGICAL,420)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_nor_q <= not (redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_notEnable_q or redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_sticky_ena_q);

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_last(CONSTANT,416)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_last_q <= "01000";

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmp(LOGICAL,417)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmp_b <= STD_LOGIC_VECTOR("0" & redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_q);
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmp_q <= "1" WHEN redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_last_q = redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmp_b ELSE "0";

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmpReg(REG,418)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmpReg_q <= STD_LOGIC_VECTOR(redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_sticky_ena(REG,421)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_sticky_ena_q <= "0";
            ELSE
                IF (redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_nor_q = "1") THEN
                    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_sticky_ena_q <= STD_LOGIC_VECTOR(redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_enaAnd(LOGICAL,422)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_enaAnd_q <= redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_sticky_ena_q and en;

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt(COUNTER,413)
    -- low=0, high=9, step=1, init=0
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_i = TO_UNSIGNED(8, 4)) THEN
                        redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_eq <= '1';
                    ELSE
                        redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_eq <= '0';
                    END IF;
                    IF (redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_eq = '1') THEN
                        redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_i <= redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_i + 7;
                    ELSE
                        redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_i <= redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_i, 4)));

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux(MUX,414)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_s <= en;
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_combproc: PROCESS (redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_s, redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_wraddr_q, redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_q)
    BEGIN
        CASE (redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_s) IS
            WHEN "0" => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_q <= redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_wraddr_q;
            WHEN "1" => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_q <= redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdcnt_q;
            WHEN OTHERS => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_wraddr(REG,415)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_wraddr_q <= "1001";
            ELSE
                redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_wraddr_q <= STD_LOGIC_VECTOR(redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem(DUALMEM,412)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_ia <= STD_LOGIC_VECTOR(redist3_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_1_q);
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_aa <= redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_wraddr_q;
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_ab <= redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_rdmux_q;
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_reset0 <= rst;
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 14,
        widthad_a => 4,
        numwords_a => 10,
        width_b => 14,
        widthad_b => 4,
        numwords_b => 10,
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
        clocken1 => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_reset0,
        clock1 => clk,
        address_a => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_aa,
        data_a => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_ia,
        wren_a => en(0),
        address_b => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_ab,
        q_b => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_iq
    );
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_q <= redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_iq(13 downto 0);
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_enaOr_rst <= redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_enaAnd_q(0) or redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_reset0;

    -- redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_outputreg0(DELAY,411)
    redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_outputreg0 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_mem_q, xout => redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_bs13(BITSELECT,271)@24
    resultMultFull_uid57_sqrt_bs13_b <= redist19_resultPreMultX_uid56_sqrt_b_1_q(33 downto 18);

    -- resultMultFull_uid57_sqrt_im12_cma(CHAINMULTADD,347)@24 + 4
    -- out q@29
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
                    resultMultFull_uid57_sqrt_im12_cma_ah(0) <= RESIZE(UNSIGNED(resultMultFull_uid57_sqrt_bs13_b),16);
                    resultMultFull_uid57_sqrt_im12_cma_ch(0) <= RESIZE(UNSIGNED(redist4_xMulInitApproxSquaredFull_uid47_sqrt_bs4_b_13_outputreg0_q),14);
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
    GENERIC MAP ( width => 30, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_im12_cma_s0, xout => resultMultFull_uid57_sqrt_im12_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultMultFull_uid57_sqrt_im12_cma_q <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_im12_cma_qq(29 downto 0));

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_notEnable(LOGICAL,432)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_nor(LOGICAL,433)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_nor_q <= not (redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_notEnable_q or redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_sticky_ena_q);

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_last(CONSTANT,429)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_last_q <= "01000";

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmp(LOGICAL,430)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmp_b <= STD_LOGIC_VECTOR("0" & redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_q);
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmp_q <= "1" WHEN redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_last_q = redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmp_b ELSE "0";

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmpReg(REG,431)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmpReg_q <= "0";
            ELSE
                IF (en = "1") THEN
                    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmpReg_q <= STD_LOGIC_VECTOR(redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmp_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_sticky_ena(REG,434)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_sticky_ena_q <= "0";
            ELSE
                IF (redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_nor_q = "1") THEN
                    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_sticky_ena_q <= STD_LOGIC_VECTOR(redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_enaAnd(LOGICAL,435)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_enaAnd_q <= redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_sticky_ena_q and en;

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt(COUNTER,426)
    -- low=0, high=9, step=1, init=0
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_eq <= '0';
            ELSE
                IF (en = "1") THEN
                    IF (redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_i = TO_UNSIGNED(8, 4)) THEN
                        redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_eq <= '1';
                    ELSE
                        redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_eq <= '0';
                    END IF;
                    IF (redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_eq = '1') THEN
                        redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_i <= redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_i + 7;
                    ELSE
                        redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_i <= redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_i + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_i, 4)));

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux(MUX,427)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_s <= en;
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_combproc: PROCESS (redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_s, redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_wraddr_q, redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_q)
    BEGIN
        CASE (redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_s) IS
            WHEN "0" => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_q <= redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_wraddr_q;
            WHEN "1" => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_q <= redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdcnt_q;
            WHEN OTHERS => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_inputreg0(DELAY,423)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_inputreg0 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xMulInitApproxSquaredFull_uid47_sqrt_bs1_b, xout => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_inputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_wraddr(REG,428)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_wraddr_q <= "1001";
            ELSE
                redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_wraddr_q <= STD_LOGIC_VECTOR(redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem(DUALMEM,425)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_ia <= STD_LOGIC_VECTOR(redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_inputreg0_q);
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_aa <= redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_wraddr_q;
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_ab <= redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_rdmux_q;
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_reset0 <= rst;
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 18,
        widthad_a => 4,
        numwords_a => 10,
        width_b => 18,
        widthad_b => 4,
        numwords_b => 10,
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
        clocken1 => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_reset0,
        clock1 => clk,
        address_a => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_aa,
        data_a => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_ia,
        wren_a => en(0),
        address_b => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_ab,
        q_b => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_iq
    );
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_q <= redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_iq(17 downto 0);
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_enaOr_rst <= redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_enaAnd_q(0) or redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_reset0;

    -- redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_outputreg0(DELAY,424)
    redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_outputreg0 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_mem_q, xout => redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_outputreg0_q, ena => en(0), clk => clk, aclr => rst );

    -- resultMultFull_uid57_sqrt_bs1(BITSELECT,259)@24
    resultMultFull_uid57_sqrt_bs1_in <= redist19_resultPreMultX_uid56_sqrt_b_1_q(17 downto 0);
    resultMultFull_uid57_sqrt_bs1_b <= resultMultFull_uid57_sqrt_bs1_in(17 downto 0);

    -- resultMultFull_uid57_sqrt_im0_cma(CHAINMULTADD,346)@24 + 4
    -- out q@29
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
                    resultMultFull_uid57_sqrt_im0_cma_ch(0) <= RESIZE(UNSIGNED(redist5_xMulInitApproxSquaredFull_uid47_sqrt_bs1_b_13_outputreg0_q),18);
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
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => resultMultFull_uid57_sqrt_im0_cma_s0, xout => resultMultFull_uid57_sqrt_im0_cma_qq, ena => en(0), clk => clk, aclr => rst );
    resultMultFull_uid57_sqrt_im0_cma_q <= STD_LOGIC_VECTOR(resultMultFull_uid57_sqrt_im0_cma_qq(35 downto 0));

    -- resultMultFull_uid57_sqrt_join_15(BITJOIN,273)@29
    resultMultFull_uid57_sqrt_join_15_q <= resultMultFull_uid57_sqrt_im12_cma_q & resultMultFull_uid57_sqrt_im0_cma_q;

    -- resultMultFull_uid57_sqrt_result_add_0_0(ADD,276)@29
    resultMultFull_uid57_sqrt_result_add_0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & resultMultFull_uid57_sqrt_join_15_q));
    resultMultFull_uid57_sqrt_result_add_0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((68 downto 55 => resultMultFull_uid57_sqrt_align_16_q(54)) & resultMultFull_uid57_sqrt_align_16_q));
    resultMultFull_uid57_sqrt_result_add_0_0_o <= STD_LOGIC_VECTOR(SIGNED(resultMultFull_uid57_sqrt_result_add_0_0_a) + SIGNED(resultMultFull_uid57_sqrt_result_add_0_0_b));
    resultMultFull_uid57_sqrt_result_add_0_0_q <= resultMultFull_uid57_sqrt_result_add_0_0_o(67 downto 0);

    -- result_uid58_sqrt(BITSELECT,57)@29
    result_uid58_sqrt_in <= resultMultFull_uid57_sqrt_result_add_0_0_q(64 downto 0);
    result_uid58_sqrt_b <= result_uid58_sqrt_in(64 downto 31);

    -- redist17_result_uid58_sqrt_b_1(DELAY,376)
    redist17_result_uid58_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => result_uid58_sqrt_b, xout => redist17_result_uid58_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- redist18_result_uid58_sqrt_b_3(DELAY,377)
    redist18_result_uid58_sqrt_b_3 : dspba_delay
    GENERIC MAP ( width => 34, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist17_result_uid58_sqrt_b_1_q, xout => redist18_result_uid58_sqrt_b_3_q, ena => en(0), clk => clk, aclr => rst );

    -- invNegShiftEven_uid61_sqrt(BITSELECT,60)@32
    invNegShiftEven_uid61_sqrt_b <= STD_LOGIC_VECTOR(redist18_result_uid58_sqrt_b_3_q(33 downto 33));

    -- negShiftEven_uid62_sqrt(LOGICAL,61)@32
    negShiftEven_uid62_sqrt_q <= not (invNegShiftEven_uid61_sqrt_b);

    -- parityOddOriginal_uid12_sqrt(BITSELECT,11)@32
    parityOddOriginal_uid12_sqrt_in <= STD_LOGIC_VECTOR(redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_outputreg0_q(0 downto 0));
    parityOddOriginal_uid12_sqrt_b <= STD_LOGIC_VECTOR(parityOddOriginal_uid12_sqrt_in(0 downto 0));

    -- EvenBranchAndNegUpdate_uid66_sqrt(LOGICAL,65)@32
    EvenBranchAndNegUpdate_uid66_sqrt_q <= parityOddOriginal_uid12_sqrt_b and negShiftEven_uid62_sqrt_q;

    -- maxValInOutFormat_uid147_finalMult_uid59_sqrt(CONSTANT,146)
    maxValInOutFormat_uid147_finalMult_uid59_sqrt_q <= "1111111111111111111111111111111111";

    -- minValueInFormat_uid148_finalMult_uid59_sqrt(CONSTANT,147)
    minValueInFormat_uid148_finalMult_uid59_sqrt_q <= "0000000000000000000000000000000000";

    -- xv0_uid127_finalMult_uid59_sqrt(BITSELECT,126)@30
    xv0_uid127_finalMult_uid59_sqrt_in <= redist17_result_uid58_sqrt_b_1_q(5 downto 0);
    xv0_uid127_finalMult_uid59_sqrt_b <= xv0_uid127_finalMult_uid59_sqrt_in(5 downto 0);

    -- p0_uid138_finalMult_uid59_sqrt(LOOKUP,137)@30
    p0_uid138_finalMult_uid59_sqrt_combproc: PROCESS (xv0_uid127_finalMult_uid59_sqrt_b)
    BEGIN
        -- Begin reserved scope level
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
        -- End reserved scope level
    END PROCESS;

    -- xv1_uid128_finalMult_uid59_sqrt(BITSELECT,127)@30
    xv1_uid128_finalMult_uid59_sqrt_in <= redist17_result_uid58_sqrt_b_1_q(11 downto 0);
    xv1_uid128_finalMult_uid59_sqrt_b <= xv1_uid128_finalMult_uid59_sqrt_in(11 downto 6);

    -- p1_uid137_finalMult_uid59_sqrt(LOOKUP,136)@30
    p1_uid137_finalMult_uid59_sqrt_combproc: PROCESS (xv1_uid128_finalMult_uid59_sqrt_b)
    BEGIN
        -- Begin reserved scope level
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
        -- End reserved scope level
    END PROCESS;

    -- lev1_a2_uid144_finalMult_uid59_sqrt(ADD,143)@30 + 1
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

    -- xv2_uid129_finalMult_uid59_sqrt(BITSELECT,128)@30
    xv2_uid129_finalMult_uid59_sqrt_in <= redist17_result_uid58_sqrt_b_1_q(17 downto 0);
    xv2_uid129_finalMult_uid59_sqrt_b <= xv2_uid129_finalMult_uid59_sqrt_in(17 downto 12);

    -- p2_uid136_finalMult_uid59_sqrt(LOOKUP,135)@30
    p2_uid136_finalMult_uid59_sqrt_combproc: PROCESS (xv2_uid129_finalMult_uid59_sqrt_b)
    BEGIN
        -- Begin reserved scope level
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
        -- End reserved scope level
    END PROCESS;

    -- xv3_uid130_finalMult_uid59_sqrt(BITSELECT,129)@30
    xv3_uid130_finalMult_uid59_sqrt_in <= redist17_result_uid58_sqrt_b_1_q(23 downto 0);
    xv3_uid130_finalMult_uid59_sqrt_b <= xv3_uid130_finalMult_uid59_sqrt_in(23 downto 18);

    -- p3_uid135_finalMult_uid59_sqrt(LOOKUP,134)@30
    p3_uid135_finalMult_uid59_sqrt_combproc: PROCESS (xv3_uid130_finalMult_uid59_sqrt_b)
    BEGIN
        -- Begin reserved scope level
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
        -- End reserved scope level
    END PROCESS;

    -- lev1_a1_uid143_finalMult_uid59_sqrt(ADD,142)@30
    lev1_a1_uid143_finalMult_uid59_sqrt_a <= STD_LOGIC_VECTOR("0" & p3_uid135_finalMult_uid59_sqrt_q);
    lev1_a1_uid143_finalMult_uid59_sqrt_b <= STD_LOGIC_VECTOR("0000000" & p2_uid136_finalMult_uid59_sqrt_q);
    lev1_a1_uid143_finalMult_uid59_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a1_uid143_finalMult_uid59_sqrt_a) + UNSIGNED(lev1_a1_uid143_finalMult_uid59_sqrt_b));
    lev1_a1_uid143_finalMult_uid59_sqrt_q <= lev1_a1_uid143_finalMult_uid59_sqrt_o(28 downto 0);

    -- xv5_uid132_finalMult_uid59_sqrt(BITSELECT,131)@30
    xv5_uid132_finalMult_uid59_sqrt_b <= redist17_result_uid58_sqrt_b_1_q(33 downto 30);

    -- p5_uid133_finalMult_uid59_sqrt(LOOKUP,132)@30
    p5_uid133_finalMult_uid59_sqrt_combproc: PROCESS (xv5_uid132_finalMult_uid59_sqrt_b)
    BEGIN
        -- Begin reserved scope level
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
        -- End reserved scope level
    END PROCESS;

    -- lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt(ADD,140)@30
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_a <= STD_LOGIC_VECTOR("0" & p5_uid133_finalMult_uid59_sqrt_q);
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_b <= STD_LOGIC_VECTOR("000000" & lowRangeB_uid139_finalMult_uid59_sqrt_merged_bit_select_c);
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_a) + UNSIGNED(lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_b));
    lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_q <= lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_o(38 downto 0);

    -- xv4_uid131_finalMult_uid59_sqrt(BITSELECT,130)@30
    xv4_uid131_finalMult_uid59_sqrt_in <= redist17_result_uid58_sqrt_b_1_q(29 downto 0);
    xv4_uid131_finalMult_uid59_sqrt_b <= xv4_uid131_finalMult_uid59_sqrt_in(29 downto 24);

    -- p4_uid134_finalMult_uid59_sqrt(LOOKUP,133)@30
    p4_uid134_finalMult_uid59_sqrt_combproc: PROCESS (xv4_uid131_finalMult_uid59_sqrt_b)
    BEGIN
        -- Begin reserved scope level
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
        -- End reserved scope level
    END PROCESS;

    -- lowRangeB_uid139_finalMult_uid59_sqrt_merged_bit_select(BITSELECT,358)@30
    lowRangeB_uid139_finalMult_uid59_sqrt_merged_bit_select_b <= p4_uid134_finalMult_uid59_sqrt_q(0 downto 0);
    lowRangeB_uid139_finalMult_uid59_sqrt_merged_bit_select_c <= p4_uid134_finalMult_uid59_sqrt_q(33 downto 1);

    -- lev1_a0_uid142_finalMult_uid59_sqrt(BITJOIN,141)@30
    lev1_a0_uid142_finalMult_uid59_sqrt_q <= lev1_a0sumAHighB_uid141_finalMult_uid59_sqrt_q & lowRangeB_uid139_finalMult_uid59_sqrt_merged_bit_select_b;

    -- lev2_a0_uid145_finalMult_uid59_sqrt(ADD,144)@30 + 1
    lev2_a0_uid145_finalMult_uid59_sqrt_a <= STD_LOGIC_VECTOR("0" & lev1_a0_uid142_finalMult_uid59_sqrt_q);
    lev2_a0_uid145_finalMult_uid59_sqrt_b <= STD_LOGIC_VECTOR("000000000000" & lev1_a1_uid143_finalMult_uid59_sqrt_q);
    lev2_a0_uid145_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                lev2_a0_uid145_finalMult_uid59_sqrt_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    lev2_a0_uid145_finalMult_uid59_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev2_a0_uid145_finalMult_uid59_sqrt_a) + UNSIGNED(lev2_a0_uid145_finalMult_uid59_sqrt_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    lev2_a0_uid145_finalMult_uid59_sqrt_q <= lev2_a0_uid145_finalMult_uid59_sqrt_o(40 downto 0);

    -- lev3_a0_uid146_finalMult_uid59_sqrt(ADD,145)@31
    lev3_a0_uid146_finalMult_uid59_sqrt_a <= STD_LOGIC_VECTOR("0" & lev2_a0_uid145_finalMult_uid59_sqrt_q);
    lev3_a0_uid146_finalMult_uid59_sqrt_b <= STD_LOGIC_VECTOR("0000000000000000000000000" & lev1_a2_uid144_finalMult_uid59_sqrt_q);
    lev3_a0_uid146_finalMult_uid59_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev3_a0_uid146_finalMult_uid59_sqrt_a) + UNSIGNED(lev3_a0_uid146_finalMult_uid59_sqrt_b));
    lev3_a0_uid146_finalMult_uid59_sqrt_q <= lev3_a0_uid146_finalMult_uid59_sqrt_o(41 downto 0);

    -- sR_uid156_finalMult_uid59_sqrt(BITSELECT,155)@31
    sR_uid156_finalMult_uid59_sqrt_in <= lev3_a0_uid146_finalMult_uid59_sqrt_q(37 downto 0);
    sR_uid156_finalMult_uid59_sqrt_b <= sR_uid156_finalMult_uid59_sqrt_in(37 downto 4);

    -- redist8_sR_uid156_finalMult_uid59_sqrt_b_1(DELAY,367)
    redist8_sR_uid156_finalMult_uid59_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sR_uid156_finalMult_uid59_sqrt_b, xout => redist8_sR_uid156_finalMult_uid59_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- updatedX_uid150_finalMult_uid59_sqrt(BITJOIN,149)@31
    updatedX_uid150_finalMult_uid59_sqrt_q <= maxValInOutFormat_uid147_finalMult_uid59_sqrt_q & zs_uid110_leadingZeros_uid7_sqrt_q;

    -- ovf_uid149_finalMult_uid59_sqrt(COMPARE,150)@31 + 1
    ovf_uid149_finalMult_uid59_sqrt_a <= STD_LOGIC_VECTOR("000000" & updatedX_uid150_finalMult_uid59_sqrt_q);
    ovf_uid149_finalMult_uid59_sqrt_b <= STD_LOGIC_VECTOR("00" & lev3_a0_uid146_finalMult_uid59_sqrt_q);
    ovf_uid149_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                ovf_uid149_finalMult_uid59_sqrt_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    ovf_uid149_finalMult_uid59_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(ovf_uid149_finalMult_uid59_sqrt_a) - UNSIGNED(ovf_uid149_finalMult_uid59_sqrt_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    ovf_uid149_finalMult_uid59_sqrt_c(0) <= ovf_uid149_finalMult_uid59_sqrt_o(43);

    -- updatedY_uid153_finalMult_uid59_sqrt(BITJOIN,152)@31
    updatedY_uid153_finalMult_uid59_sqrt_q <= minValueInFormat_uid148_finalMult_uid59_sqrt_q & zs_uid110_leadingZeros_uid7_sqrt_q;

    -- udf_uid152_finalMult_uid59_sqrt(COMPARE,153)@31 + 1
    udf_uid152_finalMult_uid59_sqrt_a <= STD_LOGIC_VECTOR("00" & lev3_a0_uid146_finalMult_uid59_sqrt_q);
    udf_uid152_finalMult_uid59_sqrt_b <= STD_LOGIC_VECTOR("000000" & updatedY_uid153_finalMult_uid59_sqrt_q);
    udf_uid152_finalMult_uid59_sqrt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                udf_uid152_finalMult_uid59_sqrt_o <= (others => '0');
            ELSE
                IF (en = "1") THEN
                    udf_uid152_finalMult_uid59_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(udf_uid152_finalMult_uid59_sqrt_a) - UNSIGNED(udf_uid152_finalMult_uid59_sqrt_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    udf_uid152_finalMult_uid59_sqrt_c(0) <= udf_uid152_finalMult_uid59_sqrt_o(43);

    -- ovfudfcond_uid155_finalMult_uid59_sqrt(BITJOIN,154)@32
    ovfudfcond_uid155_finalMult_uid59_sqrt_q <= ovf_uid149_finalMult_uid59_sqrt_c & udf_uid152_finalMult_uid59_sqrt_c;

    -- sRA0_uid157_finalMult_uid59_sqrt(MUX,156)@32
    sRA0_uid157_finalMult_uid59_sqrt_s <= ovfudfcond_uid155_finalMult_uid59_sqrt_q;
    sRA0_uid157_finalMult_uid59_sqrt_combproc: PROCESS (sRA0_uid157_finalMult_uid59_sqrt_s, redist8_sR_uid156_finalMult_uid59_sqrt_b_1_q, minValueInFormat_uid148_finalMult_uid59_sqrt_q, maxValInOutFormat_uid147_finalMult_uid59_sqrt_q)
    BEGIN
        CASE (sRA0_uid157_finalMult_uid59_sqrt_s) IS
            WHEN "00" => sRA0_uid157_finalMult_uid59_sqrt_q <= redist8_sR_uid156_finalMult_uid59_sqrt_b_1_q;
            WHEN "01" => sRA0_uid157_finalMult_uid59_sqrt_q <= minValueInFormat_uid148_finalMult_uid59_sqrt_q;
            WHEN "10" => sRA0_uid157_finalMult_uid59_sqrt_q <= maxValInOutFormat_uid147_finalMult_uid59_sqrt_q;
            WHEN "11" => sRA0_uid157_finalMult_uid59_sqrt_q <= maxValInOutFormat_uid147_finalMult_uid59_sqrt_q;
            WHEN OTHERS => sRA0_uid157_finalMult_uid59_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- finalMultLSBRange_uid60_sqrt(BITSELECT,59)@32
    finalMultLSBRange_uid60_sqrt_b <= sRA0_uid157_finalMult_uid59_sqrt_q(33 downto 1);

    -- negShiftOdd_uid63_sqrt(BITSELECT,62)@32
    negShiftOdd_uid63_sqrt_b <= finalMultLSBRange_uid60_sqrt_b(32 downto 32);

    -- negShiftOdd_uid64_sqrt(LOGICAL,63)@32
    negShiftOdd_uid64_sqrt_q <= not (negShiftOdd_uid63_sqrt_b);

    -- parityOddOriginalInv_uid13_sqrt(LOGICAL,12)@32
    parityOddOriginalInv_uid13_sqrt_q <= not (parityOddOriginal_uid12_sqrt_b);

    -- OddBranchAndNegUpdate_uid67_sqrt(LOGICAL,66)@32
    OddBranchAndNegUpdate_uid67_sqrt_q <= parityOddOriginalInv_uid13_sqrt_q and negShiftOdd_uid64_sqrt_q;

    -- shiftUpdateValue_uid68_sqrt(LOGICAL,67)@32
    shiftUpdateValue_uid68_sqrt_q <= OddBranchAndNegUpdate_uid67_sqrt_q or EvenBranchAndNegUpdate_uid66_sqrt_q;

    -- redist16_shiftUpdateValue_uid68_sqrt_q_1(DELAY,375)
    redist16_shiftUpdateValue_uid68_sqrt_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => shiftUpdateValue_uid68_sqrt_q, xout => redist16_shiftUpdateValue_uid68_sqrt_q_1_q, ena => en(0), clk => clk, aclr => rst );

    -- inExponent_uid9_sqrt(SUB,8)@32
    inExponent_uid9_sqrt_a <= STD_LOGIC_VECTOR("0" & shiftConstant_uid8_sqrt_q);
    inExponent_uid9_sqrt_b <= STD_LOGIC_VECTOR("0" & redist9_r_uid125_leadingZeros_uid7_sqrt_q_29_outputreg0_q);
    inExponent_uid9_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(inExponent_uid9_sqrt_a) - UNSIGNED(inExponent_uid9_sqrt_b));
    inExponent_uid9_sqrt_q <= inExponent_uid9_sqrt_o(6 downto 0);

    -- outExponentOdd_uid17_sqrt(ADD,16)@32
    outExponentOdd_uid17_sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((8 downto 7 => inExponent_uid9_sqrt_q(6)) & inExponent_uid9_sqrt_q));
    outExponentOdd_uid17_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000" & VCC_q));
    outExponentOdd_uid17_sqrt_o <= STD_LOGIC_VECTOR(SIGNED(outExponentOdd_uid17_sqrt_a) + SIGNED(outExponentOdd_uid17_sqrt_b));
    outExponentOdd_uid17_sqrt_q <= outExponentOdd_uid17_sqrt_o(7 downto 0);

    -- outExponentOdd_uid18_sqrt(BITSELECT,17)@32
    outExponentOdd_uid18_sqrt_in <= STD_LOGIC_VECTOR(outExponentOdd_uid17_sqrt_q(6 downto 0));
    outExponentOdd_uid18_sqrt_b <= STD_LOGIC_VECTOR(outExponentOdd_uid18_sqrt_in(6 downto 1));

    -- outExponentEven_uid19_sqrt(BITSELECT,18)@32
    outExponentEven_uid19_sqrt_b <= STD_LOGIC_VECTOR(inExponent_uid9_sqrt_q(6 downto 1));

    -- outputExponent_uid20_sqrt(MUX,19)@32
    outputExponent_uid20_sqrt_s <= parityOddOriginalInv_uid13_sqrt_q;
    outputExponent_uid20_sqrt_combproc: PROCESS (outputExponent_uid20_sqrt_s, outExponentEven_uid19_sqrt_b, outExponentOdd_uid18_sqrt_b)
    BEGIN
        CASE (outputExponent_uid20_sqrt_s) IS
            WHEN "0" => outputExponent_uid20_sqrt_q <= outExponentEven_uid19_sqrt_b;
            WHEN "1" => outputExponent_uid20_sqrt_q <= outExponentOdd_uid18_sqrt_b;
            WHEN OTHERS => outputExponent_uid20_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- shiftConstant_uid8_sqrt(CONSTANT,7)
    shiftConstant_uid8_sqrt_q <= "011111";

    -- shiftOutVal_uid22_sqrt(SUB,21)@32 + 1
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

    -- shiftOutValUpdated_uid75_sqrt(ADD,74)@33
    shiftOutValUpdated_uid75_sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((8 downto 7 => shiftOutVal_uid22_sqrt_q(6)) & shiftOutVal_uid22_sqrt_q));
    shiftOutValUpdated_uid75_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000" & redist16_shiftUpdateValue_uid68_sqrt_q_1_q));
    shiftOutValUpdated_uid75_sqrt_o <= STD_LOGIC_VECTOR(SIGNED(shiftOutValUpdated_uid75_sqrt_a) + SIGNED(shiftOutValUpdated_uid75_sqrt_b));
    shiftOutValUpdated_uid75_sqrt_q <= shiftOutValUpdated_uid75_sqrt_o(7 downto 0);

    -- sat_uid76_sqrt(BITSELECT,75)@33
    sat_uid76_sqrt_b <= STD_LOGIC_VECTOR(shiftOutValUpdated_uid75_sqrt_q(7 downto 7));

    -- redist15_sat_uid76_sqrt_b_1(DELAY,374)
    redist15_sat_uid76_sqrt_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sat_uid76_sqrt_b, xout => redist15_sat_uid76_sqrt_b_1_q, ena => en(0), clk => clk, aclr => rst );

    -- satOrOvfPostRnd_uid85_sqrt(LOGICAL,84)@34
    satOrOvfPostRnd_uid85_sqrt_q <= redist15_sat_uid76_sqrt_b_1_q or resultFinalPreSat_uid83_sqrt_merged_bit_select_c;

    -- wIntCst_uid280_xRightShiftFinal_uid78_sqrt(CONSTANT,279)
    wIntCst_uid280_xRightShiftFinal_uid78_sqrt_q <= "100001";

    -- shiftedOut_uid281_xRightShiftFinal_uid78_sqrt(COMPARE,280)@33 + 1
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

    -- rightShiftStage2Idx2Rng32_uid307_xRightShiftFinal_uid78_sqrt(BITSELECT,306)@33
    rightShiftStage2Idx2Rng32_uid307_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q(32 downto 32);

    -- rightShiftStage2Idx2_uid309_xRightShiftFinal_uid78_sqrt(BITJOIN,308)@33
    rightShiftStage2Idx2_uid309_xRightShiftFinal_uid78_sqrt_q <= zs_uid92_leadingZeros_uid7_sqrt_q & rightShiftStage2Idx2Rng32_uid307_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage2Idx1Rng16_uid304_xRightShiftFinal_uid78_sqrt(BITSELECT,303)@33
    rightShiftStage2Idx1Rng16_uid304_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q(32 downto 16);

    -- rightShiftStage2Idx1_uid306_xRightShiftFinal_uid78_sqrt(BITJOIN,305)@33
    rightShiftStage2Idx1_uid306_xRightShiftFinal_uid78_sqrt_q <= zs_uid98_leadingZeros_uid7_sqrt_q & rightShiftStage2Idx1Rng16_uid304_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage1Idx3Rng12_uid299_xRightShiftFinal_uid78_sqrt(BITSELECT,298)@33
    rightShiftStage1Idx3Rng12_uid299_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q(32 downto 12);

    -- rightShiftStage1Idx3_uid301_xRightShiftFinal_uid78_sqrt(BITJOIN,300)@33
    rightShiftStage1Idx3_uid301_xRightShiftFinal_uid78_sqrt_q <= leftShiftStage1Idx3Pad12_uid202_xLeftShift_uid23_sqrt_q & rightShiftStage1Idx3Rng12_uid299_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage1Idx2Rng8_uid296_xRightShiftFinal_uid78_sqrt(BITSELECT,295)@33
    rightShiftStage1Idx2Rng8_uid296_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q(32 downto 8);

    -- rightShiftStage1Idx2_uid298_xRightShiftFinal_uid78_sqrt(BITJOIN,297)@33
    rightShiftStage1Idx2_uid298_xRightShiftFinal_uid78_sqrt_q <= zs_uid104_leadingZeros_uid7_sqrt_q & rightShiftStage1Idx2Rng8_uid296_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage1Idx1Rng4_uid293_xRightShiftFinal_uid78_sqrt(BITSELECT,292)@33
    rightShiftStage1Idx1Rng4_uid293_xRightShiftFinal_uid78_sqrt_b <= rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q(32 downto 4);

    -- rightShiftStage1Idx1_uid295_xRightShiftFinal_uid78_sqrt(BITJOIN,294)@33
    rightShiftStage1Idx1_uid295_xRightShiftFinal_uid78_sqrt_q <= zs_uid110_leadingZeros_uid7_sqrt_q & rightShiftStage1Idx1Rng4_uid293_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage0Idx3Rng3_uid288_xRightShiftFinal_uid78_sqrt(BITSELECT,287)@33
    rightShiftStage0Idx3Rng3_uid288_xRightShiftFinal_uid78_sqrt_b <= shifterInData_uid74_sqrt_q(32 downto 3);

    -- rightShiftStage0Idx3_uid290_xRightShiftFinal_uid78_sqrt(BITJOIN,289)@33
    rightShiftStage0Idx3_uid290_xRightShiftFinal_uid78_sqrt_q <= leftShiftStage2Idx3Pad3_uid213_xLeftShift_uid23_sqrt_q & rightShiftStage0Idx3Rng3_uid288_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage0Idx2Rng2_uid285_xRightShiftFinal_uid78_sqrt(BITSELECT,284)@33
    rightShiftStage0Idx2Rng2_uid285_xRightShiftFinal_uid78_sqrt_b <= shifterInData_uid74_sqrt_q(32 downto 2);

    -- rightShiftStage0Idx2_uid287_xRightShiftFinal_uid78_sqrt(BITJOIN,286)@33
    rightShiftStage0Idx2_uid287_xRightShiftFinal_uid78_sqrt_q <= zs_uid116_leadingZeros_uid7_sqrt_q & rightShiftStage0Idx2Rng2_uid285_xRightShiftFinal_uid78_sqrt_b;

    -- rightShiftStage0Idx1Rng1_uid282_xRightShiftFinal_uid78_sqrt(BITSELECT,281)@33
    rightShiftStage0Idx1Rng1_uid282_xRightShiftFinal_uid78_sqrt_b <= shifterInData_uid74_sqrt_q(32 downto 1);

    -- rightShiftStage0Idx1_uid284_xRightShiftFinal_uid78_sqrt(BITJOIN,283)@33
    rightShiftStage0Idx1_uid284_xRightShiftFinal_uid78_sqrt_q <= GND_q & rightShiftStage0Idx1Rng1_uid282_xRightShiftFinal_uid78_sqrt_b;

    -- finalMultBottomBits_uid70_sqrt(BITSELECT,69)@32
    finalMultBottomBits_uid70_sqrt_in <= sRA0_uid157_finalMult_uid59_sqrt_q(32 downto 0);
    finalMultBottomBits_uid70_sqrt_b <= finalMultBottomBits_uid70_sqrt_in(32 downto 0);

    -- resultBottomBits_uid71_sqrt(BITSELECT,70)@32
    resultBottomBits_uid71_sqrt_in <= redist18_result_uid58_sqrt_b_3_q(32 downto 0);
    resultBottomBits_uid71_sqrt_b <= resultBottomBits_uid71_sqrt_in(32 downto 0);

    -- resultUpperRange_uid73_sqrt(BITSELECT,72)@32
    resultUpperRange_uid73_sqrt_b <= redist18_result_uid58_sqrt_b_3_q(33 downto 1);

    -- negShiftEvenParityOdd_uid69_sqrt(BITJOIN,68)@32
    negShiftEvenParityOdd_uid69_sqrt_q <= shiftUpdateValue_uid68_sqrt_q & parityOddOriginalInv_uid13_sqrt_q;

    -- shifterInData_uid74_sqrt(MUX,73)@32 + 1
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
                        WHEN "01" => shifterInData_uid74_sqrt_q <= finalMultLSBRange_uid60_sqrt_b;
                        WHEN "10" => shifterInData_uid74_sqrt_q <= resultBottomBits_uid71_sqrt_b;
                        WHEN "11" => shifterInData_uid74_sqrt_q <= finalMultBottomBits_uid70_sqrt_b;
                        WHEN OTHERS => shifterInData_uid74_sqrt_q <= (others => '0');
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt(BITSELECT,290)@33
    rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_in <= shiftOutValUpdated_uid75_sqrt_q(1 downto 0);
    rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_b <= rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_in(1 downto 0);

    -- rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt(MUX,291)@33
    rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_s <= rightShiftStageSel0Dto0_uid291_xRightShiftFinal_uid78_sqrt_b;
    rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_combproc: PROCESS (rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_s, shifterInData_uid74_sqrt_q, rightShiftStage0Idx1_uid284_xRightShiftFinal_uid78_sqrt_q, rightShiftStage0Idx2_uid287_xRightShiftFinal_uid78_sqrt_q, rightShiftStage0Idx3_uid290_xRightShiftFinal_uid78_sqrt_q)
    BEGIN
        CASE (rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_s) IS
            WHEN "00" => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= shifterInData_uid74_sqrt_q;
            WHEN "01" => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage0Idx1_uid284_xRightShiftFinal_uid78_sqrt_q;
            WHEN "10" => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage0Idx2_uid287_xRightShiftFinal_uid78_sqrt_q;
            WHEN "11" => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage0Idx3_uid290_xRightShiftFinal_uid78_sqrt_q;
            WHEN OTHERS => rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt(BITSELECT,301)@33
    rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_in <= shiftOutValUpdated_uid75_sqrt_q(3 downto 0);
    rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_b <= rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_in(3 downto 2);

    -- rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt(MUX,302)@33
    rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_s <= rightShiftStageSel2Dto2_uid302_xRightShiftFinal_uid78_sqrt_b;
    rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_combproc: PROCESS (rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_s, rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q, rightShiftStage1Idx1_uid295_xRightShiftFinal_uid78_sqrt_q, rightShiftStage1Idx2_uid298_xRightShiftFinal_uid78_sqrt_q, rightShiftStage1Idx3_uid301_xRightShiftFinal_uid78_sqrt_q)
    BEGIN
        CASE (rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_s) IS
            WHEN "00" => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage0_uid292_xRightShiftFinal_uid78_sqrt_q;
            WHEN "01" => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage1Idx1_uid295_xRightShiftFinal_uid78_sqrt_q;
            WHEN "10" => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage1Idx2_uid298_xRightShiftFinal_uid78_sqrt_q;
            WHEN "11" => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= rightShiftStage1Idx3_uid301_xRightShiftFinal_uid78_sqrt_q;
            WHEN OTHERS => rightShiftStage1_uid303_xRightShiftFinal_uid78_sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt(BITSELECT,310)@33
    rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_in <= shiftOutValUpdated_uid75_sqrt_q(5 downto 0);
    rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b <= rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_in(5 downto 4);

    -- rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt(MUX,311)@33 + 1
    rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_s <= rightShiftStageSel4Dto4_uid311_xRightShiftFinal_uid78_sqrt_b;
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

    -- resultFinalPostRnd_uid82_sqrt(ADD,81)@34
    resultFinalPostRnd_uid82_sqrt_a <= STD_LOGIC_VECTOR("0" & rightShiftStage2_uid312_xRightShiftFinal_uid78_sqrt_q);
    resultFinalPostRnd_uid82_sqrt_b <= STD_LOGIC_VECTOR("000000000000000000000000000000000" & VCC_q);
    resultFinalPostRnd_uid82_sqrt_i <= resultFinalPostRnd_uid82_sqrt_b;
    resultFinalPostRnd_uid82_sqrt_a1 <= resultFinalPostRnd_uid82_sqrt_i WHEN shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n = "1" ELSE resultFinalPostRnd_uid82_sqrt_a;
    resultFinalPostRnd_uid82_sqrt_b1 <= (others => '0') WHEN shiftedOut_uid281_xRightShiftFinal_uid78_sqrt_n = "1" ELSE resultFinalPostRnd_uid82_sqrt_b;
    resultFinalPostRnd_uid82_sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(resultFinalPostRnd_uid82_sqrt_a1) + UNSIGNED(resultFinalPostRnd_uid82_sqrt_b1));
    resultFinalPostRnd_uid82_sqrt_q <= resultFinalPostRnd_uid82_sqrt_o(33 downto 0);

    -- resultFinalPreSat_uid83_sqrt_merged_bit_select(BITSELECT,353)@34
    resultFinalPreSat_uid83_sqrt_merged_bit_select_b <= resultFinalPostRnd_uid82_sqrt_q(32 downto 1);
    resultFinalPreSat_uid83_sqrt_merged_bit_select_c <= resultFinalPostRnd_uid82_sqrt_q(33 downto 33);

    -- resultFinalPostOvf_uid86_sqrt(LOGICAL,85)@34
    resultFinalPostOvf_uid86_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 1 => satOrOvfPostRnd_uid85_sqrt_q(0)) & satOrOvfPostRnd_uid85_sqrt_q));
    resultFinalPostOvf_uid86_sqrt_q <= resultFinalPreSat_uid83_sqrt_merged_bit_select_b or resultFinalPostOvf_uid86_sqrt_b;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- resultFinal_uid90_sqrt(LOGICAL,89)@34
    resultFinal_uid90_sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 1 => inputNotAllZeros_uid89_sqrt_q(0)) & inputNotAllZeros_uid89_sqrt_q));
    resultFinal_uid90_sqrt_q <= resultFinalPostOvf_uid86_sqrt_q and resultFinal_uid90_sqrt_b;

    -- out_rsrvd_fix(GPOUT,4)@34
    result <= resultFinal_uid90_sqrt_q;

END normal;
