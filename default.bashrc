#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Variable for setting the prompt theme. Can be changed from the shell
export PROMPT_THEME="default"

function prompt_command {
    RET="$?"
    PS1=$(~/bin/bash_prompt/"$PROMPT_THEME" "$RET")
}
PROMPT_DIRTRIM=8
PROMPT_COMMAND=prompt_command
