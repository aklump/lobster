<?php
/**
 * @file
 * An example of a route using a php handler
 */
require_once getenv('LOBSTER_ROOT') . '/lobster.php';

try {
    if ($error) {
        throw new \Exception('An error occurred.');
    }

    // ... provide the route service, throw an exception if it fails ...
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
    $output[] = "PHP scripts have access to a JSON string with lots of data in it, a global BASH";
    $output[] = "variable, \$LOBSTER_JSON, which decodes like this:";
    $output[] = '';
    $output[] = print_r($json, TRUE);
    $output[] = '';

    lobster_success(implode(PHP_EOL, $output));

} catch (\Exception $exception) {
    lobster_error($exception->getMessage());
    lobster_exit();
}
