#!/bin/sh

# TODO make better usage message
function show_usage()
{
	echo "Takes the current battery percent as the first argument." 1>&2
}

# Quit script if we don't have exactly one argument
[ "$#" != "1" ] && show_usage && exit

# Set the file with the battery status, and quit if it doesn't exist
STATUS_FILE="/sys/class/power_supply/BAT0/status"
[ ! -f "$STATUS_FILE" ] && exit

PERCENT="$1"
STATUS="$(cat "$STATUS_FILE")"

# Define default color variables, if they aren't already set
[ -z "$BAT_PROMPT_COLOR_CHARGING" ] && BAT_PROMPT_COLOR_CHARGING="\e[1;35m"
[ -z "$BAT_PROMPT_COLOR_DYING" ] && BAT_PROMPT_COLOR_DYING="\e[1;5;31m"
[ -z "$BAT_PROMPT_COLOR_LOW" ] && BAT_PROMPT_COLOR_LOW="\e[1;31m"
[ -z "$BAT_PROMPT_COLOR_OKAY" ] && BAT_PROMPT_COLOR_OKAY="\e[1;33m"
[ -z "$BAT_PROMPT_COLOR_GOOD" ] && BAT_PROMPT_COLOR_GOOD="\e[1;32m"

if [ "$STATUS" == "Charging" ] || [ "$STATUS" == "Unknown" ]; then
	echo "$BAT_PROMPT_COLOR_CHARGING"
elif [ "$PERCENT" -lt "11" ]; then
	echo "$BAT_PROMPT_COLOR_DYING"
elif [ "$PERCENT" -lt "26" ]; then
	echo "$BAT_PROMPT_COLOR_LOW"
elif [ "$PERCENT" -lt "80" ]; then
	echo "$BAT_PROMPT_COLOR_OKAY"
else
	echo "$BAT_PROMPT_COLOR_GOOD"
fi
