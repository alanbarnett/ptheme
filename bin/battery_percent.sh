#!/bin/sh

# Checks the existence of a file that contains the battery percentage, and cats
# it.

BATTERY_FILE="/sys/class/power_supply/BAT0/capacity"
[ -f "$BATTERY_FILE" ] && cat "$BATTERY_FILE"
