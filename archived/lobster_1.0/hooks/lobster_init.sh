source $LOBSTER/core.sh

framework="$LOBSTER/framework"
location="$LOBSTER_CWD"
config_dir="$location/.lobster"

if ! lobster_confirm "Install Lobster Shell in $location"; then
  lobster_alert "Installation cancelled." ok
  lobster_exit
fi

# Check for presence of .lobster which means already installed
if [[ -d "$config_dir" ]]; then
  lobster_progress "$config_dir found; Lobster is already installed" error
  lobster_alert "Installation cancelled." error
  lobster_exit
fi

lobster_prepare_directory "$location/.lobster"
lobster_prepare_directory "$location/lobster"

if lobster_install_framework "$framework" "$location"; then
  _lobster_rsync "$LOBSTER" "$location/lobster"
  if [[ -f "$location/lobster/core.sh" ]]; then
    lobster_progress "Lobster core installed." ok
  else
    lobster_progress "Lobster core installation failed." error
    lobster_alert "Installation cancelled." error
    lobster_exit
  fi

  lobster_alert "Installation complete." ok
fi
