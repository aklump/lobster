<?php

/**
 * Include a php script cascade by basename.
 *
 * @param string $basename
 *
 * @code
 *   lobster_include('bootstrap');
 * @endcode
 *
 * The above will include the file located in the app at
 * /includes/bootstrap.php, if it exists.
 */
function lobster_include($basename)
{
    global $LOBSTER_APP_ROOT, $lobster_t_include_found, $lobster_t_include_missing;
    $full_path = $basename . '.php';
    if (!file_exists($full_path)) {
        $full_path = "$LOBSTER_APP_ROOT/includes/" . $basename . '.php';
    }
    if (file_exists($full_path)) {
        lobster_core_verbose($lobster_t_include_found . lobster_app_relative_path($full_path));
        require_once $full_path;
    }
    else {
        lobster_core_verbose($lobster_t_include_missing . lobster_app_relative_path($full_path));
    }
}

/**
 * Make an array of variables available in the global scope.
 *
 * This can be used say in bootstrap.php to provide app name prefixed global
 * vars to your php routes and other includes.
 *
 * @param array $vars
 *
 * @code
 *   lobster_app_vars(array(
 *     'some_var' => 'some value',
 *     'another' => 'different value',
 *   ));
 *
 * @endcode
 *
 * @see example_app/includes/bootstrap.php
 */
function lobster_app_vars($vars)
{
    global $lobster_app_name;
    foreach ($vars as $key => $value) {
        $GLOBALS[$lobster_app_name . '_' . $key] = $value;
    }
}

/**
 * @file
 * Summary of the file. e.g. Handles file uploads.
 *
 * @def, in, or addtogroup name Group Name
 */
function lobster_echo($string = '')
{
    global $lobster_color_current;
    if ($string) {
        $color = $lobster_color_current;
        $parts = array();
        if ($color) {
            $parts[] = lobster_colorize($color, $string);
        }
        else {
            $parts[] = $string;
        }
    }
    $parts[] = PHP_EOL;

    echo implode('', $parts);
}

function lobster_verbose($string)
{
    if (lobster_has_flag('v')) {
        lobster_color_echo("verbose", $string);
    }
}

function lobster_core_verbose($string)
{
    global $lobster_core_verbose_prefix;
    lobster_verbose($lobster_core_verbose_prefix . $string);
}

function lobster_colorize($color, $string)
{
    if (!$string) {
        return '';
    }
    else {
        global $lobster, $lobster_escape_char;
        // Expand a symantic color
        $color_key = "lobster_color_{$color}";
        if (!is_numeric(substr($color, 0, 1)) && isset($lobster[$color_key])) {
            $color = $lobster[$color_key];
        }

        $parts = array();
        $parts[] = $lobster_escape_char;
        $parts[] = '[' . $color . 'm';
        $parts[] = $string;
        $parts[] = $lobster_escape_char;
        $parts[] = '[0m';

        return implode('', $parts);
    }
}

function lobster_color($color)
{
    global $lobster, $lobster_color_current, $lobster_color_bright;

    // First look for a color already defined; usually semantics.
    if (isset($lobster['lobster_color_' . $color])) {
        $color = $lobster['lobster_color_' . $color];
    }
    else {

        // Transform color words to codes
        switch ($color) {
            case 'grey':
                $color = "$lobster_color_bright;30";
                break;
            case 'red':
                $color = "$lobster_color_bright;31";
                break;
            case 'green':
                $color = "$lobster_color_bright;32";
                break;
            case 'yellow':
                $color = "$lobster_color_bright;33";
                break;
            case 'blue':
                $color = "$lobster_color_bright;34";
                break;
            case 'magenta':
            case 'pink':
                $color = "$lobster_color_bright;35";
                break;
            case 'cyan':
                $color = "$lobster_color_bright;36";
                break;
            case 'white':
                $color = "$lobster_color_bright;37";
                break;
        }
    }

    $lobster_color_current = $color;
}


function lobster_color_echo($color, $output)
{
    global $lobster_color_current;
    $stash = $lobster_color_current;
    lobster_color($color);
    lobster_echo($output);
    lobster_color($stash);
}

function lobster_success($string)
{
    lobster_color_echo('success', $string);
}

function lobster_error($string)
{
    lobster_color_echo('error', $string);
}

function lobster_notice($string)
{
    lobster_color_echo('notice', $string);
}


// function lobster_color_echo($color, $string) {
//   $esc = "\033";
//   $fore = "1;36";
//   $string = "${esc}[${fore}m${string}${esc}[0m";
//   lobster_echo($string);
// }

function lobster_exit()
{
    lobster_set_route_status(99);
    exit(99);
}

function lobster_has_flag($flag)
{
    global $lobster_flags;

    return in_array($flag, $lobster_flags);
}

function lobster_get_param($param_name, $default = null)
{
    global $lobster_params;

    return isset($lobster_params[$param_name]) ? $lobster_params[$param_name] : $default;
}

function lobster_has_param($param_name)
{
    global $lobster_params;

    return array_key_exists($param_name, $lobster_params);
}

/**
 * Sets the route status
 *
 * @param int $code Any non zero value means the route failed.
 *
 * @return int|false
 */
function lobster_set_route_status($code)
{
    $file = getenv('LOBSTER_TMPDIR') . '/route_status';

    return file_put_contents($file, $code);
}

function lobster_get_route_status()
{
    $file = getenv('LOBSTER_TMPDIR') . '/route_status';

    return file_get_contents($file);
}

function lobster_log($string)
{
    global $lobster_logs;
    if (!empty($lobster_logs)) {
        $fh = fopen($lobster_logs . '/exceptions.txt', 'a');
        $chunk = date('r') . PHP_EOL . $string . PHP_EOL . str_repeat('-', 80) . PHP_EOL;
        fwrite($fh, $chunk);
        fclose($fh);
    }
}

function lobster_get_core_variables()
{
    global $_defined_vars;
    $vars = array();
    foreach ($_defined_vars as $key => $value) {
        if (stripos($key, 'lobster_') === 0) {
            $vars[$key] = $value;
        }
    }

    return $vars;
}

function lobster_echo_core_variables()
{
    $vars = lobster_get_core_variables();
    unset($vars['lobster_conf']);
    _lobster_echo_array($vars);
}

function lobster_get_app_variables()
{
    global $_defined_vars, $lobster_app_name;
    $vars = array();
    foreach ($_defined_vars as $key => $value) {
        if (stripos($key, $lobster_app_name . '_') === 0) {
            $vars[$key] = $value;
        }
    }

    return $vars;
}

function lobster_echo_app_variables()
{
    $vars = lobster_get_app_variables();
    unset($vars['lobster_conf']);
    _lobster_echo_array($vars);

}

function _lobster_echo_array($vars)
{
    lobster_echo(print_r($vars));
}

/**
 * Cache a value for later retrieval.
 *
 * This is how you can pass values from one PHP process to another, say from a
 * template to a route file.
 *
 * @param      $cache_id
 * @param null $value
 *
 * @return mixed|null
 */
function lobster_cache($cache_id, $value = null)
{
    global $LOBSTER_APP_TMPDIR;
    if (func_num_args() === 1) {
        $value = file_get_contents($LOBSTER_APP_TMPDIR . "/$cache_id.json");

        return $value ? unserialize($value) : null;
    }
    else {
        $value = serialize($value);
        file_put_contents($LOBSTER_APP_TMPDIR . "/$cache_id.json", $value);
    }
}

