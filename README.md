# Ansible Kali Setup

## Overview
This Ansible playbook automates the setup of a Kali Linux system for penetration testing, CTFs, and hacking. It installs **i3-gaps**, configures **Alacritty, Compton (Picom), and Rofi**, sets up **Oh-My-Zsh**, applies the **Arc-Theme**, installs **Nerd Fonts**, and ensures a persistent background image.

## Prerequisites
Before running the playbook, ensure the following requirements are met:

### 1. Install Ansible
```bash
sudo apt update && sudo apt install -y ansible
```

### 2. Get root token
Ensure that the user has root privileges. You can check this by running:
```bash
sudo whoami
```
Do not execute this playbook as root, use the default user e.g. kali. If you are root, change to your default user.
```bash
su username
```

## Installation Steps

### 1. Clone the Repository
```bash
git clone https://github.com/freaks0ut/kali-build.git
cd kali-build
```

### 2. Run the Playbook
Execute the following command to start the installation:
```bash
ansible-playbook playbooks/kali-setup.yml
```

### 3. Reboot the System
After the installation completes, reboot the system to apply all changes:
```bash
reboot
```

## What This Playbook Does
- **Installs** `i3-gaps`, `Alacritty`, `Compton`, `Rofi`, and all necessary dependencies.
- **Configures** `i3`, `Alacritty`, `Picom`, and `Rofi`.
- **Installs and sets up** `Oh-My-Zsh` with plugins.
- **Applies** `Arc-Theme` and `Papirus-Dark` icon theme persistently.
- **Installs** Nerd Fonts (`FiraCode`, `JetBrainsMono`).
- **Sets the background** image and ensures it persists after reboots.

## Verifying the Installation
1. **Check i3-Gaps**: Log in and ensure i3-gaps is running.
2. **Test Alacritty**: Press `Mod+Enter` to launch Alacritty.
3. **Test Rofi**: Press `Mod+D` to open the Rofi application launcher.
4. **Confirm Background Image**: The wallpaper should persist across reboots.
5. **Verify Zsh**: Run `echo $SHELL` and confirm it returns `/usr/bin/zsh`.
6. **Confirm Arc-Theme & Icons**: Open any GTK application and check the theme.

## Troubleshooting
### If Ansible Fails to Run
Ensure Ansible is correctly installed:
```bash
ansible --version
```
If not installed, reinstall it:
```bash
sudo apt install -y ansible
```

### If Oh-My-Zsh Didn’t Install Correctly
Try running:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### If i3 Configurations Aren’t Applied
Restart i3 manually:
```bash
i3-msg restart
```

## Updating the Setup
To update installed tools and configurations, simply re-run the playbook:
```bash
ansible-playbook playbooks/kali-setup.yml
```

## Contributing
Feel free to submit issues and pull requests to improve the setup!

---
### Author: Your Name
GitHub: [freaks0ut](https://github.com/freaks0ut)

