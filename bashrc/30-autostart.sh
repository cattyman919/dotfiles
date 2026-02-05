# -----------------------------------------------------
# AUTOSTART
# -----------------------------------------------------

# -----------------------------------------------------
# Launch Hyprland when boot
# -----------------------------------------------------

if [[ "$(tty)" == "/dev/tty1" ]]; then
  pgrep Hyprland || start-hyprland
fi

# -----------------------------------------------------
# Launch dwm when boot
# -----------------------------------------------------

# if [[ "$(tty)" == "/dev/tty1" ]]; then
#    pgrep dwm || exec startx
# fi

# -----------------------------------------------------
# Launch bspwm when boot
# -----------------------------------------------------

# if [[ "$(tty)" == "/dev/tty1" ]]; then
#    pgrep bspwm || exec startx
# fi


# -----------------------------------------------------
# Fastfetch
# -----------------------------------------------------
if [[ $(tty) == *"pts"* ]]; then
    fastfetch
<<<<<<<< HEAD:bashrc/30-autostart
========
    # eval $(keychain --eval --quiet ~/.ssh/id_ed25519)
    # eval $(keychain --eval --quiet ~/.ssh/id_xlsmart)
>>>>>>>> e80536b (feat (bashrc): aliases & functions yazi):bashrc/30-autostart.sh
fi
# eval $(keychain --eval --quiet ~/.ssh/id_ed25519)
