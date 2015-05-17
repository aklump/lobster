# Program Flow

## Controller File
Think of a controller file as `index.php`; most apps built with lobster will have only one controller file (this is not a technical limitation, but at design contstraint) whose name reflects the name of the app, e.g., `lobster.sh`.  When a user invokes the app they would be typing something like the following, which runs the controller file.

    $ lobster.sh init new_project --no-example

A controller file need only include three lines of code to leverage the power of Lobster.  Place these lines first in your script before anything else.  **Note: adjust the path to `lobster.sh` as appropriate.**

    source ../lobster/core.sh
    lobster_bootstrap ${@}

Then make sure this comes last after any code you need to add.

    lobster_exit

## Hooks
A hook is a script that is designed to be run at some defined point during execution.  For example there is a hook that runs during the bootstrap phase of lobster called 'lobster_bootstrap'.  Any file that is placed in a hook directory that has a filename of lobster_bootstrap (`lobster_bootstrap.sh`, `lobster_bootstrap.php`) will automatically be called during bootstrap.

Files of this type should only ever include the following line at the beginning, (path adjusted if necessary).

    source ../lobster/lobster.sh


**Never call lobster_bootstrap() from a hook file, lest you unleash recursion!**

### Arguments
Hooks receive the following arguments

| php | bash | description |
|-|-|-|
| $argv[1] | $1 | The path to the controller file |
| $argv[2] | $2 | The hook name |

### No args hook
When a controller file is called without args and flags, two hooks are invoked.  If the controller file was called `lobster.sh`...

    lobster hook lobster_no_args
    lobster_help lobster_no_args

The point is that you can add a help file, `docs/lobster_no_args.*`, that instructs the user what to do with your script, provide which args, etc.  You could also do something else using `hooks/lobster_no_args.*`.

### Menu system
You add menu items (user actions) with `lobster_menu_item`.

Some menu items are provided by default, e.g., "help" "init"

### Menu callback hooks
Rather than cluttering the controller file with code, most functionality should be provided by menu callback hook files, processes that get called based on the first argument sent to the controller file.  In the example above, this menu callback hook is invoked automatically.  Lobster is expecting that you will add hook a file to respond to the user's wanting to "init" a "new project" with "--no-example".

    hooks/lobster_new_project.php
    hooks/lobster_new_project.sh
    hooks/lobster_new_project.html
    hooks/lobster_new_project.md
    hooks/lobster_new_project.txt

### Stopping Early
If you any script (controller or hook) encounters an error and you need to stop early, do something like this:

    if [[ ! "$args" ]]; then
      alert "Call with arguments and these flags: -e --drink=" danger
      lobster_exit
    fi
