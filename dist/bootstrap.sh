#!/bin/bash
# 
# @file
# Lobster shell core bootstrapping.
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  dir="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$dir/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
LOBSTER_ROOT="$( cd -P "$( dirname "$source" )" && pwd )"

LOBSTER_TMPDIR="$TMPDIR"
lobster_php=$(which php)
lobster_bash=$(which bash)

# Load all our functions.
source "$LOBSTER_ROOT/functions.sh"

# Sort out the args, flags and params.
lobster_get_flags ${@}
declare -a lobster_flags=("${lobster_get_flags_return[@]}")
lobster_get_params ${@}
declare -a lobster_params=("${lobster_get_params_return[@]}")
lobster_get_args ${@}
declare -a lobster_args=("${lobster_get_args_return[@]}")

lobster_load_config ".lobsterconfig"
lobster_load_config "$lobster_app_config"

lobster_core_verbose "Flags: ${lobster_flags[@]}"
lobster_core_verbose "Params: ${lobster_params[@]}"
lobster_core_verbose "Args: ${lobster_args[@]}"

# This is the first parent directory containing the app's config file that is
# above $PWD.
LOBSTER_PWD_ROOT=$(lobster_upfind "$lobster_app_config" && echo $(dirname "$lobster_upfind_dir"))

# Set up the default text colors.
lobster_color_current=''
lobster_color $lobster_color_default
lobster_op=${lobster_args[0]}


# By convention if you pass a second argument it will be taken as a
# target directory and checked.  The directory test will be stored in the
# variable lobster_target_error
# 
# App usage can go like this:
# 
# @code
#   if [ $lobster_target_error -eq 1 ]; then
#     lobster_error "'$lobster_target_dir' is not a directory!"
#     lobster_exit
#   fi
# @endcode
# 
lobster_target_dir="$PWD"
lobster_target_error=0
if [ "${lobster_args[1]}" ]; then
  lobster_target_dir="${lobster_args[1]}"
  if [ ! -d "${lobster_args[1]}" ]; then
    lobster_target_error=1
  fi
fi

# File logging.
if [ "$lobster_logs" ]; then
  if [ ! -d "$lobster_logs" ]; then
    mkdir -p "$lobster_logs"
  fi

  # Create a timestamp in the log to help make it readable.
  echo "" >> "$lobster_logs/echo.txt"
  echo ">>>>> $(date) -- Lobster thread started" >> "$lobster_logs/echo.txt"
fi

# Turns on debug based on the option, not the config file
if lobster_has_param "lobster-debug"; then
  lobster_debug=$(lobster_get_param "lobster-debug");
  if [ "$lobster_debug" == '' ]; then
    lobster_debug=1
  fi
fi

if [ "$lobster_debug" -eq 1 ]; then
  lobster_notice "Lobster debug mode is enabled."
fi

if [ ! -d "$LOBSTER_TMPDIR" ] && [ ! mkdir "$LOBSTER_TMPDIR "]; then
  lobster_warning "Cannot create tmpdir at $LOBSTER_TMPDIR"
fi

# Bootstrap the project layer
lobster_include 'bootstrap'
lobster_include 'functions'


export LOBSTER_ROOT
export LOBSTER_APP_ROOT
export LOBSTER_PWD_ROOT
export LOBSTER_TMPDIR
