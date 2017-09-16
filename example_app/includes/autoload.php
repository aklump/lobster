<?php
/**
 * @file Autoloading for all routes
 */
require __DIR__ . '/../vendor/autoload.php';

//
//
// Set up some extra, php-only app variables
//
lobster_app_vars(array(
    # Define an app var
    'some_var' => 'some value',
    'another' => 'different value',
));
