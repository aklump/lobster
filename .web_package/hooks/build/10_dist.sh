#!/bin/bash
# 
# @file
# Handles build processes

# Make sure dist is not a symlink and exists as a folder
test -L $7/dist && rm $7/dist
if [ ! -d $7/dist ]; then
  mkdir $7/dist
fi

# Add everything needed to the dist folder.
rsync -a --delete $7/src/ $7/dist/
cp lobster.info $7/dist/
cp LICENSE.txt $7/dist/

# Copy dist onto the example app
test -d $7/example_app/lib/lobster/dist || mkdir -p $7/example_app/lib/lobster/dist
rsync -a --delete $7/dist/ $7/example_app/lib/lobster/dist/

# Copy config files to the example app
cp $7/dist/.lobsterconfig $7/example_app/
