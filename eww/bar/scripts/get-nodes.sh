#!/bin/bash

monitor_node() {
  bspc subscribe node_stack | while read -r event node_id _ node_id2; do
     window_title=$(xprop -id "$node_id" WM_NAME | awk -F '"' '{print $2}')
     echo "$window_title"
  done
}

monitor_node 
