#!/bin/sh

# Setup for using ptheme with the twoline prompt and some basic plugins
# It preserves the value of PROMPT_COMMAND
# It supports having a custom inputrc for your prompt, and shows you git info
# It includes commands for switching/editing prompts easily
# It also supports themes that show the return status of your last command

# Variables {{{

# Default prompt theme
export PTHEME_THEME="twoline"

# Path of base directory (used in theme scripts to find bin folder)
export PTHEME_BASE_DIR="$HOME/bin/ptheme"

# Path of prompt theme directory (used to avoid rewriting the path)
export PTHEME_THEMES_DIR="$PTHEME_BASE_DIR/themes"

# Path of prompt plugins
export PTHEME_PLUGINS_DIR="$PTHEME_BASE_DIR/plugins"

# Save the return status of the last program in a variable before PROMPT_COMMAND
# This is to prevent $? from being changed by the other things it may be doing
export RETURN_STATUS="$?"

# }}}

# Plugins {{{

# Color variable shortcuts
. "$PTHEME_PLUGINS_DIR"/colors.sh

# Source utils file for core functions
. "$PTHEME_PLUGINS_DIR"/utils.sh

# Add git prompt ability
. "$PTHEME_PLUGINS_DIR"/git.sh

# }}}

# "Switch" to current prompt theme using pt plugin, which reloads inputrc files
pt "$PTHEME_THEME"

# Prompt command {{{

# This function captures the return value of the last command
# It should be inserted before the things currently in PROMPT_COMMAND to ensure
# that runs first, as it's value will change after other commands
function ptheme_save_ret()
{
	RETURN_STATUS="$?"
}

# This function runs the theme, and sets the PS1 variable to its output.
# It should be appended to the things currently in PROMPT_COMMAND
function ptheme_set_ps1()
{
    PS1=$("$PTHEME_THEMES_DIR"/"$PTHEME_THEME")
}

# This variable gets executed before the prompt gets drawn
# Since it executes other commands, we first need to save the last return value
# If PROMPT_COMMAND is empty, run the command "true" instead (as a dummy)
PROMPT_COMMAND="ptheme_save_ret; ${PROMPT_COMMAND:-true}; ptheme_set_ps1"

# How many directories to display before truncating
PROMPT_DIRTRIM=8

# }}}

# vim: foldmethod=marker foldmarker={{{,}}}
