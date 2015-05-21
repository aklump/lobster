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
lobster_root="$( cd -P "$( dirname "$source" )" && pwd )"

lobster_tmpdir="$TMPDIR"
lobster_php=$(which php)
lobster_bash=$(which bash)

source "$lobster_root/.lobsterconfig"
if [ -f "$root/.lobsterconfig" ]; then
  source "$root/.lobsterconfig"
fi

# Load all our functions.
source "$lobster_root/functions.sh"

# Set up the default text colors.
lobster_color_current=''
lobster_color $lobster_color_default
lobster_op=$1

# Sort out the args, flags and params.
declare -a lobster_args=()
declare -a lobster_flags=()
declare -a lobster_params=()
for arg in "$@"; do
  if [[ "$arg" =~ ^--(.*) ]]
  then
    lobster_params=("${lobster_params[@]}" "${BASH_REMATCH[1]}")
  elif [[ "$arg" =~ ^-(.*) ]]
  then
    lobster_flags=("${lobster_flags[@]}" "${BASH_REMATCH[1]}")
  else
    lobster_args=("${lobster_args[@]}" "$arg")
  fi
done

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

if [ ! -d "$lobster_tmpdir" ] && [ ! mkdir "$lobster_tmpdir "]; then
  lobster_warning "Cannot create tmpdir at $lobster_tmpdir"
fi

# Bootstrap the project layer
lobster_include 'bootstrap'
lobster_include 'functions'

