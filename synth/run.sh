#!/bin/bash

quartus_sh -t RL_top.tcl

quartus_sh -t run_synth.tcl

quartus_fit RL_top
