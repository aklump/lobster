<?php
/**
 * @file A wrapper for php files to facilitate exception captures and logging.
 */
try {
    // Bootstrap the PHP side of Lobster.
    require_once getenv('LOBSTER_ROOT') . '/lobster.php';

    lobster_core_verbose($lobster_t_include_found . lobster_app_relative_path($argv[1]));

    // Require the route file.
    ob_start();
    require $argv[1];
    $return = ob_get_contents();
    ob_end_clean();

    print $return;

} catch (\Exception $exception) {

    // Log exceptions to the file system if file logging is enabled.
    lobster_log($exception);

    // In debug mode we print exception to the screen.
    if ($lobster_debug) {
        print $exception . PHP_EOL;
    }
}

lobster_include('shutdown');
