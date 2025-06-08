#!/bin/bash
# uses rmpc for controlling media song player

MAX_LEN=30 # Set the maximum length for the song title

# Execute the rmpc status command and parse its JSON output with jq
status_output=$(rmpc status 2> /dev/null)
song_output=$(rmpc song 2> /dev/null)

state=$(echo "$status_output" | jq -r '.state')
elapsed_seconds=$(echo "$status_output" | jq '.elapsed.secs')
duration_seconds=$(echo "$status_output" | jq '.duration.secs')

title_song=$(echo "$song_output" | jq '.metadata.title' | tr -d '\"')

if [ ${#title_song} -gt $MAX_LEN ]; then
  truncated_title="$(echo "$title_song" | cut -c1-$MAX_LEN)..."
else
  truncated_title="$title_song"
fi

prev_button="%{A1:rmpc prev:}%{T2}󰒮%{T-}%{A}"
next_button="%{A1:rmpc next:}%{T2}󰒭%{T-}%{A}"

playing_state="%{A1:rmpc pause:}%{A4:rmpc volume +5:}%{A5:rmpc volume -5:}${truncated_title}%{A}%{A}%{A}"

case "${state}" in
  Play)
    echo "$prev_button $playing_state $next_button"
    ;;
  Pause)
    echo "$prev_button %{A1:rmpc play:}${truncated_title}%{A} $next_button"
    ;;
  Stop)
    echo "$prev_button {A1:rmpc play:}${truncated_title}%{A} $next_button"
    ;;
  *)
    # If rmpc is not running, status_output will be empty
    if [ -z "$state" ]; then
      echo "Media is Inactive"
    else
      echo "Error"
      exit 1
    fi
    ;;
esac
