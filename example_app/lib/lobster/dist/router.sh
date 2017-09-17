#!/bin/bash
# 
# @file
# Handles common routing based on the $op

# We start by saying the route has failed with a 1 = unknown route.
lobster_set_route_status 1

#
#
# Setup the filenames we'll search for.
#
base=""
declare -a list=();
items=("$lobster_op" "${lobster_args[@]}")
for item in "${items[@]}"; do
  if [ "$base" ]; then
    base=$base.$item;
  else
    base=$item;
  fi
  list=("${list[@]}" "$base")
done

#
#
# Reverse the order for specific to general order.
#
declare -a lobster_suggestions=();
for (( i = ${#list[@]} - 1; i >= 0 ; i-- )); do
  lobster_suggestions=("${lobster_suggestions[@]}" ${list[$i]})
done
lobster_core_verbose "Possible routes: ${lobster_suggestions[@]}"

#
#
# The default route.
#
if [ ${#lobster_suggestions[@]} -lt 1 ]; then
  lobster_suggestions[0]="$lobster_default_route"
fi

# Will hold the discovered route
lobster_route=''

#
#
# From the routes folder
#
declare -a dirs=("$LOBSTER_APP_ROOT" "$LOBSTER_ROOT");
for lobster_route_id in "${lobster_suggestions[@]}"; do
  for dir in "${dirs[@]}"; do
    for ext in "${lobster_route_extensions[@]}"; do
      filename=$lobster_route_id.$ext
      if [ -f "$dir/routes/$filename" ]; then
        path_to_route="$dir/routes/$filename"

        # This will be consumable by php scripts, et al.
        declare -xr LOBSTER_ENV=$(lobster_env)
        if [ "$lobster_logs" ]; then
         echo $LOBSTER_ENV > "$lobster_logs/env.json"
        fi

        lobster_include "preroute"
        lobster_include "preroute.$lobster_route_id"
        case $ext in
          'sh' )
            lobster_theme "header"
            path=$(lobster_app_relative_path $path_to_route)
            lobster_core_verbose "$lobster_t_include_found$path"
            source "$path_to_route"
            lobster_route_end
            return;
            ;;

          'php' )
            lobster_theme "header"
            path=$(lobster_app_relative_path $path_to_route)
            $lobster_php "$LOBSTER_ROOT/php_runner.php" "$path_to_route"
            lobster_route_end
            ;;
        esac
      fi
    done
  done

  #
  #
  # From the theme folder
  #
  for dir in "${dirs[@]}"; do
    for ext in "${lobster_tpl_extensions[@]}"; do
      filename="$lobster_route_id.$ext"
      if [ -f "$dir/themes/$lobster_theme/tpl/$filename" ]; then
        lobster_route="$dir/themes/$lobster_theme/tpl/$filename"

        # This will be consumable by php scripts, et al.
        declare -xr LOBSTER_ENV=$(lobster_env)
        if [ "$lobster_logs" ]; then
         echo $LOBSTER_ENV > "$lobster_logs/env.json"
        fi
        lobster_include "preroute"
        lobster_include "preroute.$lobster_route_id"

        # Make the output
        lobster_theme 'header'
        lobster_theme "$lobster_route"
        lobster_route_end
      fi
    done
  done
done

if ! lobster_get_route_status; then
  # Fallback when the op is unknown
    declare -xr LOBSTER_ENV=$(lobster_env)
    if [ "$lobster_logs" ]; then
     echo $LOBSTER_ENV > "$lobster_logs/env.json"
    fi
    lobster_error "Unknown operation: $lobster_op"
    lobster_route_end
fi
