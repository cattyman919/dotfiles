#!/usr/bin/env bash

set -u

## COLORS
RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
RESET=$'\e[0m'

fail(){
  local err_message=$1
  echo "${RED}[ERROR] $err_message${RESET}"
  exit 1
}

usage(){
  cat << EOF >&2
  Usage: $(basename "$0") [OPTIONS]

  A script to sync with youtube playlist. Will download audio files and sync to your "$HOME/music" by default. Playlist batch file uses this https://export-youtube-playlist.vercel.app/tools/youtube-playlist-link-extractor

  Options:
    -d TARGET_DIRECTORY specifies the directory you want to sync your music.
    -p TARGET_PLAYLIST specifies the batch file
    -v verbose
    -h help
EOF
}

DEPENDENCIES=( yt-dlp ffmpeg ffprobe )

for dependency in "${DEPENDENCIES[@]}"; do
  if ! command -v "$dependency" &> /dev/null; then
    fail "Command $dependency does not exist"
  fi
done

VERBOSE=false
TARGET_PLAYLIST="./New-Music-Playlist.txt"
TARGET_DIRECTORY="$HOME/music"

while getopts 'hd:p:v' opt; do
  case "$opt" in 
    d) TARGET_DIRECTORY=${OPTARG};;
    p) TARGET_PLAYLIST=${OPTARG};;
    v) VERBOSE=true;;
    h) usage; exit 0;;
    *) usage >&2; exit 1;;
  esac
done
shift $((OPTIND -1))

if "$VERBOSE"; then
  echo "TARGET PLAYLIST: ${TARGET_PLAYLIST}"
  echo "TARGET DIRECTORY: ${TARGET_DIRECTORY}"
fi

# AUDIO_FORMAT="aac"
CONCURRENT=3
COMMAND_ARGUMENTS=(
  --progress 
  --newline 
  -N "${CONCURRENT}"  
  -P "$TARGET_DIRECTORY" 
  --batch-file "$TARGET_PLAYLIST"
  --color "always" 
  --extract-audio 
  --audio-quality 0
  --no-overwrites
  -o "[%(autonumber)03d] %(title)s.%(ext)s"
  --embed-thumbnail
  --embed-metadata
  --cookies-from-browser chromium
  --download-archive "$TARGET_DIRECTORY/downloaded.txt"
)

yt-dlp "${TARGET_PLAYLIST}" "${COMMAND_ARGUMENTS[@]}"
