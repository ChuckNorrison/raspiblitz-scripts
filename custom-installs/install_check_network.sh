#!/bin/bash

if ! sudo crontab -l | grep "check_network.sh"; then
  echo "# Add cronjob check_network.sh"    
  # Add cron to check network with 5 min interval
  (sudo crontab -l; echo "*/5 * * * * bash /mnt/hdd/raspiblitz-scripts/custom-installs/check_network.sh >> /var/log/check_network_cron.log 2>&1";) | sudo crontab -  
else
  echo "# Cronjob with check_network.sh already exists"
fi
