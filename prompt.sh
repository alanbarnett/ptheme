# Default prompt theme
export PROMPT_THEME="twoline"

# Path of base directory (used in theme scripts to find bin folder)
export PROMPT_BASE_DIR="$HOME/bin/bash_prompt"

function prompt_command {
    RET="$?"
    PS1=$("$PROMPT_BASE_DIR"/themes/"$PROMPT_THEME" "$RET")
}
PROMPT_DIRTRIM=8
PROMPT_COMMAND=prompt_command
