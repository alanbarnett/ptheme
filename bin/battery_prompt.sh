#!/bin/sh

PERCENT=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

if [ "$STATUS" == "Charging" ] || [ "$STATUS" == "Unknown" ]; then
	echo -e "\e[1;35m$PERCENT%\e[m"
elif [ $PERCENT -lt "11" ]; then
	echo -e "\e[1;5;31m$PERCENT%\e[m"
elif [ $PERCENT -lt "26" ]; then
	echo -e "\e[1;31m$PERCENT%\e[m"
else
	echo -e "\e[1;33m$PERCENT%\e[m"
fi
