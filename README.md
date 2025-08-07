```
   ___      _                 _        _   _      _      _     
  / _ \__ _| | ___ _   _  ___| |_ __ _| | | |_ __(_) ___| |__  
 / /_)/ _` | |/ __| | | |/ __| __/ _` | | | | '__| |/ __| '_ \ 
/ ___/ (_| | | (__| |_| | (__| || (_| | |_| | |  | | (__| | | |
\/    \__,_|_|\___|\__,_|\___|\__\__,_|\___/|_|  |_|\___|_| |_|

               Alfa AWUS036ACH Installer Toolkit
```

# awus036ach-installer

A master launcher and toolset to manage the Alfa AWUS036ACH WiFi adapter on Kali Linux—especially helpful for VirtualBox users.

This toolkit helps you:

- ✅ Set up the RTL8812AU driver for the first time
- 🔄 Reinstall the driver after kernel updates
- 🧪 Test monitor mode and packet injection capabilities

---

## 📦 What's Included

| Script                          | Purpose                                              |
|---------------------------------|------------------------------------------------------|
| `setup-awus036ach.sh`           | First-time setup: installs driver via DKMS          |
| `reinstall-awus036ach.sh`       | Reinstalls driver after Kali updates break it       |
| `test-monitor-and-injection.sh` | Verifies monitor mode and injection are working     |
| `awus036ach-toolkit.sh`         | Interactive launcher with menu for all tasks        |

---

## ⚡ Quick Start (One-Liner)

Run this in Kali to launch the full interactive menu:

```bash
curl -sSL https://raw.githubusercontent.com/NoahHackworth/awus036ach-installer/main/awus036ach-toolkit.sh | sed 's/\r$//' | bash
```

---

## 🧰 Menu Options (from the toolkit)

```text
=========== Alfa AWUS036ACH Toolkit ===========
[1] First-Time Driver Setup
[2] Reinstall Driver After Kali Update
[3] Test Monitor Mode & Packet Injection
[4] Exit
===============================================
```

---

## 💻 Individual Script Use

### ▶️ First-Time Setup

```bash
curl -sSL https://raw.githubusercontent.com/NoahHackworth/awus036ach-installer/main/setup-awus036ach.sh | bash
```

This script:

- Installs dependencies
- Clones the aircrack-ng RTL8812AU driver to `/opt/rtl8812au`
- Builds the driver using DKMS
- Prompts you to reboot or unplug/replug the adapter

---

### 🔁 Reinstall After Update

```bash
curl -sSL https://raw.githubusercontent.com/NoahHackworth/awus036ach-installer/main/reinstall-awus036ach.sh | bash
```

Use this any time a Kali Linux update breaks your WiFi driver.

---

### 🧪 Test Monitor Mode & Packet Injection

```bash
curl -sSL https://raw.githubusercontent.com/NoahHackworth/awus036ach-installer/main/test-monitor-and-injection.sh | bash
```

This script:

- Prompts you to select your adapter (e.g., `wlan1`)
- Enables monitor mode
- Runs an `aireplay-ng` injection test
- Prints success/failure results

---

## 📁 Optional: Make It Local and Persistent

If you want to store the scripts offline for reuse:

```bash
sudo mkdir -p /opt/awus-tools
cd /opt/awus-tools

sudo curl -O https://raw.githubusercontent.com/NoahHackworth/awus036ach-installer/main/setup-awus036ach.sh
sudo curl -O https://raw.githubusercontent.com/NoahHackworth/awus036ach-installer/main/reinstall-awus036ach.sh
sudo curl -O https://raw.githubusercontent.com/NoahHackworth/awus036ach-installer/main/test-monitor-and-injection.sh
sudo curl -O https://raw.githubusercontent.com/NoahHackworth/awus036ach-installer/main/awus036ach-toolkit.sh

sudo chmod +x *.sh
```

### 💬 Add a Terminal Alias:

To make it easier to launch:

```bash
echo "alias ach-toolkit='sudo /opt/awus-tools/awus036ach-toolkit.sh'" >> ~/.bashrc
source ~/.bashrc
```

Then just run:

```bash
ach-toolkit
```

---

## 🧠 Notes

- These scripts are written for **Kali Linux 2023+**
- Designed to work in **VirtualBox** with **USB 3.0 passthrough enabled**
- Tested with **Alfa AWUS036ACH** using the **RTL8812AU** chipset
- They install the driver to `/opt/rtl8812au` using DKMS for kernel persistence

---

## 🛡️ Disclaimer

This toolkit is for educational and authorized penetration testing purposes only.  
Always have explicit permission before scanning, capturing, or testing any network.

Use responsibly. Hack smart. Hack legal. 🕶️
