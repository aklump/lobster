<?php
$args = $argv;
array_shift($args);


$string = implode('&', $args);
print urlencode($string);