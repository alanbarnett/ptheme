# Variable to enable/disable git information in prompt
export ENABLE_GIT_PROMPT=1

# Function to easily set the ENABLE_GIT_PROMPT variable
# Only accepts "on" or "off" as values (for now)
function gitpt ()
{
	if [ "$1" = "on" ]; then
		ENABLE_GIT_PROMPT=1
	elif [ "$1" = "off" ]; then
		ENABLE_GIT_PROMPT=0
	else
		echo "usage: gitpt [on | off]"
	fi
}
