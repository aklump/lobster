#!/bin/bash
# 
# @file
# This is an example route showing how to print out the arguments using
# different colors.
#

lobster_color white
lobster_echo "Here is contextual info from your command line:"
lobster_echo

lobster_color_echo cyan "The operation is $lobster_op."

lobster_color "pink"
lobster_echo "You called with arguments: ${lobster_args[@]}"

# This is how we tell if a flag was used.
if lobster_has_flag o; then
  lobster_echo "You called this with the 'o' flag."
else
  lobster_color 'yellow'
  lobster_echo "Try including the flag '-o' next time you call this."
fi

# This is how we check the value of a param
if lobster_has_param 'size'; then
  size=$(lobster_get_param size)
  lobster_echo "You have specificed a parameter 'size' of '$size'."
else
  lobster_color_echo yellow "Try including the parameter '--size=large' next time."
fi

lobster_echo

# An example of using the default value for a parameter
color=$(lobster_get_param color white)
if [[ "$color" ]]; then
  lobster_color $color
fi
if ! lobster_has_param color; then
  lobster_color_echo yellow "Trying passing --color=red"
  lobster_echo
fi

lobster_echo "Here is some nifty info:"
lobster_echo "  * Today is: "$(lobster_date)
lobster_echo "  * Current timestamp: "$(lobster_time)
lobster_echo "  * Current datetime is: "$(lobster_datetime)
lobster_echo
