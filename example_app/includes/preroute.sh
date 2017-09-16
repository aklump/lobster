#!/bin/bash
#
# @file
# Pre-route is automatically called every time example_app.sh is executed, after bootstrap and before the route is executed.  The path to the route file is available as $lobster_route.  The operation as available as $lobster_op.  Note that you can also create preroute.{route_id} if you want.

#if [[ "$lobster_debug" ]]; then
#    lobster_core_verbose "Variables available in preroute.sh":
#    lobster_core_verbose "$(lobster_echo_core_variables)"
#fi

# An example of how you might alter the arguments sent to the app.
if [ "${lobster_args[0]}" == 'foo' ]; then
  lobster_args[0]='bar'
fi

# An example how to assume a route based on the arguments.  In this example if the first arg is 'bar' or 'baz' then we assume a route of 'foo'. This would allow a single router to be used for multiple arguments if needed.
declare -a array=("${lobster_args[0]}" "bar" "baz")
if lobster_in_array ${array[@]}; then
  lobster_args=("foo" "${lobster_args[@]}")
fi
