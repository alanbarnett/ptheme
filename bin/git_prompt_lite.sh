#!/bin/sh

if [ "$GIT_PROMPT" -eq 1 ]; then
    BRANCH=$(git branch 2> /dev/null | grep \* |  cut -d " " -f 2)
	echo $BRANCH
fi
