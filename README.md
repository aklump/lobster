# Lobster Shell
A lightweight bash framework by In the Loft Studios.

When building a _Lobster Shell_ app the core folder `dist` must be located, relative to the app's root at:

    /vendor/aklump/lobster/dist

## Setup
If you are making an app called "Titanium"...

1. In the root folder of your app, create a file called `titanium.sh`; this will be the controller for the app.
1. In the root folder create the following folders: `includes, routes, templates`.
1. In the root folder create a file `.lobsterconfig`.
1. Refer to `__lobster_app_example` for how to build the app.
1. Install lobster core at `vendor/aklump/lobster`; you can rename `gitignore` as `.gitignore` for use in your app.

## Configuration
1. You should copy the file `dist/.lobsterconfig` to your root directory and override.
