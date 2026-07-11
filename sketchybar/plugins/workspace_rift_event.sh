#!/usr/bin/env bash

source "$HOME/.config/sketchybar/theme/colors.sh"

RIFT_CLI="/opt/homebrew/bin/rift-cli"

if [ "$SENDER" = "workspace_changed" ]; then
  if [ "$NAME" = "$RIFT_WORKSPACE_NAME" ]; then
    # Active: Bright accent background, dark contrasting text
    sketchybar --animate tanh 5 --set "$NAME" \
      background.color=$BLUE \
      label.color=$TEXT_ACTIVE
  else
    # Inactive: Transparent background, dimmed text to reduce visual noise
    sketchybar --animate tanh 5 --set "$NAME" \
      background.color=$TRANSPARENT \
      label.color=$WHITE
  fi
elif [ "$SENDER" = "mouse.clicked" ] && [ "$BUTTON" = "left" ]; then
  # Extract the 1-based workspace number from the item name "Workspace N"
  # and switch to the corresponding 0-based rift workspace index.
  workspace_index=$(echo "$NAME" | awk '{print $2}')
  if [ -n "$workspace_index" ]; then
    "$RIFT_CLI" execute workspace switch $((workspace_index - 1))
  fi
fi
