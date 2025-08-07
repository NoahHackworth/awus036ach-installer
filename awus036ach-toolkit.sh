#!/bin/bash

set -e

REPO_BASE="https://raw.githubusercontent.com/NoahHackworth/awus036ach-installer/main"

function install_driver() {
  echo "[*] Running initial driver setup..."
  curl -sSL "$REPO_BASE/setup-awus036ach.sh" | bash
}

function reinstall_driver() {
  echo "[*] Running post-update driver reinstall..."
  curl -sSL "$REPO_BASE/reinstall-awus036ach.sh" | bash
}

function test_capabilities() {
  echo "[*] Running monitor mode and injection test..."
  curl -sSL "$REPO_BASE/test-monitor-and-injection.sh" | bash
}

while true; do
  echo ""
  echo "=========== Alfa AWUS036ACH Toolkit ==========="
  echo "[1] First-Time Driver Setup"
  echo "[2] Reinstall Driver After Kali Update"
  echo "[3] Test Monitor Mode & Packet Injection"
  echo "[4] Exit"
  echo "==============================================="
  read -p "Choose an option [1-4]: " choice

  case $choice in
    1) install_driver ;;
    2) reinstall_driver ;;
    3) test_capabilities ;;
    4) echo "[*] Exiting. Stay stealthy, hacker 😎"; exit 0 ;;
    *) echo "[!] Invalid choice. Enter 1, 2, 3, or 4." ;;
  esac
done
