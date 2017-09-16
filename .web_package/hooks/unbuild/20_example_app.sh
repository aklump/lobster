#!/usr/bin/env bash
test -e "$7/example_app/example_app.sh" && rm "$7/example_app/example_app.sh"
rm -rf "$7/example_app/hooks"
rm -rf "$7/example_app/install"
rm -rf "$7/example_app/lib"
rm -rf "$7/example_app/vendor"
rm -rf "$7/example_app/plugins"
rm -rf "$7/new/lib/lobster/dist/"
rm -rf "$7/dist/"
