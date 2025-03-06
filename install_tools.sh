#!/bin/bash

# Set variables
tools_dir="/opt/tools"
scripts_dir="/opt/scripts"

echo "[+] Erstelle Verzeichnisstruktur..."
sudo mkdir -p $tools_dir/{recon,web,ad,shells,privilege_escalation,networking,post_exploitation,blue_team,bug_bounty}
sudo mkdir -p $scripts_dir/{recon,exploit,automation}
sudo chown -R $USER:$USER $tools_dir $scripts_dir

# Funktion zur Überprüfung, ob ein Tool installiert ist
is_installed() {
    command -v "$1" &> /dev/null
}

# Install required dependencies
echo "[+] Installiere benötigte Pakete..."
sudo apt update && sudo apt install -y python3-pip python3-venv git netcat ruby-full proxychains \
    openjdk-17-jdk code ripgrep firefox 

# === Reconnaissance Tools ===
echo "[+] Installiere Reconnaissance-Tools..."
git clone https://github.com/unknown/nxc.git $tools_dir/recon/nxc

# === Web Application Testing Tools ===
echo "[+] Installiere Web Application Testing-Tools..."
git clone https://github.com/maurosoria/dirsearch.git $tools_dir/web/dirsearch
cd $tools_dir/web/dirsearch
python3 -m venv --without-pip dirsearch-venv
source dirsearch-venv/bin/activate
curl https://bootstrap.pypa.io/get-pip.py | python
pip install -r requirements.txt

echo 'alias dirsearch="~/dirsearch-venv/bin/python ~/dirsearch/dirsearch.py"' >> ~/.bashrc
source ~/.bashrc

# === Active Directory Tools ===
echo "[+] Installiere Active Directory-Tools..."
git clone https://github.com/CravateRouge/bloodyAD.git $tools_dir/ad/bloodyAD
git clone https://github.com/unknown/pywhisker.git $tools_dir/ad/pywhisker
git clone https://github.com/SecureAuthCorp/impacket.git $tools_dir/ad/impacket
cd $tools_dir/ad/impacket && pip3 install .
pip3 install certipy-ad

# === Browser Plugins ===
echo "[+] Installiere Firefox-Erweiterungen..."
firefox -install-global-extension https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi
firefox -install-global-extension https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi
firefox -install-global-extension https://addons.mozilla.org/firefox/downloads/latest/cookie-editor/latest.xpi
firefox -install-global-extension https://addons.mozilla.org/firefox/downloads/latest/webalyzer/latest.xpi

# === ProxyChains Configuration ===
echo "[+] Konfiguriere ProxyChains..."
sudo sed -i 's/socks4 127.0.0.1 9050/socks5 127.0.0.1 1080/' /etc/proxychains.conf

# === Zertifikate ===
echo "[+] Installiere ZAP Zertifikat..."
wget -O $tools_dir/web/zap_certificate.pem https://www.zaproxy.org/CA/zap-cert.pem

echo "[+] Konfiguriere BurpSuite Zertifikat für Firefox..."
wget -O /tmp/cacert.der http://burp/cert
certutil -d sql:$HOME/.mozilla/firefox/*.default-release -A -t "C,," -n "BurpSuite" -i /tmp/cacert.der

# === Swap File Setup ===
echo "[+] Erstelle Swap-Datei..."
sudo swapoff -a
sudo rm -f /swapfile
sudo touch /swapfile
sudo chmod 600 /swapfile
sudo chattr +C /swapfile
sudo fallocate -l 4G /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Abschluss
echo "[+] Installation abgeschlossen!"
