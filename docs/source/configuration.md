# Configuration

There are three layers of configuration that you should consider:

1. Lobster core.
2. Your app's lobster overrides and non-user configuration.
3. User configurable settings user defaults.
4. User configurable settings instance values.

Lobster core provides default values for a number of variables; this is layer one.

Layer two is a file in the root of your app called `.lobsterconfig` where you may override Lobster core and add any settings that you do not wish to be visible to users.  Refer to `.lobsterconfig` in the core for variables you may override.  This file is a required file.

Layer three is the user configuration and should be defined in `install/.{app_name}config`.  This file is used as a template for the core `init` path and is also loaded during bootstrap to obtain defaults before reading instance overrides.  The core `init` command will copy `install/.{app_name}config` to `.{app_name}config` in the directory where `init` was executed.

Also note the the configuration will automatically look for the file `~/.{app_name}config` (user's home directory) and load it before the instance config file.  This allows users of your app the ability to set their own defaults that preexist an instance defaults.  This is like the `.gitconfig` file.

In summary configuration automatically loads as follows:

    {app root}/lib/lobster/dist/.lobsterconfig
    {app root}/.lobsterconfig
    {app root}/install/.{app_name}config
    ~/.{app_name}config
    {instance root}/.{app_name}config
        
