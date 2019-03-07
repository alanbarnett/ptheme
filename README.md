# Installation
Add the following line to your bashrc:

`. [path_to_prompt.sh]`

It will source the `prompt.sh` file, which exports some default variables
needed for the themes to work, and has the functions set up to use
`PROMPT_COMMAND` with whatever theme you choose.

# Information
The file `prompt.sh` has the basic setup for adding this into your bashrc.
Basically, you make a function that sets PS1, and call that function from
`PROMPT_COMMAND`. You could also just copy the section below and paste it into
your `.bashrc` (note: it's the same as `prompt.sh`).

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

Additional themes should be placed in the base/themes folder, but they can be
placed anywhere as long as you provide the path to it. The included themes
place all used scripts inside the base/bin folder, and locally set the PATH to
include it. Also, the included themes will NOT have a .sh extension, while all
additional scripts that are used WILL have the .sh extension.

To change themes from the command line:

`$ PROMPT_THEME="theme name"`

ex.

`$ PROMPT_THEME=twoline`
