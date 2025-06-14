#!/bin/bash

# Function to get the current volume and mute status, then print it.
get_and_print_volume() {
    # Get the mute status for the default sink (e.g., 'yes' or 'no').
    MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '[0-9]+(?=%)' | head -n 1)

    printf '{"volume": "%s", "muted": "%s"}\n' "$VOLUME" "$MUTE_STATUS"
}

if [[ "$#" -lt 1 ]] || [[ "$#" -gt 2 ]]; then
  echo "Invalid amount argument"
  echo "Usage: $0 < subscribe | set-volume {up | down}"
  exit 1
else
  case "$1" in
    subscribe)
      get_and_print_volume 
      pactl subscribe | grep --line-buffered 'on sink' | while read -r event; do
        get_and_print_volume
      done
      ;;
    set-volume)
      if [[ "$2" == "up" ]]; then
        VOLUME="+5%"
      else
        VOLUME="-5%"
      fi
      pactl set-sink-volume @DEFAULT_SINK@ $VOLUME
      ;;
    *)
      echo "Invalid argument"
      exit 1
      ;;
  esac
fi
