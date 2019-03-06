#PS1='\[\e[1;37m\]\342\224\214[\[\e[1;36m\]\u$(network_status.sh)\[\e[1;36m\]\h\[\e[1;37m\]]\342\224\200(\[\e[1;32m\]\w$(git_branch_prompt.sh)\[\e[1;37m\])\342\224\200($(battery)\[\e[1;37m\])\342\224\200(\[\e[1;34m\]$(date "+%I:%M %P")\[\e[1;37m\])$(need_to_reboot.sh)\n\[\e[1;37m\]\342\224\224\342\224\200(\[\e[1;36m\]$\[\e[1;37m\]> \[\e[m\]'

WHITE="\[\e[1;37m\]"
GREEN="\[\e[1;32m\]"

BOX_HORIZ="\342\224\200"

prompt_bubble ()
{
	printf "$WHITE$BOX_HORIZ("$1"$WHITE)"
}

PS1="$(prompt_bubble "$GREEN\w")\
$WHITE$(prompt_bubble $)\[\e[1;37m\]>\[\e[m\] "
