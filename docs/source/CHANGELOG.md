# Changelog

## 2.2
* **Breaking change**, your app controller file must remove these lines:

      source "$LOBSTER_APP_ROOT/lib/lobster/dist/bootstrap.sh"
      lobster_theme 'header'
      source "$LOBSTER_APP_ROOT/lib/lobster/dist/router.sh"

And replace with this line:

    source "$LOBSTER_APP_ROOT/lib/lobster/dist/lobster.sh"
