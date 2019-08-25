# This file contains useful functions that you might want to include in all
# different profiles

# Function to list available themes
lpt ()
{
	ls "$PROMPT_THEME_DIR"
}

# Helper function to check if a theme exists
_check_theme_exists()
{
	if [ -f "$PROMPT_THEME_DIR/$1" ]; then
		return 0
	else
		return 1
	fi
}

# Helper function for switching themes
# Changes the variable for the theme to be ran, and sources some .inputrc files
# Your default one with main configuration, and one for just the theme
# Useful if you have lots of common settings, and some that change regularly
_switch_theme()
{
	PROMPT_THEME="$1"
	[ -f "$HOME/.inputrc" ] &&
		bind -f "$HOME/.inputrc"
	[ -f "$PROMPT_THEME_DIR/.$PROMPT_THEME.inputrc" ] &&
		bind -f "$PROMPT_THEME_DIR/.$PROMPT_THEME.inputrc"
	return 0
}

# Function to quickly switch themes
# No args: display current theme
# One arg: check if theme exists, switch to it if so, print error if no
#			also run that theme's inputrc file
# Multiple args: ignored. you must use "" if you want a space in the name
pt ()
{
	if [ -z "$1" ]; then
		echo "$PROMPT_THEME"
	else
		if _check_theme_exists "$1"; then
			_switch_theme "$1"
		else
			echo "Theme \"$1\" not in $PROMPT_THEME_DIR"
			return 1
		fi
	fi
}

# Function to open the current theme in your editor
# No args: edit current theme
# One arg: check if theme exists, edit if so, print error if no
# Multiple args: ignored. you must use "" if you want a space in the name
ept ()
{
	if [ -z "$1" ]; then
		"$EDITOR" "$PROMPT_THEME_DIR/$PROMPT_THEME"
	else
		_check_theme_exists "$1" && "$EDITOR" "$PROMPT_THEME_DIR/$1"
	fi
}
