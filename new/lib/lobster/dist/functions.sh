#!/bin/bash
# 
# @file
# Defines Lobster core functions.

#
# Load the configuration cascade by name
# 
# Given 1='my_app' the files will load in this order
# 
# 2. $LOBSTER_APP_ROOT/.my_appconfig
# 3. ~/.my_appconfig
# 5. The first file found in parent dirs, if found.
# 
# @param string app name, e.g. 'my_app'
#
function lobster_load_config() {
  base=$1
  path_to_config="$LOBSTER_APP_ROOT/install/$base"
  if ! test -e "$path_to_config"; then
    lobster_failed "You must create $path_to_config before your app will run.";
  fi
  declare -a cascade=("$path_to_config" "$HOME/$base" "$LOBSTER_INSTANCE_ROOT/$base" );
  for file in "${cascade[@]}"; do
    if [ -f "$file" ]; then
      lobster_core_verbose "Loading config file: $file"
      source "$file"
    fi
  done

#  path=$(lobster_upfind $base && echo "$lobster_upfind_dir")
#  if [ "$path" != "" ] && [ -f "$path" ]; then
#    source "$path"
#    lobster_core_verbose "Loading config file: $path"
#  fi
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

function lobster_show_debug {
  if [ $lobster_debug -eq 1 ]; then
    lobster_include 'debug'
  fi  
}

#
# Includes a bash script cascade by basename.
# 
# If the argument is not a path, it will be assumed to be located in
# $LOBSTER_APP_ROOT/includes.  Scripts may be of type .sh
#
# @param string $script  Script name without extension or path without extension
#
function lobster_include() {
  local path_to_include="$1"
  local dir=''
  if ! [ -f "$path_to_include" ]; then
    path_to_include="$LOBSTER_APP_ROOT/includes/$path_to_include.sh"
  fi

  # Run the include at the project layer
  if [ -f "$path_to_include" ]; then
    include=$(lobster_app_relative_path $path_to_include)
    lobster_core_verbose "$lobster_t_include_found$include"
    source "$path_to_include"
  else
    include=$(lobster_app_relative_path $path_to_include)
    lobster_core_verbose "$lobster_t_include_missing$include"
  fi
}

#
# Extracts all flags (values beginning with a single -) from an array
#
# DO NOT CALL THIS FUNCTION USE: $lobster_flags INSTEAD.
#
# @param array
#
# @code
#   _lobster_get_flags ${@}
#   declare -a lobster_flags=("${_lobster_get_flags_return[@]}")
# @endcode
#
declare -a _lobster_get_flags_return=();
function _lobster_get_flags() {
  for arg in "$@"; do
    if [[ "$arg" =~ ^-([a-z]+) ]]; then
      for ((i=0; i < ${#BASH_REMATCH[1]}; i++)); do
        _lobster_get_flags_return=("${_lobster_get_flags_return[@]}" "${BASH_REMATCH[1]:$i:1}")
      done
    fi
  done
}

#
# Extracts all flags (values beginning with a single -) from an array
#
# DO NOT CALL THIS FUNCTION USE: $lobster_params INSTEAD.
#
declare -a _lobster_get_params_return=();
function _lobster_get_params() {
  for arg in "$@"; do
    if [[ "$arg" =~ ^--(.*) ]]; then
      _lobster_get_params_return=("${_lobster_get_params_return[@]}" "${BASH_REMATCH[1]}")
    fi
  done
}

#
# Sets an array with all arguments (not including the operation)
#
# DO NOT CALL THIS FUNCTION USE: $lobster_args INSTEAD.
#
declare -a _lobster_get_args_return=();
function _lobster_get_args() {
  for arg in "${@}"; do
    if [[ ! "$arg" =~ ^-(.*) ]]; then
      _lobster_get_args_return=("${_lobster_get_args_return[@]}" "$arg")
    fi
  done
}

#
# Echos the lobster environment as JSON to pass to PHP via environment variable.
#
# regex find: ^.+$
# regex replace: printf '"$0":"%s",' \$$0
function lobster_env() {

    # Notes about the variables to use
    # Do not include any variables that:
    # - begin with _lobster
    # - is called *_JSON

    printf '{'

    # Add variable values
    printf '"LOBSTER_APP":"%s",' $LOBSTER_APP
    printf '"LOBSTER_APP_ROOT":"%s",' $LOBSTER_APP_ROOT
    printf '"LOBSTER_APP_TMPDIR":"%s",' $LOBSTER_APP_TMPDIR
    printf '"LOBSTER_CWD":"%s",' $LOBSTER_CWD
    printf '"LOBSTER_CWD_ROOT":"%s",' $LOBSTER_CWD_ROOT
    printf '"LOBSTER_ENV":"%s",' $LOBSTER_ENV
    printf '"LOBSTER_INSTANCE_ROOT":"%s",' $LOBSTER_INSTANCE_ROOT
    printf '"LOBSTER_PWD":"%s",' $LOBSTER_PWD
    printf '"LOBSTER_PWD_ROOT":"%s",' $LOBSTER_PWD_ROOT
    printf '"LOBSTER_ROOT":"%s",' $LOBSTER_ROOT
    printf '"LOBSTER_TMPDIR":"%s",' $LOBSTER_TMPDIR
    printf '"lobster_access_denied":"%s",' $lobster_access_denied
    printf '"lobster_app_config":"%s",' $lobster_app_config
    printf '"lobster_app_config_dir":"%s",' $lobster_app_config_dir
    printf '"lobster_app_name":"%s",' $lobster_app_name
    printf '"lobster_app_title":"%s",' $lobster_app_title
    printf '"lobster_args":"%s",' "${lobster_args[*]}"
    printf '"lobster_bash":"%s",' $lobster_bash
    printf '"lobster_color_bright":"%s",' $lobster_color_bright
    printf '"lobster_color_confirm":"%s",' $lobster_color_confirm
    printf '"lobster_color_current":"%s",' $lobster_color_current
    printf '"lobster_color_default":"%s",' $lobster_color_default
    printf '"lobster_color_error":"%s",' $lobster_color_error
    printf '"lobster_color_info":"%s",' $lobster_color_info
    printf '"lobster_color_input":"%s",' $lobster_color_input
    printf '"lobster_color_input_suggestion":"%s",' $lobster_color_input_suggestion
    printf '"lobster_color_notice":"%s",' $lobster_color_notice
    printf '"lobster_color_success":"%s",' $lobster_color_success
    printf '"lobster_color_verbose":"%s",' $lobster_color_verbose
    printf '"lobster_color_warning":"%s",' $lobster_color_warning
    printf '"lobster_core_verbose_prefix":"%s",' "$lobster_core_verbose_prefix"
    printf '"lobster_debug":"%s",' $lobster_debug
    printf '"lobster_default_route":"%s",' $lobster_default_route
    printf '"lobster_format_date":"%s",' "$lobster_format_date"
    printf '"lobster_format_datetime":"%s",' "$lobster_format_datetime"
    printf '"lobster_format_time":"%s",' "$lobster_format_time"
    printf '"lobster_flags":"%s",' "${lobster_flags[*]}"
    printf '"lobster_has_params_return":"%s",' $lobster_has_params_return
    printf '"lobster_input_return":"%s",' $lobster_input_return
    printf '"lobster_logs":"%s",' $lobster_logs
    printf '"lobster_op":"%s",' $lobster_op
    printf '"lobster_params":"%s",' "${lobster_params[*]}"
    printf '"lobster_php":"%s",' $lobster_php
    printf '"lobster_route":"%s",' $lobster_route
    printf '"lobster_route_extensions":"%s",' "${lobster_route_extensions[*]}"
    printf '"lobster_route_id":"%s",' $lobster_route_id
    printf '"lobster_suggestions":"%s",' $lobster_suggestions
    printf '"lobster_t_include_found":"%s",' "$lobster_t_include_found"
    printf '"lobster_t_include_missing":"%s",' "$lobster_t_include_missing"
    printf '"lobster_target_dir":"%s",' $lobster_target_dir
    printf '"lobster_target_error":"%s",' $lobster_target_error
    printf '"lobster_theme":"%s",' "$lobster_theme"
    printf '"lobster_theme_source":"%s",' "$lobster_theme_source"
    printf '"lobster_tpl_extensions":"%s",' "$lobster_tpl_extensions"
    printf '"lobster_upfind_dir":"%s",' "$lobster_upfind_dir"
    printf '"lobster_user":"%s",' "$lobster_user"

    # Last one cannot have comma
    # This one needs to be escaped for json because of the \; we do it by hand but that could be problematic?
    printf '"lobster_escape_char":"\%s"' $lobster_escape_char

    # Close out the object
    printf '}'
}

##
 # Determine if a shell function exists
 #
function lobster_function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}
