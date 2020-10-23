#!/bin/bash

# This line quits the script if it's been disabled
[ "$ENABLE_GIT_PROMPT" != "1" ] && exit

function show_usage()
{
	echo "########## git status script ##########
With no arguments (and regardless of other arguments), it echos an
export for the GIT_PROMPT_STATUS variable, only if it is empty.
It then uses that variable to get other things, so if it isn't
working, make sure it isn't defined to anything. You may pass other
arguments to echo exports for the other variables, described below.

Requires the ENABLE_GIT_PROMPT variable to be set to 1. If you're
using the git.sh plugin, you can toggle that variable with:
    gitpt [on | off]

Arguments:
  -h|--help
    Prints this help message
  -b|--branch
    echo GIT_PROMPT_BRANCH variable
  -c|--color
    echo GIT_PROPMT_COLOR variable
    Uses these color variables:
      GIT_PROMPT_COLOR_GOOD: No untracked files and working directory clean
      GIT_PROMPT_COLOR_UNTRACKED: Untracked files, but no unstaged changes
      GIT_PROMPT_COLOR_BAD: Unstaged changes to files" 1>&2
}

# Gather options, skipping variables that exist already
while [ -n "$1" ]; do
	case "$1" in
		-b|--branch)
			shift
			[ -n "$GIT_PROMPT_BRANCH" ] && continue
			GET_BRANCH="1"
			;;
		-c|--color)
			shift
			[ -n "$GIT_PROMPT_COLOR" ] && continue
			GET_COLOR="1"
			;;
		-h|--help|*)
			show_usage
			exit
			;;
	esac
done

# Dealing with the variables and generating the output strings
if [ -z "$GIT_PROMPT_STATUS" ]; then
	GIT_PROMPT_STATUS="$(git status -sb 2> /dev/null)"
	echo "export GIT_PROMPT_STATUS='$GIT_PROMPT_STATUS'"
fi

if [ -n "$GIT_PROMPT_STATUS" ]; then
	if [ -n "$GET_BRANCH" ]; then
		BRANCH=$(echo "$GIT_PROMPT_STATUS" | sed -e "s/\.\.\..*//" -ne "s/^## //p")
		echo "export GIT_PROMPT_BRANCH='$BRANCH'"
	fi

	if [ -n "$GET_COLOR" ]; then
		# Don't override variable if it's already set, but provide defaults
		[ -z "$GIT_PROMPT_COLOR_GOOD" ] && GIT_PROMPT_COLOR_GOOD="\e[0;32m"
		[ -z "$GIT_PROMPT_COLOR_UNTRACKED" ] && GIT_PROMPT_COLOR_UNTRACKED="\e[1;33m"
		[ -z "$GIT_PROMPT_COLOR_BAD" ] && GIT_PROMPT_COLOR_BAD="\e[1;31m"

		NUM_STATUS=$(echo "$GIT_PROMPT_STATUS" | wc -l)
		UNTRACKED=$(echo "$GIT_PROMPT_STATUS" | grep "^?? ")

		if [ -n "$UNTRACKED" ]; then
			NUM_UNTRACKED=$(echo "$UNTRACKED" | wc -l)
		else
			NUM_UNTRACKED=0
		fi

		NUM_OTHER=$(( $NUM_STATUS - $NUM_UNTRACKED - 1 ))

		if [ $NUM_OTHER -gt 0 ]; then
			echo "export GIT_PROMPT_COLOR=\"$GIT_PROMPT_COLOR_BAD\""
		elif [ $NUM_UNTRACKED -gt 0 ]; then
			echo "export GIT_PROMPT_COLOR=\"$GIT_PROMPT_COLOR_UNTRACKED\""
		else
			echo "export GIT_PROMPT_COLOR=\"$GIT_PROMPT_COLOR_GOOD\""
		fi
	fi
fi
