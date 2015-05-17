# Working with arrays in BASH

## Passing an array to a function
In BASH you cannot pass arrays to functions.  To get around this you will use global variables.

Before calling a lobster function beginning with 'lobster_array_', set the value of the global variable `_lobster_array_ with your array argument like this:

    _lobster_array_=("do" "re" "mi fa sol")
    last_val=$(lobster_array_pop)