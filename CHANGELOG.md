# Changelog

## 2.2
### In the controller file
**Breaking change**, your app controller file must remove these lines:

      source "$LOBSTER_APP_ROOT/lib/lobster/dist/bootstrap.sh"
      lobster_theme 'header'
      source "$LOBSTER_APP_ROOT/lib/lobster/dist/router.sh"

And replace with this line:

    source "$LOBSTER_APP_ROOT/lib/lobster/dist/lobster.sh"

### In php files
**Breaking change**, any php files that previously did this:

    require_once getenv('LOBSTER_ROOT') . '/bootstrap.php';

No must do this:
    
    require_once getenv('LOBSTER_ROOT') . '/lobster.php';
