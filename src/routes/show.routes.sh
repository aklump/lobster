#!/usr/bin/env bash

# create an array with all the filer/dir inside ~/myDir
lobster_notice "App Routes"
routes=$(lobster_app_routes)
for i in ${routes[@]}; do
   lobster_echo $i
done

lobster_echo

lobster_notice "Core Routes"
routes=$(lobster_core_routes)
for i in ${routes[@]}; do
   lobster_echo $i
done
