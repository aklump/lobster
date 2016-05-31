#!/bin/bash
# 
# @file
# Handles build processes

if [ ! -d dist ]; then
  mkdir dist
fi

rsync -a --delete src/ dist/
cp lobster.info dist/
cp LICENSE.txt dist/

# Copy dist onto the example app
-d $7/example_app/lib/lobster/dist || mkdir -p $7/example_app/lib/lobster/dist
rsync -a --delete $7/dist/ $7/example_app/lib/lobster/dist/

# Copy config files to the example app
cp $7/dist/example_app/.config $7/example_app/.example_appconfig
cp $7/dist/.lobsterconfig $7/example_app/
