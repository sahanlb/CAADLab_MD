// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



`timescale 1 ps / 1 ps

module FIFO2_M20K_fifo2_180_2eednqa #(
    // Variant
    parameter SCFIFO_MODE               = 1,
    parameter DATAWIDTH                 = 32,
    parameter RAM_BLK_TYPE              = "M20K",
    parameter USEDWIDTH                 = (RAM_BLK_TYPE == "M20K")? 9: 5,
    parameter USE_ACLR_PORT             = 0,
    parameter WRPTR_GRY_SYNC_CHAIN_LEN  = 3,
    parameter RDPTR_GRY_SYNC_CHAIN_LEN  = 3,
    parameter RAM_WRPTR_DUPLICATE       = 0,
    parameter RAM_RDPTR_DUPLICATE       = 0
        
) (
    // SCFIFO
    input  wire                     clk,
    input  wire                     aclr,
    input  wire                     sclr,

    // DCFIFO
    input  wire                     w_clk,
    input  wire                     w_aclr,
    input  wire                     w_sclr,
    input  wire                     r_clk,
    input  wire                     r_aclr,
    input  wire                     r_sclr,

    //Common
    input  wire                     w_req,
    input  wire                     r_req,
    input  wire [DATAWIDTH-1:0]     w_data,
    output wire [USEDWIDTH-1:0]     w_usedw,
    output wire                     w_full,
    output wire                     w_ready,
    output wire [DATAWIDTH-1:0]     r_data,
    output wire [USEDWIDTH-1:0]     r_usedw,
    output wire                     r_empty,
    output wire                     r_valid
);


generate
    if(SCFIFO_MODE == 1) 
        begin
            alt_pipeline_dcfifo #(
                .DATAWIDTH                (DATAWIDTH),
                .RAM_BLK_TYPE             (RAM_BLK_TYPE),
                .USE_ACLR_PORT            (USE_ACLR_PORT),
                .RAM_WRPTR_DUPLICATE      (RAM_WRPTR_DUPLICATE),
                .RAM_RDPTR_DUPLICATE      (RAM_RDPTR_DUPLICATE)
            ) scfifo_mode (
                .w_clk        (clk),
                .w_aclr       (aclr),
                .w_sclr       (sclr),
                .r_clk        (clk),
                .r_aclr       (aclr),
                .r_sclr       (sclr),
                .w_req        (w_req),
                .w_data       (w_data),
                .w_usedw      (w_usedw),
                .w_full       (w_full),
                .w_ready      (w_ready),
                .r_req        (r_req),
                .r_data       (r_data),
                .r_usedw      (r_usedw),
                .r_empty      (r_empty),
                .r_valid      (r_valid),
                .test_sts_mon ()
            );
        end 
    else
        begin
            alt_pipeline_dcfifo #(
                .DATAWIDTH                (DATAWIDTH),
                .RAM_BLK_TYPE             (RAM_BLK_TYPE),
                .USE_ACLR_PORT            (USE_ACLR_PORT),
                .WRPTR_GRY_SYNC_CHAIN_LEN (WRPTR_GRY_SYNC_CHAIN_LEN),
                .RDPTR_GRY_SYNC_CHAIN_LEN (RDPTR_GRY_SYNC_CHAIN_LEN),
                .RAM_WRPTR_DUPLICATE      (RAM_WRPTR_DUPLICATE),
                .RAM_RDPTR_DUPLICATE      (RAM_RDPTR_DUPLICATE)
            ) dcfifo_mode (
                .w_clk        (w_clk),
                .w_aclr       (w_aclr),
                .w_sclr       (w_sclr),
                .r_clk        (r_clk),
                .r_aclr       (r_aclr),
                .r_sclr       (r_sclr),
                .w_req        (w_req),
                .w_data       (w_data),
                .w_usedw      (w_usedw),
                .w_full       (w_full),
                .w_ready      (w_ready),
                .r_req        (r_req),
                .r_data       (r_data),
                .r_usedw      (r_usedw),
                .r_empty      (r_empty),
                .r_valid      (r_valid),
                .test_sts_mon ()
            );
        end
endgenerate

endmodule
