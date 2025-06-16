#!/bin/bash

# This script listens for bspwm fullscreen events and closes/opens
# the correct eww bar ONLY on the specific monitor where the event occurs.

EWW_CONFIG="$HOME/.config/eww/bar"

# --- Configuration ---
# Add your EWW bar names here in the same order as your monitors
# are listed by `bspc query -M --names`.
# For example, if `bspc query -M --names` outputs:
# DP-1
# HDMI-A-0
# Then `bar_names[0]` ("primary") is for DP-1 and `bar_names[1]` ("secondary") is for HDMI-A-0.

bar_names=("primary" "secondary")

# ---------------------

# report | monitor | desktop | node
bspc subscribe node_state | while read -r _ _ desktop_id node_id state status; do

    # We only care about fullscreen state changes
    if [[ "$state" != "fullscreen" ]]; then
        continue
    fi

    # Get the name of the monitor for the node that triggered the event
    monitor_name=$(bspc query -M --names -n "$node_id")
    
    # If we couldn't find a monitor for the node, skip
    [[ -z "$monitor_name" ]] && continue

    # Get an ordered list of all connected monitors
    mapfile -t all_monitors < <(bspc query -M --names)

    
    # Find the index (screen number) of our monitor
    screen_index=-1
    for i in "${!all_monitors[@]}"; do
       if [[ "${all_monitors[$i]}" == "$monitor_name" ]]; then
           screen_index=$i
           break
       fi
    done

    # If the monitor was not found in the list, skip
    (( screen_index < 0 )) && continue

    # Get the corresponding bar name from our ordered array
    bar_name=${bar_names[$screen_index]}

    # If no bar is defined for this screen index, skip
    [[ -z "$bar_name" ]] && continue

    if [[ "$status" == "on" ]]; then
        # A window went fullscreen, close the bar on its monitor.
        eww -c "$EWW_CONFIG" close "$bar_name"
    elif [[ "$status" == "off" ]]; then
        # A window exited fullscreen. Before opening the bar,
        # we must check if any *other* window is still fullscreen on that same monitor.
        # If this command returns an empty string, no windows are fullscreen there.
        if [[ -z "$(bspc query -N -n .fullscreen -m "$monitor_name")" ]]; then
             # No other fullscreen windows exist on this monitor, so open the bar again.
             # NOTE: This assumes your eww widget is named "bar".
             # If it's named something else, change it in the command below.
             eww -c "$EWW_CONFIG" open bar --screen "$screen_index" --id "$bar_name"
        fi
    fi
done
