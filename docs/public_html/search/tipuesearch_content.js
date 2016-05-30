var tipuesearch = {"pages":[{"title":"Lobster Shell","text":"  A BASH framework by In the Loft Studios.  Getting started  If you are making an app called \"Titanium\"...   Copy the folder called example_app as titanium somewhere on your computer and start building your app.  That is the only folder you need from this repository to bundle with your app. Rename titanium\/gitignore to titanium\/.gitignore. Rename example_app.sh as  titanium.sh; this will be the controller for the app. Copy dist\/.lobsterconfig to titanium\/.lobsterconfig and modify as needed. Sample routes have been proved in example_app\/routes.   Lobster Documentation   HTML documentation is found at \/docs\/public_html.  ","tags":"","url":"README.html"},{"title":"Autoload","text":"  The following files are automatically loaded:  includes\/bootstrap.sh includes\/bootstrap.php includes\/functions.sh includes\/functions.php  ","tags":"","url":"autoload.html"},{"title":"Colors","text":"  The following may be passed to color functions as arguments  Color names   grey red green yellow blue magenta pink cyan   Semantic   notice warning error success confirm verbose   BASH  You can also pass thes values directly http:\/\/tldp.org\/HOWTO\/Bash-Prompt-HOWTO\/x329.html       Color   Argument       Black   0;30     Blue   0;34     Green   0;32     Cyan   0;36     Red   0;31     Purple   0;35     Brown   0;33     Light Gray   0;37     Dark Gray   1;30     Light Blue   1;34     Light Green   1;32     Light Cyan   1;36     Light Red   1;31     Light Purple   1;35     Yellow   1;33     White   1;37     Controlling the dark\/light attribute of colors  You may manipulate the variable lobster_color_bright where 1 is lighter and 0 is darker, e.g.,  # Turn on lighter colors (if not enabled by default) lobster_color_bright=1  # These next two lines will use lighter colors. lobster_color_echo red  \"This is in light red text\" lobster_color_echo red  \"This is in light red text\"  # Disable lighter colors until otherwise directed lobster_color_bright=0 lobster_color_echo red  \"This is in dark red text\"  ","tags":"","url":"colors.html"},{"title":"","text":"These are lobster options that can be passed to all lobster apps.       option   description       --lobster-nowrap   Turn off header and footer     --lobster-quiet   Suppress normal output     --lobster-debug   Go into temporary debug mode and nullifies --lobster-quite, you may also set this to 0 or 1, e.g. --lobster-debug=0    ","tags":"","url":"options.html"},{"title":"PHP","text":"  All PHP files need to include this line at the top:  &lt;?php require_once getenv('LOBSTER_ROOT') . '\/bootstrap.php';   This line will cause the Lobster PHP functions to be loaded as well as these files in your app, if they exist.  includes\/bootstrap.php includes\/functions.php  ","tags":"","url":"php.html"},{"title":"Routing","text":"  Route files   Place script files in \/routes folder of your app. Configure the types and order of files via $lobster_route_extensions. If a route cannot be found, then a tpl will be sought. Core routes can be overridden, e.g. 'init'   Theme tpls   You may have more than one theme, but not more than one active theme. Configure the types and order of files via $lobster_tpl_extensions. Place tpl files in \/themes\/{lobster_theme}\/tpl   The Route\/Theme Cascade  Given that a user types:  $ my_app.sh do re mi   Then the first existing file from in the following list will be used:  \/routes\/do.re.mi.sh \/routes\/do.re.mi.php \/routes\/do.re.sh \/routes\/do.re.php \/routes\/do.sh \/routes\/do.php \/themes\/{lobster_theme}\/tpl\/do.re.mi.twig \/themes\/{lobster_theme}\/tpl\/do.re.mi.txt \/themes\/{lobster_theme}\/tpl\/do.re.twig \/themes\/{lobster_theme}\/tpl\/do.re.txt \/themes\/{lobster_theme}\/tpl\/do.twig \/themes\/{lobster_theme}\/tpl\/do.txt   Route options  You can pass options to routes in two ways: flags and parameters.  Here is an example of a route with a parameter+value:  app op --color=red   .. It is not necessary for a param to have a value:  app op --debug   Here are examples with two flags, with identical effect:  app op -v -d app op -vd   Route flags   A flag is an argument that begins with a single -, e.g. -v. A flag cannot have a value (see parameter) Flags must be single characters. Flags may be grouped like this -asdf, which signifies four flags.   Route parameters   A parameter is an argument that begins with a double hyphen, e.g., '--verbose' It may have a value assigned, e.g., --file=my_file.txt   Option order is irrelevent  Lobster doesn't care the order of the args, flag or params.  All of the following have the same effect:  app arg1 -abcd --param=value arg2 arg3 app -abcd --param=value arg1 arg2 arg3 app --param=value arg1 -abcd  arg2 arg3 ...   Internal Routes  Sometimes you may want to call a route within a route; you will use --lobster-quiet to suppress theme output.  Do something like this:  $LOBSTER_APP {route} -f --lobster-nowrap  ","tags":"","url":"routes.html"},{"title":"Search Results","text":" ","tags":"","url":"search--results.html"},{"title":"Themes","text":"  The header and footer will not be output when --lobster-nowrap is present. All output is suppressed when --lobster-quite is present.  File structure  Given the following file structure:  \/default   \/post     header.sh   \/pre     header.sh   \/tpl     header.twig   And a line in the script reads:  theme \"header\"   Then the following files are called in this order:  \/default\/pre\/header.sh \/default\/tpl\/header.twig \/default\/post\/header.sh   File types  Only .sh files are supported for pre\/post scripts. ","tags":"","url":"themes.html"},{"title":"Lobster vars","text":"  Your app       var   description       $LOBSTER_APP   The path to the app controller script; use this to call self from within another route.     $LOBSTER_PWD   The path from which the script was originally called.     $LOBSTER_PWD_ROOT   Path to the dir $LOBSTER_PWD containing app config     $LOBSTER_APP_ROOT   Path to the Lobster app's root, same as $root     $lobster_app_config   Filename for app config files, e.g. .pspconfig  This is used to locate LOBSTER_PWD_ROOT     Lobster       var   description       $LOBSTER_ROOT   Path to the root of Lobster     Command-related       var   description       $lobster_args   An array of arguments called     $lobster_params   An array of x=y params called, e.g. --name=bob     $lobster_flags   An array of flags called e.g. -d     $lobster_target_dir   $2 will be expanded to an absolute dir or $PWD     $lobster_target_error   Set to 1 if lobster_target_dir is not a directory    ","tags":"","url":"vars.html"},{"title":"Verbose flag '-v'","text":"  lobster_verbose()  Use this function to output messages only when the -v flag is used.  lobster_verbose \"This will only show to user if the `-v` flag is used.\"   Lobster Core  By default the -v will also print Lobster core verbosity.  To disable this feature you need to add the following line to your app controller file just before calling the bootstrap:  lobster_core_verbose=0 source \"$LOBSTER_APP_ROOT\/lib\/lobster\/dist\/bootstrap.sh\"   Setting this variable in a config file is too late as the boostrapping process uses verbosity before loading all config files. ","tags":"","url":"verbose.html"}]};
