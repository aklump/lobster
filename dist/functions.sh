#!/bin/bash
# 
# @file
# Defines Lobster core functions.


#
# Load the configuration cascade by name
# 
# Given 1='lobster' the files will load in this order
# 
# 1. $lobster_root/.lobsterconfig
# 2. $lobster_app_root/.lobsterconfig
# 3. ~/.lobsterconfig
# 4. $pwd/.lobsterconfig
# 5. The first file found in parent dirs, if found.
# 
# @param string app name, e.g. 'lobster'
#
function lobster_load_config() {
  base=$1
  declare -a cascade=("$lobster_root/$base" "$lobster_app_root/$base" "$HOME/$base" "$PWD/$base");
  for file in "${cascade[@]}"; do
    if [ -f "$file" ]; then
      lobster_core_verbose "Loading config file: $file"
      source "$file"
    fi
  done

  path=$(lobster_upfind $base && echo "$lobster_upfind_dir")
  if [ "$path" != "" ] && [ -f "$path" ]; then
    source "$path"
    lobster_core_verbose "Loading config file: $path"
  fi
}

function lobster_verbose() {
  if lobster_has_flag "v"; then
    lobster_color_echo "verbose" $1
  fi
}

function lobster_core_verbose() {
  if [ ! "$lobster_core_verbose" ] || [ $lobster_core_verbose -eq 1 ]; then 
    lobster_verbose "$1"
  fi
}

##
 # Recursive search for file in parent dirs
 # 
 # @param string This may only be  filename, not a dir/name
 #  
 # usage
 #   path=$(lobster_upfind $base && echo "$lobster_upfind_dir")
 #
lobster_upfind_dir=''
function lobster_upfind () {
  lobster_upfind_dir=''
  file=$(basename "$1")
  test / == "$PWD" && return 1 || test -e "$file" && lobster_upfind_dir="${PWD}/$file" && return || cd .. && lobster_upfind "$file"
}


#
# Produces an error output
#
# @param string $arg
#
function lobster_error() {
  local stash=$lobster_color_current
  lobster_color 'error'
  lobster_echo "$1"
  lobster_color "$stash"
}

#
# Produces an error output
#
# @param string $arg
#
function lobster_warning() {
  local stash=$lobster_color_current
  lobster_color 'warning'
  lobster_echo "$1"
  lobster_color "$stash"
}

#
# Produces an error output
#
# @param string $arg
#
function lobster_success() {
  local stash=$lobster_color_current
  lobster_color 'success'
  lobster_echo "$1"
  lobster_color "$stash"
}

#
# Produces an error output
#
# @param string $arg
#
function lobster_notice() {
  local stash=$lobster_color_current
  lobster_color 'notice'
  lobster_echo "$1"
  lobster_color "$stash"
}

#
# Sets the output color.
#
# @param int|string  One of a color name or semantic string or a color 0-7.
# 
# You can also set the color to null and lobster_echo will not print the tty
# commands.
#
function lobster_color() {

  # First allow the passing of a number
  if [[ "$1" -ge 0 ]] && [[ "$1" -le 7 ]]; then
    lobster_color_current=$1
  fi

  case $1 in
    
    # Color names
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

    # Semantic
    'notice' )
      lobster_color $lobster_color_notice
      ;;
    
    'warning' )
      lobster_color $lobster_color_warning
      ;;
    
    'error' )
      lobster_color $lobster_color_error
      ;;

    'success' )
      lobster_color $lobster_color_success
      ;;            

  esac
}

#
# Prints one or more messages in the current color.
#
# @param string|array $arg
#
function lobster_echo() {
  line="${@}"
  if [ -d "$lobster_logs" ]; then
    echo $line >> "$lobster_logs/echo.txt"
  fi

  if [ "$lobster_debug" == "1" ] || ! lobster_has_param 'lobster-quiet'; then
    if [ "$lobster_color_current" == "null" ]; then
      echo "$line"
    else
      echo "`tty -s && tput setaf $lobster_color_current`$line`tty -s && tput op`"
    fi
  fi
}

#
# Prints one or more lines in a color, but does not change the color setting.
# 
# @param string|int The argument to pass to lobster_color
# @param string|array $lines Will be passed to lobster_echo.
#
function lobster_color_echo() {
  local stash=$lobster_current_color
  lobster_color $1
  lines=${@:2}
  lobster_echo $lines
  lobster_color $stash
}

lobster_theme_source=''
function lobster_theme() {
  if [ $lobster_debug -eq 0 ] && lobster_has_param 'lobster-quiet'; then
    return
  fi  
  source=$1
  if [ ! -f "$source" ]; then
    for ext in "${lobster_tpl_extensions[@]}"; do
      if [ -f "$lobster_app_root/themes/$lobster_theme/tpl/$1.$ext" ]; then
        source="$lobster_app_root/themes/$lobster_theme/tpl/$1.$ext"
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
  if [ -f "$source" ]; then
    lobster_theme_source="$source"
    output=$(cat "$source")
    if [ "$output" ]; then
      lobster_echo "$output"
    fi
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
# $lobster_app_root/includes.  Scripts may be of type .sh or .php. .sh scripts are executed
# before .php scripts if ever the basename is the same.
#
# @param string $script  Script name without extension or path without extension
#
function lobster_include() {
  local basename=$1
  local dirname=''
  if [ "$basename" == "${basename##*/}" ]; then
    dir="$lobster_app_root/includes"
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
  json=$json\"tmpdir\"\:\"$lobster_tmpdir\",

  json=$json\"default_route\"\:\"$lobster_default_route\",
  json=$json\"theme\"\:\"$lobster_theme\",
  json=$json\"debug\"\:$lobster_debug,
  json=$json\"bash\"\:\"$lobster_bash\",
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
  json=$json\"root\"\:\"$lobster_app_root\",
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

#
# Trim whitespace from a string
#
# @param string $string
# 
# result=$(lobster_trim arg)
#
function lobster_trim() {
  echo -e "${1}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}
