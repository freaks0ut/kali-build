#!/bin/bash

# Set variables
log_file="/var/log/pentest_install.log"
error_file="/var/log/pentest_install_errors.log"
tools_dir="/opt/tools"
scripts_dir="/opt/scripts"
wordlists_dir="/opt/wordlists"

# Colors for output
GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m" # No Color

# Create log files
sudo touch $log_file $error_file
sudo chmod 666 $log_file $error_file

# Log function
log() {
    echo -e "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$log_file"
}

log_error() {
    echo -e "$(date +'%Y-%m-%d %H:%M:%S') - ERROR: $1" | tee -a "$error_file"
}

# Funktion zur Überprüfung, ob ein Tool installiert ist
is_installed() {
    dpkg -l | grep -q "^ii  $1 "
}

log "[+] Erstelle Verzeichnisstruktur..."
sudo mkdir -p $tools_dir/{recon,web,ad,shells,privilege_escalation,networking,post_exploitation,blue_team,bug_bounty}
sudo mkdir -p $scripts_dir/{recon,exploit,automation}
sudo mkdir -p $wordlists_dir
sudo chown -R $USER:$USER $tools_dir $scripts_dir $wordlists_dir

# Install required dependencies
packages=("python3-pip" "python3-venv" "git" "netcat-traditional" "ruby-full" "proxychains" \
          "openjdk-17-jdk" "code" "ripgrep" "firefox-esr")

for package in "${packages[@]}"; do
    if ! is_installed "$package"; then
        log "[+] Installiere $package..."
        if sudo apt install -y "$package" >> "$log_file" 2>> "$error_file"; then
            log "${GREEN}[✓] $package installiert${NC}"
        else
            log_error "Fehler bei der Installation von $package"
            echo -e "${RED}[✗] $package fehlgeschlagen${NC}"
        fi
    else
        log "${GREEN}[✓] $package ist bereits installiert, überspringe.${NC}"
    fi
done

# Install other tools with error handling
install_tool() {
    local repo="$1"
    local dir="$2"
    local install_cmd="$3"
    log "[+] Installiere $dir..."
    if [ ! -d "$dir" ]; then
        if git clone "$repo" "$dir" >> "$log_file" 2>> "$error_file"; then
            log "${GREEN}[✓] $dir erfolgreich installiert${NC}"
            if [ -n "$install_cmd" ]; then
                eval "$install_cmd" >> "$log_file" 2>> "$error_file"
            fi
        else
            log_error "Fehler beim Klonen von $repo"
            echo -e "${RED}[✗] $dir fehlgeschlagen${NC}"
        fi
    else
        log "${GREEN}[✓] $dir ist bereits vorhanden, überspringe.${NC}"
    fi
}

# Install tools
install_tool "https://github.com/Pennyw0rth/NetExec.git" "$tools_dir/recon/nxc" "cd $tools_dir/recon/nxc && pip3 install -r requirements.txt"
install_tool "https://github.com/maurosoria/dirsearch.git" "$tools_dir/web/dirsearch" "cd $tools_dir/web/dirsearch && python3 -m venv dirsearch-venv && source dirsearch-venv/bin/activate && pip install -r requirements.txt"
install_tool "https://github.com/CravateRouge/bloodyAD.git" "$tools_dir/ad/bloodyAD"
install_tool "https://github.com/ShutdownRepo/pywhisker.git" "$tools_dir/ad/pywhisker" "cd $tools_dir/ad/pywhisker && pip3 install -r requirements.txt"
install_tool "https://github.com/SecureAuthCorp/impacket.git" "$tools_dir/ad/impacket" "cd $tools_dir/ad/impacket && pip3 install ."
install_tool "https://github.com/danielmiessler/SecLists.git" "$wordlists_dir/SecLists"

# ProxyChains Configuration
log "[+] Konfiguriere ProxyChains..."
if sudo sed -i 's/socks4 127.0.0.1 9050/socks5 127.0.0.1 1080/' /etc/proxychains.conf >> "$log_file" 2>> "$error_file"; then
    log "${GREEN}[✓] ProxyChains konfiguriert${NC}"
else
    log_error "Fehler bei der ProxyChains-Konfiguration"
    echo -e "${RED}[✗] ProxyChains Konfiguration fehlgeschlagen${NC}"
fi

# Abschluss
log "[+] Installation abgeschlossen!"
echo -e "${GREEN}[✓] Installation abgeschlossen${NC}"