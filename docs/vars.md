# Lobster vars

| var | description |
|----------|----------|
| lobster_args | An array of arguments called |
| lobster_params | An array of x=y params called, e.g. --name=bob |
| lobster_flags | An array of flags called e.g. -d |
| lobster_target_dir | $2 will be expanded to an absolute dir or $PWD |
| lobster_target_error | Set to 1 if lobster_target_dir is not a directory |