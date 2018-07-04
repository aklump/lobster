# Troubleshooting

## `Could not open input file:...`

This happens when the output of `which php` does not return the path to the PHP file.  The fix is to set the path to php in _.lobsterconfig_ like so:

	lobster_php='/Applications/MAMP/bin/php/php7.1.12/bin/php'