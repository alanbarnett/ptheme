The file `default.bashrc` contains the bare minimum `.bashrc` file with this
already set up. Basically, you make a function that sets PS1, and call that
function from `PROMPT_COMMAND`. You could also just copy the section below and
paste it into your `.bashrc`.

If you cloned this repository as `~/bin/bash_prompt`:
``` # Variable for setting the prompt theme. Can be changed from the shell
export PROMPT_THEME="default"

function prompt_command {
    RET="$?"
    PS1=$(~/bin/bash_prompt/"$PROMPT_THEME" "$RET")
}
PROMPT_DIRTRIM=8
PROMPT_COMMAND=prompt_command```

Additional themes should be placed in the base folder, but they can be placed
anywhere as long as you provide the path to it. The included themes place all
used scripts inside the base folder, and locally set the PATH to include it.
Also, the included themes will NOT have a .sh extension, while all additional
scripts that are used WILL have the .sh extension.

To change themes:
`$ PROMPT_THEME="theme name"`
ex.
`$ PROMPT_THEME=twoline`
