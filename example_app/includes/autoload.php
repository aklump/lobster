<?php
/**
 * @file Autoloading for all routes
 */
require $LOBSTER_APP_ROOT . '/vendor/autoload.php';

//
//
// Set up some extra, php-only app variables
//
lobster_app_vars(array(
    # Define an app var
    'some_var' => 'some value',
    'another' => 'different value',
));
