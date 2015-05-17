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

source "$lobster_root/.lobsterconfig"
if [ -f "$root/.lobsterconfig" ]; then
  source "$root/.lobsterconfig"
fi

# Load all our functions.
source "$lobster_root/functions.sh"

lobster_php=$(which php)

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

# Bootstrap the project layer
lobster_include 'bootstrap'
lobster_include 'functions'
