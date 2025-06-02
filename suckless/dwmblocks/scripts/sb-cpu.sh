#!/bin/sh
# sb-cpu
# Calculates CPU usage as (100 - idle_percentage)
# LC_ALL=C ensures consistent output for awk regardless of system locale.

idle=$(LC_ALL=C mpstat | awk '/all/ {printf $NF}')
busy=$(echo "100 - $idle" | bc)
printf " %.0f%%" "$busy"
