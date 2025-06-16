#!/bin/bash

# Final corrected script to get MPD status as a single JSON line.
ALBUM_ART_PATH_A="/tmp/rmpc/music_cover_a.jpg"
ALBUM_ART_PATH_B="/tmp/rmpc/music_cover_b.jpg"

# A simple file to track which image was used last
TOGGLE_FILE="/tmp/rmpc/art_toggle"
mkdir -p "$(dirname "$ALBUM_ART_PATH_A")"

stopped_json='{"artist":"","title":"Nothing Playing","state":"stopped","random":"off","repeat":"off","single":"off"}'

get_status() {
    # Get the full multi-line status output from mpc.
    full_status=$(mpc status)

    # Check if the player state is "stopped".
    if ! echo "$full_status" | grep -q '\[playing\]\|\[paused\]'; then
        echo "$stopped_json"
        # Clean up both art files when stopped
        [ -f "$ALBUM_ART_PATH_A" ] && rm "$ALBUM_ART_PATH_A"
        [ -f "$ALBUM_ART_PATH_B" ] && rm "$ALBUM_ART_PATH_B"
        return
    fi

    # --- If playing or paused, gather all the info ---
    
    local current_art_path
    if [ -f "$TOGGLE_FILE" ]; then
        # Last used A, so we use B now and delete the toggle
        current_art_path="$ALBUM_ART_PATH_B"
        rm "$TOGGLE_FILE"
    else
        # Last used B (or none), so we use A and create the toggle
        current_art_path="$ALBUM_ART_PATH_A"
        touch "$TOGGLE_FILE"
    fi

    
    # Fetch the album art into the chosen file
    rmpc albumart --output "$current_art_path" > /dev/null 2>&1

    # 1. Get song artist and title using `mpc current`.
    song_json=$(mpc current -f '{"artist":"%artist%","title":"%title%"}')

    # 2. Parse the player state and modes from the `mpc status` output.
    state=$(echo "$full_status" | awk '/^\[/ {print $1}' | tr -d '[]')
    modes_line=$(echo "$full_status" | awk '/volume:/')

    # --- UPDATED PARSING LOGIC ---
    # This `awk` logic is more robust. It splits the string by "mode: "
    # and takes the first word of what's left, correctly capturing on/off/once.
    # The `${...:-off}` part sets a default value of "off" if parsing fails for any reason.
    raw_random=$(echo "$modes_line" | awk -F 'random: ' '{print $2}' | awk '{print $1}')
    random=${raw_random:-off}

    raw_repeat=$(echo "$modes_line" | awk -F 'repeat: ' '{print $2}' | awk '{print $1}')
    repeat=${raw_repeat:-off}

    raw_single=$(echo "$modes_line" | awk -F 'single: ' '{print $2}' | awk '{print $1}')
    single=${raw_single:-off}

    # 3. Use `jq` to safely merge the song data and the parsed status into a single JSON object.
    echo "$song_json" | jq \
        --arg state "$state" \
        --arg random "$random" \
        --arg repeat "$repeat" \
        --arg single "$single" \
        --arg album_art_path "$current_art_path" \
        '. + {state: $state, random: $random, repeat: $repeat, single: $single, album_art_path: $album_art_path}' |
        tr -d '\n' && echo "" # Ensure it's a single line
}

# Run once at the beginning to get the initial state.
get_status

# Use `idleloop` to efficiently wait for player-related events.
mpc idleloop player options | while read -r event; do
    get_status
done
