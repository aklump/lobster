source ../core.sh
lobster_bootstrap ${@}

# test function: lobster_array_pop
control=("first" "second" "third fourth fifth" "blue")
_lobster_array_=("${control[@]}")
lobster_test_assert_same "blue" $(lobster_array_end)
lobster_test_assert_same 4 ${#_lobster_array_[@]}
lobster_test_assert_same "blue" $(lobster_array_pop)
lobster_test_assert_same "third_fourth_fifth" $(lobster_array_pop)
lobster_test_assert_same "first" $(lobster_array_reset)