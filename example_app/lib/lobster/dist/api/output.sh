#!/usr/bin/env bash
#
# Define Lobster API Functions for output.

function lobster_verbose() {
  if lobster_has_flag "v"; then
    lobster_color_echo "verbose" ${@}
  fi
}

function lobster_core_verbose() {
  if [ ! "$lobster_core_verbose" ] || [ $lobster_core_verbose -eq 1 ]; then
    lobster_verbose "$lobster_core_verbose_prefix ${@}"
  fi
}


#
# Produces an error output
#
# @param string $arg
#
function lobster_error() {
  lobster_color_echo error "$1"
}

#
# Produces an error output
#
# @param string $arg
#
function lobster_warning() {
  lobster_color_echo warning "$1"
}

#
# Produces an error output
#
# @param string $arg
#
function lobster_success() {
  lobster_color_echo success "$1"
}

#
# Produces an error output
#
# @param string $arg
#
function lobster_info() {
  lobster_color_echo info "$1"
}

#
# Produces an error output
#
# @param string $arg
#
function lobster_notice() {
  lobster_color_echo notice "$1"
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
  lobster_color_current=$1

  case $1 in

    # Transform color words to codes
    'grey' )
      lobster_color_current="$lobster_color_bright;30"
      ;;
    'red' )
      lobster_color_current="$lobster_color_bright;31"
      ;;
    'green' )
      lobster_color_current="$lobster_color_bright;32"
      ;;
    'yellow' )
      lobster_color_current="$lobster_color_bright;33"
      ;;
    'blue' )
      lobster_color_current="$lobster_color_bright;34"
      ;;
    'magenta' )
      lobster_color_current="$lobster_color_bright;35"
      ;;
    'pink' )
      lobster_color_current="$lobster_color_bright;35"
      ;;
    'cyan' )
      lobster_color_current="$lobster_color_bright;36"
      ;;
    'white' )
      lobster_color_current="$lobster_color_bright;37"
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

    'confirm' )
      lobster_color $lobster_color_confirm
      ;;

    'verbose' )
      lobster_color $lobster_color_verbose
      ;;

    'info' )
      lobster_color $lobster_color_info
      ;;
  esac
}

#
# Prints one or more messages in the current color.
#
# @param string|array $arg
#
# @todo Support for background colors.
#
function lobster_echo() {
  line="${@}"
  if [ -d "$lobster_logs" ]; then
    echo -e $line >> "$lobster_logs/echo.txt"
  fi

  if [ "$lobster_debug" == "1" ] || ! lobster_has_param 'lobster-quiet'; then
    if [ "$lobster_color_current" == "null" ] || [ ! "$line" ] || [ ! "$lobster_escape_char" ]; then
      echo -e "$line"
    else
      esc=$lobster_escape_char
      fore=$lobster_color_current
      echo -e "${esc}[${fore}m${line}${esc}[0m"
    fi
  fi
}

#
# Writes a message to a log file.
#
# @param string|array $arg
function lobster_log() {
  if [ "$lobster_logs" ]; then
    type=$1
    message=$2
    severity=$3
    line="\"$(lobster_datetime)\",\"$(whoami)\",\"$message\",\"$severity\""
    echo -e $line >> "$lobster_logs/$type.csv"
  else
    lobster_error "Please enable $lobster_logs"
  fi
}

#
#
# Outputs the argument(s) in bold
#
function lobster_strong() {
  esc=$lobster_escape_char
  line=${@}
  echo -e "$esc[1m$line$esc[0m"
}

#
#
# Outputs the argument(s) underlined
#
function lobster_underline() {
  esc=$lobster_escape_char
  line=${@}
  echo -e "$esc[4m$line$esc[0m"
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
  lobster_echo "${@:2}"
  lobster_color $stash
}


function lobster_echo_core_variables() {
  lobster_echo "$(compgen -A variable | grep LOBSTER)"
  lobster_echo "$(compgen -A variable | grep lobster)"
}

function lobster_echo_app_variables() {
    compgen -A variable | grep $lobster_app_name
}


lobster_theme_source=''
function lobster_theme() {
  if [ $lobster_debug -eq 0 ] && lobster_has_param 'lobster-quiet'; then
    return
  fi

  source=$1
  if lobster_has_param "lobster-nowrap" && ( [ "$source" == 'header' ] || [ "$source" == 'footer' ] ); then
    return
  fi

  if [ ! -f "$source" ]; then
    for ext in "${lobster_tpl_extensions[@]}"; do
      if [ -f "$LOBSTER_APP_ROOT/themes/$lobster_theme/tpl/$1.$ext" ]; then
        source="$LOBSTER_APP_ROOT/themes/$lobster_theme/tpl/$1.$ext"
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
    lobster_include "$processor"
  fi

  # Load the file content.
  if [ -f "$source" ]; then
    include=$(lobster_app_relative_path $source)
    local stash=$lobster_color_current
    lobster_core_verbose "$lobster_t_include_found$include"
    lobster_color_current=$stash
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
    lobster_include "$processor"
  fi
}


##
 # Clears all previously added twig vars.
 #
function lobster_clear_twig_vars() {
  file="$LOBSTER_TMPDIR/twig_vars.csv"
  test -e $file && rm "$file"
  lobster_verbose "Twig vars cleared from $LOBSTER_TMPDIR/twig_vars.csv"
}

##
 # Add a key/value variable to be used by lobster_process_twig()
 #
 # @code
 #   lobster_add_twig_var varName 'value'
 # @endcode
 #
function lobster_add_twig_var() {
  file="$LOBSTER_TMPDIR/twig_vars.csv"
  echo "$1,$2" >> $file
  lobster_verbose "Twig var $1 added to $file"
}

##
 # Process a twig file located at $1 with all vars added via lobster_add_twig_var.
 #
 # @code
 #   replaced=$(lobster_process_twig '/path/to/template.twig')
 # @endcode
 #
function lobster_process_twig() {
  file=$1
  if ! test -e $file; then
    lobster_error "Cannot process non-existent twig file: $file"
  fi
  source="$(cat $file)"
  while IFS='' read -r line || [[ -n "$line" ]]; do
    data=(${line//,/ })
    find="{{ ${data[0]} }}"
    replace="${data[1]}"
    source="${source/$find/$replace}"
  done < "$LOBSTER_TMPDIR/twig_vars.csv"

  echo "$source"
}
