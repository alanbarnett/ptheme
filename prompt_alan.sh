#!/bin/sh

# Alan's custom ptheme config
# Used for testing new plugins and an example of more personal settings
# It's almost the exact same as prompt_twoline.sh, except:
# It sets PS0, since my terminal cursor is a vertical bar while in "insert
# mode". PS0 sets it back to a block when the command runs.
# It enables the divider plugin, which puts a line above the prompt. This is
# useful for knowing 50/72/80 column widths, or for command separation.
# It exports the variable for controlling the color of the box characters

# Variables {{{

# Default prompt theme
export PTHEME_THEME="twoline-lite"

# Path of base directory (used in theme scripts to find bin folder)
export PTHEME_BASE_DIR="$HOME/bin/ptheme"

# Path of prompt theme directory (used to avoid rewriting the path)
export PTHEME_THEMES_DIR="$PTHEME_BASE_DIR/themes"

# Path of prompt plugins
export PTHEME_PLUGINS_DIR="$PTHEME_BASE_DIR/plugins"

# Save the return status of the last program in a variable before PROMPT_COMMAND
# This is to prevent $? from being changed by the other things it may be doing
export RETURN_STATUS="$?"

# Variable for the boxprinting color
export BOX_COLOR=""

# }}}

# Plugins {{{

# Color variable shortcuts
. "$PTHEME_PLUGINS_DIR"/colors.sh

# Source utils file for core functions
. "$PTHEME_PLUGINS_DIR"/utils.sh

# Add git prompt ability
. "$PTHEME_PLUGINS_DIR"/git.sh

# Add function for enabling/disabling an 80 column separator
. "$PTHEME_PLUGINS_DIR"/divider.sh

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

# This prompt gets printed before commands are run
# Change cursor to a block
PS0="\e[2 q"

# }}}

# vim: foldmethod=marker foldmarker={{{,}}}
