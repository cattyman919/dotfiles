#!/bin/sh
# sb-battery-status (assumes BAT0)
status_char=$(cat /sys/class/power_supply/BAT0/status | head -c 1)
# You can make this more iconic if you wish:
case "$status_char" in
C) printf "🔌";; # Charging
D) printf "🔋";; # Discharging (though main battery icon shows this too)
N) printf "💯";; # Neutral
*) printf "%s" "$status_char";;
esac
# printf "%s" "$status_char" # Outputs C, D, F, etc.
