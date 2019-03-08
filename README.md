# ptheme

Prompt theme configuration tool for bash

This script/set of scripts allow you to easily customize your prompt with
real-time updatable theme files that are easy to read and edit, and convenient
commands to list/change/edit themes.

## Information

Here's the [stackoverflow question](https://stackoverflow.com/questions/3058325/what-is-the-difference-between-ps1-and-prompt-command) that started this whole project.

The file `prompt.sh` has the basic setup for adding these themes into your
bashrc. Basically, you make a function that sets `PS1` to a script, and call
that function from `PROMPT_COMMAND`, which will run whatever command you
specify each time you display `PS1`. 

The `prompt.sh` file is just the default. You are encouraged to make your own,
with your own additional configuration if needed (for example, my
`prompt_alan.sh` file sources `plugins/utils.sh`, which includes a few
functions for managing your prompt from the command line. See **plugins** for
more info). The things in `prompt.sh` are only run once, where the things in
the `PROMPT_COMMAND` variable are run every time you get a new prompt.

Additional themes should be placed in the base/themes folder. The included
themes place all used scripts inside the base/bin folder, and locally set the
PATH to include it. Also, the included themes will NOT have a .sh extension,
while all additional scripts that are used WILL have the .sh extension.

To change themes from the command line (also see **plugins**)

`$ PROMPT_THEME="theme name"`

ex.

`$ PROMPT_THEME=twoline-lite`

It is not yet multi-shell compatible, but I imagine that it could be. I would
need to write a prompt file and possibly also a theme file for the other
shells, or look into ways to make the theme files work for any shell.

## Installation

Remove (or comment out) all `PS1` and `PROMPT_COMMAND` configuration from your
`.bashrc`, and add the following line:

```
. [path_to_prompt.sh]
```

It will source the `prompt.sh` file, which exports some default variables
needed for the themes to work, and has the functions set up to use
`PROMPT_COMMAND` with whatever theme you choose.

You could also just copy the section below and paste it into your `.bashrc` for
the basic functionality (note: it's the same as `prompt.sh`).

```
# Default prompt theme
export PROMPT_THEME="default"

# Path of base directory (used in theme scripts to find bin folder)
export PROMPT_BASE_DIR="$HOME/bin/bash_prompt"

# Path of prompt theme directory (used to avoid rewriting the path)
export PROMPT_THEME_DIR="$PROMPT_BASE_DIR/themes"

prompt_command ()
{
    PS1=$("$PROMPT_THEME_DIR"/"$PROMPT_THEME" "$?")
}

PROMPT_COMMAND=prompt_command
```

The included themes take the return value of the last command (`$?`) as the
only parameter, but of course it doesn't need to be used. This just happens to
be the nicest way to do it.

You will need to change the variable `PROMPT_BASE_DIR` to the directory where
you cloned this repository. Additionally, the variable `PROMPT_THEME` sets the
default theme.

### plugins

#### plugins/utils.sh

The included `plugins/utils.sh` file has these additional things defined. To
use them, source the `plugins/utils.sh` file in your custom `prompt.sh` file
the same way you source your `prompt.sh` in your `.bashrc` (see `prompt_alan.sh`
for an example).

`lpt` is a command that simply runs `ls` on the `$PROMPT_THEME_DIR` folder.

`pt` is a command that will switch your theme with whatever you give it as an
argument (ex. `pt default`). With no arguments it prints the current theme. If
you want to switch to a theme with spaces in the name, you must surround it
with quotes.

`ept` is a command that will open your `$EDITOR` with the current theme (for
quick editing)

#### plugins/git.sh

Also included is the `plugins/git.sh` file, which has the exported variable to
control git printing, and this function to set it from the command line:

`gitpt` is a command that will turn on or off the git branch information in the
prompt, by changing the `GIT_PROMPT` variable (note that the only reason this
works is because I check the value of the `GIT_PROMPT` variable before running
any git commands in the prompt scripts).
