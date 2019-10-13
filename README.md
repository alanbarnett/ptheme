# ptheme

Prompt theme configuration tool for bash

This script/set of scripts allow you to easily customize your prompt (and
readline!) with real-time updatable theme files that are easy to read and edit,
and convenient commands to list/change/edit themes.

## Screenshot

![Some of the included themes and commands](/ptheme_themes.png?raw=true "themes_scrot")

## Information

Here's the [stackoverflow question](https://stackoverflow.com/questions/3058325/what-is-the-difference-between-ps1-and-prompt-command) that started this whole project.

The file `prompt.sh` has the basic setup for adding these themes into your
bashrc.
To understand it, you must know some things:
 - The `PS1` variable is where your prompt is stored in bash.
 - The `PROMPT_COMMAND` variable can be set to the name of a function who sets
 the `PS1` variable.

So, I made a function that runs a script (or a "theme"), and uses the string it
produces as your prompt. It is set up this way to allow you additional freedom
when scripting your prompt, which is usually much cleaner looking than an
incredibly long `PS1` set in your `.bashrc`. It can be set up to do some cool
things, like changing the prompt automatically if you're in a git repository,
or using custom inputrc configuration globally and per-theme to make vim mode
strings integrate with the prompts that need it, and not on the ones that
don't.

> Quick story about why it's set up that way. I have a `.inputrc` file in my
> home directory, which sets my readline to be in vim mode, turns on mode
> printing, sets the default mode strings, and adds a binding to get into
> movement mode. The problem comes when I switch to a prompt that isn't set up
> to work with the mode string (prompts that have boxes drawn around them). I
> don't want to make a .inputrc file for each one of them, I'd rather make
> theme-specific ones just for the themes that have vim mode strings
> integrated. So, I set up a global rules file that would let you turn off the
> mode string printing, so that it can be turned back on with the themes that
> use it.

The `prompt.sh` file is just the default. You are encouraged to make your own,
with your own additional configuration if needed (for example, my
`prompt_alan.sh` file sources `plugins/utils.sh`, which includes a few
functions for managing your prompt from the command line. See the **plugins**
section for more info). The things in your `prompt.sh` are only run once,
except for the function that `PROMPT_COMMAND` is set to - that runs every time
you get a new prompt. Which also means that any scripting you do in that
function (and your theme script, which is called in that function) gets ran for
every new prompt, instead of once globally for your session. This means you can
easily set up plugins that control things for all of your different themes, or
just one! For example, maybe not every theme needs to load git information.
But, maybe you want all of them to have a toggleable divider! Then for the
global settings, you could define color code variables that don't need
re-created every time.

Additional themes should be placed in the /themes folder. The included themes
place all used scripts inside the /bin folder, and locally set the PATH to
include it. Also, as a style note, the included themes will NOT have a .sh
extension, while all additional scripts that are used WILL have the .sh
extension.

To change themes from the command line (also see **plugins**), run:

`PROMPT_THEME="theme name"`

ex.

`PROMPT_THEME=twoline-lite`

It is not yet multi-shell compatible, but I imagine that it could be. I would
need to write a prompt file and possibly also a theme file for the other
shells, or look into ways to make the theme files work for any shell.

**UPDATE:** I've been thinking about different ways to make the themes shell
agnostic, and I've also learned how to do something similar to `PROMPT_COMMAND`
in `zsh`, so hopefully these things collide soon. There is a working alpha test
with `zsh`, and it should be more integrated soon!


## Installation

Remove (or comment out) all `PS1` and `PROMPT_COMMAND` configuration from your
`.bashrc`, and add the following line:

```
. [path/to/prompt.sh]
```
ex.
```
. $HOME/bin/ptheme/prompt_alan.sh
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
export PROMPT_BASE_DIR="$HOME/bin/ptheme"

# Path of prompt theme directory (used to avoid rewriting the path)
export PROMPT_THEME_DIR="$PROMPT_BASE_DIR/themes"

function prompt_command ()
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
quick editing). You can also give it the name of a theme as an argument to
edit. Additionally, if your editor is vim or neovim, using this command opens
your theme's .inputrc in the preview window. You can move back and forth from
it with `CTRL-w p`, and close it with `CTRL-w z`.
Note that support for other editors that allow you to open multiple windows on
the command line can easily be added, if anyone has requests for other editors
then submit a pull request! :)

#### plugins/git.sh

Also included is the `plugins/git.sh` file, which has the exported variable to
control git printing, and this function to set it from the command line:

`gitpt` is a command that will turn on or off the git branch information in the
prompt, by changing the `ENABLE_GIT_PROMPT` variable (note that the only reason
this works is because I check the value of the `ENABLE_GIT_PROMPT` variable
before running any git commands in the prompt scripts).

#### plugins/divider.sh

This plugin is for controlling the `ENABLE_DIVIDER` variable. It sets it to 1
initially, as well. It also gives this function for controlling it:

`divider` is a command that takes "on" or "off" as parameters, and sets the
variable to a 1 or 0. This function is very similar to gitpt, except it
controls the variable for printing an 80 column divider. You can print your
divider in any way you like, but also included in the bin/ folder is a script
called `80col_divider.sh` that echo's a string of 80 dots. There is also one
called `fullwidth_divider.sh`, which prints a line of hyphens across the full
width of your terminal (assuming your screen isn't wider than 2000 characters).
Eventually, I'll have one script that controls the color, character, and length
of the divider.

### bin

#### TODO
Make a section in here for each script in the bin folder, and how they are used
