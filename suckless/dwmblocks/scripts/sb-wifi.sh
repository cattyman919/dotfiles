#!/bin/sh
# sb-wifi (assumes wlan0)
essid=$(iwgetid -r wlan0)
if [ -n "$essid" ]; then
    printf "  %s" "$essid"
else
    printf "  n/a"
fi
