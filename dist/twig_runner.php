<?php
/**
 * @file A wrapper for php files to facilitate exception captures and logging.
 */
try {
    // Bootstrap the PHP side of Lobster.
    require_once getenv('LOBSTER_ROOT') . '/lobster.php';
    //    lobster_core_verbose($lobster_t_include_found . lobster_app_relative_path($argv[1]));
    $info = pathinfo($argv[1]);

    $loader = new Twig_Loader_Filesystem($info['dirname']);
    $twig = new Twig_Environment($loader, array(
        'cache' => false,
    ));

    //
    //
    // The variables available in the template
    //
    $template_vars['date'] = lobster_date();
    $template_vars['datetime'] = lobster_datetime();
    $template_vars['time'] = lobster_time();

    lobster_cache('template_vars', $template_vars);

    putenv('LOBSTER_TEMPLATE_VARS=' . json_encode($template_vars));
    echo $twig->render($info['basename'], get_defined_vars() + $template_vars);

} catch (\Exception $exception) {

    // Log exceptions to the file system if file logging is enabled.
    lobster_log($exception);

    // In debug mode we print exception to the screen.
    if ($lobster_debug) {
        print $exception . PHP_EOL;
    }
}

lobster_include('shutdown');
