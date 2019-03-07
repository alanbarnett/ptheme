##PS1='\[\e[1;37m\]\342\224\214[\[\e[1;36m\]\u$(network_status.sh)\[\e[1;36m\]\h\[\e[1;37m\]]\342\224\200(\[\e[1;32m\]\w$(git_branch_prompt.sh)\[\e[1;37m\])\342\224\200($(battery)\[\e[1;37m\])\342\224\200(\[\e[1;34m\]$(date "+%I:%M %P")\[\e[1;37m\])$(need_to_reboot.sh)\n\[\e[1;37m\]\342\224\224\342\224\200(\[\e[1;36m\]$\[\e[1;37m\]> \[\e[m\]'


# Save the exit value of the last command
RET="$1"

# Update path to include folder with necessary prompt scripts
# NOTE: This doesn't update the path outside this script
PATH="$PATH:$HOME/bin/bash_prompt"

# String for the date command
DATE_SEQ="+%I:%M %P"

# Color shortcut variables
RED='\[\e[1;31m\]'
GREEN='\[\e[1;32m\]'
BLUE='\[\e[1;34m\]'
CYAN='\[\e[1;36m\]'
WHITE='\[\e[1;37m\]'
NORM='\[\e[m\]'

# Box printing shortcut variables
BOX_TOPL='\342\224\214'
BOX_BOTL='\342\224\224'
BOX_HORIZ='\342\224\200'

echo "${WHITE}${BOX_TOPL}[${CYAN}\u\
$(network_status.sh)\
${CYAN}\h${WHITE}]\
${BOX_HORIZ}(${GREEN}\w$(git_prompt.sh)${WHITE})\
${BOX_HORIZ}($(battery_prompt.sh)${WHITE})\
${BOX_HORIZ}(${BLUE}$(date "${DATE_SEQ}")${WHITE})\
$(need_to_reboot.sh)\
\n${WHITE}${BOX_BOTL}${BOX_HORIZ}(${CYAN}\$${WHITE}> ${NORM}"
