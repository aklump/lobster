
color 'yellow'
message "DEBUG INFO" "This will only be called if you set lobster_debug=1 in config.lobster"

color 'green'
message "\$lobster_core:" "$lobster_root" " "
message "\$lobster_php:" "$lobster_php" " "
message "\$lobster_op:" "$lobster_op" " "
message "\$lobster_route:" "$lobster_route" " "
message "\$lobster_args:" $lobster_args " "
message "\$lobster_params:" $lobster_params " "
message "\$lobster_flags:" $lobster_flags " "
message "\$LOBSTER_JSON:" $LOBSTER_JSON " "
