#!/usr/bin/env bash

# Migrate the new structure onto example app.
rsync -a "$7/new/" "$7/example_app/" --exclude=.appconfig

# Rename certain files for example_app.
mv "$7/example_app/app.sh" "$7/example_app/example_app.sh"
cp "$7/example_app/install/.example_appconfig" "$7/example_app/.example_appconfig"
