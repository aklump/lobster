#!/bin/bash
# 
# @file
# This will use grab to get the file copies (not symlinks)
# 
rm -r $7/dist
(cd $7 && ln -s src dist)
