#!/bin/sh

function show_usage()
{
	echo "########## git status script ##########"
	echo "Requires the ENABLE_GIT_STATUS variable to be set to 1"
	echo "Also needs options to do anything"
	echo ""
	echo " Options:"
	echo "	-b|--branch"
	echo "		echo GIT_BRANCH variable"
	echo "	-c|--color"
	echo "		echo GIT_BRANCH and GIT_COLOR variables"
	echo "		Uses these color variables:"
	echo "			GIT_COLOR_GOOD: No untracked files and working directory clean"
	echo "			GIT_COLOR_UNTRACKED: Untracked files, but no unstaged changes"
	echo "			GIT_COLOR_BAD: Unstaged changes to files"
	echo "########## ################# ##########"
}

# Make sure there are arguments, exit if not
[ "$#" -lt 1 ] && show_usage 1>&2 && exit

while [ -n "$1" ]; do
	case "$1" in
		-b|--branch)
			GET_BRANCH="1"
			shift
			;;
		-c|--color)
			GET_BRANCH="1"
			GET_COLOR="1"
			shift
			;;
		*)
			show_usage 1>&2
			exit
			;;
	esac
done

if [ "$ENABLE_GIT_STATUS" = "1" ]; then
	STATUS=$(git status -sb 2> /dev/null)

	if [ -n "$STATUS" ]; then
		if [ -n "$GET_BRANCH" ]; then
			BRANCH=$(echo "$STATUS" | sed -e "s/\.\.\./ /" -ne "s/^## //p")

			echo "GIT_BRANCH=\"$BRANCH\""
		fi

		if [ -n "$GET_COLOR" ]; then
			# Don't override variable if it's already set, but provide defaults
			[ -z "$GIT_COLOR_GOOD" ] && GIT_COLOR_GOOD="\e[0;32m"
			[ -z "$GIT_COLOR_UNTRACKED" ] && GIT_COLOR_UNTRACKED="\e[1;33m"
			[ -z "$GIT_COLOR_BAD" ] && GIT_COLOR_BAD="\e[1;31m"

			NUM_STATUS=$(echo "$STATUS" | wc -l)
			UNTRACKED=$(echo "$STATUS" | grep "^?? ")

			if [ -n "$UNTRACKED" ]; then
				NUM_UNTRACKED=$(echo "$UNTRACKED" | wc -l)
			else
				NUM_UNTRACKED=0
			fi

			NUM_OTHER=$(( $NUM_STATUS - $NUM_UNTRACKED - 1 ))

			if [ $NUM_OTHER -gt 0 ]; then
				echo "GIT_COLOR=\"$GIT_COLOR_BAD\""
			elif [ $NUM_UNTRACKED -gt 0 ]; then
				echo "GIT_COLOR=\"$GIT_COLOR_UNTRACKED\""
			else
				echo "GIT_COLOR=\"$GIT_COLOR_GOOD\""
			fi
		fi
	fi
fi
