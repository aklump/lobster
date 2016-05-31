#!/bin/bash
# 
# @file
# This is a core route override.
lobster_color_echo "cyan" "This is an example of overriding core's init route."

# You must still call the hook if you want it to fire.
lobster_include "post_init"
