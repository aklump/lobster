#!/bin/bash
# 
# @file
# Lobster shell core file.
# 

##
 # Begin functions
 #

##
 # Echo the width of the terminal window in chars
 #
function lobster_window_width() {
  echo $(tput cols)
}

##
 # Echo the height of the terminal window in rows
 #
function lobster_window_height() {
  echo $(tput lines)
}

##
 # Print a text string (in an optional color)
 # 
 # Translation function; all output should be run through this
 # Any other formatters, h1, p, should ultimately call this function
 # 
 # @param string The text to output
 # @param string (Optional) The color of the text
 #   - default
 #   - green
 #   - yellow
 #   - red
 #
function lobster_div() {
  local color=$2
  local text=$1
  
  if [[ ! "$color" ]]; then
    color='default'
  fi
  _lobster_t_$color "$text"
}

function lobster_code() {
  lobster_br
  lobster_p "    $1" $2
}

function lobster_header() {
  _lobster_array_=("$@")
  local color=$(lobster_array_pop)
  local width=$(lobster_window_width)
  local line=$(lobster_str_repeat '-' "$width")
  # local title=$(lobster_strtoupper "$1")
  local title="$1"
  lobster_div "$line" $color
  lobster_div "$title" $color
  lobster_div "$line" $color
}

function lobster_hr() {
  local width=$(lobster_window_width)
  local line=$(lobster_str_repeat "-" "$width")
  lobster_div "$line" $1
}

function lobster_footer() {
  lobster_hr $2
  lobster_div "$1" $2
}

function lobster_br() {
  echo
}

function lobster_span() {
  lobster_div "$1" "$2"
}

function lobster_alert() {
  # local alert=$(lobster_strtoupper "$1")
  local alert="$1"
  echo
  lobster_p "--- $alert ---" "$2"
}

#
# Record debug and admin messages based on settings and permissions
# 
# All debug messages should go through this function
#
# @param string $string
#
function lobster_watchdog() {
  local string=$1
  # todo Base this on settings
  lobster_div "$string" pink
}

function lobster_progress() {
  local color='default'
  local indicator='OK'
  case $2 in
    'error') 
      color='red'
      indicator='ERROR'
      ;;
    'danger' )
      color='red'
      indicator='ERROR'
    ;;
    'warning' )
      color='yellow'
      indicator='WARNING'
      ;;
    'ok' )
      color='green'
      indicator='OK'
      ;;
    'status' )
      color='green'
      indicator='OK'
      ;;
    'success' )
      color='green'
      indicator='OK'
      ;;
  esac

  span=$(lobster_span "[$indicator]" $color)
  lobster_div "$1 $span"
}

function lobster_p() {
  lobster_div "$1" "$2"
  echo  
}

function lobster_h1() {
  # div '##' "$2"
  lobster_div "# $1" "$2"
  lobster_br
  # div '##' "$2"
}

function lobster_h2() {
  # div '#' "$2"
  lobster_div "## $1" "$2"
  lobster_br
  # div '#' "$2"
}

function lobster_h3() {
  # div '#' "$2"
  lobster_div "### $1" "$2"
  lobster_br
}

##
 # Register the table header row for the next table call
 # 
 # @param... string Each element becomes a single column header
 #
function lobster_th() {
  lobster_table_th=${@:1}
}

##
 # Register a new table row for the next table call
 # 
 # @param... string Each element becomes a single column header
 #
lobster_table_row_count=0
function lobster_tr() {

  local row=()
  for arg in "${@:1}"; do
    row=("${row[@]}" "$arg")
  done

  local name=$(echo "lobster_table_tr_$lobster_table_row_count")

  c=0
  for i in "${row[@]}"; do
    eval $name[$c]="'$i'"
    ((c++))
  done  

  lobster_table_row_count=$(($lobster_table_row_count + 1))
}

##
 # Print out the table in memory as registered with th() and tr()
 # 
 # @todo Need to normalize column widths
 #
