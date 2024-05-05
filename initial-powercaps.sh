#!/bin/bash
# Set Initial Powercaps

powercap-set intel-rapl -z 0:0 -c 0 -l 130000000
powercap-set intel-rapl -z 1:0 -c 0 -l 130000000
powercap-set intel-rapl -z 0:1 -c 0 -l 84000000
powercap-set intel-rapl -z 1:1 -c 0 -l 84000000
powercap-set intel-rapl -z 0:0 -e 1
powercap-set intel-rapl -z 0:1 -e 1
powercap-set intel-rapl -z 1:0 -e 1
powercap-set intel-rapl -z 1:1 -e 1

powercap-set intel-rapl -z 0 -c 0 -l 130000000
powercap-set intel-rapl -z 0 -c 1 -l 130000000
powercap-set intel-rapl -z 1 -c 0 -l 130000000
powercap-set intel-rapl -z 1 -c 1 -l 130000000
powercap-set intel-rapl -z 0 -c 0 -s 976
powercap-set intel-rapl -z 0 -c 1 -s 976
powercap-set intel-rapl -z 1 -c 0 -s 976
powercap-set intel-rapl -z 1 -c 1 -s 976

# Disable turbo boost
echo "1" > /sys/devices/system/cpu/intel_pstate/no_turbo
