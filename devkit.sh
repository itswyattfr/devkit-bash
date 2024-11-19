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

# Display menu and allow user to select options
echo "Ubuntu Performance Setup Menu"
echo "-----------------------------"
echo "[*] Install Net Tools (./. installed)"
echo "[ ] Install Developer Essentials (./. installed)"
echo "[ ] Install Development Kit"
echo "[ ] Install All"

while true; do
  read -p "Select option (1-4, q to quit): " option
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
    q|Q)
      echo "Exiting the script."
      break
      ;;
    *)
      echo "Invalid option. Please select a valid number or q to quit."
      ;;
  esac
done
