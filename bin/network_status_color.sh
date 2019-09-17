#!/bin/sh

# Get a list of connected interfaces, by name
interfaces="$(ip -br addr | awk '/ UP /{ print $1 }')"

# Don't overwrite defined colors, but provide defaults
[ -z "$NET_PROMPT_COLOR_ETHERNET" ] && NET_PROMPT_COLOR_ETHERNET="\e[1;31m"
[ -z "$NET_PROMPT_COLOR_WIFI" ] && NET_PROMPT_COLOR_WIFI="\e[0;36m"
[ -z "$NET_PROMPT_COLOR_BOTH" ] && NET_PROMPT_COLOR_BOTH="\e[38;5;135m"
[ -z "$NET_PROMPT_COLOR_DOWN" ] && NET_PROMPT_COLOR_DOWN="\e[1;37m"
[ -z "$NET_PROMPT_COLOR_OTHER" ] && NET_PROMPT_COLOR_OTHER="\e[38;5;215m"

# Check if not connected
[ -z "$interfaces" ] && echo "$NET_PROMPT_COLOR_DOWN" && exit

# Assign color if we're connected to ethernet
if [ -n "$(echo "$interfaces" | grep "enp")" ]; then
	color="$NET_PROMPT_COLOR_ETHERNET"
fi

# Check if we're connected to wifi
if [ -n "$(echo "$interfaces" | grep "wlp")" ]; then
	# Check if we're also connected to ethernet
	if [ -n "$color" ]; then
		color="$NET_PROMPT_COLOR_BOTH"
	else
		color="$NET_PROMPT_COLOR_WIFI"
	fi
fi

# Set other color if connected to something else
if [ -z "$color" ]; then
	color="$NET_PROMPT_COLOR_OTHER"
fi

echo "$color"
