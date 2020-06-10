# Most basic setup for ptheme
# Uses the default theme with no plugins
# It preserves the value of PROMPT_COMMAND
# The only fancy thing it does is support themes that show the return status of
# your last command

# Default prompt theme
export PTHEME_THEME="default"

# Path of base directory (used in theme scripts to find bin folder)
export PTHEME_BASE_DIR="$HOME/bin/ptheme"

# Path of prompt theme directory (used to avoid rewriting the path)
export PTHEME_THEMES_DIR="$PTHEME_BASE_DIR/themes"

# Save the return status of the last program in a variable
# This is because $? will be changed by things in PROMPT_COMMAND
export RETURN_STATUS="$?"

# This function captures the return value of the last command
# It should be inserted before the things currently in PROMPT_COMMAND to ensure
# that it runs first, as its value will change after other commands
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
