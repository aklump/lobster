#!/bin/bash
#
#  Define Lobster API Functions for gathering input.

##
 # Capture some input (w/optional default)
 #
 # @param string The question to ask.
 # @param string An optional default value.
 #
 # @see $lobster_input_return
 #
 # @code
 #   input=$(lobster_input "First day?" 'Sunday')
 # @endcode
 #
lobster_input_return=''
function lobster_input() {
  local default="$2"
  local esc=$lobster_escape_char
  local fore=$lobster_color_input
  local fore2=$lobster_color_input_suggestion
  local prompt="$1"
  local response
  if [ "$default" ]; then
    prompt="$prompt [${esc}[0m${esc}[${fore2}m$default${esc}[0m${esc}[${fore}m]${esc}[0m"
  fi
  echo -e -n "${esc}[${fore}m${prompt}${esc}[${fore}m?:${esc}[0m "
  read -e input
  lobster_input_return="${input:-$default}"
}


##
 # Accept a y/n confirmation message or end
 #
 # @param string $1
 #   A question to ask
 # @param string $2
 #   A flag, e.g. noend; which means a n will not exit
 #
 # @return bool
 #   Sets the value of confirm_result
 #
function lobster_confirm() {
  local esc=$lobster_escape_char
  local fore=$lobster_color_confirm
  local prompt="${esc}[${fore}m${1}? [y/N] ${esc}[0m"
  local response

  # The echo -n option suppresses the trailing newline.
  echo -e -n $prompt
  # -n 1 means to read just 1 char
  read -n 1 response && echo
  case $response in
      [yY][eE][sS]|[yY])
          return 0
          ;;
  esac
  return 1
}
