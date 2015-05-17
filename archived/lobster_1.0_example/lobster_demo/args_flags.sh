#!/bin/bash
# 
# @file
# 
# An example of using args and flags
# 
source ../lobster/core.sh
lobster_bootstrap ${@}

# Controller begins.
argv=($LOBSTER_ARGS)
flags=($LOBSTER_FLAGS)

if [[ ! "$argv" ]]; then
  lobster_alert "Try calling with some arguments" help
  lobster_exit
fi

if ! lobster_has_flag e; then
  lobster_alert "The -e flag indicates you're ready for breakfast." help
else
  lobster_div "It's time to eat." pink
fi

if ! lobster_has_flag drink; then
  lobster_alert "Tell me what you want to drink with the --drink flag, e.g. --drink=oj" help
else
  drink=$(lobster_get_flag drink)
  lobster_div "You want to drink $drink." pink  
fi

for arg in "${argv[@]}"; do
  lobster_div "Argument found: $arg" pink
done


# Must remain last.
lobster_exit