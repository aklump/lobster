# Hooks (or includes)
A single route will try to call execute the following files, if they exist, in this order.

`/includes/`
1. bootstrap.sh
1. bootstrap.php
1. functions.sh
1. functions.php

_Now all functions are available, but the route is not yet known. Arguments may be altered, which then alter the route._

1. init.sh
1. init.php

_At this point, the route is known._

1. preroute.sh
1. preroute.php
1. preroute.{route_id}.sh
1. preroute.{route_id}.php

_Output starts, header is rendered._

`/routes/`
1. {route}.sh
1. {route}.php

`/includes/`
1. shutdown.sh
1. shutdown.php
