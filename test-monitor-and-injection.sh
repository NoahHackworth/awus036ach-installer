#!/bin/bash

set -e

iface="wlan0"

echo ""
echo "========== AWUS036ACH Monitor Mode & Injection Test =========="

# Kill interfering services
echo "[*] Killing NetworkManager and wpa_supplicant..."
sudo systemctl stop NetworkManager
sudo systemctl stop wpa_supplicant

# Enable monitor mode
echo "[*] Enabling monitor mode on $iface..."
sudo airmon-ng start "$iface"

# Check monitor mode (NO renaming assumptions)
echo "[*] Verifying interface type for $iface..."
if iw dev "$iface" info | grep -q "type monitor"; then
    echo "✅ $iface is in monitor mode"
else
    echo "❌ $iface is NOT in monitor mode"
    exit 1
fi

# Injection test
echo "[*] Running injection test on $iface..."
sudo aireplay-ng -9 "$iface"

# Ask to restore services
read -p "[*] Restore networking now? (y/n): " restart
if [[ "$restart" =~ ^[Yy]$ ]]; then
    echo "[*] Restarting services..."
    sudo systemctl start NetworkManager
    sudo systemctl start wpa_supplicant
fi

echo ""
echo "✅ Done."
