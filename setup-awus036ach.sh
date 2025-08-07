#!/bin/bash

set -e  # Exit on error

echo "[*] Installing build dependencies..."
sudo apt update
sudo apt install -y dkms git build-essential libelf-dev linux-headers-$(uname -r)

echo "[*] Cloning RTL8812AU driver to /opt/rtl8812au..."
sudo rm -rf /opt/rtl8812au
sudo git clone https://github.com/aircrack-ng/rtl8812au.git /opt/rtl8812au

echo "[*] Installing driver with DKMS..."
cd /opt/rtl8812au
sudo make dkms_install

echo "[*] Driver installed. Checking interfaces..."
iwconfig

echo ""
read -p "Would you like to reboot now to finish setup? (y/n): " reboot_choice
if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
  echo "[*] Rebooting..."
  sudo reboot
else
  echo "[*] Done. You may need to unplug and replug your adapter if not rebooting."
fi
