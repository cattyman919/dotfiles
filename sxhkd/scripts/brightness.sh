#!/bin/bash

get_brightness_level(){
  xbacklight | awk '{printf "%.f", $0}'
}

if [ -z "$1" ]; then
  echo "Usage: $0 <inc|dec>"
  exit 1
fi

case "$1" in
  inc)
    xbacklight -inc 10
    ;;
  dec)
    xbacklight -dec 10
    ;;
  *)
    echo "Usage: $0 <inc|dec>"
    exit 1
    ;;
esac

notify-send -a changeBrightness -t 1000 -i brightness -h int:value:$(get_brightness_level) -h string:x-dunst-stack-tag:brightness "Brigthness: $(get_brightness_level)"

exit 0
