#!/usr/bin/env bash

# create an array with all the filer/dir inside ~/myDir
lobster_notice "App Routes"
arr=($LOBSTER_APP_ROOT/routes/*)

# iterate through array using a counter
for ((i=0; i<${#arr[@]}; i++)); do
    #do something to each element of array
    s="${arr[$i]}"
    s=${s##*/}
    lobster_echo ${s%.*}
done
lobster_echo

lobster_notice "Core Routes"
arr=($LOBSTER_ROOT/routes/*)
# iterate through array using a counter
for ((i=0; i<${#arr[@]}; i++)); do
    #do something to each element of array
    s=${arr[$i]}
    s=${s##*/}
    lobster_echo ${s%.*}
done

