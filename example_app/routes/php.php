<?php
/**
 * @file
 * An example of a route using a php handler
 */
array_shift($argv);
$op = array_shift($argv);
if (($json = getenv('LOBSTER_JSON'))) {
  $json = json_decode($json);
}

$output = array();
$output[] = "This is a PHP handler";
$output[] = "The operation is " . $json->app->op;
$output[] = "You called with arguments: " . implode(', ', $json->app->args);
$output[] = '';

print implode(PHP_EOL, $output);