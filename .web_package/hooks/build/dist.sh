#!/bin/bash
# 
# @file
# Handles build processes

if [ ! -d dist ]; then
  mkdir dist
fi

cp lobster.info dist/lobster.info

rsync -a src/ dist/

# Copy dist onto the example app
-d $7/example_app/lib/lobster/dist || mkdir -p $7/example_app/lib/lobster/dist
rsync -av $7/dist/ $7/example_app/lib/lobster/dist/
