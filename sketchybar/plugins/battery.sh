#!/bin/sh

set -u

CONFIG_DIR="/Users/senohebat/.config/sketchybar"
THEME_DIR="$CONFIG_DIR/theme"

source "$THEME_DIR/colors.sh"

# Changed \d to [0-9] so macOS grep can read it properly
PERCENTAGE="$(pmset -g batt | grep -Eo "[0-9]+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
[6-9][0-9] | 100)
  ICON="" COLOR="${DEFAULT}"
  ;;
[3-5][0-9])
  ICON="" COLOR="${YELLOW}"
  ;;
[1-2][0-9])
  ICON="" COLOR="${RED}"
  ;;
*) ICON="" COLOR="${RED}" ;;
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color="$COLOR" \
  label="${PERCENTAGE}%" \
  label.color="$COLOR"
