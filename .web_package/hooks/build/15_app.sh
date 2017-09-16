#!/usr/bin/env bash

# Copy lobster config file to the app
cp "$7/dist/.lobsterconfig" "$7/new/.lobsterconfig"

# Copy lobster dist into lib
mkdir -p "$7/new/lib/lobster/dist/"
rsync -a "$7/dist/" "$7/new/lib/lobster/dist/"
