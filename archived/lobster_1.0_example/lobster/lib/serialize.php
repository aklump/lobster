<?php
$args = $argv;
array_shift($args);
$direction = array_shift($args);

switch ($direction) {
  case 0:
    print http_build_query($args);
    break;

  case 1:
    # unserialize
    print parse_str($args[0], $result);
    print '<pre>'; print __FILE__ . '/' . __FUNCTION__ . "():\n"; print_r($result); print '</pre>'; die;
    break;
  
}
  