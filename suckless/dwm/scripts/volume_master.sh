#!/bin/bash

# Default settings
QUIET_MODE=false

get_volume_level() {
  amixer sget Master | grep "Left.*%" | awk '{print $5}' | sed 's/[^0-9]*//g'
}

get_mute() {
  amixer sget Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g'
}

show_help(){
  cat << EOF
Usage: $(basename "$0") [options] <action>

Actions:
  up, increase        Increase volume by 5%.
  down, decrease      Decrease volume by 5%.
  toggle_volume       Toggle Volume
  toggle_mic          Toggle Microphone

Options:
  -h, --help          Display this help message and exit.
  -q, --quiet         Quiet mode. Suppress output messages.

Examples:
  $(basename "$0") up
  $(basename "$0") --quiet decrease
  $(basename "$0") -h
EOF
}

# --- Option Parsing ---
# Reset OPTIND to ensure getopts works correctly if the script is sourced multiple times.
OPTIND=1

while getopts "hq" opt; do
  case "$opt" in 
    h)
      show_help
      exit 0
      ;;
    q)
      QUIET_MODE=true
      ;;
    \?)
      show_help
      exit 1
      ;;
  esac
done

# Shift off the options processed by getopts
shift $((OPTIND - 1))

if [ -z "$1" ]; then
  if [ "$QUIET_MODE" = false ]; then
    echo "Error: No action specified."
  fi
  show_help
  exit 1
fi

# convert args to lowercase
action=$(echo "$1" | tr '[:upper:]' '[:lower:]')

case "$action" in
  up|increase)
    amixer -q sset Master 5%+
    if [ "$QUIET_MODE" = false ]; then
      echo "Volume increased."
    fi
    ;;
  down|decrease)
    amixer -q sset Master 5%-
    if [ "$QUIET_MODE" = false ]; then
      echo "Volume decreased."
    fi
    ;;
  toggle_volume)
    amixer -q sset Master toggle
    if [ "$QUIET_MODE" = false ]; then
      echo "Volume toggled."
    fi
    ;;

  toggle_mic)
    amixer -q sset Capture toggle
    if [ "$QUIET_MODE" = false ]; then
      echo "Microphone toggled."
    fi
    ;;
  *)
    show_help
    exit 1
    ;;
esac

VOLUME_LEVEL=$(get_volume_level)
MUTE=$(get_mute)

if [[ $VOLUME_LEVEL == 0 || "$MUTE" == "off" ]]; then
  notify-send -a volumeMaster -t 1000 -i audio-volume-muted -h string:x-dunst-stack-tag:volume "Volume: Muted"
else
  notify-send -a volumeMaster -t 1000 -i audio-speakers -h int:value:$VOLUME_LEVEL -h string:x-dunst-stack-tag:volume "Volume: $VOLUME_LEVEL"
fi

exit 0
