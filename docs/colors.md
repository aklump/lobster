# Colors

The following may be passed to color functions as arguments

## Color names
* grey
* red
* green
* yellow
* blue
* magenta
* pink
* cyan

## Semantic
* notice
* warning
* error
* success
* confirm
* verbose

## BASH
You can also pass thes values directly
<http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html>

| Color | Argument |
|----------|----------|
| Black         | 0;30 |
| Blue          | 0;34 |
| Green         | 0;32 |
| Cyan          | 0;36 |
| Red           | 0;31 |
| Purple        | 0;35 |
| Brown         | 0;33 |
| Light Gray    | 0;37 |
| Dark Gray     | 1;30 |
| Light Blue    | 1;34 |
| Light Green   | 1;32 |
| Light Cyan    | 1;36 |
| Light Red     | 1;31 |
| Light Purple  | 1;35 |
| Yellow        | 1;33 |
| White         | 1;37 |

## Controlling the dark/light attribute of colors

You may manipulate the variable `lobster_color_bright` where `1` is lighter and `0` is darker, e.g.,

    # Turn on lighter colors (if not enabled by default)
    lobster_color_bright=1

    # These next two lines will use lighter colors.
    lobster_color_echo red  "This is in light red text"
    lobster_color_echo red  "This is in light red text"

    # Disable lighter colors until otherwise directed
    lobster_color_bright=0
    lobster_color_echo red  "This is in dark red text"