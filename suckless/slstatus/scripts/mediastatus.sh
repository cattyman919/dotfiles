#!/bin/sh

# Check if a player is running and playing
if playerctl status &> /dev/null && [ "$(playerctl status)" = "Playing" ]; then
    artist=$(playerctl metadata xesam:artist)
    title=$(playerctl metadata xesam:title)
    # Truncate if too long, adjust numbers as needed
    echo "$(echo "$artist - $title" | cut -c 1-50)"
elif playerctl status &> /dev/null && [ "$(playerctl status)" = "Paused" ]; then
    echo "Paused"
else
    echo "" # Output nothing if no player is active or stopped
fi
