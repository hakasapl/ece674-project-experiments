#!/bin/bash

output_file=$1
sampling_period=$2

# Get energy vals
while true; do
    start=$(date +%s.%N)

    core_0_val=$(rapl-info -p 0 -z 0 -j)
    core_1_val=$(rapl-info -p 1 -z 0 -j)
    dram_0_val=$(rapl-info -p 0 -z 1 -j)
    dram_1_val=$(rapl-info -p 1 -z 1 -j)

    epoch_time=$(date +%s)

    csv_str="$epoch_time,$core_0_val,$core_1_val,$dram_0_val,$dram_1_val"

    echo $csv_str >> $output_file

    end=$(date +%s.%N)

    runtime=$(echo "$end - $start" | bc)
    sleeptime=$(echo "$sampling_period - $runtime" | bc)

    if (( $(echo "$sleeptime > 0" | bc -l) )); then
        sleep "$sleeptime"
    fi
done
