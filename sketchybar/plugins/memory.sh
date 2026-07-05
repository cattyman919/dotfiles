#!/bin/sh

# Colors
DEFCOLOR="0x44FFFFFF"
ALERTCOLOR="0xAAFF0000"

ALERTVALUE=14

# Get the hardware page size (4096 for Intel, 16384 for Apple Silicon)
PAGE_SIZE=$(sysctl -n hw.pagesize)

# Extract exactly what Activity Monitor uses
PAGES_ANON=$(vm_stat | grep "Anonymous pages:" | awk '{print $3}' | tr -d '.')
PAGES_WIRED=$(vm_stat | grep "Pages wired down:" | awk '{print $4}' | tr -d '.')
PAGES_COMPRESSED=$(vm_stat | grep "Pages occupied by compressor:" | awk '{print $5}' | tr -d '.')

# Calculate total bytes
USED_BYTES=$(( (PAGES_ANON + PAGES_WIRED + PAGES_COMPRESSED) * PAGE_SIZE ))

# Convert to Gigabytes (Base 2 / 1024^3) and format to 2 decimal places
USED_GB=$(awk "BEGIN {printf \"%.2f\", $USED_BYTES / 1073741824}")

clr=""
if [ "$(echo "${USED_GB} > ${ALERTVALUE}" | bc)" -eq 1 ]; then
    clr="$ALERTCOLOR"
else
    clr="$DEFCOLOR"
fi

sketchybar --set "$NAME" label="${USED_GB} GB" icon.color="$clr" label.color="$clr"
