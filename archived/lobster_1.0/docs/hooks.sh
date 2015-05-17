source $LOBSTER/core.sh

lobster_th "hook" "description"

# list of hooks
lobster_tr "lobster_bootstrap" "called during bootstrap."
lobster_tr "lobster_exit" "called during the exit phase"
lobster_tr "lobster_help" "when help is invoked"
lobster_tr "lobster_{filename}_no_args" "when {filename} is called without args"

lobster_h2 "Lobster Hooks"
lobster_table