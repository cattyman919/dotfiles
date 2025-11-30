#!/bin/bash
# uses rmpc for controlling media song player

MAX_LEN=30 # Set the maximum length for the song title

# Execute the rmpc status command and parse its JSON output with jq
status_output=$(rmpc status 2> /dev/null)
song_output=$(rmpc song 2> /dev/null)

state=$(echo "$status_output" | jq -r '.state')

title_song=$(echo "$song_output" | jq '.metadata.title' | tr -d '\"')

if [ ${#title_song} -gt $MAX_LEN ]; then
  truncated_title="$(echo "$title_song" | cut -c1-$MAX_LEN)..."
else
  truncated_title="$title_song"
fi

playing_state="%{A1:rmpc togglepause:}%{A4:rmpc volume +5:}%{A5:rmpc volume -5:}${truncated_title}%{A}%{A}%{A}"

if [ "$state" =  "Play" ] || [ "$state" =  "Pause" ]; then
  echo "$playing_state"

elif [ "$state" = "Stop" ]; then
  echo "%{A1:rmpc play:}${truncated_title}%{A}"

else
    if [ -z "$state" ]; then
      echo "Media is Inactive"
    else
      echo "Error"
      exit 1
    fi
fi
