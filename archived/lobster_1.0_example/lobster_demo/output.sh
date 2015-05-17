#!/bin/bash
# 
# @file
# 
# Demo the output solutions
# 
source ../lobster/core.sh
lobster_bootstrap ${@}

# Controller begins.
# 

lobster_header "Here is a header" white

lobster_div "Output some text"
lobster_div "Output some blue text" pink

my_var="Output variable contents in grey"
lobster_div "$my_var" grey

declare -a array=('just the first value' 'not the second value');
lobster_div "${array[0]}" blue

declare -a array=('output' 'all' 'array' 'values' 'in red');
lobster_div "${array[*]}" red

lobster_h2 "Other types of output"

span=$(lobster_span "a blue word" blue)
lobster_div "Output yellow text with $span in the middle" yellow
lobster_br

lobster_p "Output yellow paragraph text" yellow
lobster_h1 "Output green h1 text" green
lobster_div "Followed by a div"
lobster_h2 "Output blue h2 text" blue
lobster_div "Followed by a div"
lobster_h3 "Output aqua h3 text" aqua
lobster_div "Followed by a div"
lobster_br

lobster_h2 "Progress indicators"
lobster_progress "File copied" success
lobster_progress "Missing default value" warning
lobster_progress "Can't finish!" error
lobster_br

lobster_h2 "Alerts"
lobster_alert "This is a status alert" success
lobster_alert "This is a warning alert" warning
lobster_alert "This is an error alert" danger

lobster_h2 "dates"
lobster_div "Current timestamp is: $(lobster_time)"
lobster_div "Current datetime is: $(lobster_datetime)"
lobster_div "Current date is: $(lobster_date)"
lobster_br

lobster_h2 "Tables"
lobster_tr "do" "C" "1st"
lobster_tr "re" "D" "2nd"
lobster_tr "mi" "E" "3rd"
lobster_th "col1" "col2" "col3"
lobster_table aqua
lobster_br

lobster_tr "do" "C" "1st"
lobster_tr "re" "D" "2nd"
lobster_tr "mi" "E" "3rd"
lobster_th "col1" "col2" "col3"
lobster_table aqua
lobster_br

lobster_footer "The window is $(lobster_window_width) x $(lobster_window_height) in size. Today is $(lobster_date)." help




# Must remain last.
lobster_exit