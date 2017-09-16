#!/bin/bash
#
#  Define Lobster API Functions dealing with application flow, context, variables, etc.

##
 # Extract the value of a script param e.g. (--param=value)
 #
 # @code
 # value=$(lobster_get_param try)
 # @endcode
 #
 # @param string $1
 #   The name of the param
 # @param string $2
 #   The default value
 #
function lobster_get_param() {
  for var in "${lobster_params[@]}"; do
    if [[ "$var" =~ ^(.*)\=(.*) ]] && [ ${BASH_REMATCH[1]} == $1 ]; then
      echo ${BASH_REMATCH[2]}
      return
    fi
  done
  echo $2
}

##
 # Test for a parameter
 #
 # @code
 # if has_param code; then
 # @endcode
 #
 # @param string $1a
 #   The param name to test for, omit the -
 #
 # @return int
 #   0: it has the param
 #   1: it does not have the param
 #
function lobster_has_param() {
  for var in "${lobster_params[@]}"; do
    if [[ "$var" =~ $1 ]]; then
      return 0
    fi
  done
  return 1
}


##
 # Test for a multiple parameters at once.
 #
 # @code
 #   declare -a array=('ini' 'json' 'yaml' 'yml');
 #   if lobster_has_params ${array[@]}; then
 #     info_file="$lobster_app_name.$lobster_has_params_return";
 #   fi
 # @endcode
 #
 # @param string $1a
 #   The param name to test for, omit the -
 #
 # @return int
 #   0: it has one of the params; $lobster_has_params_return is set with the first matched param.
 #   1: it does not have any of the param
 #
lobster_has_params_return=''
function lobster_has_params() {
  for var in "${lobster_params[@]}"; do
    declare -a test=("$var" "${@}")
    if lobster_in_array ${test[@]}; then
      lobster_has_params_return="$var"
      return 0
    fi
  done
  return 1
}

##
 # Test for a flag
 #
 # @code
 # if has_flag s; then
 # @endcode
 #
 # @param string $1
 #   The flag name to test for, omit the -
 #
 # @return int
 #   0: it has the flag
 #   1: it does not have the flag
 #
function lobster_has_flag() {
  for var in "${lobster_flags[@]}";do
    if [[ "$var" =~ $1 ]];then
      return 0
    fi
  done
  return 1
}


#
# This function is called at the end of the route.
#
# It may need to be changed to 'return' for some apps.  See docs for more info
#
function lobster_route_end() {
  lobster_set_route_status 0
  lobster_theme 'footer'
  lobster_include 'shutdown'
  exit 0
}

function lobster_failed() {
  lobster_error "$1"
  lobster_include "failed"
  lobster_exit 1
}

#
# Prints the footer and exits the script with optional exit status 0-5
function lobster_exit() {
  lobster_theme 'footer'
  lobster_include 'shutdown'
  # @todo Can't find a way to typecast so arg is a numeric argument.
  case "$1" in
  1)
    exit 1 ;;
  2)
    exit 2 ;;
  3)
    exit 3 ;;
  4)
    exit 4 ;;
  5)
    exit 5 ;;
  esac

  exit 0
}

#
#
# @code
#   if [ $(lobster_get_route_status) -eq 0 ]; then...
# @endcode
#
function lobster_get_route_status() {
   status=$(cat "$LOBSTER_TMPDIR/route_status")

   return $status
}

#
# Sets the route status
#
# @param int $1 Any non zero value means the route failed.
#
function lobster_set_route_status() {
    echo $1 > "$LOBSTER_TMPDIR/route_status"
}

##
 # Access check for routing.
 #
function lobster_access() {
  if ! lobster_function_exists $1; then
    lobster_failed "The required access callback '$1' does not exist."
  fi
  if ! eval ${1}; then
    if [ "$lobster_access_denied" ]; then
      lobster_error "$lobster_access_denied"
    fi
    lobster_failed
  fi
}
