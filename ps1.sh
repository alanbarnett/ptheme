#PS1='\[\e[1;37m\]\342\224\214[\[\e[1;36m\]\u$(network_status.sh)\[\e[1;36m\]\h\[\e[1;37m\]]\342\224\200(\[\e[1;32m\]\w$(git_branch_prompt.sh)\[\e[1;37m\])\342\224\200($(battery)\[\e[1;37m\])\342\224\200(\[\e[1;34m\]$(date "+%I:%M %P")\[\e[1;37m\])$(need_to_reboot.sh)\n\[\e[1;37m\]\342\224\224\342\224\200(\[\e[1;36m\]$\[\e[1;37m\]> \[\e[m\]'

PATH=$PATH:$HOME/bin/bash_prompt

GREEN="\[\e[1;32m\]"
BLUE="\[\e[1;34m\]"
CYAN="\[\e[1;36m\]"
WHITE="\[\e[1;37m\]"
NORM="\[\e[m\]"

BOX_TOPL="\342\224\214"
BOX_BOTL="\342\224\224"
BOX_HORIZ="\342\224\200"

DATE_SEQ="+%I:%M %P"

PS1="$WHITE$BOX_TOPL($CYAN\u$(network_status.sh)$CYAN\h$WHITE)\
$BOX_HORIZ($GREEN\w$WHITE)\
$BOX_HORIZ($BLUE$(date "$DATE_SEQ")$WHITE)\n\
$WHITE$BOX_BOTL$BOX_HORIZ($CYAN\$$WHITE> $NORM"
