#!/bin/bash

output_file=$1
sampling_period=$2

# Get energy vals
while true; do
    start=$(date +%s.%N)

    sum_0=$(powercap-info intel-rapl -z 0 -j)
    sum_1=$(powercap-info intel-rapl -z 1 -j)
    core_0_val=$(powercap-info intel-rapl -z 0:0 -j)
    core_1_val=$(powercap-info intel-rapl -z 1:0 -j)
    dram_0_val=$(powercap-info intel-rapl -z 0:1 -j)
    dram_1_val=$(powercap-info intel-rapl -z 1:1 -j)

    epoch_time=$(date +%s)

    csv_str="$epoch_time,$sum_0,$sum_1,$core_0_val,$core_1_val,$dram_0_val,$dram_1_val"

    echo $csv_str >> $output_file

    end=$(date +%s.%N)

    runtime=$(echo "$end - $start" | bc)
    sleeptime=$(echo "$sampling_period - $runtime" | bc)

    if (( $(echo "$sleeptime > 0" | bc -l) )); then
        sleep "$sleeptime"
    fi
done
