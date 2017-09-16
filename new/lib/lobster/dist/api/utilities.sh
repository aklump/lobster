#!/usr/bin/env bash
#
# Define Lobster API utility functions

##
 # Echo the current date.
 #
function lobster_date() {
  date +"$lobster_format_date"
}

##
 # Echo the current date and time.
 #
function lobster_datetime() {
  date +"$lobster_format_datetime"
}

##
 # Echo the current unix timestamp.
 #
function lobster_time() {
  date +"$lobster_format_time"
}

##
 # Echo a path with the app root removed so that it appears relative to the app root.
 #
 # @param string A fullpath to a file or folder within the app.
 #
function lobster_app_relative_path() {
    echo ${1/$LOBSTER_APP_ROOT\//}
}
