# This file contains useful functions that you might want to include in all
# different profiles

# Function to list available themes
lpt ()
{
	ls "$PROMPT_THEME_DIR"
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

# Function to open the current theme in your editor
ept ()
{
	"$EDITOR" "$PROMPT_THEME_DIR"/"$PROMPT_THEME"
}

# Function to easily set the GIT_PROMPT variable
# Only accepts "on" or "off" as values (for now)
gpt ()
{
	if [ "$1" = "on" ]; then
		GIT_PROMPT=1
	elif [ "$1" = "off" ]; then
		GIT_PROMPT=0
	else
		echo "usage: gpt [on | off]"
	fi
}
