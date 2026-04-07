#!/bin/bash

# 1. Get the current wallpaper path from swww
# (Using print instead of printf ensures proper newline handling)
CURRENT_BG=$(swww query | awk '{print $9}')

# 2. Create a symbolic link pointing to that wallpaper
ln -sf "$CURRENT_BG" /tmp/current_lock_bg.jpg

# 3. Launch hyprlock
hyprlock
