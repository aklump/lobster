<?php
lobster_notice('PHP Core Variables:');
lobster_echo_core_variables();

lobster_notice('PHP App Variables:');
lobster_echo_app_variables();

lobster_notice('Template-only Variables');
lobster_echo_array(lobster_cache('template_vars'));
