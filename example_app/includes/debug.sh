#!/bin/bash
# 
# @file
# 
# This file will get called if lobster_debug == 1 at the time the function
# lobster_show_debug() is called.

lobster_color 'yellow'
lobster_echo "DEBUG INFO" "This will only be called if you set lobster_debug=1 in the config file"

lobster_color 'green'
lobster_echo "\$lobster_app_name:" "$lobster_app_name" " "
lobster_echo "\$lobster_app_title:" "$lobster_app_title" " "
lobster_echo "\$lobster_root:" "$lobster_root" " "
lobster_echo "\$lobster_php:" "$lobster_php" " "
lobster_echo "\$lobster_op:" "$lobster_op" " "
lobster_echo "\$lobster_route:" "$lobster_route" " "
lobster_echo "\$lobster_args:" $lobster_args " "
lobster_echo "\$lobster_params:" $lobster_params " "
lobster_echo "\$lobster_flags:" $lobster_flags " "
lobster_echo "\$LOBSTER_JSON:" "$LOBSTER_JSON" " "