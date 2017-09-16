#!/bin/bash
# 
# @file
# This will use grab to get the file copies (not symlinks)
# 
rm -r $7/dist
(cd $7 && ln -s src dist)

(cd "$7/example_app/lib/lobster" && rm -rf dist && ln -s "$7/src" dist)
