#!/bin/bash
# 
# @file
# Bootstrap is automatically called every time example_app.sh is executed, but after Lobster's bootstrap is called.

# An example of how you might redirect a route from foo to bar
if [ "${lobster_args[0]}" == 'foo' ]; then
  lobster_args[0]='bar'
fi

# An example how to assume a route based on the arguments.  In this example if the first arg is 'bar' or 'baz' then we assume a route of 'foo'. This would allow a single router to be used for multiple arguments if needed.
declare -a array=("${lobster_args[0]}" "bar" "baz")
if lobster_in_array ${array[@]}; then
  lobster_args=("foo" "${lobster_args[@]}")
fi
