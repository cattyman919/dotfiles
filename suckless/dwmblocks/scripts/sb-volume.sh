#!/bin/sh
# sb-volume
if amixer -q | grep -q off; then
    printf "MUTE"
else
    amixer -q | awk '/Front Left.*Playback/ {printf $5}' | sed "s/[][]//g"
fi
