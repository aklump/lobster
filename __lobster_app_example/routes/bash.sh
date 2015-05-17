#!/bin/bash
# 
# @file
# This is an example route showing how to print out the arguments using
# different colors.
# 
lobster_color "cyan"
lobster_message "The operation is $lobster_op."

lobster_color "pink"
lobster_message "You called with arguments: $2, $3, $4"

# This is how we tell if a flag was used.
if lobster_has_flag o; then
  lobster_message "You called this with the flag '-o'."
else
  lobster_color 'yellow'
  lobster_message "Try including the flag '-o' next time you call this."
fi

# This is how we check the value of a param
if lobster_has_param 'size'; then
  size=$(lobster_get_param size)
  lobster_message "You have specificed a parameter 'size' of '$size'."
else
  lobster_color 'yellow'
  lobster_message "Try including the parameter '--size=large' next time."
fi

lobster_color "white"
