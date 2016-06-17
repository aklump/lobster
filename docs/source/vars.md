# Lobster vars

## Your app
| var | description |
|----------|----------|
| `$LOBSTER_APP` | The path to the app controller script; use this to call self from within another route. |
| `$LOBSTER_PWD` | The path from which the script was originally called. |
| `$LOBSTER_INSTANCE_ROOT` | Path to the root dir above $LOBSTER_PWD with a $lobster_app_config file |
| `$LOBSTER_APP_ROOT` | Path to the Lobster app's root, same as $root |
| `$lobster_app_config` | Filename for app config files, e.g. `.pspconfig`  This is used to locate `LOBSTER_INSTANCE_ROOT` |

## Lobster
| var | description |
|----------|----------|
| $LOBSTER_ROOT | Path to the root of Lobster |

## Command-related
| var | description |
|----------|----------|
| $lobster_args | An array of arguments called |
| $lobster_params | An array of x=y params called, e.g. --name=bob |
| $lobster_flags | An array of flags called e.g. -d |
| $lobster_target_dir | $2 will be expanded to an absolute dir or $PWD |
| $lobster_target_error | Set to 1 if lobster_target_dir is not a directory |
