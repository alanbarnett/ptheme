#PS1='\[\e[1;37m\]\342\224\214[\[\e[1;36m\]\u$(network_status.sh)\[\e[1;36m\]\h\[\e[1;37m\]]\342\224\200(\[\e[1;32m\]\w$(git_branch_prompt.sh)\[\e[1;37m\])\342\224\200($(battery)\[\e[1;37m\])\342\224\200(\[\e[1;34m\]$(date "+%I:%M %P")\[\e[1;37m\])$(need_to_reboot.sh)\n\[\e[1;37m\]\342\224\224\342\224\200(\[\e[1;36m\]$\[\e[1;37m\]> \[\e[m\]'

prompt_bubble ()
{
	printf "\[\e[1;37m\]\342\224\200("$1")"
}

WHITE="\[\e[1;37m\]"
GREEN="\[\e[1;32m\]"

PS1="$(prompt_bubble "\w")\
$WHITE$(prompt_bubble $)\[\e[1;37m\]>\[\e[m\] "
