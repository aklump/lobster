# Output

The goal is to feel like HTML.  Semantic meaning is also a factor in this design. By implementing Lobster's output abstraction layer, we leave our applications open to features in the future, such as a templating engine, for example.

## Text
    lobster_div "Output some text"

## A variable
Always wrap the variable in double quotes.

    my_var="Output variable contents"
    lobster_div "$my_var"

## An array element

    declare -a array=('just the first value' 'not the second value');
    lobster_div "${array[0]}"

## An array

    declare -a array=('output' 'all' 'array' 'values');
    lobster_div "${array[*]}"

## Colored text
For any of the above examples you can specify color with the second argument. Valid argument values: _grey, red, green, yellow, blue, pink, aqua, white, default, success, status, ok, warning, danger, error, help._

    lobster_div "Output some blue text" blue

## Other elements
Instead of _div_ you may use these other output functions:

    span=$(lobster_span "a blue word" blue)
    lobster_div "Output yellow text with $span in the middle"
    lobster_br

    lobster_p "Output yellow paragraph text" yellow
    lobster_h1 "Output green h1 text" green
    lobster_h2 "Output blue h2 text" blue
    lobster_h3 "Output aqua h3 text" aqua

## Semantic output
_Progress indicators_ and _alerts_ provide semantic meaning.  For example, instead of outputting a red paragraph, you should consider a danger/error progress indicator or alert. The following are synonyms and can be used interchangeably: danger/error and success/status.  That said, it is technically possible to use any of the color names as the second argument, to get the formatting without the semantics.

###Progress indicators
When your script is running you might want to provide progress indicators such as "things are okay" or "oops there's a warning" or "big time error right here".  For this use the `progress` function.

    lobster_progress "File copied" success
    lobster_progress "Missing default value" warning
    lobster_progress "Can't finish!" error

### Alerts
Use alerts for stronger communication where a progress indicator is insufficient, such as when a script is called with invalid arguments and execution stops.

    lobster_alert "This is a status alert" status
    lobster_alert "This is a status alert" success
    lobster_alert "This is a warning alert" warning
    lobster_alert "This is an error alert" error
    lobster_alert "This is an error alert" danger

## Tables
To build a table you must call at least two functions: `tr()` and `table()`; additionally you can set headers using `th()`.  The following would print a green table with a header row and three rows of data, three columns wide.

Its worth noting that `th` and `tr` _add_ data to the table, while `table` is the only table call that _outputs_ data.  Also, you could add the header at any point before you call `table`, even after calling `tr` one or more times.  You could be adding rows throughout the script and then at the end call the table to print the output.  When you call `table` it has the effect of clearing out the table data.  So if you need to print more than one table in a script, you are ready to go on the next table after printing the first.  You cannot, however, be building more than one table at a time.

    lobster_th "col1" "col2" "col3"
    lobster_tr "do" "C" "1st"
    lobster_tr "re" "D" "2nd"
    lobster_tr "mi" "E" "3rd"
    lobster_table aqua

