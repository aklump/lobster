#!/bin/bash
# 
# @file
# Handles common routing based on the $op

# If the op is pointing to a file in routes/$op.sh...
lobster_route=''
if [ -f "$root/routes/$lobster_op.sh" ]; then
  lobster_route="$root/routes/$lobster_op.sh"
  # This will be consumable by php scripts, et al.
  export LOBSTER_JSON=$(lobster_json)    
  source "$lobster_route"

# If the op is pointing to a file in routes/$lobster_op.php...
elif [ -f "$root/routes/$lobster_op.php" ]; then
  lobster_route="$root/routes/$lobster_op.php"
  # This will be consumable by php scripts, et al.
  export LOBSTER_JSON=$(lobster_json)    
  $lobster_php "$lobster_route"
fi

if [ ! "$lobster_route" ]; then
  output=$(theme $lobster_op)
  if [ "$output" ]; then
    lobster_route=$theme_source
    # This will be consumable by php scripts, et al.
    export LOBSTER_JSON=$(lobster_json)      
    echo "$output";
  else
    # This will be consumable by php scripts, et al.
    export LOBSTER_JSON=$(lobster_json)      
    error "Unknown operation: $lobster_op"
  fi
fi
