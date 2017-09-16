# Lobster Shell

A BASH framework by In the Loft Studios, especially for PHP Developers.

## Guidelines

<https://google.github.io/styleguide/shell.xml#Naming_Conventions>

## Quick Start with PSP

1. `psp make bash/lobster alpha`

## Getting started

If you are making an app called "Titanium"...

1. Type `git clone git@github.com:aklump/lobster.git alpha` and hit enter.
1. Copy the folder called `example_app` as `titanium` somewhere on your computer and start building your app.  That is the only folder you need from this repository to bundle with your app.
1. Rename `titanium/gitignore` to `titanium/.gitignore`.
1. Rename `example_app.sh` as  `titanium.sh`; this will be the controller for the app.
1. Copy `dist/.lobsterconfig` to `titanium/.lobsterconfig` and modify the necessary items.
1. Copy `dist/.example_appconfig` to `titanium/.titaniumconfig` and use this file for any configuration used by your app.
1. Sample routes have been provided in `example_app/routes`.

## Documentation

1. HTML documentation for Lobster is found at `/docs/public_html`.
