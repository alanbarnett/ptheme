#!/bin/sh

# Variables {{{

# Default prompt theme
export PROMPT_THEME="twoline-lite"

# Path of base directory (used in theme scripts to find bin folder)
export PROMPT_BASE_DIR="$HOME/bin/ptheme"

# Path of prompt theme directory (used to avoid rewriting the path)
export PROMPT_THEME_DIR="$PROMPT_BASE_DIR/themes"

# Path of prompt plugins
export PROMPT_PLUGINS_DIR="$PROMPT_BASE_DIR/plugins"

# }}}

# Plugins {{{

# Source utils file for core functions
. "$PROMPT_PLUGINS_DIR"/utils.sh

# Add git prompt ability
. "$PROMPT_PLUGINS_DIR"/git.sh

# }}}

# Prompt command {{{

prompt_command ()
{
    PS1=$("$PROMPT_THEME_DIR"/"$PROMPT_THEME" "$?")
}

PROMPT_COMMAND=prompt_command

# How many directories to display before truncating
PROMPT_DIRTRIM=8

# }}}

# vim: foldmethod=marker foldmarker={{{,}}}
