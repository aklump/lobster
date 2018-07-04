# Themes

The header and footer will not be output when `--lobster-nowrap` is present.
All output is suppressed when `--lobster-quite` is present.

## File structure
Given the following file structure:

    /default
      /post
        header.sh
      /pre
        header.sh
      /tpl
        header.twig

And a line in the script reads:

    theme "header"

Then the following files are called in this order:

    /default/pre/header.sh
    /default/tpl/header.twig
    /default/post/header.sh
    
## File types
Only `.sh` files are supported for pre/post scripts.

## Twig

To see the variables available for twig templates use the `show phpvars`.
