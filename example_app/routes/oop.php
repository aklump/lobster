<?php

use ExampleApp\Record;

$obj = new Record();

lobster_echo('This is a file that uses OOP with a Composer autoload file.');
lobster_echo();
lobster_echo('The id of the record is: ' . $obj->getId());
