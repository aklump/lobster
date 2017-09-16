#!/usr/bin/env bash
#
# Examples of all output functions

lobster_theme "hr"
echo do re mi fa
lobster_echo do re mi fa
lobster_verbose "This is verbose"
lobster_strong do re mi fa
lobster_underline do re mi fa
lobster_color_echo red do re mi fa

declare -a array=('value1' 'value2');
echo $array
lobster_echo $array
echo ${array[@]}
lobster_echo ${array[@]}


