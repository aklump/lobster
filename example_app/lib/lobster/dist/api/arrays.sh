#!/bin/bash
#
#  Define Lobster API Functions for working with arrays.

function lobster_array_get_shortest_value() {
  local arrayname=${1:?Array name required} varname=${2:-shortest}
  local IFS= string e

  eval "array=( \"\${$arrayname[@]}\" )"
  shortest=${array[0]}
  for e in "${array[@]}"; do
    [[ ${#e} -lt ${#shortest} ]] && shortest=$e
  done
  [[ "$varname" != shortest ]] && eval "$varname=${shortest}"
}

#
# Shift the first element from an array
#
# @param string The name of an array; omit the dollar sign, your passing a string of the array name, not the array reference!
#
# @code
#   declare -a my_array=( do re mi )
#   lobster_array_shift my_array
# @endcode
# ... my_array === ( re mi )
function lobster_array_shift() {
  local arrayname=${1:?Array name required}
  eval "$arrayname=( \"\${$arrayname[@]:1}\" )"
}

#
# Checks for a value in a an array
#
# @param array  The first element will be shifted off and used as the needle
#
# @code
#   declare -a array=("e" "do" "re" "e")
#   if lobster_in_array ${array[@]}; then
#     echo "found"
#   fi
# @endcode
#
# @code
#   needle="do"
#   haystack=("do" "re" "e")
#   array=($needle "${haystack[@]}")
#   if lobster_in_array ${array[@]}; then
#     echo "found"
#   fi
# @endcode
#
function lobster_in_array() {
  needle=$1
  for var in "${@:2}"; do
    if [[ "$var" =~ "$needle" ]]; then
      return 0
    fi
  done
  return 1
}
