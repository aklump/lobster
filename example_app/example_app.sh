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
lobster_app_root="$( cd -P "$( dirname "$self" )" && pwd )"
source "$lobster_app_root/vendor/aklump/lobster/dist/bootstrap.sh"
lobster_theme 'header'
source "$lobster_app_root/vendor/aklump/lobster/dist/router.sh"