function lobster_table() {
  # ??? http://stackoverflow.com/questions/6462894/how-can-i-format-the-output-of-a-bash-command-in-neat-columns
  
  # number of columns based on header
  local col_count=(${lobster_table_th[@]})
  col_count=${#col_count}

  # thead
  local thead=$(lobster_implode ' | ' ${lobster_table_th[@]})
  lobster_div "| $thead |" $1
  
  # dividing line
  declare -a local line=();
  for (( i = 1; i < $col_count; i++ )); do
    line=("${line[@]}" "---")
  done
  local row=$(lobster_implode '|' ${line[@]})
  lobster_div "|$row|" $1

  #tbody
  for (( i = 0; i < $lobster_table_row_count; i++ )); do
    eval row=( '"${lobster_table_tr_'${i}'[@]}"' )
    local cols=$(lobster_implode ' | ' "${row[@]}")
    lobster_div "| $cols |" $1
  done

  # clear the table data
  local name
  for (( i = 0; i < $lobster_table_row_count; i++ )); do
    name=$(echo "lobster_table_tr_$lobster_table_row_count")
    eval $name=''
  done
  lobster_table_row_count=0
  unset lobster_table_th

}

function _lobster_t_default() {
  echo $1
}

function _lobster_t_grey() {
  echo "`tty -s && tput setaf 0`$1`tty -s && tput op`"
}

function _lobster_t_red() {
  echo "`tty -s && tput setaf 1`$1`tty -s && tput op`"
}

function _lobster_t_danger() {
  echo "`tty -s && tput setaf 1`$1`tty -s && tput op`"
}

function _lobster_t_error() {
  echo "`tty -s && tput setaf 1`$1`tty -s && tput op`"
}

function _lobster_t_green() {
  echo "`tty -s && tput setaf 2`$1`tty -s && tput op`"
}

function _lobster_t_success() {
  echo "`tty -s && tput setaf 2`$1`tty -s && tput op`"
}

function _lobster_t_status() {
  echo "`tty -s && tput setaf 2`$1`tty -s && tput op`"
}

function _lobster_t_ok() {
  echo "`tty -s && tput setaf 2`$1`tty -s && tput op`"
}

function _lobster_t_yellow() {
  echo "`tty -s && tput setaf 3`$1`tty -s && tput op`"
}

function _lobster_t_warning() {
  echo "`tty -s && tput setaf 3`$1`tty -s && tput op`"
}

function _lobster_t_blue() {
  echo "`tty -s && tput setaf 4`$1`tty -s && tput op`"
}

function _lobster_t_pink() {
  echo "`tty -s && tput setaf 5`$1`tty -s && tput op`"
}

function _lobster_t_help() {
  echo "`tty -s && tput setaf 4`$1`tty -s && tput op`"
}

function _lobster_t_aqua() {
  echo "`tty -s && tput setaf 6`$1`tty -s && tput op`"
}

function _lobster_t_white() {
  echo "`tty -s && tput setaf 7`$1`tty -s && tput op`"
}

#
# Provides a yes/no confirmation
#
# @param string $question
#
function lobster_confirm() {
  local question="$1"
  span=$(lobster_span "(y)es or (n)o?" yellow)
  lobster_div "$question $span" $2
  read -n 1 a
  echo
  if [ "$a" != 'y' ]; then
    return -1
  fi
  return 0
}

##
 # Accept a y/n confirmation message or end
 #
function confirm() {
  echo "`tty -s && tput setaf 3`$1 (y/n)`tty -s && tput op`"
  read -n 1 a
  echo
  if [ "$a" != 'y' ]; then
    return -1
  fi
  return 0
}
##
 # Echos the current date and time
 #
function lobster_date() {
  echo $(date +"%B %_d, %Y")
}

##
 # Echos the current date and time
 #
function lobster_datetime() {
  echo $(date +"%Y-%m-%dT%H:%M:%S%z")
}

##
 # Echos the current unix timestamp
 #
function lobster_time() {
  echo $(date +"%s") 
}

##
 # Echo the last value of $_lobster_array_
 #
function lobster_array_end() {
  local index=${#_lobster_array_[@]}
  ((index--))
  echo ${_lobster_array_[$index]}
}

##
 # Remove the final argument from $_lobster_array_ and echo it
 #
function lobster_array_pop() {
  local index=${#_lobster_array_[@]}
  ((index--))
  echo ${_lobster_array_[$index]}
  _lobster_array_=("${_lobster_array_[@]:0:$index}")
  echo Function: $FUNCNAME
  echo '  "'$_lobster_array_'"'
  echo '    [#] => '${#_lobster_array_[@]}
  echo '    [@] => '${_lobster_array_[@]}
  echo '    [*] => '${_lobster_array_[*]}
  echo 'Array'
  echo '('
  echo '    [0] => '${_lobster_array_[0]}
  echo '    [1] => '${_lobster_array_[1]}
  echo '    [2] => '${_lobster_array_[2]}
  echo '    [3] => '${_lobster_array_[3]}
  echo '    [4] => '${_lobster_array_[4]}
  echo '    [5] => '${_lobster_array_[5]}
  echo '    [6] => '${_lobster_array_[6]}
  echo '    [7] => '${_lobster_array_[7]}
  echo '    [8] => '${_lobster_array_[8]}
  echo '    [9] => '${_lobster_array_[9]}
  echo ')'

}

##
 # Echo the first value of $_lobster_array_
 #
function lobster_array_reset() {
  echo ${_lobster_array_[0]}
}

##
 # Implode additional arguments using the first as glue
 # 
 # @param string $glue
 # @param... string
 #
function lobster_implode() {
  local glue=$1
  local output=''
  local index=0
  local last=$(( ${#@} - 2))
  for arg in "${@:2}"; do
    if [[ ! "$output" ]]; then
      # first time
      output="${arg}${glue}"
    elif [[ $index -eq $last ]]; then
      # last time
      output="${output}${arg}"  
    else
      # in the middle
      output="${output}${arg}${glue}"  
    fi
    index=$(($index + 1))
  done

  echo $output
}

##
 # Echo the length of the first argument in chars
 # 
 # @param string
 #
function lobster_strlen() {
  echo ${#1}
}

#
# Echo a string in uppercase
#
# @param string $string
#
function lobster_strtoupper() {
  local string=$1
  
  echo $string | tr '[:lower:]' '[:upper:]'
}

#
# Echo a string in lowercase
#
# @param string $string
#
function lobster_strtolower() {
  local string=$1
  
  echo $string | tr '[:upper:]' '[:lower:]'
}

# Usage
# result=$(lobster_strtoupper arg)

##
 # Echo a string repeated N times
 # 
 # @param string $input
 # @param int $multiplier
 #
function lobster_str_repeat() {
  local input=$1
  local multiplier=$2
  str=$(printf "%${multiplier}s");
  echo ${str// /"$input"}  
}

#
# Return the realpath
# 
# @param string $path
# 
function lobster_realpath() {
  local cmd="print realpath('$1');"
  local path=$($LOBSTER_PHP -r "$cmd")
  echo $path
}

##
 # Function Declarations
 #

##
 # Echo the value of a script flag e.g. (--flag=value)
 #
 # @code
 # value=$(lobster_get_param try)
 # @endcode
 #
 # @param string $1
 #   The name of the param
 #
function lobster_get_flag() {
  local flags=($LOBSTER_FLAGS)
  local flag=$1
  for key_value in "${flags[@]}"; do
    if [[ "$key_value" =~ ^(.*)\=(.*) ]] && [ ${BASH_REMATCH[1]} == $1 ]; then
      echo ${BASH_REMATCH[2]}
      return
    fi
  done
}

##
 # Test for a flag
 #
 # @code
 # if lobster_has_flag s; then
 # @endcode
 #
 # @param string $1
 #   The flag name to test for, omit the -
 #
 # @return int
 #   0: it has the flag
 #   1: it does not have the flag
 #
function lobster_has_flag() {
  local value=$(lobster_get_flag $1)
  if [[ "$value" ]]; then
    return 0
  fi
  return 1
}

##
 # Invoke help on an optional topic
 # 
 # @param string $topic Optional. the help topic.
 #
function lobster_help() {
  local topic=$1
  if [[ ! "$topic" ]]; then
    topic='default'
  fi
  _lobster_invoke "hooks" "help_pre"
  _lobster_invoke "docs" "$topic"
  _lobster_invoke "hooks" "help_post"
  lobster_br

  # @todo this causes weird things to happen, e.g.
  # try this from a help script
  # p "*** test ***"
  # output="$(_lobster_invoke "docs" "$topic")"
  # lobster_div "$output" help
}

##
 # Invoked a hook
 # 
 # @param string $hook The name of the hook.
 #
function lobster_hook() {
  _lobster_invoke "hooks" $1
}

lobster_invoke_result=()
function _lobster_invoke() {
  lobster_invoke_result=()
  local dir=$1
  local hook=$2
  if [[ -d "$LOBSTER_INSTANCE/$dir" ]]; then
    for file in $(find "$LOBSTER_INSTANCE/$dir" -maxdepth 1 -type f -iname "$hook.*"); do
      lobster_include "$file" "$LOBSTER_CONTROLLER" "$hook"
      lobster_invoke_result=("${lobster_invoke_result[@]}" "$file")
    done
  fi
  if [[ -d "$LOBSTER_PROJECT/$dir" ]]; then
    for file in $(find "$LOBSTER_PROJECT/$dir" -maxdepth 1 -type f -iname "$hook.*"); do
      lobster_include "$file" "$LOBSTER_CONTROLLER" "$hook"
      lobster_invoke_result=("${lobster_invoke_result[@]}" "$file")
    done
  fi
  if [[ -d "$LOBSTER/$dir" ]]; then
    for file in $(find "$LOBSTER/$dir" -maxdepth 1 -type f -iname "$hook.*"); do
      lobster_include "$file" "$LOBSTER_CONTROLLER" "$hook"
      lobster_invoke_result=("${lobster_invoke_result[@]}" "$file")
    done
  fi
}

##
 # Includes a file issuing the appropriate command based on file extension
 # 
 # @param string $path
 #
function lobster_include() {
  local file="$1"
  if [[ ${file##*.} == 'php' ]]; then
    $LOBSTER_PHP "$file" ${@:2}
  elif [[ ${file##*.} == 'sh' ]]; then
    $LOBSTER_BASH "$file" ${@:2}
  elif [[ ${file##*.} == 'txt' ]] || [[ ${file##*.} == 'md' ]]; then
    cat "$file"
  fi
}

function lobster_serialize() {
  echo $($LOBSTER_PHP $LOBSTER/lib/serialize.php 0 "$@") 
}

lobster_explode_result=()
function lobster_explode() {
  # *********************************************************
  # file: querystring.sh
  # date: 18.10.2004
  # author: (c) by Marko Schulz - <mschulz@jamba.net>
  # description: Get the form data from QueryString.
  # *********************************************************
  # example of script call:
  # http://www.doman.de/cgi-bin/querystring.sh?src=xxx&target=yyy
   
  # Scanning the QUERY_STRING and save the values/pairs
  # as elements in the array "QUERYSTRING".
  # declare -a QUERYSTRING=( $( env | grep 'QUERY_STRING' | sed 's/QUERY_STRING=//g' | sed 's/&/ /g' ) )
  #declare -a QUERYSTRING=( $( echo "$1" | sed 's/QUERY_STRING=//g' | sed 's/&/ /g' ) )
  #declare -a lobster_explode_result=( $( echo "$1" | sed 's/&/ /g' ) )
  echo Function: $FUNCNAME
  echo '  "'$lobster_explode_result'"'
  echo '  [@] => "'${lobster_explode_result[@]}'"'
  echo '  [*] => "'${lobster_explode_result[*]}'"'
  echo 'Array'
  echo '('
  echo '  [0] => "'${lobster_explode_result[0]}'"'
  echo '  [1] => "'${lobster_explode_result[1]}'"'
  echo '  [2] => "'${lobster_explode_result[2]}'"'
  echo '  [3] => "'${lobster_explode_result[3]}'"'
  echo '  [4] => "'${lobster_explode_result[4]}'"'
  echo '  [5] => "'${lobster_explode_result[5]}'"'
  echo '  [6] => "'${lobster_explode_result[6]}'"'
  echo '  [7] => "'${lobster_explode_result[7]}'"'
  echo '  [8] => "'${lobster_explode_result[8]}'"'
  echo '  [9] => "'${lobster_explode_result[9]}'"'
  echo ')'
  exit
   
  # Loop the array "QUERYSTRING" and save each
  # form name as variable with its value.
  for element in ${QUERYSTRING[@]}; do
    name=$( echo $element|cut -d= -f1 )
    value=$( echo $element|cut -d= -f2 )

    lobster_explode_result=("${lobster_unserialize_result[@]}" "$value")
  done
}

lobster_unserialize_result=()
function lobster_unserialize() {
  # *********************************************************
  # file: querystring.sh
  # date: 18.10.2004
  # author: (c) by Marko Schulz - <mschulz@jamba.net>
  # description: Get the form data from QueryString.
  # *********************************************************
  # example of script call:
  # http://www.doman.de/cgi-bin/querystring.sh?src=xxx&target=yyy
   
  # Scanning the QUERY_STRING and save the values/pairs
  # as elements in the array "QUERYSTRING".
  # declare -a QUERYSTRING=( $( env | grep 'QUERY_STRING' | sed 's/QUERY_STRING=//g' | sed 's/&/ /g' ) )
  # declare -a QUERYSTRING=( $( echo "$1" | sed 's/QUERY_STRING=//g' | sed 's/&/ /g' ) )
  declare -a QUERYSTRING=( $( echo "$1" | sed 's/&/ /g' ) )
   
  # Loop the array "QUERYSTRING" and save each
  # form name as variable with its value.
  for element in ${QUERYSTRING[@]}; do
    name=$( echo $element|cut -d= -f1 )
    value=$( echo $element|cut -d= -f2 )

    lobster_unserialize_result=("${lobster_unserialize_result[@]}" "$value")
  done
}

#
# Invoke a lib script
#
# @param string $filename
#
lobster_invoke_lib_result=''
function lobster_invoke_lib() {

echo Function: $FUNCNAME
echo 'Array'
echo '('
echo '  [0] => "'$0'"'
echo '  [1] => "'$1'"'
echo '  [2] => "'$2'"'
echo '  [3] => "'$3'"'
echo '  [4] => "'$4'"'
echo '  [5] => "'$5'"'
echo '  [6] => "'$6'"'
echo '  [7] => "'$7'"'
echo '  [8] => "'$8'"'
echo '  [9] => "'$9'"'
echo ')'
exit


  local filename=$1
  lobster_alert "$*"
  lobster_alert $filename
  # lobster_invoke_lib_result=$()
}

##
 # Copy framework files to destination
 # 
 # @param string $from
 # @param string $to
 #
function lobster_install_framework() {
  local from="$1"
  local to="$2"
  
  _lobster_rsync "$from" "$to"

  if lobster_verify_framework; then
    lobster_progress "Installed framework: $from into $to" ok
    return 0
  else
    lobster_progress "Error installing framework: $from into $to" error
  fi 

  return 1
}

function _lobster_rsync() {
  rsync -a "$1/" "$2/" --exclude=*.git
}

##
 # Verify all parts of a framework are in place
 # 
 # @param string $from
 # @param string $to
 #
function lobster_verify_framework() {
  local from="$1"
  local to="$2"

  # @todo Need to flesh this out
  return 0
}

#
# Assert a directory is available and if not, create it
#
# @param string $path
#
function lobster_prepare_directory() {
  local path=$1
  local filename=${path##*/}

  if [[ ! -d $path ]]; then
    if mkdir "$path"; then
      lobster_progress "$filename directory created." ok
    else
      lobster_progress "Failed to create $path." error
    fi
  else 
    lobster_progress "$filename directory confirmed." ok
  fi
}

##
 # Bootstrap Lobster
 #
function lobster_bootstrap() {
  declare -a local args=()
  declare -a local flags=()
  for arg in "$@"
  do
    if [[ "$arg" =~ ^--(.*) ]]
    then
      flags=("${flags[@]}" "${BASH_REMATCH[1]}")
    elif [[ "$arg" =~ ^-(.*) ]]
    then
      flags=("${flags[@]}" "${BASH_REMATCH[1]}=1")
    else
      args=("${args[@]}" "$arg")
    fi
  done

  export LOBSTER_FLAGS=${flags[*]}
  export LOBSTER_ARGS=${args[*]}
  export LOBSTER_CONTROLLER=$0

  # bootstrap hook
  lobster_hook lobster_bootstrap

  # has the user requested help
  if [[ "${args[0]}" == "help" ]]; then   
    
    # Controller-based: lobster.sh help lobster_default
    local hook="$(_lobster_filename $LOBSTER_CONTROLLER)_default"
    lobster_help $hook

    # General: lobster.sh help default
    lobster_help ${args[1]}

    lobster_exit
  fi

  # Provide the lobster-required menu items
  lobster_menu_items=()
  lobster_menu_item "init" "Initialize a new project in the current dir."
  lobster_menu_item "help" "Return general help. With an argument, for specific help."
}

##
 # Deliver a menu hook
 # 
 # @return
 #   - False if the callback file is missing; even if the menu item is registered.
 #
function lobster_deliver() {

  local command="${LOBSTER_ARGS[0]}"

  # No items deliver the no_args hook
  if [[ ! "$command"  ]]; then
    local hook="$(_lobster_filename $LOBSTER_CONTROLLER)_no_args"
    lobster_help $hook
    lobster_hook $hook
  
  # Otherwise try to call a menu hook
  else
    # call a menu hook
    for i in "${lobster_menu_items[@]}"; do
      local item=$(_lobster_menu_get_item $i)
      if [[ $item == "${LOBSTER_ARGS[0]}" ]]; then
        lobster_hook $(_lobster_menu_get_callback $i)
        if [[ ${#lobster_invoke_result[@]} -gt 0 ]]; then
          return 0
        fi
      fi
    done      
  fi

  if [[ "$command" ]]; then
    lobster_alert "\"$command\" is not a valid command." error
  fi
    
  return 1
}

##
 # Register a menu item
 # 
 # @param string $menu_item
 # @param string $description
 # 
 # @return
 #   - False if the item could not be added
 #
declare -a lobster_menu_items=();
function lobster_menu_item() {
  
  # Fail silently when no args
  if [[ ${#@} -eq 0 ]]; then
    return 1
  fi

  local item=("$1" "$2")

  # Cycle through and block a duplicate
  for menu in "${lobster_menu_items[@]}"; do
    local menu=$(_lobster_menu_get_item $menu)
    if [[ "$menu" == ${item[0]} ]]; then
      lobster_watchdog "Trying to add a menu item that already exists: \"$menu\""
      return 1
    fi
  done
  
  lobster_menu_items=("${lobster_menu_items[@]}" "${item[*]}")
  return 0
}

function lobster_menu() {
  local item
  local description
  for item in "${lobster_menu_items[@]}"; do
    item=($item)
    description="${item[*]:2}"
    lobster_tr "${item[0]}" "$description"
  done

  lobster_h2 "Available commands..." help
  lobster_th "arg1" "description"
  lobster_table help
}

##
 # Given a menu item, echo the item
 # 
 # @param string $menu_item
 #
function _lobster_menu_get_item() {
  local menu_item=(${@})
  echo ${menu_item[0]}
}

##
 # Given a menu item, echo the callback script
 # 
 # @param string $menu_item
 #
function _lobster_menu_get_callback() {
  local menu_item=(${@})
  echo ${menu_item[0]}
}

# Usage
# result=$(func_name arg)

#
# Echo the filename (remove the path and extension)
# 
# @param string $path
#
function _lobster_filename() {
  local  basename=$(basename $1)
  echo ${basename%%.*}
}

result=

##
 # Invoke all exit hooks
 #
function lobster_exit() {
  lobster_hook lobster_exit
  exit
}

##
 # Assert two strings are the same
 # 
 # @param string $control
 # @param string $subject
 #
function lobster_test_assert_same() {
  if [[ "$1" == "$2" ]]; then
    lobster_test_pass "$1 is the same as $2"
  else
    lobster_test_fail "$1 is not the same as $2"
  fi 
}

##
 # Assert a pass
 #
function lobster_test_pass() {
  lobster_progress "TEST: $1" 'ok'
}

##
 # Assert a fail
 #
function lobster_test_fail() {
  lobster_progress "TEST: $1" 'error'
  lobster_alert "Tests stopped" 'warning'
  lobster_exit
}

##
 # End Function Declarations
 #

##
 # Path the php binary to use
 #
export LOBSTER_PHP=$(which php)

##
 # Path to the bash binary to use
 #
export LOBSTER_BASH=$(which bash)

##
 # @var lobster
 # 
 # The path to Lobster core
 #
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  dir="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$dir/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
export LOBSTER="$( cd -P "$( dirname "$source" )" && pwd )"

##
 # This is the current working directory from the calling script
 #
export LOBSTER_PWD=$PWD

##
 # @var lobster_project
 # 
 # Path to the project root
 #
export LOBSTER_PROJECT=$(lobster_realpath "$LOBSTER/..")

##
 # @var lobster_instance
 # 
 # Path to the instance root
 #
export LOBSTER_INSTANCE=$(lobster_realpath "$LOBSTER_PROJECT/..")

# 
# Declare global vars
# 

##
 # Used by array functions (lobster_array_*) to pass in the array argument for processing.
 #
declare -a _lobster_array_=()
