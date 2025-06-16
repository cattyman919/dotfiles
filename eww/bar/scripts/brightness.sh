#!/bin/sh

if [[ -z $1 ]] || [[ -z $2 ]]; then
  echo "Incorrect argument <info | set> <display name>"
  exit 1
fi

get_brightness_info() {
  DEVICE="$2"

  BRIGHTNESS_FILE="/sys/class/backlight/$DEVICE/brightness"

  CURRENT_PERCENT=$(brightnessctl -d "$DEVICE" | grep -o "(.*%)" | tr -d '()%')
  echo "$CURRENT_PERCENT"
  
  # Loop forever, waiting for the file to be modified
  while inotifywait -q -q -e modify "$BRIGHTNESS_FILE"; do
      # When a change occurs, get the new value
      CURRENT_PERCENT=$(brightnessctl -d "$DEVICE" | grep -o "(.*%)" | tr -d '()%')
      
      echo "$CURRENT_PERCENT"
  done
}

set_brightness() {
  DEVICE="$2"
  VALUE="$3"
  echo "$@" >> /tmp/eww_debug.log

  if [[ -z $3 ]]; then
    echo "Please enter the value for the brightness"
    exit 1
  fi

  brightnessctl -q -d "$DEVICE" s "${VALUE}%"
}

case "$1" in
  info)
    get_brightness_info $@

    ;;
  set)
    echo "Debugging on Setting" >> /tmp/eww_debug.log
    set_brightness $@
    ;;
  *)
    echo "Incorrect argument <info | set> <display name> {set: value}"
    exit 1
    ;;
esac

