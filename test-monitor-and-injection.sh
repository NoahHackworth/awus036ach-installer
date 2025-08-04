#!/bin/bash

set -e

echo "[*] Finding wireless interfaces..."
interfaces=$(iw dev | awk '$1=="Interface"{print $2}')

if [[ -z "$interfaces" ]]; then
  echo "[!] No wireless interfaces found. Is your adapter plugged in?"
  exit 1
fi

echo "[*] Detected interfaces:"
echo "$interfaces"
read -p "Enter the interface to test (e.g., wlan1): " iface

echo "[*] Starting monitor mode on $iface..."
sudo airmon-ng start "$iface"

mon_iface="${iface}mon"

echo "[*] Verifying monitor mode..."
iwconfig "$mon_iface" | grep -i monitor >/dev/null && \
  echo "✅ Monitor mode enabled on $mon_iface" || \
  { echo "❌ Monitor mode failed."; exit 1; }

echo "[*] Running packet injection test..."
sudo aireplay-ng -9 "$mon_iface"

echo "✅ Test complete. If injection was successful, you're good to go!"
