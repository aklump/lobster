# Help
When a user calls any lobster shell script with 'help' as the first argument, the help hook is invoked.  Something like the following:

    ./breakfast.sh help

would include files found at:

    $LOBSTER_PROJECT/docs/breakfast_default.*
    $LOBSTER/docs/breakfast_default.*
    $LOBSTER_PROJECT/docs/default.*
    $LOBSTER/docs/default.*

Calling it with a second argument

    ./breakfast.sh help lobster

would look for a more specific file

    $LOBSTER_PROJECT/docs/lobster.*
    $LOBSTER/docs/lobster.*

## Creating help files
Depending upon the complexity of your project, you will have one or many help files.  At the very least you need to have a help file with a filename of `_default` in one of the languages below. `help/_default.md` is present in fresh installs of Lobster.  You may replace it's contents or delete it entirely if you're going to use something other than markdown for your help files.

If you will have multiple help files then you create files with specific names, which become the second argument to a lobster-powered shell script.

### You can write help files in several languages
1. Markdown
2. Plaintext
3. Lobster Shell
4. Php

To see an example of multiple formats try the following on a fresh installation of Lobster:

    lobster.sh help example
