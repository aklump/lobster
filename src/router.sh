#!/bin/bash
# 
# @file
# Handles common routing based on the $op

# Setup the filenames we'll search for
base=""
declare -a list=();
for item in "${lobster_args[@]}"; do
  if [ "$base" ]; then
    base=$base.$item;
  else
    base=$item;
  fi
  list=("${list[@]}" "$base")
done  

# Reverse the order for specific to general order.
declare -a lobster_suggestions=();
for (( i = ${#list[@]} - 1; i >= 0 ; i-- )); do
  lobster_suggestions=("${lobster_suggestions[@]}" ${list[$i]})
done

# The default route.
if [ ${#lobster_suggestions[@]} -lt 1 ]; then
  lobster_suggestions[0]=$lobster_default_route
fi

# Will hold the discovered route
lobster_route=''

# From the routes folder
declare -a dirs=("$lobster_app_root" "$lobster_root");
for suggestion in "${lobster_suggestions[@]}"; do
  for ext in "${lobster_route_extensions[@]}"; do
    filename=$suggestion.$ext

    for dir in "${dirs[@]}"; do
      if [ -f "$dir/routes/$filename" ]; then
        lobster_route="$dir/routes/$filename"

        # This will be consumable by php scripts, et al.
        export LOBSTER_JSON=$(lobster_json)          
        case $ext in
          'sh' )
            source "$lobster_route"
            lobster_exit
            ;;

          'php' )
            $lobster_php "$lobster_route"
            lobster_exit
            ;;
        esac
      fi
      
    done
  done

  # From the theme folder
  for ext in "${lobster_tpl_extensions[@]}"; do
    filename=$suggestion.$ext

    for dir in "${dirs[@]}"; do
      if [ -f "$dir/themes/$lobster_theme/tpl/$filename" ]; then
        lobster_route="$dir/themes/$lobster_theme/tpl/$filename"

        # This will be consumable by php scripts, et al.
        export LOBSTER_JSON=$(lobster_json)
        output=$(lobster_theme $lobster_route)

        case $ext in
          'twig' )
            # @todo process the twig file
            ;;
        esac

        echo "$output"
        lobster_exit
      fi
    done
  done

done

# Fallback when the op is unknown
export LOBSTER_JSON=$(lobster_json)      
lobster_error "Unknown operation: $lobster_op"
lobster_exit
