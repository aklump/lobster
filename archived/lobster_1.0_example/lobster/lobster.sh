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
source "$( cd -P "$( dirname "$source" )" && pwd )/lobster/core.sh"
lobster_bootstrap ${@}

# Register menu item(s)
lobster_menu_item "init" "Initialize a new lobster project in the current dir."

# Controller begins.
if [[ lobster_deliver ]]; then
  lobster_exit
fi

# Must remain last.
lobster_exit