# BASH Routes

_*.sh_ files placed in the _/routes_ folder constitute BASH routes.  These are shell scripts that are called when a user of your app calls a route by the basename of the shell script.  For example:

    $ ./example_app.sh bash do re mi -a --speed=10
    
The shell script _routes/bash.sh_ will be called.

Refer to _example_app/routes/bash.sh_ to learn more.

## Bootstrapped Files

The following files (if they exist) are automatically bootstrapped for each bash route file:

1. _lib/lobster/dist/functions.sh_
1. _includes/bootstrap.sh_
1. _includes/functions.sh_

## Variables

To see the variables available to your scripts call:

    $ ./example_app.sh show vars
    
This is a core route and works in any app.

## Handling Errors

TBD
