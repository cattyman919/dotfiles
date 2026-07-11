#!/bin/sh

set -u

CONFIG_DIR="/Users/senohebat/.config/sketchybar"
THEME_DIR="$CONFIG_DIR/theme"
CACHE_FILE="/tmp/sketchybar_bluetooth_device"

source "$THEME_DIR/colors.sh"

ICON=""

# Hover events: show or hide the connected device name
if [ "$SENDER" = "mouse.entered" ]; then
  if [ -f "$CACHE_FILE" ]; then
    DEVICE_NAME=$(cat "$CACHE_FILE")
    if [ -n "$DEVICE_NAME" ]; then
      sketchybar --set "$NAME" label="$DEVICE_NAME"
    fi
  fi
  exit 0
fi

if [ "$SENDER" = "mouse.exited" ]; then
  sketchybar --set "$NAME" label=""
  exit 0
fi

# Discover the currently connected Bluetooth device
DEVICE_NAME=""

if command -v blueutil >/dev/null 2>&1; then
  DEVICE_NAME=$(blueutil --connected 2>/dev/null | head -n 1 | sed -n 's/.*name: \([^,]*\).*/\1/p')
else
  DEVICE_NAME=$(system_profiler SPBluetoothDataType -json 2>/dev/null | python3 -c '
import json, sys

def find_connected(data):
    try:
        items = data.get("SPBluetoothDataType", [])
        for item in items:
            for key in ["device_connected", "device_title", "device_paired"]:
                devices = item.get(key)
                if not devices or not isinstance(devices, dict):
                    continue
                for name, info in devices.items():
                    if not isinstance(info, dict):
                        continue
                    is_connected = str(info.get("device_isconnected", "")).lower() in ("attrib_yes", "yes")
                    is_connected = is_connected or str(info.get("device_connected", "")).lower() in ("yes", "true")
                    if is_connected:
                        return name
    except Exception:
        pass
    return ""

try:
    data = json.load(sys.stdin)
    print(find_connected(data))
except Exception:
    print("")
')
fi

if [ -z "$DEVICE_NAME" ]; then
  rm -f "$CACHE_FILE"
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

printf '%s' "$DEVICE_NAME" > "$CACHE_FILE"

sketchybar --set "$NAME" \
  drawing=on \
  icon="$ICON" \
  label=""
