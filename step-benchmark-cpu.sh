#!/bin/bash

log_file=$1
step_size=$2

max_workers=$(nproc --all)

i=1
while true; do
    if [ $i -gt $max_workers ]; then
        break
    fi

    epoch=$(date +%s)

    # Log to file
    echo "$epoch,$i" >> $log_file
    stress-ng -c $i -t $step_size

    i=$(($i+1))
done
