#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "This script must be run as root"
  exit
fi


# start rapl logging
output_folder=$1
mkdir -p $output_folder

./log-rapl-power.sh $output_folder/log-rapl.csv 1 &
bg_pid=$!

# Step Benchmark CPU
./step-benchmark-cpu.sh $output_folder/log-step-cpu.csv 60
sleep 60
# Step Benchmark Mem
./step-benchmark-mem.sh $output_folder/log-step-mem.csv 60
sleep 60
# Step Benchmark
./step-benchmark.sh $output_folder/log-step.csv 60
sleep 60

# Step Powerlim CPU
./step-powerlim-benchmark-cpu.sh $output_folder/log-step-powerlim-cpu.csv 60
sleep 60
# Step Powerlim Mem
./step-powerlim-benchmark-mem.sh $output_folder/log-step-powerlim-mem.csv 60
sleep 60
# Step Powerlim
./step-powerlim-benchmark.sh $output_folder/log-step-powerlim.csv 60
sleep 60

kill $bg_pid
