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
  if [ "$status" == "maintenance_mode: '0'" ]; then
    return 0;
  fi
  return 1;
}
