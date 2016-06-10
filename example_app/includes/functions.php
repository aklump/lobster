<?php

/**
 * Access function that always fails.
 *
 * @return bool
 */
function never_allow() {
  @
    // TODO This has not been finished in lobster
    
  # Static failure messages can be set using lobster_access_denied in .lobsterconfig

  # Notice that any access messages that are dynamic should be echoed when the failure occurs.
  lobster_error "You will never be able to do '$lobster_op' because the access always fails."
  return 1
}
