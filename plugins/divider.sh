# Variable to enable/disable an 80 column divider printed before the prompt
export ENABLE_DIVIDER=1

# Function to easily set the ENABLE_DIVIDER variable
# Only accepts "on" or "off" as values (for now)
divider()
{
	if [ "$1" = "on" ]; then
		ENABLE_DIVIDER=1
	elif [ "$1" = "off" ]; then
		ENABLE_DIVIDER=0
	else
		echo "usage: divider [on | off]"
	fi
}
