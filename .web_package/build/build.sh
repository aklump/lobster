#!/bin/bash
# 
# @file
# Handles build processes

if [ ! -d dist ]; then
  mkdir dist
fi

cp web_package.info dist/core.info

rsync -a src/ dist/