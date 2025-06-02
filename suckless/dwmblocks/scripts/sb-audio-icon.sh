#!/bin/sh
# sb-audio-icon
if pactl list sinks | grep -q bluez; then
    printf "" # Bluetooth icon
else
    printf "" # Speaker icon
fi
