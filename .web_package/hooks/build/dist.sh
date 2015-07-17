#!/bin/bash
# 
# @file
# Handles build processes

if [ ! -d dist ]; then
  mkdir dist
fi

cp lobster.info dist/lobster.info

rsync -a src/ dist/