# Routing

## Route files
1. Place script files in `/routes`
1. Configure the types and order of files via `$lobster_route_extensions`.
1. If a route cannot be found, then a tpl will be sought.

## Theme tpls
1. You may have more than one theme, but not more than one _active_ theme.
1. Configure the types and order of files via `$lobster_tpl_extensions`.
1. Place tpl files in `/themes/{lobster_theme}/tpl`

## The Route/Theme Cascade
Given that a user types:
    
    $ my_app.sh do re mi

Then the first existing file from in the following list will be used:

    /routes/do.re.mi.sh
    /routes/do.re.mi.php
    /routes/do.re.sh
    /routes/do.re.php
    /routes/do.sh
    /routes/do.php
    /themes/{lobster_theme}/tpl/do.re.mi.twig
    /themes/{lobster_theme}/tpl/do.re.mi.txt
    /themes/{lobster_theme}/tpl/do.re.twig
    /themes/{lobster_theme}/tpl/do.re.txt
    /themes/{lobster_theme}/tpl/do.twig
    /themes/{lobster_theme}/tpl/do.txt
