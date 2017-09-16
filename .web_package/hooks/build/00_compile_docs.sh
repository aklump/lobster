#!/bin/bash
#
# @file Compiles Loft Docs.
#

(cd "$7/docs/" && ./core/compile.sh)
git add public_html/* -u
cp "$7/docs/source/CHANGELOG.md" "$7/CHANGELOG.md"
