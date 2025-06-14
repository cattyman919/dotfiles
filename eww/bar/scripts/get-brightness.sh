#!/bin/sh

if [[ -z $1 ]]; then
  echo "Please enter an argument for the display"
  exit 1
fi

DEVICE="$1"

brightnessctl -d "$DEVICE" i | awk '/Current/ {print $4}' | tr -d '(%)'
