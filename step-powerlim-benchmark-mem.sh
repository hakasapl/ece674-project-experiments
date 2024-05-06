#!/bin/bash

log_file=$1
step_size=$2

workers=32
worker_size=128G

initial_power=10  # Watts
power_step=10  # Watts
final_power=80  # Watts

# Convert to uW
initial_power_u=$(($initial_power*1000000))
power_step_u=$(($power_step*1000000))
final_power_u=$(($final_power*1000000))

i=$initial_power_u
while true; do
    if [ $i -gt $final_power_u ]; then
        break
    fi

    # Set power caps (short and long)
    powercap-set intel-rapl -z 0:1 -c 0 -l $i
    powercap-set intel-rapl -z 1:1 -c 0 -l $i

    epoch=$(date +%s)

    # Log to file
    echo "$epoch,$i" >> $log_file
    stress-ng -m $workers --vm-bytes $worker_size -t $step_size

    i=$(($i+$power_step_u))
done

powercap-set intel-rapl -z 0:1 -c 0 -l 84000000
powercap-set intel-rapl -z 1:1 -c 0 -l 84000000
