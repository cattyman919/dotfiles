#!/bin/sh

set -u

CONFIG_DIR="/Users/senohebat/.config/sketchybar"
THEME_DIR="$CONFIG_DIR/theme"

source "$THEME_DIR/colors.sh"

ICON=""

# Find the Wi-Fi hardware port dynamically
WIFI_DEVICE=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $2}')

if [ -z "$WIFI_DEVICE" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

SSID=$(networksetup -getairportnetwork "$WIFI_DEVICE" 2>/dev/null | sed -n 's/^Current Wi-Fi Network: //p')

if [ -n "$SSID" ]; then
  if [ ${#SSID} -gt 20 ]; then
    SSID="$(echo "$SSID" | cut -c1-17)..."
  fi

  sketchybar --set "$NAME" \
    drawing=on \
    icon="$ICON" \
    icon.color="${DEFAULT}" \
    label="$SSID" \
    label.color="${DEFAULT}"
else
  sketchybar --set "$NAME" \
    drawing=on \
    icon="$ICON" \
    icon.color="${RED}" \
    label="Off" \
    label.color="${RED}"
fi
