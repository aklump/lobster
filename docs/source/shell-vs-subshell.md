# Running your app in the same shell

In some cases you will want to run your app in the same shell, rather than a subshell.  Here's what you can do.

1. Create an alias in `.bash_profile` to your controller file like this:

        alias nav="/bin/bash /path/to/project_nav.sh"
    
1. Add the following function override to your app's `functions.sh`: 

        function lobster_route_end() {
          return 0
        }

Specifially the project_nav app needs to move a user around in by issuing a `cd` command.  This is not possible if launched as a subshell. More info: 

* <http://stackoverflow.com/questions/874452/change-current-directory-from-a-script>
* <http://stackoverflow.com/questions/255414/why-doesnt-cd-work-in-a-bash-shell-script>
