#!/bin/bash

EWW_BIN="/usr/local/bin/eww"

brightness() {
    LOCK_FILE_BRIGHTNESS="$HOME/.cache/eww-brigthness.lock"
    
    run() {
        ${EWW_BIN} -c $HOME/.config/eww/bar open brightness_popup 
    }
    
    # Open widgets
    if [[ ! -f "$LOCK_FILE_BRIGHTNESS" ]]; then
        ${EWW_BIN} -c $HOME/.config/eww/bar close music_popup
        touch "$LOCK_FILE_BRIGHTNESS"
        run && echo "ok good!"
    else
        ${EWW_BIN} -c $HOME/.config/eww/bar close brightness_popup 
        rm "$LOCK_FILE_BRIGHTNESS" && echo "closed"
    fi
}

music() {
    LOCK_FILE_MUSIC="$HOME/.cache/eww-music.lock"
    
    run() {
        ${EWW_BIN} -c $HOME/.config/eww/bar open music_popup 
    }
    
    # Open widgets
    if [[ ! -f "$LOCK_FILE_MUSIC" ]]; then
        ${EWW_BIN} -c $HOME/.config/eww/bar close brightnes_popup
        touch "$LOCK_FILE_MUSIC"
        run && echo "ok good!"
    else
        ${EWW_BIN} -c $HOME/.config/eww/bar close music_popup 
        rm "$LOCK_FILE_MUSIC" && echo "closed"
    fi

}
case "$1" in
  brightness)
    brightness 
    ;;
  music)
    music
    ;;
  *)
    echo "Invalid Argument"
    echo "Usage: $0 <brigthness>"
    exit 1
    ;;
esac
