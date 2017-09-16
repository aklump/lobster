<?php
/**
 * @file
 * An example of a route using a php handler
 */

lobster_color('white');
lobster_echo('Here is a contextual info from your command line:');
lobster_echo();

lobster_color_echo('cyan', "The operation is $lobster_op.");

lobster_color('pink');
lobster_echo("You called with arguments: " . implode(', ', $lobster_args));

// This is how we tell if a flag was used.
if (lobster_has_flag('o')) {
    lobster_echo("You called this with the 'o' flag.");
}
else {
    lobster_color('yellow');
    lobster_echo("Try including the flag '-o' next time you call this.");
}

// This is how we check the value of a param
if (lobster_has_param('size')) {
    $size = lobster_get_param('size');
    lobster_echo("You have specified a parameter 'size' of '$size'.");
}
else {
    lobster_color_echo('yellow', "Try including the parameter '--size=large' next time.");
}

lobster_echo();

// An example of using the default value for a parameter
$color = lobster_get_param('color', 'white');
if ($color) {
    lobster_color($color);
}
if (!lobster_has_param('color')) {
    lobster_color_echo('yellow', 'Try passing --color=red');
    lobster_echo();
}

lobster_echo("Here is some nifty info:");
lobster_echo("  * Today is: " . lobster_date());
lobster_echo("  * Current timestamp: " . lobster_time());
lobster_echo("  * Current datetime is: " . lobster_datetime());
lobster_echo();
