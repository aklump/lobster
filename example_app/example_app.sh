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
LOBSTER_APP_ROOT="$( cd -P "$( dirname "$self" )" && pwd )"
source "$LOBSTER_APP_ROOT/lib/lobster/dist/bootstrap.sh"
lobster_theme 'header'
source "$LOBSTER_APP_ROOT/lib/lobster/dist/router.sh"
