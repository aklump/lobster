# PHP
All PHP files need to include this line at the top:

    <?php
    require_once getenv('LOBSTER_ROOT') . '/bootstrap.php';

This line will cause the Lobster PHP functions to be loaded as well as these files in your app, if they exist.

    includes/bootstrap.php
    includes/functions.php