#!/bin/sh
# sb-ram
ram_perc=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100.0}')
printf " %s%%" "$ram_perc"
