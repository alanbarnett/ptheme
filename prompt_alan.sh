# Variables {{{

# Default prompt theme
export PROMPT_THEME="twoline"

# Path of base directory (used in theme scripts to find bin folder)
export PROMPT_BASE_DIR="$HOME/bin/bash_prompt"

# Path of prompt theme directory (used to avoid rewriting the path)
export PROMPT_THEME_DIR="$PROMPT_BASE_DIR/themes"

# Variable to enable/disable git information in prompt
GIT_PROMPT=1

# }}}

# Functions {{{ 

# Source utils file for core functions
. "$PROMPT_BASE_DIR"/utils.sh

# }}}

# Prompt command {{{

prompt_command ()
{
    PS1=$("$PROMPT_THEME_DIR"/"$PROMPT_THEME" "$?")
}

PROMPT_COMMAND=prompt_command

# }}}

# How many directories to display before truncating
PROMPT_DIRTRIM=8

# vim: foldmethod=marker, foldmarker={{{,}}}
