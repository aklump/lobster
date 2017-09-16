<?php

function lobster_date()
{
    global $lobster_format_date;

    return exec('date +"' . $lobster_format_date . '"');
}

function lobster_datetime()
{
    global $lobster_format_datetime;

    return exec('date +"' . $lobster_format_datetime . '"');
}

function lobster_time()
{
    global $lobster_format_time;

    return exec('date +"' . $lobster_format_time . '"');
}

function lobster_app_relative_path($path)
{
    global $LOBSTER_APP_ROOT;

    return str_replace($LOBSTER_APP_ROOT . '/', '', $path);
}
