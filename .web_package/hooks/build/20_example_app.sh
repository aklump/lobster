#!/usr/bin/env bash

# Migrate the new structure onto example app.
rsync -a "$7/new/" "$7/example_app/"

# Rename certain files for example_app.
mv "$7/example_app/app.sh" "$7/example_app/example_app.sh"
mv "$7/example_app/install/.appconfig" "$7/example_app/install/.example_appconfig"
