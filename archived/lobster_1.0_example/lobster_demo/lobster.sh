#!/bin/bash
# 
# @file
# 
source ../lobster/core.sh
lobster_bootstrap ${@}

# 
# Controller begins.
# 
# Here you define your menu items and the name of their callbacks
lobster_menu_item "dive" "Dive down under the water."
lobster_menu_item "surface" "Surface from the depths."
lobster_menu_item "hold" "Hold your breath for --s=N seconds, where N is a number."

# This menu item cannot be added, help is reserved; uncomment to see...
# lobster_menu_item "help" "This will trigger invalid."

# Now we will deliver the page requested by the user
if lobster_deliver; then
  lobster_exit
fi

# The user did not request a page registered in our menu router
lobster_h1 "Welcome to Lobster | By Aaron Klump" blue

# We show them all their options
lobster_menu

# Must remain last.
lobster_exit