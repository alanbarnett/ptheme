#!/bin/sh

STATE=$(ip -br link show wlp2s0 | awk -F ' ' '{ printf "%s", $2 }')

if [ "$STATE" == "UP" ]; then
	echo -en "\e[0;36m@\e[m"
else
	echo -en "\e[1;37m@\e[m"
fi
