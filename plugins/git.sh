# Variable to enable/disable git information in prompt
export GIT_PROMPT=1

# Function to easily set the GIT_PROMPT variable
# Only accepts "on" or "off" as values (for now)
gitpt ()
{
	if [ "$1" = "on" ]; then
		GIT_PROMPT=1
	elif [ "$1" = "off" ]; then
		GIT_PROMPT=0
	else
		echo "usage: gpt [on | off]"
	fi
}
