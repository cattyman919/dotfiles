#!/bin/bash

# This function generates the JSON data for the workspaces
generate_workspaces() {
    local desktops=$(bspc query -D --names)
    local focused_desktop=$(bspc query -D -d focused --names)
    local occupied_desktops=$(bspc query -D -d .occupied --names)

    local json="["

    for d in $desktops; do
        local class="unoccupied" # Default class

        # Check if the desktop is in the list of occupied desktops
        if [[ "$occupied_desktops" =~ "$d" ]]; then
            class="occupied"
        fi
        
        # Check if it's the focused desktop, which overrides other states
        if [ "$d" = "$focused_desktop" ]; then
            class="focused"
        fi
        
        # Build the JSON object with the final class name
        json+=$(printf '{"name": "%s", "class": "%s"},' "$d" "$class")
    done

    json=${json%,} # Remove trailing comma
    json+="]"
    
    echo "$json"
}

# Run once for initial state
generate_workspaces

# Subscribe to events and re-run on every change
bspc subscribe report | while read -r _; do
    generate_workspaces
done
