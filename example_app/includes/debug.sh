#!/bin/bash
# 
# This file will get called if lobster_debug == 1 at the time the function lobster_show_debug() is called.

lobster_color_echo yellow "DEBUG INFO" "This will only be called if you set lobster_debug=1 in the config file, or pass --lobster-debug"
