#!/bin/sh

COLOR_GOOD='\e[0;32m'
COLOR_UNTRACKED='\e[1;33m'
COLOR_BAD='\e[1;31m'

if [ "$GIT_PROMPT" = "1" ]; then
	STATUS=$(git status -sb 2> /dev/null)

	if [ -n "$STATUS" ]; then
		NUM_STATUS=$(echo "$STATUS" | wc -l)
		BRANCH=$(echo "$STATUS" | sed "s/\.\.\./\n/" | sed -n "s/^## \(.*\)$/\1/p")
		UNTRACKED=$(echo "$STATUS" | grep "^?? ")

		if [ -n "$UNTRACKED" ]; then
			NUM_UNTRACKED=$(echo "$UNTRACKED" | wc -l)
		else
			NUM_UNTRACKED=0
		fi

		NUM_OTHER=$(( $NUM_STATUS - $NUM_UNTRACKED - 1 ))

		if [ $NUM_OTHER -gt 0 ]; then
			printf "\e[1;37m->$COLOR_BAD$BRANCH\e[m"
		elif [ $NUM_UNTRACKED -gt 0 ]; then
			printf "\e[1;37m->$COLOR_UNTRACKED$BRANCH\e[m"
		else
			printf "\e[1;37m->$COLOR_GOOD$BRANCH\e[m"
		fi
	fi
fi
