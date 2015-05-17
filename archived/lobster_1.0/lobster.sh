#!/bin/bash
# 
# @file
# 
# A lobster shell controller file.
# 
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do
  dir="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$dir/$source"
done
source "$( cd -P "$( dirname "$source" )" && pwd )/core.sh"

lobster_bootstrap ${@}

# Controller begins.
if lobster_deliver; then
  lobster_exit
fi

lobster_header "Welcome to Lobster"

# Must remain last.
lobster_exit