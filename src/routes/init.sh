#!/bin/bash
# 
# @file
# Initialize the current directory as a PSP instance

if [ -f "$lobster_app_config" ]; then
  lobster_error "$PWD is already initialized."
  lobster_theme "failed"
fi

if [ "$lobster_pwd_root" ]; then
  lobster_warning "You are currently inside a project (root is $lobster_pwd_root)."
  if ! lobster_confirm "Are you sure?"; then
    lobster_theme "failed"
  fi
fi

cp "$lobster_app_root/$lobster_app_config" "$lobster_app_config"
lobster_success "Success"
