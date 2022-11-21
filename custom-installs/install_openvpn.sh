#!/bin/sh

##############################
## Setup OpenVPN for static IP
##############################

pingtest=10.8.0.1
ovpnfile=/mnt/hdd/custom-installs/client.ovpn

if [ $# -eq 0 ] || [ "$1" != "--silent" ]; then
  # ask user
  while true; do
      read -p "Start install OpenVPN? (y/n): " yn
      case $yn in
          [Yy]* ) break;;
          [Nn]* ) exit;;
          * ) echo "Please answer yes or no.";;
      esac
  done
fi

# Install OpenVPN
sudo apt update
sudo apt install openvpn
if [ $? -eq 0 ]; then
  echo "`date`: Install OpenVPN ok"
else
  echo "`date`: Install OpenVPN failed! Quit!"
  exit
fi

# Copy ovpn config
sudo cp $ovpnfile /etc/openvpn/client.conf
if [ $? -eq 0 ]; then
  echo "`date`: Copy OpenVPN config ok"
else
  echo "`date`: Copy OpenVPN config failed! Quit!"
  exit
fi

# start service
sudo systemctl start openvpn@client
if [ $? -eq 0 ]; then
  echo "`date`: Service start ok"
else
  echo "`date`: Service start failed! Quit!"
  exit
fi
#sudo systemctl status openvpn@client

# check vpn connection
ping -q -c 4 $pingtest > /dev/null
if [ $? -eq 0 ]; then
  echo "`date`: Connectivity check ok"
  # autostart service
  sudo systemctl enable openvpn@client
  # configure firewall
  sudo bash /mnt/hdd/custom-installs/firewall.sh
else
  echo "`date`: Connectivity check failed"
  exit
fi
