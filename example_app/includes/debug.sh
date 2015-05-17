#!/bin/bash
# 
# @file
# 
# This file will get called if lobster_debug == 1 at the time the function
# lobster_show_debug() is called.

lobster_color 'yellow'
lobster_message "DEBUG INFO" "This will only be called if you set lobster_debug=1 in the config file"

lobster_color 'green'
lobster_message "\$lobster_app_name:" "$lobster_app_name" " "
lobster_message "\$lobster_app_title:" "$lobster_app_title" " "
lobster_message "\$lobster_root:" "$lobster_root" " "
lobster_message "\$lobster_php:" "$lobster_php" " "
lobster_message "\$lobster_op:" "$lobster_op" " "
lobster_message "\$lobster_route:" "$lobster_route" " "
lobster_message "\$lobster_args:" $lobster_args " "
lobster_message "\$lobster_params:" $lobster_params " "
lobster_message "\$lobster_flags:" $lobster_flags " "
lobster_message "\$LOBSTER_JSON:" "$LOBSTER_JSON" " "
