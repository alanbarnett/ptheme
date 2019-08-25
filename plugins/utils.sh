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
#	Your default one with main readline configuration,
#		(read by default for all other programs that use readline)
#	default settings for this set of prompts,
#		(main settings that apply only to your prompt)
#		(for ex. your default readline turns on show-mode-in-prompt, but most
#		prompts aren't set up to support it. instead of adding inputrc's for
#		all of them to turn off settings you don't want from your main readline
#		config, make those changes in .inputrc in the theme directory.)
#	and one for just the theme
#		(good for visual settings specific to the current theme)
_switch_theme()
{
	PROMPT_THEME="$1"
	[ -f "$HOME/.inputrc" ] &&
		bind -f "$HOME/.inputrc"
	[ -f "$PROMPT_THEME_DIR/.inputrc" ] &&
		bind -f "$PROMPT_THEME_DIR/.inputrc"
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
