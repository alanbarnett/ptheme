#/bin/sh

UNAME=$(uname -r)
KERNEL=$(pacman -Q linux | tr _ - | awk -F ' ' '{ printf "%s", $2 }' -)

if [ "$UNAME" != "$KERNEL" ]; then
	printf "\e[1;37m\342\224\200(\e[1;5;31mReboot!\e[0;1;37m)\e[m"
fi
