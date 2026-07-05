#!/usr/bin/env bash

# Get the number of logical CPU cores
CORE_COUNT=$(sysctl -n hw.logicalcpu)

# Sum up the CPU usage of all active processes and normalize to 0-100%
CPU_PERCENT=$(ps -A -o %cpu | awk -v cores="$CORE_COUNT" '{s+=$1} END {printf "%.1f%%\n", s / cores}')

sketchybar --set "$NAME" label="$CPU_PERCENT"
