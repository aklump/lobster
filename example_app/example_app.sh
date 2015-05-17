#!/bin/bash
# 
# @file
# Controller file for example_app.

self="${BASH_SOURCE[0]}"
while [ -h "$self" ]; do
  dir="$( cd -P "$( dirname "$self" )" && pwd )"
  self="$(readlink "$self")"
  [[ $self != /* ]] && self="$dir/$self"
done
root="$( cd -P "$( dirname "$self" )" && pwd )"
source "$root/vendor/aklump/lobster/dist/bootstrap.sh"
lobster_theme 'header'
source "$root/vendor/aklump/lobster/dist/router.sh"