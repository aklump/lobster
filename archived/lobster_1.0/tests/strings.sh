#!/bin/bash
# 
# @file
# 
# 
# 
source ../core.sh
lobster_bootstrap ${@}

# Controller begins.

# test function: _lobster_menu_get_item
subject="dive Some description"
lobster_test_assert_same "dive" $(_lobster_menu_get_item "$subject")
lobster_test_assert_same "dive" $(_lobster_menu_get_callback "$subject")
subject=("dive" "Some description")
lobster_test_assert_same "dive" $(_lobster_menu_get_item ${subject[@]})
lobster_test_assert_same "dive" $(_lobster_menu_get_callback ${subject[@]})

# test function: _lobster_menu_get_callback
_lobster_menu_get_callback "dive Some description"


lobster_explode '0=do re&1=mi fa&2=so'
result=("${lobster_explode_result[@]}")
echo Function: $FUNCNAME
echo '  "'$result'"'
echo '  [@] => "'${result[@]}'"'
echo '  [*] => "'${result[*]}'"'
echo 'Array'
echo '('
echo '  [0] => "'${result[0]}'"'
echo '  [1] => "'${result[1]}'"'
echo '  [2] => "'${result[2]}'"'
echo '  [3] => "'${result[3]}'"'
echo '  [4] => "'${result[4]}'"'
echo '  [5] => "'${result[5]}'"'
echo '  [6] => "'${result[6]}'"'
echo '  [7] => "'${result[7]}'"'
echo '  [8] => "'${result[8]}'"'
echo '  [9] => "'${result[9]}'"'
echo ')'
exit


# test function: lobster_urlencode
lobster_serialize "do re" "mi fa" "so"
lobster_test_assert_same '0=do+re&1=mi+fa&2=so' $(lobster_serialize "do re" "mi fa" "so")

# test function: lobster_urlencode
lobster_unserialize '0=do re&1=mi fa&2=so'
result=("${lobster_unserialize_result[@]}")
lobster_test_assert_same "do re" ${result[0]}
lobster_test_assert_same "mi fa" ${result[1]}
lobster_test_assert_same "so" ${result[2]}

# test function: lobster_strlen
lobster_test_assert_same 29 $(lobster_strlen "This is a string of 29 chars.")

# test function: lobster_str_repeat
lobster_test_assert_same '---' $(lobster_str_repeat "-" 3)

# test function: lobster_strtoupper
lobster_test_assert_same "SUBJECT" $(lobster_strtoupper "Subject")

# test function: lobster_strtolower
lobster_test_assert_same 'subject' $(lobster_strtolower "SUBJECT")

# test function: lobster_implode
lobster_test_assert_same 'do and&re and&mi and' "$(lobster_implode "&" "do and" "re and" "mi and")"
lobster_test_assert_same 'do&re&mi' $(lobster_implode '&' 'do' 're' 'mi')


# Must remain last.
lobster_exit