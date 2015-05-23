# Lobster vars

## Lobster App
| var | description |
|----------|----------|
| `$lobster_app_root` | Path to the Lobster app's root, same as $root |
| `$root` | See `$lobster_app_root` |
| `$lobster_pwd_root` | Path to the parent above $PWD containing app config |
| `$lobster_app_config` | Filename for app config files, e.g. `.pspconfig`  This is used to locate `lobster_pwd_root` |

## Lobster
| var | description |
|----------|----------|
| lobster_root | Path to the root of Lobster |

## Command-related
| var | description |
|----------|----------|
| lobster_args | An array of arguments called |
| lobster_params | An array of x=y params called, e.g. --name=bob |
| lobster_flags | An array of flags called e.g. -d |
| lobster_target_dir | $2 will be expanded to an absolute dir or $PWD |
| lobster_target_error | Set to 1 if lobster_target_dir is not a directory |
