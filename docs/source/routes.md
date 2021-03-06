# Routing

## Route files
1. Place script files in `/routes` folder of your app.
1. Configure the types and order of files via `$lobster_route_extensions`.
1. If a route cannot be found, then a tpl will be sought.
1. Core routes can be overridden, e.g. 'init'

## Route access control
1. To control access to a route you will use `lobster_access`.
1. When the callbacks fail you may alter the 'Access Denied message' by using the var `lobster_access_denied` in the .lobsterconfig.
1. Php callbacks wishing to block access should return FALSE.
1. Shell function callbacks wishing to block access should return non zero.
1. It's recommended to place callbacks in either `functions.sh` or `functions.php`
1. Refer to `example_app/routes/access.php` and `example_app/routes/access.sh` for example code.

## Redirecting routes
1. This should be done in the app's bootstrap file; take a look at `example_app/includes/bootstrap.php` for an example.

## Theme tpls
1. You may have more than one theme, but not more than one _active_ theme.
1. Configure the types and order of files via `$lobster_tpl_extensions`.
1. Place tpl files in `/themes/{lobster_theme}/tpl`

## The Route/Theme Cascade
Given that a user types:
    
    $ my_app.sh do re mi

Then the first existing file from in the following list will be used:

    /routes/do.re.mi.sh
    /routes/do.re.mi.php
    /routes/do.re.sh
    /routes/do.re.php
    /routes/do.sh
    /routes/do.php
    /themes/{lobster_theme}/tpl/do.re.mi.twig
    /themes/{lobster_theme}/tpl/do.re.mi.txt
    /themes/{lobster_theme}/tpl/do.re.twig
    /themes/{lobster_theme}/tpl/do.re.txt
    /themes/{lobster_theme}/tpl/do.twig
    /themes/{lobster_theme}/tpl/do.txt

## Route options
You can pass options to routes in two ways: flags and parameters.

Here is an example of a route with a parameter+value:
    
    app op --color=red

.. It is not necessary for a param to have a value:

    app op --debug

Here are examples with two flags, with identical effect:

    app op -v -d
    app op -vd


### Route flags
* A flag is an argument that begins with a single `-`, e.g. `-v`.
* A flag cannot have a value (see parameter)
* Flags must be single characters.
* Flags may be grouped like this `-asdf`, which signifies four flags.

### Route parameters
* A parameter is an argument that begins with a double hyphen, e.g., '--verbose'
* It may have a value assigned, e.g., `--file=my_file.txt`

### Option order is irrelevent
Lobster doesn't care the order of the args, flag or params.  All of the following have the same effect:

    app arg1 -abcd --param=value arg2 arg3
    app -abcd --param=value arg1 arg2 arg3
    app --param=value arg1 -abcd  arg2 arg3
    ...
    
## Internal Routes
Sometimes you may want to call a route within a route; you will use --lobster-quiet to suppress theme output.  Do something like this, making sure your cd to the intial directory as needed and shown in the example.  This insures that the environment is the same:

    (cd $LOBSTER_CWD && $LOBSTER_APP {route} -f --lobster-nowrap)
