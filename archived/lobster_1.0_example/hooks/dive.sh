source $LOBSTER/core.sh

lobster_header "You want to dive?" yellow

args=("$@")

echo Function: $FUNCNAME
echo '  "'$args'"'
echo '    [#] => '${#args[@]}
echo '    [@] => '${args[@]}
echo '    [*] => '${args[*]}
echo 'Array'
echo '('
echo '    [0] => '${args[0]}
echo '    [1] => '${args[1]}
echo '    [2] => '${args[2]}
echo '    [3] => '${args[3]}
echo '    [4] => '${args[4]}
echo '    [5] => '${args[5]}
echo '    [6] => '${args[6]}
echo '    [7] => '${args[7]}
echo '    [8] => '${args[8]}
echo '    [9] => '${args[9]}
echo ')'
exit