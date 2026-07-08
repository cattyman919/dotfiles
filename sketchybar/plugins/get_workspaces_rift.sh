#!/usr/bin/env bash

RED='\033[31m'
RESET='\033[0m'

fail() {
  local msg=$1
  echo -e "$RED[ERROR] $msg$RESET"
  exit 1
}

DEPENDENCIES=(
  rift-cli
  jq
)

for dependency in "${DEPENDENCIES[@]}"; do
  if ! command -v "$dependency" >/dev/null 2>&1; then
    fail "dependency '$dependency' does not exist"
  fi
done

WORKSPACES="$(rift-cli query workspaces | jq -r)"

rift-cli query workspaces | jq -r '
  .[] 
  | [(.index + 1), .is_active]
  | @tsv
'
