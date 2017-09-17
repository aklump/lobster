<?php
/**
 * @file
 * Bootstrap the PHP portion of Lobster
 */

//
//
// Pull in the variable table from BASH
// Most bash lobster variables are available as PHP globals of the same name.
// The entire lobster environment is available (to functions) as global $lobster
//
$lobster = json_decode(getenv('LOBSTER_ENV'), true);

// @see https://stackoverflow.com/questions/8309731/interpret-escape-characters-in-single-quoted-string
$lobster['lobster_escape_char'] = stripcslashes($lobster['lobster_escape_char']);

// Expand space-delimited to arrays
$lobster['lobster_route_extensions'] = explode(' ', $lobster['lobster_route_extensions']);
$lobster['lobster_args'] = explode(' ', $lobster['lobster_args']);
$lobster['lobster_flags'] = explode(' ', $lobster['lobster_flags']);
$lobster['lobster_app_routes'] = explode(' ', $lobster['lobster_app_routes']);
$lobster['lobster_core_routes'] = explode(' ', $lobster['lobster_core_routes']);

if ($lobster['lobster_params']) {
    $temp = explode(' ', $lobster['lobster_params']);
    $lobster['lobster_params'] = array();
    foreach ($temp as $data) {
        $data = explode('=', $data) + array_fill(0, 1, null);
        list($key, $value) = $data;
        $lobster['lobster_params'][$key] = $value;
    }
}

extract($lobster);

// Lobster: PHP Bootstrap and Library load
require_once "$LOBSTER_ROOT/bootstrap.php";
require_once "$LOBSTER_ROOT/api/utilities.php";
require_once "$LOBSTER_ROOT/functions.php";

$route_id = pathinfo($argv[0], PATHINFO_FILENAME);

// Now process the app-level includes
lobster_include('autoload');
lobster_include('functions');

$_defined_vars = get_defined_vars();
