#!/bin/bash

# List of essential packages
net_tools="net-tools wireless-tools"
developer_essentials="python3 nodejs build-essential g++"
development_kit="apache2 libapache2-mod-php php php-cli"
all_essentials="$net_tools $developer_essentials $development_kit"

# Function to prompt the user for confirmation
confirm_install() {
  while true; do
    read -p "$1 [y/n]: " choice
    case "$choice" in
      y|Y ) return 0 ;;
      n|N ) return 1 ;;
      * ) echo "Please enter y or n." ;;
    esac
  done
}

# Function to install packages
install_package() {
  local package_name=$1
  sudo apt update
  sudo apt install -y $package_name
  echo "$package_name installed."
}

# Create a dialog menu
dialog_menu() {
  exec 3>&1
  option=$(dialog --clear --title "Ubuntu Performance Setup Menu" \
    --menu "Select an option" 15 50 4 \
    1 "Install Net Tools" \
    2 "Install Developer Essentials" \
    3 "Install Development Kit" \
    4 "Install All" \
    2>&1 1>&3)
  exitcode=$?
  exec 3>&-

  if [ $exitcode -ne 0 ]; then
    echo "Exiting the script."
    exit
  fi

  case $option in
    1)
      if confirm_install "Do you want to install Net Tools?"; then
        install_package "$net_tools"
      fi
      ;;
    2)
      if confirm_install "Do you want to install Developer Essentials?"; then
        install_package "$developer_essentials"
      fi
      ;;
    3)
      if confirm_install "Do you want to install the Development Kit?"; then
        install_package "$development_kit"
      fi
      ;;
    4)
      if confirm_install "Do you want to install all packages?"; then
        install_package "$all_essentials"
      fi
      ;;
    *)
      echo "Invalid option."
      ;;
  esac
}

# Main loop to keep the menu showing
while true; do
  dialog_menu
done
