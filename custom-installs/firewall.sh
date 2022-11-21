#!/bin/bash

# Reset firewall rules
sudo ufw --force reset

# deny traffic
sudo ufw default deny incoming
sudo ufw default deny outgoing

## ALL
sudo ufw allow from 172.31.0.0/16 comment "ALL IN LAN1"
sudo ufw allow from 192.168.0.0/16 comment "ALL IN LAN2"

# allow internal known networks
# fallback to common private subnet in case of emergency
sudo ufw allow out on eth0 to 172.31.0.0/16 comment "ALL OUT LAN1"
sudo ufw allow out on eth0 to 192.168.0.0/16 comment "ALL OUT LAN2"
# need to check own public IP (UPDATE THIS EXTERNAL IP HERE)
sudo ufw allow out on eth0 to 123.45.67.8/32 comment "ALL OUT VPS"

# allow OpenVPN Client connection
sudo ufw allow out 1194/udp comment "OPENVPN"

# allow traffic via openvpn tunnel only
sudo ufw allow out on tun0 from any to any comment "ALL OUT VPN"
sudo ufw allow in on tun0 from any to any comment "ALL IN VPN"

# enable rules
sudo ufw --force enable
