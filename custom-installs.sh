#!/bin/bash

# This script runs with sudo rights after an update/recovery from a fresh sd card.
# This is the place to put all the install commands, cronjobs or editing of system configs 
# for your personal modifications of RaspiBlitz

# note: use absolute paths if you point to specific files

echo "Custom install OpenVPN Client"
sudo bash /mnt/hdd/custom-installs/install_openvpn.sh

echo "Custom install network check"
sudo bash /mnt/hdd/custom-installs/install_check_network.sh
