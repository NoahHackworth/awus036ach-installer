#!/bin/bash

set -e  # Exit on error

install_driver_awus036ach() {
  echo "[*] Installing build dependencies..."

  # Explanation:
  # - 'build-essential' gives gcc/make and friends for compiling kernel modules.
  # - 'dkms' lets the driver rebuild automatically on kernel upgrades.
  sudo apt update
  sudo apt install -y build-essential dkms pkg-config bc

  KREL="$(uname -r)"                          # running kernel version string
  HEADER_LINK="/lib/modules/$KREL/build"      # present if matching headers are installed

  if [ -e "$HEADER_LINK" ]; then
    echo "[*] Headers already present for $KREL at $HEADER_LINK"
  else
    echo "[*] Trying to install headers for exact kernel: linux-headers-$KREL"
    if sudo apt install -y "linux-headers-$KREL"; then
      echo "[*] Installed exact headers: linux-headers-$KREL"
    else
      echo "[!] Exact headers not found for $KREL."
      echo "[*] Installing meta kernel + headers (linux-image-amd64, linux-headers-amd64) so DKMS can build."
      sudo apt install -y linux-image-amd64 linux-headers-amd64
      echo "[*] A reboot is required to load the new kernel. Re-run the toolkit after reboot."
      read -p "Press Enter to reboot now..." _
      sudo reboot
      exit 0
    fi
  fi

  echo "[*] Installing Realtek 88xxau DKMS driver from Kali..."
  if sudo apt install -y realtek-rtl88xxau-dkms; then
    echo "[*] DKMS driver installed successfully."
  else
    echo "[!] Failed to install Kali DKMS package."
    echo "[*] Attempting Aircrack-NG 88xxau DKMS fallback (keeps current kernel support updated)."
    # Explanation:
    # - We clone the maintained DKMS repo and register it with DKMS so it auto-rebuilds.
    # - 'git' is used to clone; 'dkms add/build/install' registers and builds it against your headers.
    sudo apt install -y git
    TMPDIR="$(mktemp -d)"
    git clone https://github.com/aircrack-ng/rtl8812au.git "$TMPDIR/rtl8812au"
    cd "$TMPDIR/rtl8812au" || { echo "[!] Could not enter source dir"; return 1; }
    sudo ./dkms-install.sh
    cd - >/dev/null
    rm -rf "$TMPDIR"
  fi

  echo "[*] Driver install step complete. You may need to plug & unplug adapter if not rebooting"



#echo "[*] Installing build dependencies..."
#sudo apt update
#sudo apt install -y dkms git build-essential libelf-dev linux-headers-$(uname -r)

#echo "[*] Cloning RTL8812AU driver to /opt/rtl8812au..."
#sudo rm -rf /opt/rtl8812au
#sudo git clone https://github.com/aircrack-ng/rtl8812au.git /opt/rtl8812au

#echo "[*] Installing driver with DKMS..."
#cd /opt/rtl8812au
#sudo make dkms_install

#echo "[*] Driver installed. Checking interfaces..."
#iwconfig

#echo ""
#read -p "Would you like to reboot now to finish setup? (y/n): " reboot_choice
#if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
 # echo "[*] Rebooting..."
 # sudo reboot
#else
 # echo "[*] Done. You may need to unplug and replug your adapter if not rebooting."
#fi
