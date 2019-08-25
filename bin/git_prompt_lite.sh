#!/bin/sh

if [ "$GIT_PROMPT" = "1" ]; then
    BRANCH=$(git branch 2> /dev/null | grep \* |  cut -d " " -f 2)
	echo $BRANCH
fi
