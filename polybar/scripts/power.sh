#! /bin/sh

chosen=$(printf "Power Off\nRestart\nLock" | rofi -dmenu -i)

case "$chosen" in
  "Power Off") poweroff ;;
  "Restart") reboot ;;
  "Lock") slock ;;
  *) exit 1 ;;
esac

