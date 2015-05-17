# Flags & Arguments

For these examples pretend you're building a script called `breakfast.sh`.  Here is the minimum code you need to bootstrap Lobster.

    #!/bin/bash
    source lobster/lobster.sh
    lobster_bootstrap ${@}

Now imagine that another process calls your script like this:

    ./breakfast.sh arg1 -e --protein=eggs arg2 --drink=oj

## Flags
There are three flags, one of which (`-e`) is a boolean TRUE.  The other two have values. Lobster uses the equal sign to assign values to flags, not the space character, which you sometimes see.  There are two functions for working with flags: `lobster_has_flag()` and `lobster_get_flag()`.

If i want to know if the caller wants to eat (`-e`) I can do this:

    if lobster_has_flag e; then
      ...
    endif

If I want to know what the caller wants to drink I do this:

    drink=$(lobster_get_flag drink)
    lobster_p "You want to drink $drink"


**NOTE: Flag values cannot contain spaces**, the following will not work, even with the double-quotes.

    ./breakfast.sh --drink="orange juice"    

## Arguments
(After removing the flags) we're left with two arguments: `arg1` and `arg2`.  To access the first one I would do this:
    
    args=($LOBSTER_ARGS)
    lobster_p "The first argument is ${args[0]}."

And the second...

    lobster_p "The second argument is ${args[1]}."
