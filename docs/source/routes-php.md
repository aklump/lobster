# PHP Routes

_*.php_ files placed in the _/routes_ folder constitute PHP routes.  These are php scripts that are called when a user of your app calls a route by the basename of the php script.  For example:

    $ ./example_app.php php do re mi -a --speed=10
    
The shell script _routes/php.php_ will be called.

Refer to _example_app/routes/php.php_ to learn more.

## Autoload

Create a file _includes/autoload.php_ for autoload functions.  This example assumes the use of composer.

    <?php
    // file: includes/autoload.php
    require __DIR__ . '/../vendor/autoload.php';
    
## Using Composer

The Example App uses composer for dependencies; refer to it on how to set up your project with Composer.

## App Functions

To define php functions used by your app create the file _includes/functions.php_.  In it place all function definitions.

## Variables

To see the variables available to your scripts call:

    $ ./example_app.php show phpvars
    
This is a core route and works in any app.

## Output

Use `lobster_echo()` to write output.

## Error Handling

* PHP Route files should throw exceptions on error; do not catch them.  Lobster will catch the errors and write them to a file called `exceptions.txt` when file logging is enabled. And to the screen when `--lobster-debug` is enabled.
* To enable file logging edit _.lobsterconfig_.
* Except for route files, you must boostrap lobster with the following at the top of php files.

        <?php
        require_once getenv('LOBSTER_ROOT') . '/bootstrap.php';
    
This line will cause the Lobster PHP functions to be loaded as well as these files in your app, if they exist.

    includes/bootstrap.php
    includes/functions.php
