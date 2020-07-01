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

-- VHDL created from FP_Div_altera_fp_functions_180_dj5ikpq
-- VHDL created on Thu Sep  6 18:37:53 2018


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

entity FP_Div_altera_fp_functions_180_dj5ikpq is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        b : in std_logic_vector(31 downto 0);  -- float32_m23
        q : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        areset : in std_logic
    );
end FP_Div_altera_fp_functions_180_dj5ikpq;

architecture normal of FP_Div_altera_fp_functions_180_dj5ikpq is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstBiasM1_uid6_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstBias_uid7_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expX_uid9_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracX_uid10_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signX_uid11_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal expY_uid12_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracY_uid13_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signY_uid14_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal paddingY_uid15_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal updatedY_uid16_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal cstAllOWE_uid18_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstAllZWE_uid20_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal excZ_x_uid23_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_x_uid23_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid24_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid24_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid25_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid25_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid26_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid27_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid27_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid28_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid28_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid29_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid30_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid31_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid37_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid37_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid38_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid38_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid39_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid39_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid40_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid41_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid41_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid42_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid42_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid43_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid44_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid45_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid45_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid46_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid46_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXmY_uid47_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expXmY_uid47_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expXmY_uid47_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expXmY_uid47_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expR_uid48_fpDivTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal expR_uid48_fpDivTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal expR_uid48_fpDivTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal expR_uid48_fpDivTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal yAddr_uid51_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal yPE_uid52_fpDivTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal invY_uid54_fpDivTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal invY_uid54_fpDivTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal invYO_uid55_fpDivTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal invYO_uid55_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal lOAdded_uid57_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal z4_uid60_fpDivTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal oFracXZ4_uid61_fpDivTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal divValPreNormYPow2Exc_uid63_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal divValPreNormYPow2Exc_uid63_fpDivTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal norm_uid64_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal divValPreNormHigh_uid65_fpDivTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal divValPreNormHigh_uid65_fpDivTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal divValPreNormLow_uid66_fpDivTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal divValPreNormLow_uid66_fpDivTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal normFracRnd_uid67_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal normFracRnd_uid67_fpDivTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal expFracRnd_uid68_fpDivTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal zeroPaddingInAddition_uid74_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expFracPostRnd_uid75_fpDivTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_a : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_o : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracPostRnd_uid76_fpDivTest_q : STD_LOGIC_VECTOR (35 downto 0);
    signal fracXExt_uid77_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal fracPostRndF_uid79_fpDivTest_in : STD_LOGIC_VECTOR (24 downto 0);
    signal fracPostRndF_uid79_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracPostRndF_uid80_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostRndF_uid80_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expPostRndFR_uid81_fpDivTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal expPostRndFR_uid81_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expPostRndF_uid82_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expPostRndF_uid82_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal lOAdded_uid84_fpDivTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal lOAdded_uid87_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdNorm_uid90_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal qDivProdFracHigh_uid91_fpDivTest_in : STD_LOGIC_VECTOR (47 downto 0);
    signal qDivProdFracHigh_uid91_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdFracLow_uid92_fpDivTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal qDivProdFracLow_uid92_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdFrac_uid93_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal qDivProdFrac_uid93_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opA_uid94_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_opBs_uid95_fpDivTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal qDivProdExp_uid96_fpDivTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal qDivProdExp_uid96_fpDivTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal qDivProdExp_uid96_fpDivTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal qDivProdExp_uid96_fpDivTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal qDivProdFracWF_uid97_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal qDivProdLTX_opA_uid98_fpDivTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal qDivProdLTX_opA_uid98_fpDivTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal qDivProdLTX_opA_uid99_fpDivTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal qDivProdLTX_opB_uid100_fpDivTest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_a : STD_LOGIC_VECTOR (32 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_o : STD_LOGIC_VECTOR (32 downto 0);
    signal qDividerProdLTX_uid101_fpDivTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal betweenFPwF_uid102_fpDivTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal betweenFPwF_uid102_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal extraUlp_uid103_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal extraUlp_uid103_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostRndFT_uid104_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_a : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_o : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExcExt_uid105_fpDivTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal fracPostRndFPostUlp_uid106_fpDivTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal fracPostRndFPostUlp_uid106_fpDivTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPreExc_uid107_fpDivTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPreExc_uid107_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal ovfIncRnd_uid109_fpDivTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal expRExt_uid114_fpDivTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal expUdf_uid115_fpDivTest_a : STD_LOGIC_VECTOR (12 downto 0);
    signal expUdf_uid115_fpDivTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal expUdf_uid115_fpDivTest_o : STD_LOGIC_VECTOR (12 downto 0);
    signal expUdf_uid115_fpDivTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal expOvf_uid118_fpDivTest_a : STD_LOGIC_VECTOR (12 downto 0);
    signal expOvf_uid118_fpDivTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal expOvf_uid118_fpDivTest_o : STD_LOGIC_VECTOR (12 downto 0);
    signal expOvf_uid118_fpDivTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal zeroOverReg_uid119_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal regOverRegWithUf_uid120_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xRegOrZero_uid121_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal xRegOrZero_uid121_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal regOrZeroOverInf_uid122_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid123_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid123_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRYZ_uid124_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRYROvf_uid125_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIYZ_uid126_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIYR_uid127_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid128_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid128_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZYZ_uid129_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIYI_uid130_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid131_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid131_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid132_fpDivTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid133_fpDivTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal oneFracRPostExc2_uid134_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPostExc_uid137_fpDivTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid137_fpDivTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPostExc_uid141_fpDivTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid141_fpDivTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal invExcRNaN_uid142_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sRPostExc_uid143_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal sRPostExc_uid143_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal divR_uid144_fpDivTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal yT1_uid158_invPolyEval_b : STD_LOGIC_VECTOR (12 downto 0);
    signal lowRangeB_uid160_invPolyEval_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid160_invPolyEval_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid161_invPolyEval_b : STD_LOGIC_VECTOR (12 downto 0);
    signal s1sumAHighB_uid162_invPolyEval_a : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid162_invPolyEval_b : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid162_invPolyEval_o : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid162_invPolyEval_q : STD_LOGIC_VECTOR (22 downto 0);
    signal s1_uid163_invPolyEval_q : STD_LOGIC_VECTOR (23 downto 0);
    signal lowRangeB_uid166_invPolyEval_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid166_invPolyEval_b : STD_LOGIC_VECTOR (1 downto 0);
    signal highBBits_uid167_invPolyEval_b : STD_LOGIC_VECTOR (22 downto 0);
    signal s2sumAHighB_uid168_invPolyEval_a : STD_LOGIC_VECTOR (32 downto 0);
    signal s2sumAHighB_uid168_invPolyEval_b : STD_LOGIC_VECTOR (32 downto 0);
    signal s2sumAHighB_uid168_invPolyEval_o : STD_LOGIC_VECTOR (32 downto 0);
    signal s2sumAHighB_uid168_invPolyEval_q : STD_LOGIC_VECTOR (32 downto 0);
    signal s2_uid169_invPolyEval_q : STD_LOGIC_VECTOR (34 downto 0);
    signal osig_uid172_divValPreNorm_uid59_fpDivTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal osig_uid175_pT1_uid159_invPolyEval_b : STD_LOGIC_VECTOR (13 downto 0);
    signal osig_uid178_pT2_uid165_invPolyEval_b : STD_LOGIC_VECTOR (24 downto 0);
    signal x0_uid180_fracYZero_uid15_fpDivTest_in : STD_LOGIC_VECTOR (11 downto 0);
    signal x0_uid180_fracYZero_uid15_fpDivTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal eq0_uid182_fracYZero_uid15_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq0_uid182_fracYZero_uid15_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal x1_uid183_fracYZero_uid15_fpDivTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal eq1_uid185_fracYZero_uid15_fpDivTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal eq1_uid185_fracYZero_uid15_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid185_fracYZero_uid15_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal andEq_uid186_fracYZero_uid15_fpDivTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal andEq_uid186_fracYZero_uid15_fpDivTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_i : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_a1 : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_b1 : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_q : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC0_uid146_invTables_lutmem_reset0 : std_logic;
    signal memoryC0_uid146_invTables_lutmem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal memoryC0_uid146_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC0_uid146_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC0_uid146_invTables_lutmem_ir : STD_LOGIC_VECTOR (31 downto 0);
    signal memoryC0_uid146_invTables_lutmem_r : STD_LOGIC_VECTOR (31 downto 0);
    signal memoryC0_uid146_invTables_lutmem_enaOr_rst : std_logic;
    signal memoryC1_uid149_invTables_lutmem_reset0 : std_logic;
    signal memoryC1_uid149_invTables_lutmem_ia : STD_LOGIC_VECTOR (21 downto 0);
    signal memoryC1_uid149_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC1_uid149_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC1_uid149_invTables_lutmem_ir : STD_LOGIC_VECTOR (21 downto 0);
    signal memoryC1_uid149_invTables_lutmem_r : STD_LOGIC_VECTOR (21 downto 0);
    signal memoryC1_uid149_invTables_lutmem_enaOr_rst : std_logic;
    signal memoryC2_uid152_invTables_lutmem_reset0 : std_logic;
    signal memoryC2_uid152_invTables_lutmem_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal memoryC2_uid152_invTables_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC2_uid152_invTables_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal memoryC2_uid152_invTables_lutmem_ir : STD_LOGIC_VECTOR (12 downto 0);
    signal memoryC2_uid152_invTables_lutmem_r : STD_LOGIC_VECTOR (12 downto 0);
    signal memoryC2_uid152_invTables_lutmem_enaOr_rst : std_logic;
    signal qDivProd_uid89_fpDivTest_cma_reset : std_logic;
    type qDivProd_uid89_fpDivTest_cma_ahtype is array(NATURAL range <>) of UNSIGNED(24 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_ah : qDivProd_uid89_fpDivTest_cma_ahtype(0 to 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of qDivProd_uid89_fpDivTest_cma_ah : signal is true;
    type qDivProd_uid89_fpDivTest_cma_chtype is array(NATURAL range <>) of UNSIGNED(23 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_ch : qDivProd_uid89_fpDivTest_cma_chtype(0 to 0);
    attribute preserve_syn_only of qDivProd_uid89_fpDivTest_cma_ch : signal is true;
    signal qDivProd_uid89_fpDivTest_cma_a0 : STD_LOGIC_VECTOR (24 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_c0 : STD_LOGIC_VECTOR (23 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_s0 : STD_LOGIC_VECTOR (48 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_qq : STD_LOGIC_VECTOR (48 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_q : STD_LOGIC_VECTOR (48 downto 0);
    signal qDivProd_uid89_fpDivTest_cma_ena0 : std_logic;
    signal qDivProd_uid89_fpDivTest_cma_ena1 : std_logic;
    signal qDivProd_uid89_fpDivTest_cma_ena2 : std_logic;
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_reset : std_logic;
    type prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ahtype is array(NATURAL range <>) of UNSIGNED(26 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ah : prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ah : signal is true;
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ch : qDivProd_uid89_fpDivTest_cma_chtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ch : signal is true;
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_a0 : STD_LOGIC_VECTOR (26 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_c0 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_s0 : STD_LOGIC_VECTOR (50 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_qq : STD_LOGIC_VECTOR (50 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_q : STD_LOGIC_VECTOR (50 downto 0);
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0 : std_logic;
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena1 : std_logic;
    signal prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena2 : std_logic;
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_reset : std_logic;
    type prodXY_uid174_pT1_uid159_invPolyEval_cma_ahtype is array(NATURAL range <>) of UNSIGNED(12 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_ah : prodXY_uid174_pT1_uid159_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid174_pT1_uid159_invPolyEval_cma_ah : signal is true;
    type prodXY_uid174_pT1_uid159_invPolyEval_cma_chtype is array(NATURAL range <>) of SIGNED(12 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_ch : prodXY_uid174_pT1_uid159_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid174_pT1_uid159_invPolyEval_cma_ch : signal is true;
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (12 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (12 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_qq : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_q : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid174_pT1_uid159_invPolyEval_cma_ena2 : std_logic;
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_reset : std_logic;
    type prodXY_uid177_pT2_uid165_invPolyEval_cma_ahtype is array(NATURAL range <>) of UNSIGNED(13 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_ah : prodXY_uid177_pT2_uid165_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid177_pT2_uid165_invPolyEval_cma_ah : signal is true;
    type prodXY_uid177_pT2_uid165_invPolyEval_cma_chtype is array(NATURAL range <>) of SIGNED(23 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_ch : prodXY_uid177_pT2_uid165_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid177_pT2_uid165_invPolyEval_cma_ch : signal is true;
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (37 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_qq : STD_LOGIC_VECTOR (37 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_q : STD_LOGIC_VECTOR (37 downto 0);
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid177_pT2_uid165_invPolyEval_cma_ena2 : std_logic;
    signal y0_uid181_fracYZero_uid15_fpDivTest_merged_bit_select_b : STD_LOGIC_VECTOR (11 downto 0);
    signal y0_uid181_fracYZero_uid15_fpDivTest_merged_bit_select_c : STD_LOGIC_VECTOR (11 downto 0);
    signal redist0_memoryC2_uid152_invTables_lutmem_r_1_q : STD_LOGIC_VECTOR (12 downto 0);
    signal redist1_memoryC0_uid146_invTables_lutmem_r_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist2_osig_uid178_pT2_uid165_invPolyEval_b_1_q : STD_LOGIC_VECTOR (24 downto 0);
    signal redist3_lowRangeB_uid160_invPolyEval_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_sRPostExc_uid143_fpDivTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_excREnc_uid133_fpDivTest_q_9_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist6_expOvf_uid118_fpDivTest_n_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_expUdf_uid115_fpDivTest_n_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_ovfIncRnd_uid109_fpDivTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_fracPostRndFPostUlp_uid106_fpDivTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist10_fracPostRndFT_uid104_fpDivTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist11_fracPostRndFT_uid104_fpDivTest_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist12_extraUlp_uid103_fpDivTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_qDivProdLTX_opA_uid98_fpDivTest_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist15_qDivProdFracWF_uid97_fpDivTest_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist19_norm_uid64_fpDivTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_invYO_uid55_fpDivTest_b_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist22_invY_uid54_fpDivTest_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist23_yPE_uid52_fpDivTest_b_3_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist26_yAddr_uid51_fpDivTest_b_14_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist27_signR_uid46_fpDivTest_q_29_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist28_excZ_y_uid37_fpDivTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist29_excR_x_uid31_fpDivTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_excZ_x_uid23_fpDivTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_fracY_uid13_fpDivTest_b_26_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist33_fracY_uid13_fpDivTest_b_27_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist35_expY_uid12_fpDivTest_b_26_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist39_expX_uid9_fpDivTest_b_26_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_inputreg0_q : STD_LOGIC_VECTOR (30 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_reset0 : std_logic;
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_ia : STD_LOGIC_VECTOR (30 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_iq : STD_LOGIC_VECTOR (30 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_q : STD_LOGIC_VECTOR (30 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_enaOr_rst : std_logic;
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_i : signal is true;
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_eq : signal is true;
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_sticky_ena_q : signal is true;
    signal redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_outputreg0_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_reset0 : std_logic;
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_ia : STD_LOGIC_VECTOR (8 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_iq : STD_LOGIC_VECTOR (8 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_enaOr_rst : std_logic;
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_i : signal is true;
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_eq : signal is true;
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_sticky_ena_q : signal is true;
    signal redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_outputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_reset0 : std_logic;
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_enaOr_rst : std_logic;
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_i : signal is true;
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_eq : signal is true;
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist17_expPostRndFR_uid81_fpDivTest_b_12_sticky_ena_q : signal is true;
    signal redist17_expPostRndFR_uid81_fpDivTest_b_12_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_inputreg0_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_reset0 : std_logic;
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_ia : STD_LOGIC_VECTOR (23 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_iq : STD_LOGIC_VECTOR (23 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_enaOr_rst : std_logic;
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_i : signal is true;
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_eq : signal is true;
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist18_fracPostRndF_uid80_fpDivTest_q_10_sticky_ena_q : signal is true;
    signal redist18_fracPostRndF_uid80_fpDivTest_q_10_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_inputreg0_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_mem_reset0 : std_logic;
    signal redist20_lOAdded_uid57_fpDivTest_q_6_mem_ia : STD_LOGIC_VECTOR (23 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_mem_iq : STD_LOGIC_VECTOR (23 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_mem_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_mem_enaOr_rst : std_logic;
    signal redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_i : signal is true;
    signal redist20_lOAdded_uid57_fpDivTest_q_6_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_lOAdded_uid57_fpDivTest_q_6_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist20_lOAdded_uid57_fpDivTest_q_6_sticky_ena_q : signal is true;
    signal redist20_lOAdded_uid57_fpDivTest_q_6_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_outputreg0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_mem_reset0 : std_logic;
    signal redist24_yPE_uid52_fpDivTest_b_10_mem_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_mem_iq : STD_LOGIC_VECTOR (13 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_mem_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_mem_enaOr_rst : std_logic;
    signal redist24_yPE_uid52_fpDivTest_b_10_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist24_yPE_uid52_fpDivTest_b_10_rdcnt_i : signal is true;
    signal redist24_yPE_uid52_fpDivTest_b_10_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist24_yPE_uid52_fpDivTest_b_10_rdcnt_eq : signal is true;
    signal redist24_yPE_uid52_fpDivTest_b_10_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_yPE_uid52_fpDivTest_b_10_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist24_yPE_uid52_fpDivTest_b_10_sticky_ena_q : signal is true;
    signal redist24_yPE_uid52_fpDivTest_b_10_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_outputreg0_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_mem_reset0 : std_logic;
    signal redist25_yAddr_uid51_fpDivTest_b_7_mem_ia : STD_LOGIC_VECTOR (8 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_mem_iq : STD_LOGIC_VECTOR (8 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_mem_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_mem_enaOr_rst : std_logic;
    signal redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_i : signal is true;
    signal redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_eq : signal is true;
    signal redist25_yAddr_uid51_fpDivTest_b_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_yAddr_uid51_fpDivTest_b_7_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist25_yAddr_uid51_fpDivTest_b_7_sticky_ena_q : signal is true;
    signal redist25_yAddr_uid51_fpDivTest_b_7_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist26_yAddr_uid51_fpDivTest_b_14_inputreg0_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist26_yAddr_uid51_fpDivTest_b_14_outputreg0_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_mem_reset0 : std_logic;
    signal redist31_fracY_uid13_fpDivTest_b_22_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_mem_enaOr_rst : std_logic;
    signal redist31_fracY_uid13_fpDivTest_b_22_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist31_fracY_uid13_fpDivTest_b_22_rdcnt_i : signal is true;
    signal redist31_fracY_uid13_fpDivTest_b_22_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist31_fracY_uid13_fpDivTest_b_22_rdcnt_eq : signal is true;
    signal redist31_fracY_uid13_fpDivTest_b_22_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fracY_uid13_fpDivTest_b_22_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist31_fracY_uid13_fpDivTest_b_22_sticky_ena_q : signal is true;
    signal redist31_fracY_uid13_fpDivTest_b_22_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_mem_reset0 : std_logic;
    signal redist34_expY_uid12_fpDivTest_b_23_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_mem_enaOr_rst : std_logic;
    signal redist34_expY_uid12_fpDivTest_b_23_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist34_expY_uid12_fpDivTest_b_23_rdcnt_i : signal is true;
    signal redist34_expY_uid12_fpDivTest_b_23_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist34_expY_uid12_fpDivTest_b_23_rdcnt_eq : signal is true;
    signal redist34_expY_uid12_fpDivTest_b_23_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_expY_uid12_fpDivTest_b_23_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist34_expY_uid12_fpDivTest_b_23_sticky_ena_q : signal is true;
    signal redist34_expY_uid12_fpDivTest_b_23_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_outputreg0_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_mem_reset0 : std_logic;
    signal redist36_fracX_uid10_fpDivTest_b_18_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_mem_enaOr_rst : std_logic;
    signal redist36_fracX_uid10_fpDivTest_b_18_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist36_fracX_uid10_fpDivTest_b_18_rdcnt_i : signal is true;
    signal redist36_fracX_uid10_fpDivTest_b_18_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fracX_uid10_fpDivTest_b_18_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist36_fracX_uid10_fpDivTest_b_18_sticky_ena_q : signal is true;
    signal redist36_fracX_uid10_fpDivTest_b_18_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_inputreg0_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_outputreg0_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_mem_reset0 : std_logic;
    signal redist37_fracX_uid10_fpDivTest_b_26_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_mem_enaOr_rst : std_logic;
    signal redist37_fracX_uid10_fpDivTest_b_26_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist37_fracX_uid10_fpDivTest_b_26_rdcnt_i : signal is true;
    signal redist37_fracX_uid10_fpDivTest_b_26_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist37_fracX_uid10_fpDivTest_b_26_rdcnt_eq : signal is true;
    signal redist37_fracX_uid10_fpDivTest_b_26_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fracX_uid10_fpDivTest_b_26_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist37_fracX_uid10_fpDivTest_b_26_sticky_ena_q : signal is true;
    signal redist37_fracX_uid10_fpDivTest_b_26_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_outputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_mem_reset0 : std_logic;
    signal redist38_expX_uid9_fpDivTest_b_23_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_mem_enaOr_rst : std_logic;
    signal redist38_expX_uid9_fpDivTest_b_23_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist38_expX_uid9_fpDivTest_b_23_rdcnt_i : signal is true;
    signal redist38_expX_uid9_fpDivTest_b_23_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist38_expX_uid9_fpDivTest_b_23_rdcnt_eq : signal is true;
    signal redist38_expX_uid9_fpDivTest_b_23_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_expX_uid9_fpDivTest_b_23_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist38_expX_uid9_fpDivTest_b_23_sticky_ena_q : signal is true;
    signal redist38_expX_uid9_fpDivTest_b_23_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist31_fracY_uid13_fpDivTest_b_22_notEnable(LOGICAL,320)
    redist31_fracY_uid13_fpDivTest_b_22_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist31_fracY_uid13_fpDivTest_b_22_nor(LOGICAL,321)
    redist31_fracY_uid13_fpDivTest_b_22_nor_q <= not (redist31_fracY_uid13_fpDivTest_b_22_notEnable_q or redist31_fracY_uid13_fpDivTest_b_22_sticky_ena_q);

    -- redist31_fracY_uid13_fpDivTest_b_22_mem_last(CONSTANT,317)
    redist31_fracY_uid13_fpDivTest_b_22_mem_last_q <= "010011";

    -- redist31_fracY_uid13_fpDivTest_b_22_cmp(LOGICAL,318)
    redist31_fracY_uid13_fpDivTest_b_22_cmp_b <= STD_LOGIC_VECTOR("0" & redist31_fracY_uid13_fpDivTest_b_22_rdcnt_q);
    redist31_fracY_uid13_fpDivTest_b_22_cmp_q <= "1" WHEN redist31_fracY_uid13_fpDivTest_b_22_mem_last_q = redist31_fracY_uid13_fpDivTest_b_22_cmp_b ELSE "0";

    -- redist31_fracY_uid13_fpDivTest_b_22_cmpReg(REG,319)
    redist31_fracY_uid13_fpDivTest_b_22_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist31_fracY_uid13_fpDivTest_b_22_cmpReg_q <= "0";
            ELSE
                redist31_fracY_uid13_fpDivTest_b_22_cmpReg_q <= STD_LOGIC_VECTOR(redist31_fracY_uid13_fpDivTest_b_22_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist31_fracY_uid13_fpDivTest_b_22_sticky_ena(REG,322)
    redist31_fracY_uid13_fpDivTest_b_22_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist31_fracY_uid13_fpDivTest_b_22_sticky_ena_q <= "0";
            ELSE
                IF (redist31_fracY_uid13_fpDivTest_b_22_nor_q = "1") THEN
                    redist31_fracY_uid13_fpDivTest_b_22_sticky_ena_q <= STD_LOGIC_VECTOR(redist31_fracY_uid13_fpDivTest_b_22_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist31_fracY_uid13_fpDivTest_b_22_enaAnd(LOGICAL,323)
    redist31_fracY_uid13_fpDivTest_b_22_enaAnd_q <= redist31_fracY_uid13_fpDivTest_b_22_sticky_ena_q and VCC_q;

    -- redist31_fracY_uid13_fpDivTest_b_22_rdcnt(COUNTER,315)
    -- low=0, high=20, step=1, init=0
    redist31_fracY_uid13_fpDivTest_b_22_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist31_fracY_uid13_fpDivTest_b_22_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist31_fracY_uid13_fpDivTest_b_22_rdcnt_eq <= '0';
            ELSE
                IF (redist31_fracY_uid13_fpDivTest_b_22_rdcnt_i = TO_UNSIGNED(19, 5)) THEN
                    redist31_fracY_uid13_fpDivTest_b_22_rdcnt_eq <= '1';
                ELSE
                    redist31_fracY_uid13_fpDivTest_b_22_rdcnt_eq <= '0';
                END IF;
                IF (redist31_fracY_uid13_fpDivTest_b_22_rdcnt_eq = '1') THEN
                    redist31_fracY_uid13_fpDivTest_b_22_rdcnt_i <= redist31_fracY_uid13_fpDivTest_b_22_rdcnt_i + 12;
                ELSE
                    redist31_fracY_uid13_fpDivTest_b_22_rdcnt_i <= redist31_fracY_uid13_fpDivTest_b_22_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist31_fracY_uid13_fpDivTest_b_22_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist31_fracY_uid13_fpDivTest_b_22_rdcnt_i, 5)));

    -- fracY_uid13_fpDivTest(BITSELECT,12)@0
    fracY_uid13_fpDivTest_b <= b(22 downto 0);

    -- redist31_fracY_uid13_fpDivTest_b_22_wraddr(REG,316)
    redist31_fracY_uid13_fpDivTest_b_22_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist31_fracY_uid13_fpDivTest_b_22_wraddr_q <= "10100";
            ELSE
                redist31_fracY_uid13_fpDivTest_b_22_wraddr_q <= STD_LOGIC_VECTOR(redist31_fracY_uid13_fpDivTest_b_22_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist31_fracY_uid13_fpDivTest_b_22_mem(DUALMEM,314)
    redist31_fracY_uid13_fpDivTest_b_22_mem_ia <= STD_LOGIC_VECTOR(fracY_uid13_fpDivTest_b);
    redist31_fracY_uid13_fpDivTest_b_22_mem_aa <= redist31_fracY_uid13_fpDivTest_b_22_wraddr_q;
    redist31_fracY_uid13_fpDivTest_b_22_mem_ab <= redist31_fracY_uid13_fpDivTest_b_22_rdcnt_q;
    redist31_fracY_uid13_fpDivTest_b_22_mem_reset0 <= areset;
    redist31_fracY_uid13_fpDivTest_b_22_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 5,
        numwords_a => 21,
        width_b => 23,
        widthad_b => 5,
        numwords_b => 21,
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
        clocken1 => redist31_fracY_uid13_fpDivTest_b_22_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist31_fracY_uid13_fpDivTest_b_22_mem_reset0,
        clock1 => clk,
        address_a => redist31_fracY_uid13_fpDivTest_b_22_mem_aa,
        data_a => redist31_fracY_uid13_fpDivTest_b_22_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist31_fracY_uid13_fpDivTest_b_22_mem_ab,
        q_b => redist31_fracY_uid13_fpDivTest_b_22_mem_iq
    );
    redist31_fracY_uid13_fpDivTest_b_22_mem_q <= redist31_fracY_uid13_fpDivTest_b_22_mem_iq(22 downto 0);
    redist31_fracY_uid13_fpDivTest_b_22_mem_enaOr_rst <= redist31_fracY_uid13_fpDivTest_b_22_enaAnd_q(0) or redist31_fracY_uid13_fpDivTest_b_22_mem_reset0;

    -- redist32_fracY_uid13_fpDivTest_b_26(DELAY,227)
    redist32_fracY_uid13_fpDivTest_b_26 : dspba_delay
    GENERIC MAP ( width => 23, depth => 4, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist31_fracY_uid13_fpDivTest_b_22_mem_q, xout => redist32_fracY_uid13_fpDivTest_b_26_q, clk => clk, aclr => areset, ena => '1' );

    -- paddingY_uid15_fpDivTest(CONSTANT,14)
    paddingY_uid15_fpDivTest_q <= "00000000000000000000000";

    -- fracXIsZero_uid39_fpDivTest(LOGICAL,38)@26 + 1
    fracXIsZero_uid39_fpDivTest_qi <= "1" WHEN paddingY_uid15_fpDivTest_q = redist32_fracY_uid13_fpDivTest_b_26_q ELSE "0";
    fracXIsZero_uid39_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracXIsZero_uid39_fpDivTest_qi, xout => fracXIsZero_uid39_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- cstAllOWE_uid18_fpDivTest(CONSTANT,17)
    cstAllOWE_uid18_fpDivTest_q <= "11111111";

    -- redist34_expY_uid12_fpDivTest_b_23_notEnable(LOGICAL,330)
    redist34_expY_uid12_fpDivTest_b_23_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist34_expY_uid12_fpDivTest_b_23_nor(LOGICAL,331)
    redist34_expY_uid12_fpDivTest_b_23_nor_q <= not (redist34_expY_uid12_fpDivTest_b_23_notEnable_q or redist34_expY_uid12_fpDivTest_b_23_sticky_ena_q);

    -- redist34_expY_uid12_fpDivTest_b_23_mem_last(CONSTANT,327)
    redist34_expY_uid12_fpDivTest_b_23_mem_last_q <= "010100";

    -- redist34_expY_uid12_fpDivTest_b_23_cmp(LOGICAL,328)
    redist34_expY_uid12_fpDivTest_b_23_cmp_b <= STD_LOGIC_VECTOR("0" & redist34_expY_uid12_fpDivTest_b_23_rdcnt_q);
    redist34_expY_uid12_fpDivTest_b_23_cmp_q <= "1" WHEN redist34_expY_uid12_fpDivTest_b_23_mem_last_q = redist34_expY_uid12_fpDivTest_b_23_cmp_b ELSE "0";

    -- redist34_expY_uid12_fpDivTest_b_23_cmpReg(REG,329)
    redist34_expY_uid12_fpDivTest_b_23_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist34_expY_uid12_fpDivTest_b_23_cmpReg_q <= "0";
            ELSE
                redist34_expY_uid12_fpDivTest_b_23_cmpReg_q <= STD_LOGIC_VECTOR(redist34_expY_uid12_fpDivTest_b_23_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist34_expY_uid12_fpDivTest_b_23_sticky_ena(REG,332)
    redist34_expY_uid12_fpDivTest_b_23_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist34_expY_uid12_fpDivTest_b_23_sticky_ena_q <= "0";
            ELSE
                IF (redist34_expY_uid12_fpDivTest_b_23_nor_q = "1") THEN
                    redist34_expY_uid12_fpDivTest_b_23_sticky_ena_q <= STD_LOGIC_VECTOR(redist34_expY_uid12_fpDivTest_b_23_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist34_expY_uid12_fpDivTest_b_23_enaAnd(LOGICAL,333)
    redist34_expY_uid12_fpDivTest_b_23_enaAnd_q <= redist34_expY_uid12_fpDivTest_b_23_sticky_ena_q and VCC_q;

    -- redist34_expY_uid12_fpDivTest_b_23_rdcnt(COUNTER,325)
    -- low=0, high=21, step=1, init=0
    redist34_expY_uid12_fpDivTest_b_23_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist34_expY_uid12_fpDivTest_b_23_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist34_expY_uid12_fpDivTest_b_23_rdcnt_eq <= '0';
            ELSE
                IF (redist34_expY_uid12_fpDivTest_b_23_rdcnt_i = TO_UNSIGNED(20, 5)) THEN
                    redist34_expY_uid12_fpDivTest_b_23_rdcnt_eq <= '1';
                ELSE
                    redist34_expY_uid12_fpDivTest_b_23_rdcnt_eq <= '0';
                END IF;
                IF (redist34_expY_uid12_fpDivTest_b_23_rdcnt_eq = '1') THEN
                    redist34_expY_uid12_fpDivTest_b_23_rdcnt_i <= redist34_expY_uid12_fpDivTest_b_23_rdcnt_i + 11;
                ELSE
                    redist34_expY_uid12_fpDivTest_b_23_rdcnt_i <= redist34_expY_uid12_fpDivTest_b_23_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist34_expY_uid12_fpDivTest_b_23_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist34_expY_uid12_fpDivTest_b_23_rdcnt_i, 5)));

    -- expY_uid12_fpDivTest(BITSELECT,11)@0
    expY_uid12_fpDivTest_b <= b(30 downto 23);

    -- redist34_expY_uid12_fpDivTest_b_23_wraddr(REG,326)
    redist34_expY_uid12_fpDivTest_b_23_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist34_expY_uid12_fpDivTest_b_23_wraddr_q <= "10101";
            ELSE
                redist34_expY_uid12_fpDivTest_b_23_wraddr_q <= STD_LOGIC_VECTOR(redist34_expY_uid12_fpDivTest_b_23_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist34_expY_uid12_fpDivTest_b_23_mem(DUALMEM,324)
    redist34_expY_uid12_fpDivTest_b_23_mem_ia <= STD_LOGIC_VECTOR(expY_uid12_fpDivTest_b);
    redist34_expY_uid12_fpDivTest_b_23_mem_aa <= redist34_expY_uid12_fpDivTest_b_23_wraddr_q;
    redist34_expY_uid12_fpDivTest_b_23_mem_ab <= redist34_expY_uid12_fpDivTest_b_23_rdcnt_q;
    redist34_expY_uid12_fpDivTest_b_23_mem_reset0 <= areset;
    redist34_expY_uid12_fpDivTest_b_23_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 22,
        width_b => 8,
        widthad_b => 5,
        numwords_b => 22,
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
        clocken1 => redist34_expY_uid12_fpDivTest_b_23_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist34_expY_uid12_fpDivTest_b_23_mem_reset0,
        clock1 => clk,
        address_a => redist34_expY_uid12_fpDivTest_b_23_mem_aa,
        data_a => redist34_expY_uid12_fpDivTest_b_23_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist34_expY_uid12_fpDivTest_b_23_mem_ab,
        q_b => redist34_expY_uid12_fpDivTest_b_23_mem_iq
    );
    redist34_expY_uid12_fpDivTest_b_23_mem_q <= redist34_expY_uid12_fpDivTest_b_23_mem_iq(7 downto 0);
    redist34_expY_uid12_fpDivTest_b_23_mem_enaOr_rst <= redist34_expY_uid12_fpDivTest_b_23_enaAnd_q(0) or redist34_expY_uid12_fpDivTest_b_23_mem_reset0;

    -- redist35_expY_uid12_fpDivTest_b_26(DELAY,230)
    redist35_expY_uid12_fpDivTest_b_26 : dspba_delay
    GENERIC MAP ( width => 8, depth => 3, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist34_expY_uid12_fpDivTest_b_23_mem_q, xout => redist35_expY_uid12_fpDivTest_b_26_q, clk => clk, aclr => areset, ena => '1' );

    -- expXIsMax_uid38_fpDivTest(LOGICAL,37)@26 + 1
    expXIsMax_uid38_fpDivTest_qi <= "1" WHEN redist35_expY_uid12_fpDivTest_b_26_q = cstAllOWE_uid18_fpDivTest_q ELSE "0";
    expXIsMax_uid38_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => expXIsMax_uid38_fpDivTest_qi, xout => expXIsMax_uid38_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- excI_y_uid41_fpDivTest(LOGICAL,40)@27 + 1
    excI_y_uid41_fpDivTest_qi <= expXIsMax_uid38_fpDivTest_q and fracXIsZero_uid39_fpDivTest_q;
    excI_y_uid41_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excI_y_uid41_fpDivTest_qi, xout => excI_y_uid41_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist37_fracX_uid10_fpDivTest_b_26_notEnable(LOGICAL,353)
    redist37_fracX_uid10_fpDivTest_b_26_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist37_fracX_uid10_fpDivTest_b_26_nor(LOGICAL,354)
    redist37_fracX_uid10_fpDivTest_b_26_nor_q <= not (redist37_fracX_uid10_fpDivTest_b_26_notEnable_q or redist37_fracX_uid10_fpDivTest_b_26_sticky_ena_q);

    -- redist37_fracX_uid10_fpDivTest_b_26_mem_last(CONSTANT,350)
    redist37_fracX_uid10_fpDivTest_b_26_mem_last_q <= "011";

    -- redist37_fracX_uid10_fpDivTest_b_26_cmp(LOGICAL,351)
    redist37_fracX_uid10_fpDivTest_b_26_cmp_q <= "1" WHEN redist37_fracX_uid10_fpDivTest_b_26_mem_last_q = redist37_fracX_uid10_fpDivTest_b_26_rdcnt_q ELSE "0";

    -- redist37_fracX_uid10_fpDivTest_b_26_cmpReg(REG,352)
    redist37_fracX_uid10_fpDivTest_b_26_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist37_fracX_uid10_fpDivTest_b_26_cmpReg_q <= "0";
            ELSE
                redist37_fracX_uid10_fpDivTest_b_26_cmpReg_q <= STD_LOGIC_VECTOR(redist37_fracX_uid10_fpDivTest_b_26_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist37_fracX_uid10_fpDivTest_b_26_sticky_ena(REG,355)
    redist37_fracX_uid10_fpDivTest_b_26_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist37_fracX_uid10_fpDivTest_b_26_sticky_ena_q <= "0";
            ELSE
                IF (redist37_fracX_uid10_fpDivTest_b_26_nor_q = "1") THEN
                    redist37_fracX_uid10_fpDivTest_b_26_sticky_ena_q <= STD_LOGIC_VECTOR(redist37_fracX_uid10_fpDivTest_b_26_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist37_fracX_uid10_fpDivTest_b_26_enaAnd(LOGICAL,356)
    redist37_fracX_uid10_fpDivTest_b_26_enaAnd_q <= redist37_fracX_uid10_fpDivTest_b_26_sticky_ena_q and VCC_q;

    -- redist37_fracX_uid10_fpDivTest_b_26_rdcnt(COUNTER,348)
    -- low=0, high=4, step=1, init=0
    redist37_fracX_uid10_fpDivTest_b_26_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist37_fracX_uid10_fpDivTest_b_26_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist37_fracX_uid10_fpDivTest_b_26_rdcnt_eq <= '0';
            ELSE
                IF (redist37_fracX_uid10_fpDivTest_b_26_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                    redist37_fracX_uid10_fpDivTest_b_26_rdcnt_eq <= '1';
                ELSE
                    redist37_fracX_uid10_fpDivTest_b_26_rdcnt_eq <= '0';
                END IF;
                IF (redist37_fracX_uid10_fpDivTest_b_26_rdcnt_eq = '1') THEN
                    redist37_fracX_uid10_fpDivTest_b_26_rdcnt_i <= redist37_fracX_uid10_fpDivTest_b_26_rdcnt_i + 4;
                ELSE
                    redist37_fracX_uid10_fpDivTest_b_26_rdcnt_i <= redist37_fracX_uid10_fpDivTest_b_26_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist37_fracX_uid10_fpDivTest_b_26_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist37_fracX_uid10_fpDivTest_b_26_rdcnt_i, 3)));

    -- redist36_fracX_uid10_fpDivTest_b_18_notEnable(LOGICAL,341)
    redist36_fracX_uid10_fpDivTest_b_18_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist36_fracX_uid10_fpDivTest_b_18_nor(LOGICAL,342)
    redist36_fracX_uid10_fpDivTest_b_18_nor_q <= not (redist36_fracX_uid10_fpDivTest_b_18_notEnable_q or redist36_fracX_uid10_fpDivTest_b_18_sticky_ena_q);

    -- redist36_fracX_uid10_fpDivTest_b_18_mem_last(CONSTANT,338)
    redist36_fracX_uid10_fpDivTest_b_18_mem_last_q <= "01110";

    -- redist36_fracX_uid10_fpDivTest_b_18_cmp(LOGICAL,339)
    redist36_fracX_uid10_fpDivTest_b_18_cmp_b <= STD_LOGIC_VECTOR("0" & redist36_fracX_uid10_fpDivTest_b_18_rdcnt_q);
    redist36_fracX_uid10_fpDivTest_b_18_cmp_q <= "1" WHEN redist36_fracX_uid10_fpDivTest_b_18_mem_last_q = redist36_fracX_uid10_fpDivTest_b_18_cmp_b ELSE "0";

    -- redist36_fracX_uid10_fpDivTest_b_18_cmpReg(REG,340)
    redist36_fracX_uid10_fpDivTest_b_18_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist36_fracX_uid10_fpDivTest_b_18_cmpReg_q <= "0";
            ELSE
                redist36_fracX_uid10_fpDivTest_b_18_cmpReg_q <= STD_LOGIC_VECTOR(redist36_fracX_uid10_fpDivTest_b_18_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist36_fracX_uid10_fpDivTest_b_18_sticky_ena(REG,343)
    redist36_fracX_uid10_fpDivTest_b_18_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist36_fracX_uid10_fpDivTest_b_18_sticky_ena_q <= "0";
            ELSE
                IF (redist36_fracX_uid10_fpDivTest_b_18_nor_q = "1") THEN
                    redist36_fracX_uid10_fpDivTest_b_18_sticky_ena_q <= STD_LOGIC_VECTOR(redist36_fracX_uid10_fpDivTest_b_18_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist36_fracX_uid10_fpDivTest_b_18_enaAnd(LOGICAL,344)
    redist36_fracX_uid10_fpDivTest_b_18_enaAnd_q <= redist36_fracX_uid10_fpDivTest_b_18_sticky_ena_q and VCC_q;

    -- redist36_fracX_uid10_fpDivTest_b_18_rdcnt(COUNTER,336)
    -- low=0, high=15, step=1, init=0
    redist36_fracX_uid10_fpDivTest_b_18_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist36_fracX_uid10_fpDivTest_b_18_rdcnt_i <= TO_UNSIGNED(0, 4);
            ELSE
                redist36_fracX_uid10_fpDivTest_b_18_rdcnt_i <= redist36_fracX_uid10_fpDivTest_b_18_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist36_fracX_uid10_fpDivTest_b_18_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist36_fracX_uid10_fpDivTest_b_18_rdcnt_i, 4)));

    -- fracX_uid10_fpDivTest(BITSELECT,9)@0
    fracX_uid10_fpDivTest_b <= a(22 downto 0);

    -- redist36_fracX_uid10_fpDivTest_b_18_wraddr(REG,337)
    redist36_fracX_uid10_fpDivTest_b_18_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist36_fracX_uid10_fpDivTest_b_18_wraddr_q <= "1111";
            ELSE
                redist36_fracX_uid10_fpDivTest_b_18_wraddr_q <= STD_LOGIC_VECTOR(redist36_fracX_uid10_fpDivTest_b_18_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist36_fracX_uid10_fpDivTest_b_18_mem(DUALMEM,335)
    redist36_fracX_uid10_fpDivTest_b_18_mem_ia <= STD_LOGIC_VECTOR(fracX_uid10_fpDivTest_b);
    redist36_fracX_uid10_fpDivTest_b_18_mem_aa <= redist36_fracX_uid10_fpDivTest_b_18_wraddr_q;
    redist36_fracX_uid10_fpDivTest_b_18_mem_ab <= redist36_fracX_uid10_fpDivTest_b_18_rdcnt_q;
    redist36_fracX_uid10_fpDivTest_b_18_mem_reset0 <= areset;
    redist36_fracX_uid10_fpDivTest_b_18_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 23,
        widthad_b => 4,
        numwords_b => 16,
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
        clocken1 => redist36_fracX_uid10_fpDivTest_b_18_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist36_fracX_uid10_fpDivTest_b_18_mem_reset0,
        clock1 => clk,
        address_a => redist36_fracX_uid10_fpDivTest_b_18_mem_aa,
        data_a => redist36_fracX_uid10_fpDivTest_b_18_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist36_fracX_uid10_fpDivTest_b_18_mem_ab,
        q_b => redist36_fracX_uid10_fpDivTest_b_18_mem_iq
    );
    redist36_fracX_uid10_fpDivTest_b_18_mem_q <= redist36_fracX_uid10_fpDivTest_b_18_mem_iq(22 downto 0);
    redist36_fracX_uid10_fpDivTest_b_18_mem_enaOr_rst <= redist36_fracX_uid10_fpDivTest_b_18_enaAnd_q(0) or redist36_fracX_uid10_fpDivTest_b_18_mem_reset0;

    -- redist36_fracX_uid10_fpDivTest_b_18_outputreg0(DELAY,334)
    redist36_fracX_uid10_fpDivTest_b_18_outputreg0 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist36_fracX_uid10_fpDivTest_b_18_mem_q, xout => redist36_fracX_uid10_fpDivTest_b_18_outputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- redist37_fracX_uid10_fpDivTest_b_26_inputreg0(DELAY,345)
    redist37_fracX_uid10_fpDivTest_b_26_inputreg0 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist36_fracX_uid10_fpDivTest_b_18_outputreg0_q, xout => redist37_fracX_uid10_fpDivTest_b_26_inputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- redist37_fracX_uid10_fpDivTest_b_26_wraddr(REG,349)
    redist37_fracX_uid10_fpDivTest_b_26_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist37_fracX_uid10_fpDivTest_b_26_wraddr_q <= "100";
            ELSE
                redist37_fracX_uid10_fpDivTest_b_26_wraddr_q <= STD_LOGIC_VECTOR(redist37_fracX_uid10_fpDivTest_b_26_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist37_fracX_uid10_fpDivTest_b_26_mem(DUALMEM,347)
    redist37_fracX_uid10_fpDivTest_b_26_mem_ia <= STD_LOGIC_VECTOR(redist37_fracX_uid10_fpDivTest_b_26_inputreg0_q);
    redist37_fracX_uid10_fpDivTest_b_26_mem_aa <= redist37_fracX_uid10_fpDivTest_b_26_wraddr_q;
    redist37_fracX_uid10_fpDivTest_b_26_mem_ab <= redist37_fracX_uid10_fpDivTest_b_26_rdcnt_q;
    redist37_fracX_uid10_fpDivTest_b_26_mem_reset0 <= areset;
    redist37_fracX_uid10_fpDivTest_b_26_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 23,
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
        clocken1 => redist37_fracX_uid10_fpDivTest_b_26_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist37_fracX_uid10_fpDivTest_b_26_mem_reset0,
        clock1 => clk,
        address_a => redist37_fracX_uid10_fpDivTest_b_26_mem_aa,
        data_a => redist37_fracX_uid10_fpDivTest_b_26_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist37_fracX_uid10_fpDivTest_b_26_mem_ab,
        q_b => redist37_fracX_uid10_fpDivTest_b_26_mem_iq
    );
    redist37_fracX_uid10_fpDivTest_b_26_mem_q <= redist37_fracX_uid10_fpDivTest_b_26_mem_iq(22 downto 0);
    redist37_fracX_uid10_fpDivTest_b_26_mem_enaOr_rst <= redist37_fracX_uid10_fpDivTest_b_26_enaAnd_q(0) or redist37_fracX_uid10_fpDivTest_b_26_mem_reset0;

    -- redist37_fracX_uid10_fpDivTest_b_26_outputreg0(DELAY,346)
    redist37_fracX_uid10_fpDivTest_b_26_outputreg0 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist37_fracX_uid10_fpDivTest_b_26_mem_q, xout => redist37_fracX_uid10_fpDivTest_b_26_outputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- fracXIsZero_uid25_fpDivTest(LOGICAL,24)@26 + 1
    fracXIsZero_uid25_fpDivTest_qi <= "1" WHEN paddingY_uid15_fpDivTest_q = redist37_fracX_uid10_fpDivTest_b_26_outputreg0_q ELSE "0";
    fracXIsZero_uid25_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracXIsZero_uid25_fpDivTest_qi, xout => fracXIsZero_uid25_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist38_expX_uid9_fpDivTest_b_23_notEnable(LOGICAL,364)
    redist38_expX_uid9_fpDivTest_b_23_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist38_expX_uid9_fpDivTest_b_23_nor(LOGICAL,365)
    redist38_expX_uid9_fpDivTest_b_23_nor_q <= not (redist38_expX_uid9_fpDivTest_b_23_notEnable_q or redist38_expX_uid9_fpDivTest_b_23_sticky_ena_q);

    -- redist38_expX_uid9_fpDivTest_b_23_mem_last(CONSTANT,361)
    redist38_expX_uid9_fpDivTest_b_23_mem_last_q <= "010011";

    -- redist38_expX_uid9_fpDivTest_b_23_cmp(LOGICAL,362)
    redist38_expX_uid9_fpDivTest_b_23_cmp_b <= STD_LOGIC_VECTOR("0" & redist38_expX_uid9_fpDivTest_b_23_rdcnt_q);
    redist38_expX_uid9_fpDivTest_b_23_cmp_q <= "1" WHEN redist38_expX_uid9_fpDivTest_b_23_mem_last_q = redist38_expX_uid9_fpDivTest_b_23_cmp_b ELSE "0";

    -- redist38_expX_uid9_fpDivTest_b_23_cmpReg(REG,363)
    redist38_expX_uid9_fpDivTest_b_23_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist38_expX_uid9_fpDivTest_b_23_cmpReg_q <= "0";
            ELSE
                redist38_expX_uid9_fpDivTest_b_23_cmpReg_q <= STD_LOGIC_VECTOR(redist38_expX_uid9_fpDivTest_b_23_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist38_expX_uid9_fpDivTest_b_23_sticky_ena(REG,366)
    redist38_expX_uid9_fpDivTest_b_23_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist38_expX_uid9_fpDivTest_b_23_sticky_ena_q <= "0";
            ELSE
                IF (redist38_expX_uid9_fpDivTest_b_23_nor_q = "1") THEN
                    redist38_expX_uid9_fpDivTest_b_23_sticky_ena_q <= STD_LOGIC_VECTOR(redist38_expX_uid9_fpDivTest_b_23_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist38_expX_uid9_fpDivTest_b_23_enaAnd(LOGICAL,367)
    redist38_expX_uid9_fpDivTest_b_23_enaAnd_q <= redist38_expX_uid9_fpDivTest_b_23_sticky_ena_q and VCC_q;

    -- redist38_expX_uid9_fpDivTest_b_23_rdcnt(COUNTER,359)
    -- low=0, high=20, step=1, init=0
    redist38_expX_uid9_fpDivTest_b_23_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist38_expX_uid9_fpDivTest_b_23_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist38_expX_uid9_fpDivTest_b_23_rdcnt_eq <= '0';
            ELSE
                IF (redist38_expX_uid9_fpDivTest_b_23_rdcnt_i = TO_UNSIGNED(19, 5)) THEN
                    redist38_expX_uid9_fpDivTest_b_23_rdcnt_eq <= '1';
                ELSE
                    redist38_expX_uid9_fpDivTest_b_23_rdcnt_eq <= '0';
                END IF;
                IF (redist38_expX_uid9_fpDivTest_b_23_rdcnt_eq = '1') THEN
                    redist38_expX_uid9_fpDivTest_b_23_rdcnt_i <= redist38_expX_uid9_fpDivTest_b_23_rdcnt_i + 12;
                ELSE
                    redist38_expX_uid9_fpDivTest_b_23_rdcnt_i <= redist38_expX_uid9_fpDivTest_b_23_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist38_expX_uid9_fpDivTest_b_23_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist38_expX_uid9_fpDivTest_b_23_rdcnt_i, 5)));

    -- expX_uid9_fpDivTest(BITSELECT,8)@0
    expX_uid9_fpDivTest_b <= a(30 downto 23);

    -- redist38_expX_uid9_fpDivTest_b_23_wraddr(REG,360)
    redist38_expX_uid9_fpDivTest_b_23_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist38_expX_uid9_fpDivTest_b_23_wraddr_q <= "10100";
            ELSE
                redist38_expX_uid9_fpDivTest_b_23_wraddr_q <= STD_LOGIC_VECTOR(redist38_expX_uid9_fpDivTest_b_23_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist38_expX_uid9_fpDivTest_b_23_mem(DUALMEM,358)
    redist38_expX_uid9_fpDivTest_b_23_mem_ia <= STD_LOGIC_VECTOR(expX_uid9_fpDivTest_b);
    redist38_expX_uid9_fpDivTest_b_23_mem_aa <= redist38_expX_uid9_fpDivTest_b_23_wraddr_q;
    redist38_expX_uid9_fpDivTest_b_23_mem_ab <= redist38_expX_uid9_fpDivTest_b_23_rdcnt_q;
    redist38_expX_uid9_fpDivTest_b_23_mem_reset0 <= areset;
    redist38_expX_uid9_fpDivTest_b_23_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 21,
        width_b => 8,
        widthad_b => 5,
        numwords_b => 21,
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
        clocken1 => redist38_expX_uid9_fpDivTest_b_23_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist38_expX_uid9_fpDivTest_b_23_mem_reset0,
        clock1 => clk,
        address_a => redist38_expX_uid9_fpDivTest_b_23_mem_aa,
        data_a => redist38_expX_uid9_fpDivTest_b_23_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist38_expX_uid9_fpDivTest_b_23_mem_ab,
        q_b => redist38_expX_uid9_fpDivTest_b_23_mem_iq
    );
    redist38_expX_uid9_fpDivTest_b_23_mem_q <= redist38_expX_uid9_fpDivTest_b_23_mem_iq(7 downto 0);
    redist38_expX_uid9_fpDivTest_b_23_mem_enaOr_rst <= redist38_expX_uid9_fpDivTest_b_23_enaAnd_q(0) or redist38_expX_uid9_fpDivTest_b_23_mem_reset0;

    -- redist38_expX_uid9_fpDivTest_b_23_outputreg0(DELAY,357)
    redist38_expX_uid9_fpDivTest_b_23_outputreg0 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist38_expX_uid9_fpDivTest_b_23_mem_q, xout => redist38_expX_uid9_fpDivTest_b_23_outputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- redist39_expX_uid9_fpDivTest_b_26(DELAY,234)
    redist39_expX_uid9_fpDivTest_b_26 : dspba_delay
    GENERIC MAP ( width => 8, depth => 3, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist38_expX_uid9_fpDivTest_b_23_outputreg0_q, xout => redist39_expX_uid9_fpDivTest_b_26_q, clk => clk, aclr => areset, ena => '1' );

    -- expXIsMax_uid24_fpDivTest(LOGICAL,23)@26 + 1
    expXIsMax_uid24_fpDivTest_qi <= "1" WHEN redist39_expX_uid9_fpDivTest_b_26_q = cstAllOWE_uid18_fpDivTest_q ELSE "0";
    expXIsMax_uid24_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => expXIsMax_uid24_fpDivTest_qi, xout => expXIsMax_uid24_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- excI_x_uid27_fpDivTest(LOGICAL,26)@27 + 1
    excI_x_uid27_fpDivTest_qi <= expXIsMax_uid24_fpDivTest_q and fracXIsZero_uid25_fpDivTest_q;
    excI_x_uid27_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excI_x_uid27_fpDivTest_qi, xout => excI_x_uid27_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- excXIYI_uid130_fpDivTest(LOGICAL,129)@28
    excXIYI_uid130_fpDivTest_q <= excI_x_uid27_fpDivTest_q and excI_y_uid41_fpDivTest_q;

    -- fracXIsNotZero_uid40_fpDivTest(LOGICAL,39)@27
    fracXIsNotZero_uid40_fpDivTest_q <= not (fracXIsZero_uid39_fpDivTest_q);

    -- excN_y_uid42_fpDivTest(LOGICAL,41)@27 + 1
    excN_y_uid42_fpDivTest_qi <= expXIsMax_uid38_fpDivTest_q and fracXIsNotZero_uid40_fpDivTest_q;
    excN_y_uid42_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excN_y_uid42_fpDivTest_qi, xout => excN_y_uid42_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- fracXIsNotZero_uid26_fpDivTest(LOGICAL,25)@27
    fracXIsNotZero_uid26_fpDivTest_q <= not (fracXIsZero_uid25_fpDivTest_q);

    -- excN_x_uid28_fpDivTest(LOGICAL,27)@27 + 1
    excN_x_uid28_fpDivTest_qi <= expXIsMax_uid24_fpDivTest_q and fracXIsNotZero_uid26_fpDivTest_q;
    excN_x_uid28_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excN_x_uid28_fpDivTest_qi, xout => excN_x_uid28_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- cstAllZWE_uid20_fpDivTest(CONSTANT,19)
    cstAllZWE_uid20_fpDivTest_q <= "00000000";

    -- excZ_y_uid37_fpDivTest(LOGICAL,36)@26 + 1
    excZ_y_uid37_fpDivTest_qi <= "1" WHEN redist35_expY_uid12_fpDivTest_b_26_q = cstAllZWE_uid20_fpDivTest_q ELSE "0";
    excZ_y_uid37_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excZ_y_uid37_fpDivTest_qi, xout => excZ_y_uid37_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist28_excZ_y_uid37_fpDivTest_q_2(DELAY,223)
    redist28_excZ_y_uid37_fpDivTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excZ_y_uid37_fpDivTest_q, xout => redist28_excZ_y_uid37_fpDivTest_q_2_q, clk => clk, aclr => areset, ena => '1' );

    -- excZ_x_uid23_fpDivTest(LOGICAL,22)@26 + 1
    excZ_x_uid23_fpDivTest_qi <= "1" WHEN redist39_expX_uid9_fpDivTest_b_26_q = cstAllZWE_uid20_fpDivTest_q ELSE "0";
    excZ_x_uid23_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excZ_x_uid23_fpDivTest_qi, xout => excZ_x_uid23_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist30_excZ_x_uid23_fpDivTest_q_2(DELAY,225)
    redist30_excZ_x_uid23_fpDivTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excZ_x_uid23_fpDivTest_q, xout => redist30_excZ_x_uid23_fpDivTest_q_2_q, clk => clk, aclr => areset, ena => '1' );

    -- excXZYZ_uid129_fpDivTest(LOGICAL,128)@28
    excXZYZ_uid129_fpDivTest_q <= redist30_excZ_x_uid23_fpDivTest_q_2_q and redist28_excZ_y_uid37_fpDivTest_q_2_q;

    -- excRNaN_uid131_fpDivTest(LOGICAL,130)@28 + 1
    excRNaN_uid131_fpDivTest_qi <= excXZYZ_uid129_fpDivTest_q or excN_x_uid28_fpDivTest_q or excN_y_uid42_fpDivTest_q or excXIYI_uid130_fpDivTest_q;
    excRNaN_uid131_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excRNaN_uid131_fpDivTest_qi, xout => excRNaN_uid131_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- invExcRNaN_uid142_fpDivTest(LOGICAL,141)@29
    invExcRNaN_uid142_fpDivTest_q <= not (excRNaN_uid131_fpDivTest_q);

    -- signY_uid14_fpDivTest(BITSELECT,13)@0
    signY_uid14_fpDivTest_b <= STD_LOGIC_VECTOR(b(31 downto 31));

    -- signX_uid11_fpDivTest(BITSELECT,10)@0
    signX_uid11_fpDivTest_b <= STD_LOGIC_VECTOR(a(31 downto 31));

    -- signR_uid46_fpDivTest(LOGICAL,45)@0 + 1
    signR_uid46_fpDivTest_qi <= signX_uid11_fpDivTest_b xor signY_uid14_fpDivTest_b;
    signR_uid46_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => signR_uid46_fpDivTest_qi, xout => signR_uid46_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist27_signR_uid46_fpDivTest_q_29(DELAY,222)
    redist27_signR_uid46_fpDivTest_q_29 : dspba_delay
    GENERIC MAP ( width => 1, depth => 28, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => signR_uid46_fpDivTest_q, xout => redist27_signR_uid46_fpDivTest_q_29_q, clk => clk, aclr => areset, ena => '1' );

    -- sRPostExc_uid143_fpDivTest(LOGICAL,142)@29 + 1
    sRPostExc_uid143_fpDivTest_qi <= redist27_signR_uid46_fpDivTest_q_29_q and invExcRNaN_uid142_fpDivTest_q;
    sRPostExc_uid143_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sRPostExc_uid143_fpDivTest_qi, xout => sRPostExc_uid143_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist4_sRPostExc_uid143_fpDivTest_q_9(DELAY,199)
    redist4_sRPostExc_uid143_fpDivTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sRPostExc_uid143_fpDivTest_q, xout => redist4_sRPostExc_uid143_fpDivTest_q_9_q, clk => clk, aclr => areset, ena => '1' );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_notEnable(LOGICAL,275)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_nor(LOGICAL,276)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_nor_q <= not (redist18_fracPostRndF_uid80_fpDivTest_q_10_notEnable_q or redist18_fracPostRndF_uid80_fpDivTest_q_10_sticky_ena_q);

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_last(CONSTANT,272)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_last_q <= "0101";

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_cmp(LOGICAL,273)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_cmp_b <= STD_LOGIC_VECTOR("0" & redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_q);
    redist18_fracPostRndF_uid80_fpDivTest_q_10_cmp_q <= "1" WHEN redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_last_q = redist18_fracPostRndF_uid80_fpDivTest_q_10_cmp_b ELSE "0";

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_cmpReg(REG,274)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist18_fracPostRndF_uid80_fpDivTest_q_10_cmpReg_q <= "0";
            ELSE
                redist18_fracPostRndF_uid80_fpDivTest_q_10_cmpReg_q <= STD_LOGIC_VECTOR(redist18_fracPostRndF_uid80_fpDivTest_q_10_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_sticky_ena(REG,277)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist18_fracPostRndF_uid80_fpDivTest_q_10_sticky_ena_q <= "0";
            ELSE
                IF (redist18_fracPostRndF_uid80_fpDivTest_q_10_nor_q = "1") THEN
                    redist18_fracPostRndF_uid80_fpDivTest_q_10_sticky_ena_q <= STD_LOGIC_VECTOR(redist18_fracPostRndF_uid80_fpDivTest_q_10_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_enaAnd(LOGICAL,278)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_enaAnd_q <= redist18_fracPostRndF_uid80_fpDivTest_q_10_sticky_ena_q and VCC_q;

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt(COUNTER,270)
    -- low=0, high=6, step=1, init=0
    redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_eq <= '0';
            ELSE
                IF (redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                    redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_eq <= '1';
                ELSE
                    redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_eq <= '0';
                END IF;
                IF (redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_eq = '1') THEN
                    redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_i <= redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_i + 2;
                ELSE
                    redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_i <= redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_i, 3)));

    -- fracXExt_uid77_fpDivTest(BITJOIN,76)@26
    fracXExt_uid77_fpDivTest_q <= redist37_fracX_uid10_fpDivTest_b_26_outputreg0_q & GND_q;

    -- redist20_lOAdded_uid57_fpDivTest_q_6_notEnable(LOGICAL,286)
    redist20_lOAdded_uid57_fpDivTest_q_6_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist20_lOAdded_uid57_fpDivTest_q_6_nor(LOGICAL,287)
    redist20_lOAdded_uid57_fpDivTest_q_6_nor_q <= not (redist20_lOAdded_uid57_fpDivTest_q_6_notEnable_q or redist20_lOAdded_uid57_fpDivTest_q_6_sticky_ena_q);

    -- redist20_lOAdded_uid57_fpDivTest_q_6_mem_last(CONSTANT,283)
    redist20_lOAdded_uid57_fpDivTest_q_6_mem_last_q <= "010";

    -- redist20_lOAdded_uid57_fpDivTest_q_6_cmp(LOGICAL,284)
    redist20_lOAdded_uid57_fpDivTest_q_6_cmp_b <= STD_LOGIC_VECTOR("0" & redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_q);
    redist20_lOAdded_uid57_fpDivTest_q_6_cmp_q <= "1" WHEN redist20_lOAdded_uid57_fpDivTest_q_6_mem_last_q = redist20_lOAdded_uid57_fpDivTest_q_6_cmp_b ELSE "0";

    -- redist20_lOAdded_uid57_fpDivTest_q_6_cmpReg(REG,285)
    redist20_lOAdded_uid57_fpDivTest_q_6_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist20_lOAdded_uid57_fpDivTest_q_6_cmpReg_q <= "0";
            ELSE
                redist20_lOAdded_uid57_fpDivTest_q_6_cmpReg_q <= STD_LOGIC_VECTOR(redist20_lOAdded_uid57_fpDivTest_q_6_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist20_lOAdded_uid57_fpDivTest_q_6_sticky_ena(REG,288)
    redist20_lOAdded_uid57_fpDivTest_q_6_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist20_lOAdded_uid57_fpDivTest_q_6_sticky_ena_q <= "0";
            ELSE
                IF (redist20_lOAdded_uid57_fpDivTest_q_6_nor_q = "1") THEN
                    redist20_lOAdded_uid57_fpDivTest_q_6_sticky_ena_q <= STD_LOGIC_VECTOR(redist20_lOAdded_uid57_fpDivTest_q_6_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist20_lOAdded_uid57_fpDivTest_q_6_enaAnd(LOGICAL,289)
    redist20_lOAdded_uid57_fpDivTest_q_6_enaAnd_q <= redist20_lOAdded_uid57_fpDivTest_q_6_sticky_ena_q and VCC_q;

    -- redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt(COUNTER,281)
    -- low=0, high=3, step=1, init=0
    redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_i <= TO_UNSIGNED(0, 2);
            ELSE
                redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_i <= redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_i, 2)));

    -- lOAdded_uid57_fpDivTest(BITJOIN,56)@18
    lOAdded_uid57_fpDivTest_q <= VCC_q & redist36_fracX_uid10_fpDivTest_b_18_outputreg0_q;

    -- redist20_lOAdded_uid57_fpDivTest_q_6_inputreg0(DELAY,279)
    redist20_lOAdded_uid57_fpDivTest_q_6_inputreg0 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lOAdded_uid57_fpDivTest_q, xout => redist20_lOAdded_uid57_fpDivTest_q_6_inputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- redist20_lOAdded_uid57_fpDivTest_q_6_wraddr(REG,282)
    redist20_lOAdded_uid57_fpDivTest_q_6_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist20_lOAdded_uid57_fpDivTest_q_6_wraddr_q <= "11";
            ELSE
                redist20_lOAdded_uid57_fpDivTest_q_6_wraddr_q <= STD_LOGIC_VECTOR(redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist20_lOAdded_uid57_fpDivTest_q_6_mem(DUALMEM,280)
    redist20_lOAdded_uid57_fpDivTest_q_6_mem_ia <= STD_LOGIC_VECTOR(redist20_lOAdded_uid57_fpDivTest_q_6_inputreg0_q);
    redist20_lOAdded_uid57_fpDivTest_q_6_mem_aa <= redist20_lOAdded_uid57_fpDivTest_q_6_wraddr_q;
    redist20_lOAdded_uid57_fpDivTest_q_6_mem_ab <= redist20_lOAdded_uid57_fpDivTest_q_6_rdcnt_q;
    redist20_lOAdded_uid57_fpDivTest_q_6_mem_reset0 <= areset;
    redist20_lOAdded_uid57_fpDivTest_q_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 24,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 24,
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
        clocken1 => redist20_lOAdded_uid57_fpDivTest_q_6_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist20_lOAdded_uid57_fpDivTest_q_6_mem_reset0,
        clock1 => clk,
        address_a => redist20_lOAdded_uid57_fpDivTest_q_6_mem_aa,
        data_a => redist20_lOAdded_uid57_fpDivTest_q_6_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist20_lOAdded_uid57_fpDivTest_q_6_mem_ab,
        q_b => redist20_lOAdded_uid57_fpDivTest_q_6_mem_iq
    );
    redist20_lOAdded_uid57_fpDivTest_q_6_mem_q <= redist20_lOAdded_uid57_fpDivTest_q_6_mem_iq(23 downto 0);
    redist20_lOAdded_uid57_fpDivTest_q_6_mem_enaOr_rst <= redist20_lOAdded_uid57_fpDivTest_q_6_enaAnd_q(0) or redist20_lOAdded_uid57_fpDivTest_q_6_mem_reset0;

    -- z4_uid60_fpDivTest(CONSTANT,59)
    z4_uid60_fpDivTest_q <= "0000";

    -- oFracXZ4_uid61_fpDivTest(BITJOIN,60)@24
    oFracXZ4_uid61_fpDivTest_q <= redist20_lOAdded_uid57_fpDivTest_q_6_mem_q & z4_uid60_fpDivTest_q;

    -- yAddr_uid51_fpDivTest(BITSELECT,50)@0
    yAddr_uid51_fpDivTest_b <= fracY_uid13_fpDivTest_b(22 downto 14);

    -- memoryC2_uid152_invTables_lutmem(DUALMEM,189)@0 + 2
    -- in j@20000000
    memoryC2_uid152_invTables_lutmem_aa <= yAddr_uid51_fpDivTest_b;
    memoryC2_uid152_invTables_lutmem_reset0 <= areset;
    memoryC2_uid152_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 13,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FP_Div_altera_fp_functions_180_dj5ikpq_memoryC2_uid152_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        sclr => memoryC2_uid152_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC2_uid152_invTables_lutmem_aa,
        q_a => memoryC2_uid152_invTables_lutmem_ir
    );
    memoryC2_uid152_invTables_lutmem_r <= memoryC2_uid152_invTables_lutmem_ir(12 downto 0);
    memoryC2_uid152_invTables_lutmem_enaOr_rst <= VCC_q(0) or memoryC2_uid152_invTables_lutmem_reset0;

    -- redist0_memoryC2_uid152_invTables_lutmem_r_1(DELAY,195)
    redist0_memoryC2_uid152_invTables_lutmem_r_1 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => memoryC2_uid152_invTables_lutmem_r, xout => redist0_memoryC2_uid152_invTables_lutmem_r_1_q, clk => clk, aclr => areset, ena => '1' );

    -- yPE_uid52_fpDivTest(BITSELECT,51)@0
    yPE_uid52_fpDivTest_b <= b(13 downto 0);

    -- redist23_yPE_uid52_fpDivTest_b_3(DELAY,218)
    redist23_yPE_uid52_fpDivTest_b_3 : dspba_delay
    GENERIC MAP ( width => 14, depth => 3, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => yPE_uid52_fpDivTest_b, xout => redist23_yPE_uid52_fpDivTest_b_3_q, clk => clk, aclr => areset, ena => '1' );

    -- yT1_uid158_invPolyEval(BITSELECT,157)@3
    yT1_uid158_invPolyEval_b <= redist23_yPE_uid52_fpDivTest_b_3_q(13 downto 1);

    -- prodXY_uid174_pT1_uid159_invPolyEval_cma(CHAINMULTADD,192)@3 + 5
    -- out q@9
    prodXY_uid174_pT1_uid159_invPolyEval_cma_reset <= areset;
    prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0 <= '1';
    prodXY_uid174_pT1_uid159_invPolyEval_cma_ena1 <= prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0;
    prodXY_uid174_pT1_uid159_invPolyEval_cma_ena2 <= prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0;
    prodXY_uid174_pT1_uid159_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                prodXY_uid174_pT1_uid159_invPolyEval_cma_ah(0) <= RESIZE(UNSIGNED(yT1_uid158_invPolyEval_b),13);
                prodXY_uid174_pT1_uid159_invPolyEval_cma_ch(0) <= RESIZE(SIGNED(redist0_memoryC2_uid152_invTables_lutmem_r_1_q),13);
            END IF;
        END IF;
    END PROCESS;

    prodXY_uid174_pT1_uid159_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(prodXY_uid174_pT1_uid159_invPolyEval_cma_ah(0));
    prodXY_uid174_pT1_uid159_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(prodXY_uid174_pT1_uid159_invPolyEval_cma_ch(0));
    prodXY_uid174_pT1_uid159_invPolyEval_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 13,
        ax_clock => "0",
        ax_width => 13,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 26,
        bx_width => 1,
        by_width => 1,
        result_b_width => 1
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXY_uid174_pT1_uid159_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid174_pT1_uid159_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid174_pT1_uid159_invPolyEval_cma_ena2,
        clr(0) => prodXY_uid174_pT1_uid159_invPolyEval_cma_reset,
        clr(1) => prodXY_uid174_pT1_uid159_invPolyEval_cma_reset,
        ay => prodXY_uid174_pT1_uid159_invPolyEval_cma_a0,
        ax => prodXY_uid174_pT1_uid159_invPolyEval_cma_c0,
        resulta => prodXY_uid174_pT1_uid159_invPolyEval_cma_s0
    );
    prodXY_uid174_pT1_uid159_invPolyEval_cma_delay : dspba_delay
    GENERIC MAP ( width => 26, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid174_pT1_uid159_invPolyEval_cma_s0, xout => prodXY_uid174_pT1_uid159_invPolyEval_cma_qq, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid174_pT1_uid159_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid174_pT1_uid159_invPolyEval_cma_qq(25 downto 0));

    -- osig_uid175_pT1_uid159_invPolyEval(BITSELECT,174)@9
    osig_uid175_pT1_uid159_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid174_pT1_uid159_invPolyEval_cma_q(25 downto 12));

    -- highBBits_uid161_invPolyEval(BITSELECT,160)@9
    highBBits_uid161_invPolyEval_b <= STD_LOGIC_VECTOR(osig_uid175_pT1_uid159_invPolyEval_b(13 downto 1));

    -- redist25_yAddr_uid51_fpDivTest_b_7_notEnable(LOGICAL,308)
    redist25_yAddr_uid51_fpDivTest_b_7_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist25_yAddr_uid51_fpDivTest_b_7_nor(LOGICAL,309)
    redist25_yAddr_uid51_fpDivTest_b_7_nor_q <= not (redist25_yAddr_uid51_fpDivTest_b_7_notEnable_q or redist25_yAddr_uid51_fpDivTest_b_7_sticky_ena_q);

    -- redist25_yAddr_uid51_fpDivTest_b_7_mem_last(CONSTANT,305)
    redist25_yAddr_uid51_fpDivTest_b_7_mem_last_q <= "011";

    -- redist25_yAddr_uid51_fpDivTest_b_7_cmp(LOGICAL,306)
    redist25_yAddr_uid51_fpDivTest_b_7_cmp_q <= "1" WHEN redist25_yAddr_uid51_fpDivTest_b_7_mem_last_q = redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_q ELSE "0";

    -- redist25_yAddr_uid51_fpDivTest_b_7_cmpReg(REG,307)
    redist25_yAddr_uid51_fpDivTest_b_7_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist25_yAddr_uid51_fpDivTest_b_7_cmpReg_q <= "0";
            ELSE
                redist25_yAddr_uid51_fpDivTest_b_7_cmpReg_q <= STD_LOGIC_VECTOR(redist25_yAddr_uid51_fpDivTest_b_7_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist25_yAddr_uid51_fpDivTest_b_7_sticky_ena(REG,310)
    redist25_yAddr_uid51_fpDivTest_b_7_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist25_yAddr_uid51_fpDivTest_b_7_sticky_ena_q <= "0";
            ELSE
                IF (redist25_yAddr_uid51_fpDivTest_b_7_nor_q = "1") THEN
                    redist25_yAddr_uid51_fpDivTest_b_7_sticky_ena_q <= STD_LOGIC_VECTOR(redist25_yAddr_uid51_fpDivTest_b_7_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist25_yAddr_uid51_fpDivTest_b_7_enaAnd(LOGICAL,311)
    redist25_yAddr_uid51_fpDivTest_b_7_enaAnd_q <= redist25_yAddr_uid51_fpDivTest_b_7_sticky_ena_q and VCC_q;

    -- redist25_yAddr_uid51_fpDivTest_b_7_rdcnt(COUNTER,303)
    -- low=0, high=4, step=1, init=0
    redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_eq <= '0';
            ELSE
                IF (redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                    redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_eq <= '1';
                ELSE
                    redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_eq <= '0';
                END IF;
                IF (redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_eq = '1') THEN
                    redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_i <= redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_i + 4;
                ELSE
                    redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_i <= redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_i, 3)));

    -- redist25_yAddr_uid51_fpDivTest_b_7_wraddr(REG,304)
    redist25_yAddr_uid51_fpDivTest_b_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist25_yAddr_uid51_fpDivTest_b_7_wraddr_q <= "100";
            ELSE
                redist25_yAddr_uid51_fpDivTest_b_7_wraddr_q <= STD_LOGIC_VECTOR(redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist25_yAddr_uid51_fpDivTest_b_7_mem(DUALMEM,302)
    redist25_yAddr_uid51_fpDivTest_b_7_mem_ia <= STD_LOGIC_VECTOR(yAddr_uid51_fpDivTest_b);
    redist25_yAddr_uid51_fpDivTest_b_7_mem_aa <= redist25_yAddr_uid51_fpDivTest_b_7_wraddr_q;
    redist25_yAddr_uid51_fpDivTest_b_7_mem_ab <= redist25_yAddr_uid51_fpDivTest_b_7_rdcnt_q;
    redist25_yAddr_uid51_fpDivTest_b_7_mem_reset0 <= areset;
    redist25_yAddr_uid51_fpDivTest_b_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 9,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 9,
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
        clocken1 => redist25_yAddr_uid51_fpDivTest_b_7_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist25_yAddr_uid51_fpDivTest_b_7_mem_reset0,
        clock1 => clk,
        address_a => redist25_yAddr_uid51_fpDivTest_b_7_mem_aa,
        data_a => redist25_yAddr_uid51_fpDivTest_b_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist25_yAddr_uid51_fpDivTest_b_7_mem_ab,
        q_b => redist25_yAddr_uid51_fpDivTest_b_7_mem_iq
    );
    redist25_yAddr_uid51_fpDivTest_b_7_mem_q <= redist25_yAddr_uid51_fpDivTest_b_7_mem_iq(8 downto 0);
    redist25_yAddr_uid51_fpDivTest_b_7_mem_enaOr_rst <= redist25_yAddr_uid51_fpDivTest_b_7_enaAnd_q(0) or redist25_yAddr_uid51_fpDivTest_b_7_mem_reset0;

    -- redist25_yAddr_uid51_fpDivTest_b_7_outputreg0(DELAY,301)
    redist25_yAddr_uid51_fpDivTest_b_7_outputreg0 : dspba_delay
    GENERIC MAP ( width => 9, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist25_yAddr_uid51_fpDivTest_b_7_mem_q, xout => redist25_yAddr_uid51_fpDivTest_b_7_outputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- memoryC1_uid149_invTables_lutmem(DUALMEM,188)@7 + 2
    -- in j@20000000
    memoryC1_uid149_invTables_lutmem_aa <= redist25_yAddr_uid51_fpDivTest_b_7_outputreg0_q;
    memoryC1_uid149_invTables_lutmem_reset0 <= areset;
    memoryC1_uid149_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 22,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FP_Div_altera_fp_functions_180_dj5ikpq_memoryC1_uid149_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        sclr => memoryC1_uid149_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC1_uid149_invTables_lutmem_aa,
        q_a => memoryC1_uid149_invTables_lutmem_ir
    );
    memoryC1_uid149_invTables_lutmem_r <= memoryC1_uid149_invTables_lutmem_ir(21 downto 0);
    memoryC1_uid149_invTables_lutmem_enaOr_rst <= VCC_q(0) or memoryC1_uid149_invTables_lutmem_reset0;

    -- s1sumAHighB_uid162_invPolyEval(ADD,161)@9 + 1
    s1sumAHighB_uid162_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 22 => memoryC1_uid149_invTables_lutmem_r(21)) & memoryC1_uid149_invTables_lutmem_r));
    s1sumAHighB_uid162_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 13 => highBBits_uid161_invPolyEval_b(12)) & highBBits_uid161_invPolyEval_b));
    s1sumAHighB_uid162_invPolyEval_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                s1sumAHighB_uid162_invPolyEval_o <= (others => '0');
            ELSE
                s1sumAHighB_uid162_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s1sumAHighB_uid162_invPolyEval_a) + SIGNED(s1sumAHighB_uid162_invPolyEval_b));
            END IF;
        END IF;
    END PROCESS;
    s1sumAHighB_uid162_invPolyEval_q <= s1sumAHighB_uid162_invPolyEval_o(22 downto 0);

    -- lowRangeB_uid160_invPolyEval(BITSELECT,159)@9
    lowRangeB_uid160_invPolyEval_in <= osig_uid175_pT1_uid159_invPolyEval_b(0 downto 0);
    lowRangeB_uid160_invPolyEval_b <= lowRangeB_uid160_invPolyEval_in(0 downto 0);

    -- redist3_lowRangeB_uid160_invPolyEval_b_1(DELAY,198)
    redist3_lowRangeB_uid160_invPolyEval_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => lowRangeB_uid160_invPolyEval_b, xout => redist3_lowRangeB_uid160_invPolyEval_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- s1_uid163_invPolyEval(BITJOIN,162)@10
    s1_uid163_invPolyEval_q <= s1sumAHighB_uid162_invPolyEval_q & redist3_lowRangeB_uid160_invPolyEval_b_1_q;

    -- redist24_yPE_uid52_fpDivTest_b_10_notEnable(LOGICAL,297)
    redist24_yPE_uid52_fpDivTest_b_10_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist24_yPE_uid52_fpDivTest_b_10_nor(LOGICAL,298)
    redist24_yPE_uid52_fpDivTest_b_10_nor_q <= not (redist24_yPE_uid52_fpDivTest_b_10_notEnable_q or redist24_yPE_uid52_fpDivTest_b_10_sticky_ena_q);

    -- redist24_yPE_uid52_fpDivTest_b_10_mem_last(CONSTANT,294)
    redist24_yPE_uid52_fpDivTest_b_10_mem_last_q <= "011";

    -- redist24_yPE_uid52_fpDivTest_b_10_cmp(LOGICAL,295)
    redist24_yPE_uid52_fpDivTest_b_10_cmp_q <= "1" WHEN redist24_yPE_uid52_fpDivTest_b_10_mem_last_q = redist24_yPE_uid52_fpDivTest_b_10_rdcnt_q ELSE "0";

    -- redist24_yPE_uid52_fpDivTest_b_10_cmpReg(REG,296)
    redist24_yPE_uid52_fpDivTest_b_10_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist24_yPE_uid52_fpDivTest_b_10_cmpReg_q <= "0";
            ELSE
                redist24_yPE_uid52_fpDivTest_b_10_cmpReg_q <= STD_LOGIC_VECTOR(redist24_yPE_uid52_fpDivTest_b_10_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist24_yPE_uid52_fpDivTest_b_10_sticky_ena(REG,299)
    redist24_yPE_uid52_fpDivTest_b_10_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist24_yPE_uid52_fpDivTest_b_10_sticky_ena_q <= "0";
            ELSE
                IF (redist24_yPE_uid52_fpDivTest_b_10_nor_q = "1") THEN
                    redist24_yPE_uid52_fpDivTest_b_10_sticky_ena_q <= STD_LOGIC_VECTOR(redist24_yPE_uid52_fpDivTest_b_10_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist24_yPE_uid52_fpDivTest_b_10_enaAnd(LOGICAL,300)
    redist24_yPE_uid52_fpDivTest_b_10_enaAnd_q <= redist24_yPE_uid52_fpDivTest_b_10_sticky_ena_q and VCC_q;

    -- redist24_yPE_uid52_fpDivTest_b_10_rdcnt(COUNTER,292)
    -- low=0, high=4, step=1, init=0
    redist24_yPE_uid52_fpDivTest_b_10_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist24_yPE_uid52_fpDivTest_b_10_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist24_yPE_uid52_fpDivTest_b_10_rdcnt_eq <= '0';
            ELSE
                IF (redist24_yPE_uid52_fpDivTest_b_10_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                    redist24_yPE_uid52_fpDivTest_b_10_rdcnt_eq <= '1';
                ELSE
                    redist24_yPE_uid52_fpDivTest_b_10_rdcnt_eq <= '0';
                END IF;
                IF (redist24_yPE_uid52_fpDivTest_b_10_rdcnt_eq = '1') THEN
                    redist24_yPE_uid52_fpDivTest_b_10_rdcnt_i <= redist24_yPE_uid52_fpDivTest_b_10_rdcnt_i + 4;
                ELSE
                    redist24_yPE_uid52_fpDivTest_b_10_rdcnt_i <= redist24_yPE_uid52_fpDivTest_b_10_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist24_yPE_uid52_fpDivTest_b_10_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist24_yPE_uid52_fpDivTest_b_10_rdcnt_i, 3)));

    -- redist24_yPE_uid52_fpDivTest_b_10_wraddr(REG,293)
    redist24_yPE_uid52_fpDivTest_b_10_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist24_yPE_uid52_fpDivTest_b_10_wraddr_q <= "100";
            ELSE
                redist24_yPE_uid52_fpDivTest_b_10_wraddr_q <= STD_LOGIC_VECTOR(redist24_yPE_uid52_fpDivTest_b_10_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist24_yPE_uid52_fpDivTest_b_10_mem(DUALMEM,291)
    redist24_yPE_uid52_fpDivTest_b_10_mem_ia <= STD_LOGIC_VECTOR(redist23_yPE_uid52_fpDivTest_b_3_q);
    redist24_yPE_uid52_fpDivTest_b_10_mem_aa <= redist24_yPE_uid52_fpDivTest_b_10_wraddr_q;
    redist24_yPE_uid52_fpDivTest_b_10_mem_ab <= redist24_yPE_uid52_fpDivTest_b_10_rdcnt_q;
    redist24_yPE_uid52_fpDivTest_b_10_mem_reset0 <= areset;
    redist24_yPE_uid52_fpDivTest_b_10_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 14,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 14,
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
        clocken1 => redist24_yPE_uid52_fpDivTest_b_10_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist24_yPE_uid52_fpDivTest_b_10_mem_reset0,
        clock1 => clk,
        address_a => redist24_yPE_uid52_fpDivTest_b_10_mem_aa,
        data_a => redist24_yPE_uid52_fpDivTest_b_10_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist24_yPE_uid52_fpDivTest_b_10_mem_ab,
        q_b => redist24_yPE_uid52_fpDivTest_b_10_mem_iq
    );
    redist24_yPE_uid52_fpDivTest_b_10_mem_q <= redist24_yPE_uid52_fpDivTest_b_10_mem_iq(13 downto 0);
    redist24_yPE_uid52_fpDivTest_b_10_mem_enaOr_rst <= redist24_yPE_uid52_fpDivTest_b_10_enaAnd_q(0) or redist24_yPE_uid52_fpDivTest_b_10_mem_reset0;

    -- redist24_yPE_uid52_fpDivTest_b_10_outputreg0(DELAY,290)
    redist24_yPE_uid52_fpDivTest_b_10_outputreg0 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist24_yPE_uid52_fpDivTest_b_10_mem_q, xout => redist24_yPE_uid52_fpDivTest_b_10_outputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- prodXY_uid177_pT2_uid165_invPolyEval_cma(CHAINMULTADD,193)@10 + 5
    -- out q@16
    prodXY_uid177_pT2_uid165_invPolyEval_cma_reset <= areset;
    prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0 <= '1';
    prodXY_uid177_pT2_uid165_invPolyEval_cma_ena1 <= prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0;
    prodXY_uid177_pT2_uid165_invPolyEval_cma_ena2 <= prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0;
    prodXY_uid177_pT2_uid165_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                prodXY_uid177_pT2_uid165_invPolyEval_cma_ah(0) <= RESIZE(UNSIGNED(redist24_yPE_uid52_fpDivTest_b_10_outputreg0_q),14);
                prodXY_uid177_pT2_uid165_invPolyEval_cma_ch(0) <= RESIZE(SIGNED(s1_uid163_invPolyEval_q),24);
            END IF;
        END IF;
    END PROCESS;

    prodXY_uid177_pT2_uid165_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(prodXY_uid177_pT2_uid165_invPolyEval_cma_ah(0));
    prodXY_uid177_pT2_uid165_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(prodXY_uid177_pT2_uid165_invPolyEval_cma_ch(0));
    prodXY_uid177_pT2_uid165_invPolyEval_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 14,
        ax_clock => "0",
        ax_width => 24,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 38
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXY_uid177_pT2_uid165_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid177_pT2_uid165_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid177_pT2_uid165_invPolyEval_cma_ena2,
        clr(0) => prodXY_uid177_pT2_uid165_invPolyEval_cma_reset,
        clr(1) => prodXY_uid177_pT2_uid165_invPolyEval_cma_reset,
        ay => prodXY_uid177_pT2_uid165_invPolyEval_cma_a0,
        ax => prodXY_uid177_pT2_uid165_invPolyEval_cma_c0,
        resulta => prodXY_uid177_pT2_uid165_invPolyEval_cma_s0
    );
    prodXY_uid177_pT2_uid165_invPolyEval_cma_delay : dspba_delay
    GENERIC MAP ( width => 38, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid177_pT2_uid165_invPolyEval_cma_s0, xout => prodXY_uid177_pT2_uid165_invPolyEval_cma_qq, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid177_pT2_uid165_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid177_pT2_uid165_invPolyEval_cma_qq(37 downto 0));

    -- osig_uid178_pT2_uid165_invPolyEval(BITSELECT,177)@16
    osig_uid178_pT2_uid165_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid177_pT2_uid165_invPolyEval_cma_q(37 downto 13));

    -- redist2_osig_uid178_pT2_uid165_invPolyEval_b_1(DELAY,197)
    redist2_osig_uid178_pT2_uid165_invPolyEval_b_1 : dspba_delay
    GENERIC MAP ( width => 25, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => osig_uid178_pT2_uid165_invPolyEval_b, xout => redist2_osig_uid178_pT2_uid165_invPolyEval_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- highBBits_uid167_invPolyEval(BITSELECT,166)@17
    highBBits_uid167_invPolyEval_b <= STD_LOGIC_VECTOR(redist2_osig_uid178_pT2_uid165_invPolyEval_b_1_q(24 downto 2));

    -- redist26_yAddr_uid51_fpDivTest_b_14_inputreg0(DELAY,312)
    redist26_yAddr_uid51_fpDivTest_b_14_inputreg0 : dspba_delay
    GENERIC MAP ( width => 9, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist25_yAddr_uid51_fpDivTest_b_7_outputreg0_q, xout => redist26_yAddr_uid51_fpDivTest_b_14_inputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- redist26_yAddr_uid51_fpDivTest_b_14(DELAY,221)
    redist26_yAddr_uid51_fpDivTest_b_14 : dspba_delay
    GENERIC MAP ( width => 9, depth => 5, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist26_yAddr_uid51_fpDivTest_b_14_inputreg0_q, xout => redist26_yAddr_uid51_fpDivTest_b_14_q, clk => clk, aclr => areset, ena => '1' );

    -- redist26_yAddr_uid51_fpDivTest_b_14_outputreg0(DELAY,313)
    redist26_yAddr_uid51_fpDivTest_b_14_outputreg0 : dspba_delay
    GENERIC MAP ( width => 9, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist26_yAddr_uid51_fpDivTest_b_14_q, xout => redist26_yAddr_uid51_fpDivTest_b_14_outputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- memoryC0_uid146_invTables_lutmem(DUALMEM,187)@14 + 2
    -- in j@20000000
    memoryC0_uid146_invTables_lutmem_aa <= redist26_yAddr_uid51_fpDivTest_b_14_outputreg0_q;
    memoryC0_uid146_invTables_lutmem_reset0 <= areset;
    memoryC0_uid146_invTables_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "FP_Div_altera_fp_functions_180_dj5ikpq_memoryC0_uid146_invTables_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Stratix 10"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        sclr => memoryC0_uid146_invTables_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC0_uid146_invTables_lutmem_aa,
        q_a => memoryC0_uid146_invTables_lutmem_ir
    );
    memoryC0_uid146_invTables_lutmem_r <= memoryC0_uid146_invTables_lutmem_ir(31 downto 0);
    memoryC0_uid146_invTables_lutmem_enaOr_rst <= VCC_q(0) or memoryC0_uid146_invTables_lutmem_reset0;

    -- redist1_memoryC0_uid146_invTables_lutmem_r_1(DELAY,196)
    redist1_memoryC0_uid146_invTables_lutmem_r_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => memoryC0_uid146_invTables_lutmem_r, xout => redist1_memoryC0_uid146_invTables_lutmem_r_1_q, clk => clk, aclr => areset, ena => '1' );

    -- s2sumAHighB_uid168_invPolyEval(ADD,167)@17
    s2sumAHighB_uid168_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => redist1_memoryC0_uid146_invTables_lutmem_r_1_q(31)) & redist1_memoryC0_uid146_invTables_lutmem_r_1_q));
    s2sumAHighB_uid168_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 23 => highBBits_uid167_invPolyEval_b(22)) & highBBits_uid167_invPolyEval_b));
    s2sumAHighB_uid168_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s2sumAHighB_uid168_invPolyEval_a) + SIGNED(s2sumAHighB_uid168_invPolyEval_b));
    s2sumAHighB_uid168_invPolyEval_q <= s2sumAHighB_uid168_invPolyEval_o(32 downto 0);

    -- lowRangeB_uid166_invPolyEval(BITSELECT,165)@17
    lowRangeB_uid166_invPolyEval_in <= redist2_osig_uid178_pT2_uid165_invPolyEval_b_1_q(1 downto 0);
    lowRangeB_uid166_invPolyEval_b <= lowRangeB_uid166_invPolyEval_in(1 downto 0);

    -- s2_uid169_invPolyEval(BITJOIN,168)@17
    s2_uid169_invPolyEval_q <= s2sumAHighB_uid168_invPolyEval_q & lowRangeB_uid166_invPolyEval_b;

    -- invY_uid54_fpDivTest(BITSELECT,53)@17
    invY_uid54_fpDivTest_in <= s2_uid169_invPolyEval_q(31 downto 0);
    invY_uid54_fpDivTest_b <= invY_uid54_fpDivTest_in(31 downto 5);

    -- redist22_invY_uid54_fpDivTest_b_1(DELAY,217)
    redist22_invY_uid54_fpDivTest_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => invY_uid54_fpDivTest_b, xout => redist22_invY_uid54_fpDivTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma(CHAINMULTADD,191)@18 + 5
    -- out q@24
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_reset <= areset;
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0 <= '1';
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena1 <= prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0;
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena2 <= prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0;
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ah(0) <= RESIZE(UNSIGNED(redist22_invY_uid54_fpDivTest_b_1_q),27);
                prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ch(0) <= RESIZE(UNSIGNED(lOAdded_uid57_fpDivTest_q),24);
            END IF;
        END IF;
    END PROCESS;

    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_a0 <= STD_LOGIC_VECTOR(prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ah(0));
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_c0 <= STD_LOGIC_VECTOR(prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ch(0));
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 27,
        ax_clock => "0",
        ax_width => 24,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 51
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena0,
        ena(1) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena1,
        ena(2) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_ena2,
        clr(0) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_reset,
        clr(1) => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_reset,
        ay => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_a0,
        ax => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_c0,
        resulta => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_s0
    );
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_delay : dspba_delay
    GENERIC MAP ( width => 51, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_s0, xout => prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_qq, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_q <= STD_LOGIC_VECTOR(prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_qq(50 downto 0));

    -- osig_uid172_divValPreNorm_uid59_fpDivTest(BITSELECT,171)@24
    osig_uid172_divValPreNorm_uid59_fpDivTest_b <= prodXY_uid171_divValPreNorm_uid59_fpDivTest_cma_q(50 downto 23);

    -- updatedY_uid16_fpDivTest(BITJOIN,15)@22
    updatedY_uid16_fpDivTest_q <= GND_q & paddingY_uid15_fpDivTest_q;

    -- y0_uid181_fracYZero_uid15_fpDivTest_merged_bit_select(BITSELECT,194)@22
    y0_uid181_fracYZero_uid15_fpDivTest_merged_bit_select_b <= updatedY_uid16_fpDivTest_q(11 downto 0);
    y0_uid181_fracYZero_uid15_fpDivTest_merged_bit_select_c <= updatedY_uid16_fpDivTest_q(23 downto 12);

    -- x1_uid183_fracYZero_uid15_fpDivTest(BITSELECT,182)@22
    x1_uid183_fracYZero_uid15_fpDivTest_b <= redist31_fracY_uid13_fpDivTest_b_22_mem_q(22 downto 12);

    -- eq1_uid185_fracYZero_uid15_fpDivTest(LOGICAL,184)@22 + 1
    eq1_uid185_fracYZero_uid15_fpDivTest_a <= STD_LOGIC_VECTOR("0" & x1_uid183_fracYZero_uid15_fpDivTest_b);
    eq1_uid185_fracYZero_uid15_fpDivTest_qi <= "1" WHEN eq1_uid185_fracYZero_uid15_fpDivTest_a = y0_uid181_fracYZero_uid15_fpDivTest_merged_bit_select_c ELSE "0";
    eq1_uid185_fracYZero_uid15_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => eq1_uid185_fracYZero_uid15_fpDivTest_qi, xout => eq1_uid185_fracYZero_uid15_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- x0_uid180_fracYZero_uid15_fpDivTest(BITSELECT,179)@22
    x0_uid180_fracYZero_uid15_fpDivTest_in <= redist31_fracY_uid13_fpDivTest_b_22_mem_q(11 downto 0);
    x0_uid180_fracYZero_uid15_fpDivTest_b <= x0_uid180_fracYZero_uid15_fpDivTest_in(11 downto 0);

    -- eq0_uid182_fracYZero_uid15_fpDivTest(LOGICAL,181)@22 + 1
    eq0_uid182_fracYZero_uid15_fpDivTest_qi <= "1" WHEN x0_uid180_fracYZero_uid15_fpDivTest_b = y0_uid181_fracYZero_uid15_fpDivTest_merged_bit_select_b ELSE "0";
    eq0_uid182_fracYZero_uid15_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => eq0_uid182_fracYZero_uid15_fpDivTest_qi, xout => eq0_uid182_fracYZero_uid15_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- andEq_uid186_fracYZero_uid15_fpDivTest(LOGICAL,185)@23 + 1
    andEq_uid186_fracYZero_uid15_fpDivTest_qi <= eq0_uid182_fracYZero_uid15_fpDivTest_q and eq1_uid185_fracYZero_uid15_fpDivTest_q;
    andEq_uid186_fracYZero_uid15_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => andEq_uid186_fracYZero_uid15_fpDivTest_qi, xout => andEq_uid186_fracYZero_uid15_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- divValPreNormYPow2Exc_uid63_fpDivTest(MUX,62)@24
    divValPreNormYPow2Exc_uid63_fpDivTest_s <= andEq_uid186_fracYZero_uid15_fpDivTest_q;
    divValPreNormYPow2Exc_uid63_fpDivTest_combproc: PROCESS (divValPreNormYPow2Exc_uid63_fpDivTest_s, osig_uid172_divValPreNorm_uid59_fpDivTest_b, oFracXZ4_uid61_fpDivTest_q)
    BEGIN
        CASE (divValPreNormYPow2Exc_uid63_fpDivTest_s) IS
            WHEN "0" => divValPreNormYPow2Exc_uid63_fpDivTest_q <= osig_uid172_divValPreNorm_uid59_fpDivTest_b;
            WHEN "1" => divValPreNormYPow2Exc_uid63_fpDivTest_q <= oFracXZ4_uid61_fpDivTest_q;
            WHEN OTHERS => divValPreNormYPow2Exc_uid63_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- norm_uid64_fpDivTest(BITSELECT,63)@24
    norm_uid64_fpDivTest_b <= STD_LOGIC_VECTOR(divValPreNormYPow2Exc_uid63_fpDivTest_q(27 downto 27));

    -- redist19_norm_uid64_fpDivTest_b_1(DELAY,214)
    redist19_norm_uid64_fpDivTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => norm_uid64_fpDivTest_b, xout => redist19_norm_uid64_fpDivTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- zeroPaddingInAddition_uid74_fpDivTest(CONSTANT,73)
    zeroPaddingInAddition_uid74_fpDivTest_q <= "000000000000000000000000";

    -- expFracPostRnd_uid75_fpDivTest(BITJOIN,74)@25
    expFracPostRnd_uid75_fpDivTest_q <= redist19_norm_uid64_fpDivTest_b_1_q & zeroPaddingInAddition_uid74_fpDivTest_q & VCC_q;

    -- cstBiasM1_uid6_fpDivTest(CONSTANT,5)
    cstBiasM1_uid6_fpDivTest_q <= "01111110";

    -- expXmY_uid47_fpDivTest(SUB,46)@23 + 1
    expXmY_uid47_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist38_expX_uid9_fpDivTest_b_23_outputreg0_q);
    expXmY_uid47_fpDivTest_b <= STD_LOGIC_VECTOR("0" & redist34_expY_uid12_fpDivTest_b_23_mem_q);
    expXmY_uid47_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                expXmY_uid47_fpDivTest_o <= (others => '0');
            ELSE
                expXmY_uid47_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expXmY_uid47_fpDivTest_a) - UNSIGNED(expXmY_uid47_fpDivTest_b));
            END IF;
        END IF;
    END PROCESS;
    expXmY_uid47_fpDivTest_q <= expXmY_uid47_fpDivTest_o(8 downto 0);

    -- expR_uid48_fpDivTest(ADD,47)@24 + 1
    expR_uid48_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 9 => expXmY_uid47_fpDivTest_q(8)) & expXmY_uid47_fpDivTest_q));
    expR_uid48_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & cstBiasM1_uid6_fpDivTest_q));
    expR_uid48_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                expR_uid48_fpDivTest_o <= (others => '0');
            ELSE
                expR_uid48_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expR_uid48_fpDivTest_a) + SIGNED(expR_uid48_fpDivTest_b));
            END IF;
        END IF;
    END PROCESS;
    expR_uid48_fpDivTest_q <= expR_uid48_fpDivTest_o(9 downto 0);

    -- divValPreNormHigh_uid65_fpDivTest(BITSELECT,64)@24
    divValPreNormHigh_uid65_fpDivTest_in <= divValPreNormYPow2Exc_uid63_fpDivTest_q(26 downto 0);
    divValPreNormHigh_uid65_fpDivTest_b <= divValPreNormHigh_uid65_fpDivTest_in(26 downto 2);

    -- divValPreNormLow_uid66_fpDivTest(BITSELECT,65)@24
    divValPreNormLow_uid66_fpDivTest_in <= divValPreNormYPow2Exc_uid63_fpDivTest_q(25 downto 0);
    divValPreNormLow_uid66_fpDivTest_b <= divValPreNormLow_uid66_fpDivTest_in(25 downto 1);

    -- normFracRnd_uid67_fpDivTest(MUX,66)@24 + 1
    normFracRnd_uid67_fpDivTest_s <= norm_uid64_fpDivTest_b;
    normFracRnd_uid67_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                normFracRnd_uid67_fpDivTest_q <= (others => '0');
            ELSE
                CASE (normFracRnd_uid67_fpDivTest_s) IS
                    WHEN "0" => normFracRnd_uid67_fpDivTest_q <= divValPreNormLow_uid66_fpDivTest_b;
                    WHEN "1" => normFracRnd_uid67_fpDivTest_q <= divValPreNormHigh_uid65_fpDivTest_b;
                    WHEN OTHERS => normFracRnd_uid67_fpDivTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- expFracRnd_uid68_fpDivTest(BITJOIN,67)@25
    expFracRnd_uid68_fpDivTest_q <= expR_uid48_fpDivTest_q & normFracRnd_uid67_fpDivTest_q;

    -- expFracPostRnd_uid76_fpDivTest(ADD,75)@25 + 1
    expFracPostRnd_uid76_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => expFracRnd_uid68_fpDivTest_q(34)) & expFracRnd_uid68_fpDivTest_q));
    expFracPostRnd_uid76_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000" & expFracPostRnd_uid75_fpDivTest_q));
    expFracPostRnd_uid76_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                expFracPostRnd_uid76_fpDivTest_o <= (others => '0');
            ELSE
                expFracPostRnd_uid76_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expFracPostRnd_uid76_fpDivTest_a) + SIGNED(expFracPostRnd_uid76_fpDivTest_b));
            END IF;
        END IF;
    END PROCESS;
    expFracPostRnd_uid76_fpDivTest_q <= expFracPostRnd_uid76_fpDivTest_o(35 downto 0);

    -- fracPostRndF_uid79_fpDivTest(BITSELECT,78)@26
    fracPostRndF_uid79_fpDivTest_in <= expFracPostRnd_uid76_fpDivTest_q(24 downto 0);
    fracPostRndF_uid79_fpDivTest_b <= fracPostRndF_uid79_fpDivTest_in(24 downto 1);

    -- invYO_uid55_fpDivTest(BITSELECT,54)@17
    invYO_uid55_fpDivTest_in <= STD_LOGIC_VECTOR(s2_uid169_invPolyEval_q(32 downto 0));
    invYO_uid55_fpDivTest_b <= STD_LOGIC_VECTOR(invYO_uid55_fpDivTest_in(32 downto 32));

    -- redist21_invYO_uid55_fpDivTest_b_9(DELAY,216)
    redist21_invYO_uid55_fpDivTest_b_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => invYO_uid55_fpDivTest_b, xout => redist21_invYO_uid55_fpDivTest_b_9_q, clk => clk, aclr => areset, ena => '1' );

    -- fracPostRndF_uid80_fpDivTest(MUX,79)@26 + 1
    fracPostRndF_uid80_fpDivTest_s <= redist21_invYO_uid55_fpDivTest_b_9_q;
    fracPostRndF_uid80_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                fracPostRndF_uid80_fpDivTest_q <= (others => '0');
            ELSE
                CASE (fracPostRndF_uid80_fpDivTest_s) IS
                    WHEN "0" => fracPostRndF_uid80_fpDivTest_q <= fracPostRndF_uid79_fpDivTest_b;
                    WHEN "1" => fracPostRndF_uid80_fpDivTest_q <= fracXExt_uid77_fpDivTest_q;
                    WHEN OTHERS => fracPostRndF_uid80_fpDivTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_inputreg0(DELAY,268)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_inputreg0 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracPostRndF_uid80_fpDivTest_q, xout => redist18_fracPostRndF_uid80_fpDivTest_q_10_inputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_wraddr(REG,271)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist18_fracPostRndF_uid80_fpDivTest_q_10_wraddr_q <= "110";
            ELSE
                redist18_fracPostRndF_uid80_fpDivTest_q_10_wraddr_q <= STD_LOGIC_VECTOR(redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist18_fracPostRndF_uid80_fpDivTest_q_10_mem(DUALMEM,269)
    redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_ia <= STD_LOGIC_VECTOR(redist18_fracPostRndF_uid80_fpDivTest_q_10_inputreg0_q);
    redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_aa <= redist18_fracPostRndF_uid80_fpDivTest_q_10_wraddr_q;
    redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_ab <= redist18_fracPostRndF_uid80_fpDivTest_q_10_rdcnt_q;
    redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_reset0 <= areset;
    redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 24,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 24,
        widthad_b => 3,
        numwords_b => 7,
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
        clocken1 => redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_reset0,
        clock1 => clk,
        address_a => redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_aa,
        data_a => redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_ab,
        q_b => redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_iq
    );
    redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_q <= redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_iq(23 downto 0);
    redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_enaOr_rst <= redist18_fracPostRndF_uid80_fpDivTest_q_10_enaAnd_q(0) or redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_reset0;

    -- betweenFPwF_uid102_fpDivTest(BITSELECT,101)@36
    betweenFPwF_uid102_fpDivTest_in <= STD_LOGIC_VECTOR(redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_q(0 downto 0));
    betweenFPwF_uid102_fpDivTest_b <= STD_LOGIC_VECTOR(betweenFPwF_uid102_fpDivTest_in(0 downto 0));

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_notEnable(LOGICAL,242)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_nor(LOGICAL,243)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_nor_q <= not (redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_notEnable_q or redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_sticky_ena_q);

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_last(CONSTANT,239)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_last_q <= "0101";

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmp(LOGICAL,240)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmp_b <= STD_LOGIC_VECTOR("0" & redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_q);
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmp_q <= "1" WHEN redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_last_q = redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmp_b ELSE "0";

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmpReg(REG,241)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmpReg_q <= "0";
            ELSE
                redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmpReg_q <= STD_LOGIC_VECTOR(redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_sticky_ena(REG,244)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_sticky_ena_q <= "0";
            ELSE
                IF (redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_nor_q = "1") THEN
                    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_sticky_ena_q <= STD_LOGIC_VECTOR(redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_enaAnd(LOGICAL,245)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_enaAnd_q <= redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_sticky_ena_q and VCC_q;

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt(COUNTER,237)
    -- low=0, high=6, step=1, init=0
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_eq <= '0';
            ELSE
                IF (redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_eq <= '1';
                ELSE
                    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_eq <= '0';
                END IF;
                IF (redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_eq = '1') THEN
                    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_i <= redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_i + 2;
                ELSE
                    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_i <= redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_i, 3)));

    -- qDivProdLTX_opB_uid100_fpDivTest(BITJOIN,99)@26
    qDivProdLTX_opB_uid100_fpDivTest_q <= redist39_expX_uid9_fpDivTest_b_26_q & redist37_fracX_uid10_fpDivTest_b_26_outputreg0_q;

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_inputreg0(DELAY,235)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_inputreg0 : dspba_delay
    GENERIC MAP ( width => 31, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => qDivProdLTX_opB_uid100_fpDivTest_q, xout => redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_inputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_wraddr(REG,238)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_wraddr_q <= "110";
            ELSE
                redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_wraddr_q <= STD_LOGIC_VECTOR(redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem(DUALMEM,236)
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_ia <= STD_LOGIC_VECTOR(redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_inputreg0_q);
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_aa <= redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_wraddr_q;
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_ab <= redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_rdcnt_q;
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_reset0 <= areset;
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 31,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 31,
        widthad_b => 3,
        numwords_b => 7,
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
        clocken1 => redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_reset0,
        clock1 => clk,
        address_a => redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_aa,
        data_a => redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_ab,
        q_b => redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_iq
    );
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_q <= redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_iq(30 downto 0);
    redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_enaOr_rst <= redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_enaAnd_q(0) or redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_reset0;

    -- redist33_fracY_uid13_fpDivTest_b_27(DELAY,228)
    redist33_fracY_uid13_fpDivTest_b_27 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist32_fracY_uid13_fpDivTest_b_26_q, xout => redist33_fracY_uid13_fpDivTest_b_27_q, clk => clk, aclr => areset, ena => '1' );

    -- lOAdded_uid87_fpDivTest(BITJOIN,86)@27
    lOAdded_uid87_fpDivTest_q <= VCC_q & redist33_fracY_uid13_fpDivTest_b_27_q;

    -- lOAdded_uid84_fpDivTest(BITJOIN,83)@27
    lOAdded_uid84_fpDivTest_q <= VCC_q & fracPostRndF_uid80_fpDivTest_q;

    -- qDivProd_uid89_fpDivTest_cma(CHAINMULTADD,190)@27 + 5
    -- out q@33
    qDivProd_uid89_fpDivTest_cma_reset <= areset;
    qDivProd_uid89_fpDivTest_cma_ena0 <= '1';
    qDivProd_uid89_fpDivTest_cma_ena1 <= qDivProd_uid89_fpDivTest_cma_ena0;
    qDivProd_uid89_fpDivTest_cma_ena2 <= qDivProd_uid89_fpDivTest_cma_ena0;
    qDivProd_uid89_fpDivTest_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                qDivProd_uid89_fpDivTest_cma_ah(0) <= RESIZE(UNSIGNED(lOAdded_uid84_fpDivTest_q),25);
                qDivProd_uid89_fpDivTest_cma_ch(0) <= RESIZE(UNSIGNED(lOAdded_uid87_fpDivTest_q),24);
            END IF;
        END IF;
    END PROCESS;

    qDivProd_uid89_fpDivTest_cma_a0 <= STD_LOGIC_VECTOR(qDivProd_uid89_fpDivTest_cma_ah(0));
    qDivProd_uid89_fpDivTest_cma_c0 <= STD_LOGIC_VECTOR(qDivProd_uid89_fpDivTest_cma_ch(0));
    qDivProd_uid89_fpDivTest_cma_DSP0 : fourteennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clock => "0",
        ay_scan_in_width => 25,
        ax_clock => "0",
        ax_width => 24,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clock => "2",
        second_pipeline_clock => "2",
        output_clock => "1",
        result_a_width => 49
    )
    PORT MAP (
        clk(0) => clk,
        clk(1) => clk,
        clk(2) => clk,
        ena(0) => qDivProd_uid89_fpDivTest_cma_ena0,
        ena(1) => qDivProd_uid89_fpDivTest_cma_ena1,
        ena(2) => qDivProd_uid89_fpDivTest_cma_ena2,
        clr(0) => qDivProd_uid89_fpDivTest_cma_reset,
        clr(1) => qDivProd_uid89_fpDivTest_cma_reset,
        ay => qDivProd_uid89_fpDivTest_cma_a0,
        ax => qDivProd_uid89_fpDivTest_cma_c0,
        resulta => qDivProd_uid89_fpDivTest_cma_s0
    );
    qDivProd_uid89_fpDivTest_cma_delay : dspba_delay
    GENERIC MAP ( width => 49, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => qDivProd_uid89_fpDivTest_cma_s0, xout => qDivProd_uid89_fpDivTest_cma_qq, clk => clk, aclr => areset, ena => '1' );
    qDivProd_uid89_fpDivTest_cma_q <= STD_LOGIC_VECTOR(qDivProd_uid89_fpDivTest_cma_qq(48 downto 0));

    -- qDivProdNorm_uid90_fpDivTest(BITSELECT,89)@33
    qDivProdNorm_uid90_fpDivTest_b <= STD_LOGIC_VECTOR(qDivProd_uid89_fpDivTest_cma_q(48 downto 48));

    -- cstBias_uid7_fpDivTest(CONSTANT,6)
    cstBias_uid7_fpDivTest_q <= "01111111";

    -- qDivProdExp_opBs_uid95_fpDivTest(SUB,94)@33 + 1
    qDivProdExp_opBs_uid95_fpDivTest_a <= STD_LOGIC_VECTOR("0" & cstBias_uid7_fpDivTest_q);
    qDivProdExp_opBs_uid95_fpDivTest_b <= STD_LOGIC_VECTOR("00000000" & qDivProdNorm_uid90_fpDivTest_b);
    qDivProdExp_opBs_uid95_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                qDivProdExp_opBs_uid95_fpDivTest_o <= (others => '0');
            ELSE
                qDivProdExp_opBs_uid95_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(qDivProdExp_opBs_uid95_fpDivTest_a) - UNSIGNED(qDivProdExp_opBs_uid95_fpDivTest_b));
            END IF;
        END IF;
    END PROCESS;
    qDivProdExp_opBs_uid95_fpDivTest_q <= qDivProdExp_opBs_uid95_fpDivTest_o(8 downto 0);

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_notEnable(LOGICAL,253)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_nor(LOGICAL,254)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_nor_q <= not (redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_notEnable_q or redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_sticky_ena_q);

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_last(CONSTANT,250)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_last_q <= "011";

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmp(LOGICAL,251)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmp_q <= "1" WHEN redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_last_q = redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_q ELSE "0";

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmpReg(REG,252)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmpReg_q <= "0";
            ELSE
                redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmpReg_q <= STD_LOGIC_VECTOR(redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_sticky_ena(REG,255)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_sticky_ena_q <= "0";
            ELSE
                IF (redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_nor_q = "1") THEN
                    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_enaAnd(LOGICAL,256)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_enaAnd_q <= redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_sticky_ena_q and VCC_q;

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt(COUNTER,248)
    -- low=0, high=4, step=1, init=0
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_eq <= '0';
            ELSE
                IF (redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_eq <= '1';
                ELSE
                    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_eq <= '0';
                END IF;
                IF (redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_eq = '1') THEN
                    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_i <= redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_i + 4;
                ELSE
                    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_i <= redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_i, 3)));

    -- expPostRndFR_uid81_fpDivTest(BITSELECT,80)@26
    expPostRndFR_uid81_fpDivTest_in <= expFracPostRnd_uid76_fpDivTest_q(32 downto 0);
    expPostRndFR_uid81_fpDivTest_b <= expPostRndFR_uid81_fpDivTest_in(32 downto 25);

    -- expPostRndF_uid82_fpDivTest(MUX,81)@26
    expPostRndF_uid82_fpDivTest_s <= redist21_invYO_uid55_fpDivTest_b_9_q;
    expPostRndF_uid82_fpDivTest_combproc: PROCESS (expPostRndF_uid82_fpDivTest_s, expPostRndFR_uid81_fpDivTest_b, redist39_expX_uid9_fpDivTest_b_26_q)
    BEGIN
        CASE (expPostRndF_uid82_fpDivTest_s) IS
            WHEN "0" => expPostRndF_uid82_fpDivTest_q <= expPostRndFR_uid81_fpDivTest_b;
            WHEN "1" => expPostRndF_uid82_fpDivTest_q <= redist39_expX_uid9_fpDivTest_b_26_q;
            WHEN OTHERS => expPostRndF_uid82_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- qDivProdExp_opA_uid94_fpDivTest(ADD,93)@26 + 1
    qDivProdExp_opA_uid94_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist35_expY_uid12_fpDivTest_b_26_q);
    qDivProdExp_opA_uid94_fpDivTest_b <= STD_LOGIC_VECTOR("0" & expPostRndF_uid82_fpDivTest_q);
    qDivProdExp_opA_uid94_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                qDivProdExp_opA_uid94_fpDivTest_o <= (others => '0');
            ELSE
                qDivProdExp_opA_uid94_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(qDivProdExp_opA_uid94_fpDivTest_a) + UNSIGNED(qDivProdExp_opA_uid94_fpDivTest_b));
            END IF;
        END IF;
    END PROCESS;
    qDivProdExp_opA_uid94_fpDivTest_q <= qDivProdExp_opA_uid94_fpDivTest_o(8 downto 0);

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_wraddr(REG,249)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_wraddr_q <= "100";
            ELSE
                redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_wraddr_q <= STD_LOGIC_VECTOR(redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem(DUALMEM,247)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_ia <= STD_LOGIC_VECTOR(qDivProdExp_opA_uid94_fpDivTest_q);
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_aa <= redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_wraddr_q;
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_ab <= redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_rdcnt_q;
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_reset0 <= areset;
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 9,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 9,
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
        clocken1 => redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_reset0,
        clock1 => clk,
        address_a => redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_aa,
        data_a => redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_ab,
        q_b => redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_iq
    );
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_q <= redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_iq(8 downto 0);
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_enaOr_rst <= redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_enaAnd_q(0) or redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_reset0;

    -- redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_outputreg0(DELAY,246)
    redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_outputreg0 : dspba_delay
    GENERIC MAP ( width => 9, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_mem_q, xout => redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_outputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- qDivProdExp_uid96_fpDivTest(SUB,95)@34
    qDivProdExp_uid96_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist16_qDivProdExp_opA_uid94_fpDivTest_q_8_outputreg0_q));
    qDivProdExp_uid96_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 9 => qDivProdExp_opBs_uid95_fpDivTest_q(8)) & qDivProdExp_opBs_uid95_fpDivTest_q));
    qDivProdExp_uid96_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(qDivProdExp_uid96_fpDivTest_a) - SIGNED(qDivProdExp_uid96_fpDivTest_b));
    qDivProdExp_uid96_fpDivTest_q <= qDivProdExp_uid96_fpDivTest_o(10 downto 0);

    -- qDivProdLTX_opA_uid98_fpDivTest(BITSELECT,97)@34
    qDivProdLTX_opA_uid98_fpDivTest_in <= qDivProdExp_uid96_fpDivTest_q(7 downto 0);
    qDivProdLTX_opA_uid98_fpDivTest_b <= qDivProdLTX_opA_uid98_fpDivTest_in(7 downto 0);

    -- redist14_qDivProdLTX_opA_uid98_fpDivTest_b_1(DELAY,209)
    redist14_qDivProdLTX_opA_uid98_fpDivTest_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => qDivProdLTX_opA_uid98_fpDivTest_b, xout => redist14_qDivProdLTX_opA_uid98_fpDivTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- qDivProdFracHigh_uid91_fpDivTest(BITSELECT,90)@33
    qDivProdFracHigh_uid91_fpDivTest_in <= qDivProd_uid89_fpDivTest_cma_q(47 downto 0);
    qDivProdFracHigh_uid91_fpDivTest_b <= qDivProdFracHigh_uid91_fpDivTest_in(47 downto 24);

    -- qDivProdFracLow_uid92_fpDivTest(BITSELECT,91)@33
    qDivProdFracLow_uid92_fpDivTest_in <= qDivProd_uid89_fpDivTest_cma_q(46 downto 0);
    qDivProdFracLow_uid92_fpDivTest_b <= qDivProdFracLow_uid92_fpDivTest_in(46 downto 23);

    -- qDivProdFrac_uid93_fpDivTest(MUX,92)@33
    qDivProdFrac_uid93_fpDivTest_s <= qDivProdNorm_uid90_fpDivTest_b;
    qDivProdFrac_uid93_fpDivTest_combproc: PROCESS (qDivProdFrac_uid93_fpDivTest_s, qDivProdFracLow_uid92_fpDivTest_b, qDivProdFracHigh_uid91_fpDivTest_b)
    BEGIN
        CASE (qDivProdFrac_uid93_fpDivTest_s) IS
            WHEN "0" => qDivProdFrac_uid93_fpDivTest_q <= qDivProdFracLow_uid92_fpDivTest_b;
            WHEN "1" => qDivProdFrac_uid93_fpDivTest_q <= qDivProdFracHigh_uid91_fpDivTest_b;
            WHEN OTHERS => qDivProdFrac_uid93_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- qDivProdFracWF_uid97_fpDivTest(BITSELECT,96)@33
    qDivProdFracWF_uid97_fpDivTest_b <= qDivProdFrac_uid93_fpDivTest_q(23 downto 1);

    -- redist15_qDivProdFracWF_uid97_fpDivTest_b_2(DELAY,210)
    redist15_qDivProdFracWF_uid97_fpDivTest_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => qDivProdFracWF_uid97_fpDivTest_b, xout => redist15_qDivProdFracWF_uid97_fpDivTest_b_2_q, clk => clk, aclr => areset, ena => '1' );

    -- qDivProdLTX_opA_uid99_fpDivTest(BITJOIN,98)@35
    qDivProdLTX_opA_uid99_fpDivTest_q <= redist14_qDivProdLTX_opA_uid98_fpDivTest_b_1_q & redist15_qDivProdFracWF_uid97_fpDivTest_b_2_q;

    -- qDividerProdLTX_uid101_fpDivTest(COMPARE,100)@35 + 1
    qDividerProdLTX_uid101_fpDivTest_a <= STD_LOGIC_VECTOR("00" & qDivProdLTX_opA_uid99_fpDivTest_q);
    qDividerProdLTX_uid101_fpDivTest_b <= STD_LOGIC_VECTOR("00" & redist13_qDivProdLTX_opB_uid100_fpDivTest_q_9_mem_q);
    qDividerProdLTX_uid101_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                qDividerProdLTX_uid101_fpDivTest_o <= (others => '0');
            ELSE
                qDividerProdLTX_uid101_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(qDividerProdLTX_uid101_fpDivTest_a) - UNSIGNED(qDividerProdLTX_uid101_fpDivTest_b));
            END IF;
        END IF;
    END PROCESS;
    qDividerProdLTX_uid101_fpDivTest_c(0) <= qDividerProdLTX_uid101_fpDivTest_o(32);

    -- extraUlp_uid103_fpDivTest(LOGICAL,102)@36 + 1
    extraUlp_uid103_fpDivTest_qi <= qDividerProdLTX_uid101_fpDivTest_c and betweenFPwF_uid102_fpDivTest_b;
    extraUlp_uid103_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => extraUlp_uid103_fpDivTest_qi, xout => extraUlp_uid103_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- redist12_extraUlp_uid103_fpDivTest_q_2(DELAY,207)
    redist12_extraUlp_uid103_fpDivTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => extraUlp_uid103_fpDivTest_q, xout => redist12_extraUlp_uid103_fpDivTest_q_2_q, clk => clk, aclr => areset, ena => '1' );

    -- fracPostRndFT_uid104_fpDivTest(BITSELECT,103)@36
    fracPostRndFT_uid104_fpDivTest_b <= redist18_fracPostRndF_uid80_fpDivTest_q_10_mem_q(23 downto 1);

    -- redist10_fracPostRndFT_uid104_fpDivTest_b_1(DELAY,205)
    redist10_fracPostRndFT_uid104_fpDivTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracPostRndFT_uid104_fpDivTest_b, xout => redist10_fracPostRndFT_uid104_fpDivTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- fracRPreExcExt_uid105_fpDivTest(ADD,104)@37
    fracRPreExcExt_uid105_fpDivTest_a <= STD_LOGIC_VECTOR("0" & redist10_fracPostRndFT_uid104_fpDivTest_b_1_q);
    fracRPreExcExt_uid105_fpDivTest_b <= STD_LOGIC_VECTOR("00000000000000000000000" & extraUlp_uid103_fpDivTest_q);
    fracRPreExcExt_uid105_fpDivTest_o <= STD_LOGIC_VECTOR(UNSIGNED(fracRPreExcExt_uid105_fpDivTest_a) + UNSIGNED(fracRPreExcExt_uid105_fpDivTest_b));
    fracRPreExcExt_uid105_fpDivTest_q <= fracRPreExcExt_uid105_fpDivTest_o(23 downto 0);

    -- ovfIncRnd_uid109_fpDivTest(BITSELECT,108)@37
    ovfIncRnd_uid109_fpDivTest_b <= STD_LOGIC_VECTOR(fracRPreExcExt_uid105_fpDivTest_q(23 downto 23));

    -- redist8_ovfIncRnd_uid109_fpDivTest_b_1(DELAY,203)
    redist8_ovfIncRnd_uid109_fpDivTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => ovfIncRnd_uid109_fpDivTest_b, xout => redist8_ovfIncRnd_uid109_fpDivTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_notEnable(LOGICAL,264)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_nor(LOGICAL,265)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_nor_q <= not (redist17_expPostRndFR_uid81_fpDivTest_b_12_notEnable_q or redist17_expPostRndFR_uid81_fpDivTest_b_12_sticky_ena_q);

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_last(CONSTANT,261)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_last_q <= "01000";

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_cmp(LOGICAL,262)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_cmp_b <= STD_LOGIC_VECTOR("0" & redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_q);
    redist17_expPostRndFR_uid81_fpDivTest_b_12_cmp_q <= "1" WHEN redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_last_q = redist17_expPostRndFR_uid81_fpDivTest_b_12_cmp_b ELSE "0";

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_cmpReg(REG,263)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist17_expPostRndFR_uid81_fpDivTest_b_12_cmpReg_q <= "0";
            ELSE
                redist17_expPostRndFR_uid81_fpDivTest_b_12_cmpReg_q <= STD_LOGIC_VECTOR(redist17_expPostRndFR_uid81_fpDivTest_b_12_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_sticky_ena(REG,266)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist17_expPostRndFR_uid81_fpDivTest_b_12_sticky_ena_q <= "0";
            ELSE
                IF (redist17_expPostRndFR_uid81_fpDivTest_b_12_nor_q = "1") THEN
                    redist17_expPostRndFR_uid81_fpDivTest_b_12_sticky_ena_q <= STD_LOGIC_VECTOR(redist17_expPostRndFR_uid81_fpDivTest_b_12_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_enaAnd(LOGICAL,267)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_enaAnd_q <= redist17_expPostRndFR_uid81_fpDivTest_b_12_sticky_ena_q and VCC_q;

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt(COUNTER,259)
    -- low=0, high=9, step=1, init=0
    redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_eq <= '0';
            ELSE
                IF (redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_i = TO_UNSIGNED(8, 4)) THEN
                    redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_eq <= '1';
                ELSE
                    redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_eq <= '0';
                END IF;
                IF (redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_eq = '1') THEN
                    redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_i <= redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_i + 7;
                ELSE
                    redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_i <= redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_i, 4)));

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_wraddr(REG,260)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist17_expPostRndFR_uid81_fpDivTest_b_12_wraddr_q <= "1001";
            ELSE
                redist17_expPostRndFR_uid81_fpDivTest_b_12_wraddr_q <= STD_LOGIC_VECTOR(redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_mem(DUALMEM,258)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_ia <= STD_LOGIC_VECTOR(expPostRndFR_uid81_fpDivTest_b);
    redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_aa <= redist17_expPostRndFR_uid81_fpDivTest_b_12_wraddr_q;
    redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_ab <= redist17_expPostRndFR_uid81_fpDivTest_b_12_rdcnt_q;
    redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_reset0 <= areset;
    redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 4,
        numwords_a => 10,
        width_b => 8,
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
        clocken1 => redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_enaOr_rst,
        clocken0 => VCC_q(0),
        clock0 => clk,
        sclr => redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_reset0,
        clock1 => clk,
        address_a => redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_aa,
        data_a => redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_ab,
        q_b => redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_iq
    );
    redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_q <= redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_iq(7 downto 0);
    redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_enaOr_rst <= redist17_expPostRndFR_uid81_fpDivTest_b_12_enaAnd_q(0) or redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_reset0;

    -- redist17_expPostRndFR_uid81_fpDivTest_b_12_outputreg0(DELAY,257)
    redist17_expPostRndFR_uid81_fpDivTest_b_12_outputreg0 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist17_expPostRndFR_uid81_fpDivTest_b_12_mem_q, xout => redist17_expPostRndFR_uid81_fpDivTest_b_12_outputreg0_q, clk => clk, aclr => areset, ena => '1' );

    -- expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged(ADD,186)@38
    expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_a <= STD_LOGIC_VECTOR("0" & redist17_expPostRndFR_uid81_fpDivTest_b_12_outputreg0_q);
    expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_b <= STD_LOGIC_VECTOR("00000000" & redist8_ovfIncRnd_uid109_fpDivTest_b_1_q);
    expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_i <= expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_a;
    expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_a1 <= expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_i;
    expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_b1 <= (others => '0') WHEN redist12_extraUlp_uid103_fpDivTest_q_2_q = "0" ELSE expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_b;
    expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_o <= STD_LOGIC_VECTOR(UNSIGNED(expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_a1) + UNSIGNED(expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_b1));
    expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_q <= expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_o(7 downto 0);

    -- invExpXIsMax_uid43_fpDivTest(LOGICAL,42)@27
    invExpXIsMax_uid43_fpDivTest_q <= not (expXIsMax_uid38_fpDivTest_q);

    -- InvExpXIsZero_uid44_fpDivTest(LOGICAL,43)@27
    InvExpXIsZero_uid44_fpDivTest_q <= not (excZ_y_uid37_fpDivTest_q);

    -- excR_y_uid45_fpDivTest(LOGICAL,44)@27 + 1
    excR_y_uid45_fpDivTest_qi <= InvExpXIsZero_uid44_fpDivTest_q and invExpXIsMax_uid43_fpDivTest_q;
    excR_y_uid45_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excR_y_uid45_fpDivTest_qi, xout => excR_y_uid45_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- excXIYR_uid127_fpDivTest(LOGICAL,126)@28
    excXIYR_uid127_fpDivTest_q <= excI_x_uid27_fpDivTest_q and excR_y_uid45_fpDivTest_q;

    -- excXIYZ_uid126_fpDivTest(LOGICAL,125)@28
    excXIYZ_uid126_fpDivTest_q <= excI_x_uid27_fpDivTest_q and redist28_excZ_y_uid37_fpDivTest_q_2_q;

    -- expRExt_uid114_fpDivTest(BITSELECT,113)@26
    expRExt_uid114_fpDivTest_b <= STD_LOGIC_VECTOR(expFracPostRnd_uid76_fpDivTest_q(35 downto 25));

    -- expOvf_uid118_fpDivTest(COMPARE,117)@26 + 1
    expOvf_uid118_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((12 downto 11 => expRExt_uid114_fpDivTest_b(10)) & expRExt_uid114_fpDivTest_b));
    expOvf_uid118_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000" & cstAllOWE_uid18_fpDivTest_q));
    expOvf_uid118_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                expOvf_uid118_fpDivTest_o <= (others => '0');
            ELSE
                expOvf_uid118_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expOvf_uid118_fpDivTest_a) - SIGNED(expOvf_uid118_fpDivTest_b));
            END IF;
        END IF;
    END PROCESS;
    expOvf_uid118_fpDivTest_n(0) <= not (expOvf_uid118_fpDivTest_o(12));

    -- redist6_expOvf_uid118_fpDivTest_n_2(DELAY,201)
    redist6_expOvf_uid118_fpDivTest_n_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => expOvf_uid118_fpDivTest_n, xout => redist6_expOvf_uid118_fpDivTest_n_2_q, clk => clk, aclr => areset, ena => '1' );

    -- invExpXIsMax_uid29_fpDivTest(LOGICAL,28)@27
    invExpXIsMax_uid29_fpDivTest_q <= not (expXIsMax_uid24_fpDivTest_q);

    -- InvExpXIsZero_uid30_fpDivTest(LOGICAL,29)@27
    InvExpXIsZero_uid30_fpDivTest_q <= not (excZ_x_uid23_fpDivTest_q);

    -- excR_x_uid31_fpDivTest(LOGICAL,30)@27
    excR_x_uid31_fpDivTest_q <= InvExpXIsZero_uid30_fpDivTest_q and invExpXIsMax_uid29_fpDivTest_q;

    -- redist29_excR_x_uid31_fpDivTest_q_1(DELAY,224)
    redist29_excR_x_uid31_fpDivTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excR_x_uid31_fpDivTest_q, xout => redist29_excR_x_uid31_fpDivTest_q_1_q, clk => clk, aclr => areset, ena => '1' );

    -- excXRYROvf_uid125_fpDivTest(LOGICAL,124)@28
    excXRYROvf_uid125_fpDivTest_q <= redist29_excR_x_uid31_fpDivTest_q_1_q and excR_y_uid45_fpDivTest_q and redist6_expOvf_uid118_fpDivTest_n_2_q;

    -- excXRYZ_uid124_fpDivTest(LOGICAL,123)@28
    excXRYZ_uid124_fpDivTest_q <= redist29_excR_x_uid31_fpDivTest_q_1_q and redist28_excZ_y_uid37_fpDivTest_q_2_q;

    -- excRInf_uid128_fpDivTest(LOGICAL,127)@28 + 1
    excRInf_uid128_fpDivTest_qi <= excXRYZ_uid124_fpDivTest_q or excXRYROvf_uid125_fpDivTest_q or excXIYZ_uid126_fpDivTest_q or excXIYR_uid127_fpDivTest_q;
    excRInf_uid128_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excRInf_uid128_fpDivTest_qi, xout => excRInf_uid128_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- xRegOrZero_uid121_fpDivTest(LOGICAL,120)@27 + 1
    xRegOrZero_uid121_fpDivTest_qi <= excR_x_uid31_fpDivTest_q or excZ_x_uid23_fpDivTest_q;
    xRegOrZero_uid121_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => xRegOrZero_uid121_fpDivTest_qi, xout => xRegOrZero_uid121_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- regOrZeroOverInf_uid122_fpDivTest(LOGICAL,121)@28
    regOrZeroOverInf_uid122_fpDivTest_q <= xRegOrZero_uid121_fpDivTest_q and excI_y_uid41_fpDivTest_q;

    -- expUdf_uid115_fpDivTest(COMPARE,114)@26 + 1
    expUdf_uid115_fpDivTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000" & GND_q));
    expUdf_uid115_fpDivTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((12 downto 11 => expRExt_uid114_fpDivTest_b(10)) & expRExt_uid114_fpDivTest_b));
    expUdf_uid115_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                expUdf_uid115_fpDivTest_o <= (others => '0');
            ELSE
                expUdf_uid115_fpDivTest_o <= STD_LOGIC_VECTOR(SIGNED(expUdf_uid115_fpDivTest_a) - SIGNED(expUdf_uid115_fpDivTest_b));
            END IF;
        END IF;
    END PROCESS;
    expUdf_uid115_fpDivTest_n(0) <= not (expUdf_uid115_fpDivTest_o(12));

    -- redist7_expUdf_uid115_fpDivTest_n_2(DELAY,202)
    redist7_expUdf_uid115_fpDivTest_n_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => expUdf_uid115_fpDivTest_n, xout => redist7_expUdf_uid115_fpDivTest_n_2_q, clk => clk, aclr => areset, ena => '1' );

    -- regOverRegWithUf_uid120_fpDivTest(LOGICAL,119)@28
    regOverRegWithUf_uid120_fpDivTest_q <= redist7_expUdf_uid115_fpDivTest_n_2_q and redist29_excR_x_uid31_fpDivTest_q_1_q and excR_y_uid45_fpDivTest_q;

    -- zeroOverReg_uid119_fpDivTest(LOGICAL,118)@28
    zeroOverReg_uid119_fpDivTest_q <= redist30_excZ_x_uid23_fpDivTest_q_2_q and excR_y_uid45_fpDivTest_q;

    -- excRZero_uid123_fpDivTest(LOGICAL,122)@28 + 1
    excRZero_uid123_fpDivTest_qi <= zeroOverReg_uid119_fpDivTest_q or regOverRegWithUf_uid120_fpDivTest_q or regOrZeroOverInf_uid122_fpDivTest_q;
    excRZero_uid123_fpDivTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excRZero_uid123_fpDivTest_qi, xout => excRZero_uid123_fpDivTest_q, clk => clk, aclr => areset, ena => '1' );

    -- concExc_uid132_fpDivTest(BITJOIN,131)@29
    concExc_uid132_fpDivTest_q <= excRNaN_uid131_fpDivTest_q & excRInf_uid128_fpDivTest_q & excRZero_uid123_fpDivTest_q;

    -- excREnc_uid133_fpDivTest(LOOKUP,132)@29 + 1
    excREnc_uid133_fpDivTest_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                excREnc_uid133_fpDivTest_q <= "01";
            ELSE
                CASE (concExc_uid132_fpDivTest_q) IS
                    WHEN "000" => excREnc_uid133_fpDivTest_q <= "01";
                    WHEN "001" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN "010" => excREnc_uid133_fpDivTest_q <= "10";
                    WHEN "011" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN "100" => excREnc_uid133_fpDivTest_q <= "11";
                    WHEN "101" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN "110" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN "111" => excREnc_uid133_fpDivTest_q <= "00";
                    WHEN OTHERS => -- unreachable
                                   excREnc_uid133_fpDivTest_q <= (others => '-');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist5_excREnc_uid133_fpDivTest_q_9(DELAY,200)
    redist5_excREnc_uid133_fpDivTest_q_9 : dspba_delay
    GENERIC MAP ( width => 2, depth => 8, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => excREnc_uid133_fpDivTest_q, xout => redist5_excREnc_uid133_fpDivTest_q_9_q, clk => clk, aclr => areset, ena => '1' );

    -- expRPostExc_uid141_fpDivTest(MUX,140)@38
    expRPostExc_uid141_fpDivTest_s <= redist5_excREnc_uid133_fpDivTest_q_9_q;
    expRPostExc_uid141_fpDivTest_combproc: PROCESS (expRPostExc_uid141_fpDivTest_s, cstAllZWE_uid20_fpDivTest_q, expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_q, cstAllOWE_uid18_fpDivTest_q)
    BEGIN
        CASE (expRPostExc_uid141_fpDivTest_s) IS
            WHEN "00" => expRPostExc_uid141_fpDivTest_q <= cstAllZWE_uid20_fpDivTest_q;
            WHEN "01" => expRPostExc_uid141_fpDivTest_q <= expFracPostRndInc_uid110_fpDivTest_expRPreExc_uid112_fpDivTest_merged_q;
            WHEN "10" => expRPostExc_uid141_fpDivTest_q <= cstAllOWE_uid18_fpDivTest_q;
            WHEN "11" => expRPostExc_uid141_fpDivTest_q <= cstAllOWE_uid18_fpDivTest_q;
            WHEN OTHERS => expRPostExc_uid141_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid134_fpDivTest(CONSTANT,133)
    oneFracRPostExc2_uid134_fpDivTest_q <= "00000000000000000000001";

    -- fracPostRndFPostUlp_uid106_fpDivTest(BITSELECT,105)@37
    fracPostRndFPostUlp_uid106_fpDivTest_in <= fracRPreExcExt_uid105_fpDivTest_q(22 downto 0);
    fracPostRndFPostUlp_uid106_fpDivTest_b <= fracPostRndFPostUlp_uid106_fpDivTest_in(22 downto 0);

    -- redist9_fracPostRndFPostUlp_uid106_fpDivTest_b_1(DELAY,204)
    redist9_fracPostRndFPostUlp_uid106_fpDivTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => fracPostRndFPostUlp_uid106_fpDivTest_b, xout => redist9_fracPostRndFPostUlp_uid106_fpDivTest_b_1_q, clk => clk, aclr => areset, ena => '1' );

    -- redist11_fracPostRndFT_uid104_fpDivTest_b_2(DELAY,206)
    redist11_fracPostRndFT_uid104_fpDivTest_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => redist10_fracPostRndFT_uid104_fpDivTest_b_1_q, xout => redist11_fracPostRndFT_uid104_fpDivTest_b_2_q, clk => clk, aclr => areset, ena => '1' );

    -- fracRPreExc_uid107_fpDivTest(MUX,106)@38
    fracRPreExc_uid107_fpDivTest_s <= redist12_extraUlp_uid103_fpDivTest_q_2_q;
    fracRPreExc_uid107_fpDivTest_combproc: PROCESS (fracRPreExc_uid107_fpDivTest_s, redist11_fracPostRndFT_uid104_fpDivTest_b_2_q, redist9_fracPostRndFPostUlp_uid106_fpDivTest_b_1_q)
    BEGIN
        CASE (fracRPreExc_uid107_fpDivTest_s) IS
            WHEN "0" => fracRPreExc_uid107_fpDivTest_q <= redist11_fracPostRndFT_uid104_fpDivTest_b_2_q;
            WHEN "1" => fracRPreExc_uid107_fpDivTest_q <= redist9_fracPostRndFPostUlp_uid106_fpDivTest_b_1_q;
            WHEN OTHERS => fracRPreExc_uid107_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracRPostExc_uid137_fpDivTest(MUX,136)@38
    fracRPostExc_uid137_fpDivTest_s <= redist5_excREnc_uid133_fpDivTest_q_9_q;
    fracRPostExc_uid137_fpDivTest_combproc: PROCESS (fracRPostExc_uid137_fpDivTest_s, paddingY_uid15_fpDivTest_q, fracRPreExc_uid107_fpDivTest_q, oneFracRPostExc2_uid134_fpDivTest_q)
    BEGIN
        CASE (fracRPostExc_uid137_fpDivTest_s) IS
            WHEN "00" => fracRPostExc_uid137_fpDivTest_q <= paddingY_uid15_fpDivTest_q;
            WHEN "01" => fracRPostExc_uid137_fpDivTest_q <= fracRPreExc_uid107_fpDivTest_q;
            WHEN "10" => fracRPostExc_uid137_fpDivTest_q <= paddingY_uid15_fpDivTest_q;
            WHEN "11" => fracRPostExc_uid137_fpDivTest_q <= oneFracRPostExc2_uid134_fpDivTest_q;
            WHEN OTHERS => fracRPostExc_uid137_fpDivTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- divR_uid144_fpDivTest(BITJOIN,143)@38
    divR_uid144_fpDivTest_q <= redist4_sRPostExc_uid143_fpDivTest_q_9_q & expRPostExc_uid141_fpDivTest_q & fracRPostExc_uid137_fpDivTest_q;

    -- xOut(GPOUT,4)@38
    q <= divR_uid144_fpDivTest_q;

END normal;
