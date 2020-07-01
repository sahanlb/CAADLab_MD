# PLL Parameters

#USER W A R N I N G !
#USER The PLL parameters are statically defined in this
#USER file at generation time!
#USER To ensure timing constraints and timing reports are correct, when you make 
#USER any changes to the PLL component using the Qsys,
#USER apply those changes to the PLL parameters in this file

set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_corename eSRAM_test_altera_iopll_180_gwcwgdi

set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data [dict create]
set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data [dict create]
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|pll_cascade_in
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in node_type pin
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in port_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in port_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in is_fpga_pin false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in is_main_refclk true
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in name "__inst_name___refclk"
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in period 10.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_base_clock_data cascade_in half_period 5.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll~ncntr_reg
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock node_type register
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock is_valid false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock name "__inst_name___n_cnt_clk"
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock src refclk
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock multiply_by 1
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock divide_by 1
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock phase 0.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data n_cnt_clock duty_cycle 50
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|vcoph\[0\]
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph node_type pin
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph is_valid false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph name "__inst_name___vcoph"
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph src cascade_in
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph multiply_by 10
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph divide_by 1
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph phase 0
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data vcoph duty_cycle 50
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|lvds_clk\[0\]
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 node_type pin
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 is_valid false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 name "__inst_name___fclk0"
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 src cascade_in
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 multiply_by 10
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 divide_by 2
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 phase 0.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 duty_cycle 50
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds0 counter_index 0
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|extclk_output\[0\]
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 node_type pin
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 is_valid false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 name "__inst_name___extclk0"
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 src cascade_in
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 multiply_by 10
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 divide_by 2
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 phase 0.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 duty_cycle 50
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk0 counter_index 0
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|extclk_output\[1\]
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 node_type pin
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 is_valid false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 name "__inst_name___extclk1"
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 src cascade_in
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 multiply_by 10
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 divide_by 2
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 phase 0.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 duty_cycle 50
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data extclk1 counter_index 0
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|loaden\[0\]
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 node_type pin
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 is_valid false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 name "__inst_name___loaden0"
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 src cascade_in
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 multiply_by 10
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 divide_by 2
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 phase 0.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 duty_cycle 50
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 counter_index 1
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 through_pin __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|lock
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data lvds1 max_delay 4.0
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk\[2\]
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 node_type pin
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 is_valid false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 name __inst_name___outclk2
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 src cascade_in
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 multiply_by 10
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 divide_by 2
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 phase 0.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 duty_cycle 50
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk2 counter_index 2
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk\[3\]
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 node_type pin
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 is_valid false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 name __inst_name___outclk3
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 src cascade_in
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 multiply_by 10
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 divide_by 2
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 phase 0.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 duty_cycle 50
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk3 counter_index 3
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 pattern __inst_name__|stratix10_altera_iopll_i|s10_iopll.fourteennm_pll|outclk\[4\]
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 node_type pin
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 pin_id ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 pin_node_name ""
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 is_valid false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 exists false
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 name __inst_name___outclk4
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 src cascade_in
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 multiply_by 10
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 divide_by 2
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 phase 0.000
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 duty_cycle 50
dict set ::GLOBAL_top_eSRAM_test_altera_iopll_180_gwcwgdi_gen_clock_data outclk4 counter_index 4
