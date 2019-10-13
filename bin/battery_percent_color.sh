#!/bin/sh

# TODO make better usage message
function show_usage()
{
	echo "usage: battery_percent_color.sh battery_percent
Takes the current battery percent as the first argument.
Prints the color it should be." 1>&2
}

# Quit script if we don't have exactly one argument
[ "$#" != "1" ] && show_usage && exit

# Set the file with the battery status, and quit if it doesn't exist
status_file="/sys/class/power_supply/BAT0/status"
[ ! -f "$status_file" ] && exit

battery_percent="$1"
battery_status="$(cat "$status_file")"

# Define default color variables, if they aren't already set
[ -z "$BATTERY_COLORS" ] && \
	BATTERY_COLORS=(124 160 196 202 208 214 220 184 148 112 76 40)
[ -z "$BATTERY_CHARGING_COLOR" ] && BATTERY_CHARGING_COLOR="13"

if [ "$battery_status" == "Charging" ] || [ "$battery_status" == "Unknown" ]; then
	color="$BATTERY_CHARGING_COLOR"
else
	color="${BATTERY_COLORS[$(( $battery_percent / 10 ))]}"
fi

echo "\e[38;5;${color}m"
