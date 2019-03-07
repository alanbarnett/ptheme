# Default prompt theme
export PROMPT_THEME="twoline"

# Path of base directory (used in theme scripts to find bin folder)
export PROMPT_BASE_DIR="$HOME/bin/bash_prompt"

# Path of prompt theme directory (best to put it in one place)
export PROMPT_THEME_DIR="$PROMPT_BASE_DIR/themes"

prompt_command ()
{
    PS1=$("$PROMPT_THEME_DIR"/"$PROMPT_THEME" "$?")
}

PROMPT_COMMAND=prompt_command

# How many directories to display before truncating
PROMPT_DIRTRIM=8

# Function to open the current theme in your editor
ept ()
{
	"$EDITOR" "$PROMPT_THEME_DIR"/"$PROMPT_THEME"
}

# Function to quickly switch themes
# No args: display current theme
# One arg: check if theme exists, switch to it if so, print error if no
# Multiple args: ignored. you must use "" if you want a space in the name
pt ()
{
	if [ -z "$1" ]; then
		echo "$PROMPT_THEME"
	else
		if [ -f "$PROMPT_THEME_DIR/$1" ]; then
			PROMPT_THEME="$1"
		else
			echo "Theme not in $PROMPT_THEME_DIR"
		fi
	fi
}
