#!/bin/bash

get_brightness_level() {
  brightnessctl -d intel_backlight | grep Current | awk '{printf $4}' | tr -d '()'
}

if [ -z "$1" ]; then
  echo "Usage: $0 <inc|dec>"
  exit 1
fi

case "$1" in
inc)
  brightnessctl -q -e4 -n2 set 5%+
  ;;
dec)
  brightnessctl -q -e4 -n2 set 5%-
  ;;
*)
  echo "Usage: $0 <inc|dec>"
  exit 1
  ;;
esac
notify-send -a changeBrightness -t 1000 -i brightness -h int:value:$(get_brightness_level) -h string:x-dunst-stack-tag:brightness "Brigthness: $(get_brightness_level)"

exit 0
