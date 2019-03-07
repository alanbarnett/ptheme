# Installation
Remove (or comment out) all `PS1` and `PROMPT_COMMAND` configuration from your
bashrc, and add the following line:

```
. [path_to_prompt.sh]
```

It will source the `prompt.sh` file, which exports some default variables
needed for the themes to work, and has the functions set up to use
`PROMPT_COMMAND` with whatever theme you choose.

You will also need to change the variable `PROMPT_BASE_DIR` in the file
`prompt.sh` to the directory that you cloned this repository.

Additionally, the variable `PROMPT_THEME` sets the default theme.

# Information
The file `prompt.sh` has the basic setup for adding this into your bashrc.
Basically, you make a function that sets `PS1` to a script, and call that
function from `PROMPT_COMMAND`. You could also just copy the section below and
paste it into your `.bashrc` (note: it's the same as `prompt.sh`).

```
# Default prompt theme
export PROMPT_THEME="default"

# Path of base directory (used in theme scripts to find bin folder)
export PROMPT_BASE_DIR="$HOME/bin/bash_prompt"

function prompt_command {
    RET="$?"
    PS1=$("$PROMPT_BASE_DIR"/themes/"$PROMPT_THEME" "$RET")
}
PROMPT_DIRTRIM=8
PROMPT_COMMAND=prompt_command
```

Additional themes should be placed in the base/themes folder. The included
themes place all used scripts inside the base/bin folder, and locally set the
PATH to include it. Also, the included themes will NOT have a .sh extension,
while all additional scripts that are used WILL have the .sh extension.

To change themes from the command line:

`$ PROMPT_THEME="theme name"`

ex.

`$ PROMPT_THEME=twoline`
