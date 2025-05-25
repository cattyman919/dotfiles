#!/bin/sh
# sb-battery (assumes BAT0)
capacity=$(cat /sys/class/power_supply/BAT0/capacity)
printf " %s%%" "$capacity"
