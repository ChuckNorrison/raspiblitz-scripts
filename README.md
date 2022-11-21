# raspiblitz-scripts
Additional custom scripts to extend your RaspiBlitz

1. Checkout the scripts to your ssd:
- `cd /mnt/hdd`
- `sudo mkdir raspiblitz-scripts`
- `sudo chown -R admin:admin raspiblitz-scripts/`
- `git clone https://github.com/ChuckNorrison/raspiblitz-scripts`

2. Add desired install script to `/mnt/hdd/app-data/custom-installs.sh` (see example)

### OpenVPN Client

First you need a OpenVPN Server and ovpn client files. 
Recommended way on how to setup OpenVPN Server on a cheap VPS and create ovpn files with a wizard. 

https://github.com/angristan/openvpn-install

After this was done, copy your ovpn file to /mnt/hdd/raspiblitz-scripts/custom-installs/client.ovpn

Start install script manually or reflash sd card

`sudo bash /mnt/hdd/raspiblitz-scripts/custom-installs/install_openvpn.sh`

### Network checker

This script can help solve connectivity issues with DHCP or VPN which can happen sometimes, especially on reconnect LAN.
Tweak your gatewayip to ping check into `check_network.sh`
Do NOT execute install script multiple times, it will simply add a line to your crontab.

Check with `sudo crontab -e`

`*/5 * * * * bash /mnt/hdd/raspiblitz-scripts/custom-installs/check_network.sh >> /var/log/check_network_cron.log 2>&1`

Start install script manually or reflash sd card

`sudo bash /mnt/hdd/raspiblitz-scripts/custom-installs/install_check_network.sh`
