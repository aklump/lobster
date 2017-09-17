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

    // Custom function: {{ lobster_color('cyan') }}
    $twig->addFunction(new Twig_Function('lobster_color', function ($color) {
        lobster_color($color);
    }));

    // Custom function: {{ lobster_color_echo('cyan') }}
    $twig->addFunction(new Twig_Function('lobster_color_echo', function ($color, $text) {
        ob_start();
        lobster_color_echo($color, $text);
        $contents = ob_get_contents();
        ob_end_clean();

        return trim($contents);
    }, array('is_safe' => array('html'))));

    //
    //
    // The variables available in the template
    //
    $template_vars['hr'] = str_repeat('-', 80);
    $template_vars['date'] = lobster_date();
    $template_vars['datetime'] = lobster_datetime();
    $template_vars['time'] = lobster_time();
    $template_vars['routes'] = array_fill_keys(array_merge($lobster_app_routes, $lobster_core_routes), 'tbd');

    lobster_cache('template_vars', $template_vars);

    putenv('LOBSTER_TEMPLATE_VARS=' . json_encode($template_vars));
    $output = $twig->render($info['basename'], get_defined_vars() + $template_vars);

    // Templates cannot have trailing whitespace. If you need whitespace after a template call lobster_echo()
    lobster_echo(rtrim($output));

} catch (\Exception $exception) {

    // Log exceptions to the file system if file logging is enabled.
    lobster_log($exception);

    // In debug mode we print exception to the screen.
    if ($lobster_debug) {
        print $exception . PHP_EOL;
    }
}

lobster_include('shutdown');
