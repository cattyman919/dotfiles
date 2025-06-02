#!/bin/sh

status_char=$(cat /sys/class/power_supply/BAT0/status | head -c 1)

case "$status_char" in
C) printf "󰂄";; # Charging
D) printf "󰁿";; # Discharging (though main battery icon shows this too)
N) printf "󱞜";; # Neutral
*) printf "%s" "$status_char";;
esac

