#!/bin/bash

# --- Monitor Device Names ---
laptop="intel_backlight"
skydata_h24G30F="ddcci4"
G24f="ddcci1"

trap 'kill $(jobs -p)' EXIT

# --- Function to create and manage a single brightness slider ---
# This function will be run as a separate process for each monitor.
# It takes two arguments: 1. The device name, 2. The title for the window.
run_slider() {
    local device="$1"
    local title="$2"
    local tabnum="$3"

    # Get initial brightness settings for the specified device
    current_brightness=$(brightnessctl -d "$device" i | awk '/Current/ {print $4}' | tr -d '(%)')
    max_brightness=100

    # The core yad command piped to the while loop
    yad --scale --plug=$$ --tabnum="$tabnum"  --value="$current_brightness" --max-value="$max_brightness" \
        --min-value="0" --print-partial --vertical \
        --title="$title" |

    while read -r value; do
        brightnessctl -q -d "$device" s "${value%.*}%"
    done &
}

# --- Main Script Logic ---

# 1. LAUNCH THE MAIN NOTEBOOK WINDOW FIRST
# We define the tabs here and send it to the background with '&'.
# The key is the PID of the shell script itself, '$$'.
yad --notebook --key="$$" --title="Brightness Control Center" --text="Brightness Control Center" \
    --text-align=center --width=350 --height=550 --center --on-top --buttons-layout=center --escape-ok \
    --tab-pos=top \
    --tab="Laptop" \
    --tab="Skydata H24G30F" \
    --tab="G24F" &

YAD_PID=$!

run_slider "$laptop" "$$" 1 &
run_slider "$skydata_h24G30F" "$$" 2 &
run_slider "$G24f" "$$" 3 &

wait "$YAD_PID"
