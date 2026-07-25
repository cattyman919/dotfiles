#!/usr/bin/env bash

source "$HOME/.config/sketchybar/theme/colors.sh"
CONFIG_DIR="$HOME/.config/sketchybar"

# If FOCUSED_WORKSPACE isn't passed from the event (like on startup), fetch it manually
if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

# 1. Update Colors for Active vs Inactive
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  # Active: Bright background, dark contrasting text
  sketchybar --animate tanh 5 --set "$NAME" \
    background.color=$BLUE \
    label.color=$TEXT_ACTIVE
else
  # Inactive: Transparent background, white text
  sketchybar --animate tanh 5 --set "$NAME" \
    background.color=$TRANSPARENT \
    label.color=$WHITE
fi

# 2. Fetch App Icons for the Workspace
# apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
#
# icon_strip=""
# if [ "${apps}" != "" ]; then
#   while read -r app; do
#     icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
#   done <<<"${apps}"
# fi

sketchybar --set "$NAME"
