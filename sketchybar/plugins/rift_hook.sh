#!/usr/bin/env bash

# Extract just the number from the name (e.g., "Workspace 3" -> "3")
PARSED_ID="${RIFT_WORKSPACE_NAME##* }"

# Log it just to be safe
echo "[$(date)] NAME: '$RIFT_WORKSPACE_NAME' | CLEAN_ID: '$PARSED_ID'" >>/tmp/rift_debug.log

# Trigger SketchyBar with the clean number
/opt/homebrew/bin/sketchybar --trigger workspace_changed RIFT_WORKSPACE_NAME="$RIFT_WORKSPACE_NAME"
