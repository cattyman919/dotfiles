#!/usr/bin/env bash

source "$HOME/.config/sketchybar/theme/colors.sh"

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
fi
