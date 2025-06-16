#!/bin/bash
# uses rmpc for controlling media song player

MAX_LEN=30 # Set the maximum length for the song title

if [[ "$#" -lt 1 ]] || [[ "$#" -gt 2 ]]; then
  echo "Invalid amount argument"
  echo "Usage: $0 <info | volume {up | down}>"
  exit 1
fi

# Get_info()
get_info() {
  # Execute the rmpc status command and parse its JSON output with jq
  status_output=$(rmpc status 2> /dev/null)
  song_output=$(rmpc song 2> /dev/null)
  
  # state: Play || Pause || Stop
  state=$(echo "$status_output" | jq -r '.state')
  
  title_song=$(echo "$song_output" | jq '.metadata.title' | tr -d '\"')
  
  if [ ${#title_song} -gt $MAX_LEN ]; then
    truncated_title="$(echo "$title_song" | cut -c1-$MAX_LEN)..."
  else
    truncated_title="$title_song"
  fi
  
  printf '{"title": "%s", "state": "%s"}\n' "$truncated_title" "$state"
}


set_volume() {
  case "$2" in
    up) 
      mpc -q volume +5
      ;;
    down)
      mpc -q volume -5
      ;; 
    *)
      echo "Unknown command"
      exit 1
      ;;
  esac 
}

case "$1" in
  info)
    get_info 
    ;;
  volume)
    set_volume $@ # Pass all arguments to it
    ;;
    *)
    echo "Invalid argument"
    echo "Usage: $0 <info | volume {up | down}>"
    exit 1
    ;;
esac 
