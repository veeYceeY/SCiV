#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue May 26 11:54:37 IST 2020
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 93eb4bf201354d728bcfd11a6bab2a78 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_sciv_core_behav xil_defaultlib.tb_sciv_core -log elaborate.log"
xelab -wto 93eb4bf201354d728bcfd11a6bab2a78 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_sciv_core_behav xil_defaultlib.tb_sciv_core -log elaborate.log

