#!/bin/bash
# 
# @file
# Initialize the current directory by an app configuration file in $PWD

if [ -f "$lobster_app_config" ]; then
  lobster_error "$PWD is already initialized."
  lobster_theme "failed"
fi

if [ "$LOBSTER_PWD_ROOT" ] && [ "$LOBSTER_PWD_ROOT" != "$HOME" ]; then
  lobster_warning "You are currently in a subdirectory of an initialized directory (root is $LOBSTER_PWD_ROOT)."
  if ! lobster_confirm "Are you sure?"; then
    lobster_theme "failed"
  fi
fi

touch "$lobster_app_config" && lobster_success "Success"
