#!/bin/bash

set -e

echo "[*] Rebuilding RTL8812AU driver after kernel update..."

sudo apt install -y linux-headers-$(uname -r)

if [ -d "/opt/rtl8812au" ]; then
  cd /opt/rtl8812au
  echo "[*] Recompiling driver in /opt/rtl8812au..."
else
  echo "[!] Driver source not found in /opt. Cloning fresh copy..."
  sudo git clone https://github.com/aircrack-ng/rtl8812au.git /opt/rtl8812au
  cd /opt/rtl8812au
fi

sudo make dkms_remove
sudo make dkms_install

echo ""
read -p "Would you like to reboot now to activate the driver? (y/n): " reboot_choice
if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
  echo "[*] Rebooting..."
  sudo reboot
else
  echo "[*] Done. You may need to unplug and replug your adapter if not rebooting."
fi
