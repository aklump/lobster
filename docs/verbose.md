# Verbose flag '-v'

## `lobster_verbose()`
Use this function to output messages only when the -v flag is used.

    lobster_verbose "This will only show to user if the `-v` flag is used."

## Lobster Core
By default the -v will also print Lobster core verbosity.

To disable this feature you need to add the following line to your app controller file just before calling the bootstrap:

    lobster_core_verbose=0
    source "$LOBSTER_APP_ROOT/vendor/aklump/lobster/dist/bootstrap.sh"

Setting this variable in a config file is too late as the boostrapping process uses verbosity before loading all config files.