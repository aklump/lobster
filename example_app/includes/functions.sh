#!/bin/bash
# 
# @file
# Provide functions to be used by example_app.  This file is
# auto-loaded every time example_app.sh is called, but after
# functions at the core level of Lobster.

#
# Determine if the cwp is a drupal project root.
#
function is_drupal_root () {
  if [ -d sites ] && [ -d modules ] && [ -d themes ]; then
    return 0
  fi
  return 1
}

#
# Determine if drupal is online or not.
#
function is_drupal_online() {
  status=$(cd $rb_drupal_root && $rb_drush vget site_offline --exact)
  regex="true|1"
  if [[ "$status" =~ $regex ]]; then
    return 1;
  fi
  return 0;
}

#
# Access function that always fails
#
function never_allow() {
  # Static failure messages can be set using lobster_access_denied in .lobsterconfig

  # Notice that any access messages that are dynamic should be echoed when the failure occurs.
  lobster_error "You will never be able to do '$lobster_op' because the access always fails."
  return 1
}
