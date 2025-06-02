#! /bin/sh

options="Lock\0icon\x1fsystem-lock-screen\n"
options="${options}Suspend\0icon\x1fsystem-suspend\n" 
options="${options}Restart\0icon\x1fsystem-reboot\n"
options="${options}Power Off\0icon\x1fsystem-shutdown"

chosen=$(printf "$options" | rofi -sep '\n' -window-title "Power Menu" -dmenu -markup-rows -config ~/.config/rofi/power.rasi)

case "$chosen" in
  "Lock") slock ;;
  "Restart") reboot ;;
  "Suspend") systemctl suspend-then-hibernate ;;
  "Power Off") poweroff ;;
  *) exit 1 ;;
esac
