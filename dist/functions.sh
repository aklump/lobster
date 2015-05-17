#!/bin/bash
# 
# @file
# Defines Lobster core functions.

#
# Produces an error output
#
# @param string $arg
#
function lobster_error() {
  local stash=$lobster_color_current
  lobster_color 'red'
  lobster_echo "$1"
  lobster_color "$stash"
  lobster_exit
}

#
# Produces an error output
#
# @param string $arg
#
function lobster_warning() {
  local stash=$lobster_color_current
  lobster_color 'yellow'
  lobster_echo "$1"
  lobster_color "$stash"
  lobster_exit
}

#
# Produces an error output
#
# @param string $arg
#
function lobster_success() {
  local stash=$lobster_color_current
  lobster_color 'green'
  lobster_echo "$1"
  lobster_color "$stash"
  lobster_exit
}

#
# Sets the output color.
#
# @param int 0-7
#
function lobster_color() {
  lobster_color_current=$1
  case $lobster_color_current in
    'grey' )
      lobster_color_current=0
      ;;
    'red' )
      lobster_color_current=1
      ;;
    'green' )
      lobster_color_current=2
      ;;
    'yellow' )
      lobster_color_current=3
      ;;
    'blue' )
      lobster_color_current=4
      ;;                  
    'pink' )
      lobster_color_current=5
      ;;
    'cyan' )
      lobster_color_current=6
      ;;
    'white' )
      lobster_color_current=7
      ;;            
  esac
}

#
# Prints one or more messages in the current color.
#
# @param string|array $arg
#
function lobster_echo() {
  for line in "${@}"; do
    echo "`tty -s && tput setaf $lobster_color_current`$line`tty -s && tput op`"  
  done
}

lobster_theme_source=''
function lobster_theme() {
  source=$1
  if [ ! -f "$source" ]; then
    for ext in "${lobster_tpl_extensions[@]}"; do
      if [ -f "$root/themes/$lobster_theme/tpl/$1.$ext" ]; then
        source="$root/themes/$lobster_theme/tpl/$1.$ext"
      fi
    done
  fi

  if [ ! "$source" ]; then
    return
  fi
  ext="${source##*.}"

  # preprocess
  processor=$source
  processor="${processor/tpl/pre}"
  processor="${processor/$ext/sh}"
  if [ -f "$processor" ]; then
    source "$processor"
  fi
  
  # Load the file content.
  lobster_theme_source="$source"
  output=$(cat "$source")
  if [ "$output" ]; then 
    echo "`tty -s && tput setaf $lobster_color_current`$output`tty -s && tput op`"
  fi

  # postprocess
  processor=$source
  processor="${processor/tpl/post}"
  processor="${processor/$ext/sh}"
  if [ -f "$processor" ]; then
    source "$processor"
  fi

}

#
# Prints the footer and exits the script
function lobster_exit() {
  lobster_theme 'footer'
  lobster_include 'shutdown'  
  exit;
}

function lobster_show_debug {
  if [ $lobster_debug -eq 1 ]; then
    lobster_include 'debug'
  fi  
}

#
# Includes a script cascade by basename
# 
# If the argument is not a path, it will be assumed to be located in
# $root/includes.  Scripts may be of type .sh or .php. .sh scripts are executed
# before .php scripts if ever the basename is the same.
#
# @param string $script  Script name without extension or path without extension
#
function lobster_include() {
  local basename=$1
  local dirname=''
  if [ "$basename" == "${basename##*/}" ]; then
    dir="$root/includes"
  fi

  # Run a bootstrap a the project layer
  if [ -f "$dir/$basename.sh" ]; then
    source "$dir/$basename.sh"
  fi
  if [ -f "$dir/$basename.php" ]; then
    $lobster_php "$dir/$basename.php"
  fi  
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
  for var in "${lobster_params[@]}"
  do
    if [[ "$var" =~ $1 ]]; then
      return 0
    fi
  done
  return 1
}

##
 # Extract the value of a script param e.g. (--param=value)
 #
 # @code
 # value=$(lobster_get_param try)
 # @endcode
 #
 # @param string $1
 #   The name of the param
 #
function lobster_get_param() {
  for var in "${lobster_params[@]}"
  do
    if [[ "$var" =~ ^(.*)\=(.*) ]] && [ ${BASH_REMATCH[1]} == $1 ]; then
      echo ${BASH_REMATCH[2]}
      return
    fi
  done
}

#
# Returns a json string for passing to php scripts
#
# @param string $arg
#
function lobster_json() {
  local json=''
  local snippet=''

  #
  #
  # Begin child: lobster
  #
  json=$json{\"lobster\":{
  json=$json\"root\"\:\"$lobster_root\",
  json=$json\"default_route\"\:\"$lobster_default_route\",
  json=$json\"theme\"\:\"$lobster_theme\",
  json=$json\"debug\"\:$lobster_debug,
  json=$json\"php\"\:\"$lobster_php\",

  json=$json\"route_extensions\"\:\[
  snippet=''
  for flag in "${lobster_route_extensions[@]}"; do
    snippet=$snippet\"$flag\",
  done
  json=$json${snippet%,}\],  

  json=$json\"tpl_extensions\"\:\[
  snippet=''
  for flag in "${lobster_tpl_extensions[@]}"; do
    snippet=$snippet\"$flag\",
  done
  json=$json${snippet%,}\]
      
  json=$json\},

  #
  #
  # Begin child: app
  #
  json=$json\"app\":{
  json=$json\"name\"\:\"$lobster_app_name\",
  json=$json\"title\"\:\"$lobster_app_title\",
  json=$json\"root\"\:\"$root\",
  json=$json\"op\"\:\"$lobster_op\",
  json=$json\"route\"\:\"$lobster_route\",
  json=$json\"tpl\"\:\"$lobster_theme_source\",

  #Add in the suggestions
  json=$json\"suggestions\"\:\[
  snippet=''
  for flag in "${lobster_suggestions[@]}"; do
    snippet=$snippet\"$flag\",
  done
  json=$json${snippet%,}\],

  # The args
  json=$json\"args\"\:\[
  snippet=''
  for flag in "${lobster_args[@]}"; do
    snippet=$snippet\"$flag\",
  done
  json=$json${snippet%,}\],  

  # Add in the flags
  json=$json\"flags\"\:\[
  snippet=''
  for flag in "${lobster_flags[@]}"; do
    snippet=$snippet\"$flag\",
  done
  json=$json${snippet%,}\],
  
  # Add in the params
  json=$json\"parameters\"\:\{
  snippet=''
  for param in "${lobster_params[@]}"; do
    if [[ "$param" =~ ^(.*)\=(.*) ]]; then
      snippet=$snippet\"${BASH_REMATCH[1]}\"\:\"${BASH_REMATCH[2]}\",
    fi
  done
  json=$json${snippet%,}\}


  json=$json\}\}
  echo $json
}
