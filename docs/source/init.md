# Core's `init` command

You are encouraged to leverage the init command provided by core, which is meant to bring continuinty to Lobster apps and achieves the following:

* calls a pre_init include file if you wish to do something before initialization.
* copies your app's configuration from /install/.appconfig to the directory being initialized
* calls a post_init include file if you wish to do something after initialization.
