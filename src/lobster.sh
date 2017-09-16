#!/usr/bin/env bash
source "$LOBSTER_APP_ROOT/lib/lobster/dist/bootstrap.sh"

lobster_include 'functions'
lobster_include 'init'
source "$LOBSTER_APP_ROOT/lib/lobster/dist/router.sh"
