# Themes

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