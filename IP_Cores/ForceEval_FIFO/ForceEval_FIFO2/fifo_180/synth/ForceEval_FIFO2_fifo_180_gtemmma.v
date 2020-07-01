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



// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module  ForceEval_FIFO2_fifo_180_gtemmma  (
    aclr,
    clock,
    data,
    rdreq,
    sclr,
    wrreq,
    almost_empty,
    almost_full,
    empty,
    full,
    q,
    usedw);

    input    aclr;
    input    clock;
    input  [112:0]  data;
    input    rdreq;
    input    sclr;
    input    wrreq;
    output   almost_empty;
    output   almost_full;
    output   empty;
    output   full;
    output [112:0]  q;
    output [8:0]  usedw;

    wire  sub_wire0;
    wire  sub_wire1;
    wire  sub_wire2;
    wire  sub_wire3;
    wire [112:0] sub_wire4;
    wire [8:0] sub_wire5;
    wire  almost_empty = sub_wire0;
    wire  almost_full = sub_wire1;
    wire  empty = sub_wire2;
    wire  full = sub_wire3;
    wire [112:0] q = sub_wire4[112:0];
    wire [8:0] usedw = sub_wire5[8:0];

    scfifo  scfifo_component (
                .aclr (aclr),
                .clock (clock),
                .data (data),
                .rdreq (rdreq),
                .sclr (sclr),
                .wrreq (wrreq),
                .almost_empty (sub_wire0),
                .almost_full (sub_wire1),
                .empty (sub_wire2),
                .full (sub_wire3),
                .q (sub_wire4),
                .usedw (sub_wire5),
                .eccstatus ());
    defparam
        scfifo_component.add_ram_output_register  = "ON",
        scfifo_component.almost_empty_value  = 1,
        scfifo_component.almost_full_value  = 1,
        scfifo_component.enable_ecc  = "FALSE",
        scfifo_component.intended_device_family  = "Stratix 10",
        scfifo_component.lpm_numwords  = 512,
        scfifo_component.lpm_showahead  = "OFF",
        scfifo_component.lpm_type  = "scfifo",
        scfifo_component.lpm_width  = 113,
        scfifo_component.lpm_widthu  = 9,
        scfifo_component.overflow_checking  = "ON",
        scfifo_component.underflow_checking  = "ON",
        scfifo_component.use_eab  = "ON";


endmodule


