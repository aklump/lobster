#!/bin/bash
#
#  Define Lobster API Functions for working with strings.


#
#
# Strings Cheatsheet
#

#
#
# Replace one string with another
#
# result_string="${original_string/Suzi/$string_to_replace_Suzi_with}"


#
# Trim whitespace from a string
#
# @param string $string
#
# result=$(lobster_trim arg)
#
function  lobster_trim() {
  echo -e "${1}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}
