# Install-Tools Ansible Role

This Ansible role automates the installation of penetration testing tools, categorizing them into specific directories under `/opt/tools/`. This ensures an organized toolset for **Bug Bounty Hunting, Pentesting, CTFs, Red Teaming, and Blue Team activities**.

## **Installation**
Add this role to your playbook:
```yaml
- hosts: localhost
  roles:
    - install-tools
```

---

## **Tool Categories & Installed Tools**
The tools are installed into the following structured directories:

```
/opt
│── tools/                 
│   ├── recon/             
│   ├── web/               
│   ├── ad/                
│   ├── shells/            
│   ├── privilege_escalation/
│   ├── networking/        
│   ├── post_exploitation/ 
│   ├── blue_team/         
│   ├── bug_bounty/        
│── scripts/               
│   ├── recon/
│   ├── exploit/
│   ├── automation/  
```

### **Breakdown of Installed Tools**

### **Recon**
- **Amass** – Subdomain enumeration
- **Sublist3r** – Subdomain enumeration
- **Hakrawler** – Crawling URLs from JavaScript files
- **MassDNS** – Fast DNS resolution
- **Assetfinder** – Asset discovery
- **Shodan-CLI** – Search Shodan from CLI

### **Web**
- **Burp Suite** – Web application testing
- **SQLMap** – SQL Injection automation
- **FFUF** – Fast web fuzzer
- **Dirsearch** – Web directory brute-force
- **XSSer** – XSS attack automation
- **WPScan** – WordPress security scanner
- **Nikto** – Web vulnerability scanner
- **WhatWeb** – Web fingerprinting

### **Active Directory**
- **BloodHound** – Graph-based AD analysis
- **CrackMapExec** – Lateral movement
- **Impacket** – Network protocol exploitation
- **Certipy** – AD CS exploitation
- **Rubeus** – Kerberos ticket manipulation
- **SharpHound** – BloodHound data collection

### **Shells**
- **Chisel** – TCP/UDP tunneling
- **Ligolo** – Reverse tunneling
- **nishang** – PowerShell payloads
- **PoshC2** – Post-exploitation framework
- **Socat** – General-purpose networking tool

### **Privilege Escalation**
- **LinPEAS** – Linux privilege escalation enumeration
- **WinPEAS** – Windows privilege escalation enumeration
- **BeRoot** – Windows/Linux privilege escalation checks
- **GTFOBins** – Unix binaries for privilege escalation
- **Linux Exploit Suggester** – Kernel exploit checker
- **Windows Exploit Suggester** – Windows vulnerability checker

### **Networking**
- **Wireshark** – Network packet analysis
- **Responder** – LLMNR/NBT-NS poisoning
- **Bettercap** – MITM attacks
- **MITMf** – Man-in-the-middle framework
- **TCPDump** – Packet capture

### **Post Exploitation**
- **Mimikatz** – Credential dumping
- **LaZagne** – Password recovery
- **PowerSploit** – Post-exploitation PowerShell
- **Pupy** – Cross-platform post-exploitation framework
- **Empire** – PowerShell post-exploitation

### **Blue Team**
- **Zeek** – Network traffic analysis
- **Suricata** – IDS/IPS
- **Sysmon** – System monitoring
- **Velociraptor** – Endpoint monitoring
- **Loki** – Malware scanner

### **Bug Bounty**
- **Nuclei** – Template-based scanning
- **Httpx** – HTTP probing
- **Katana** – Web crawling
- **ParamSpider** – Parameter discovery
- **Dalfox** – XSS scanner

---

## **How to Use**
1. Ensure Ansible is installed:
   ```bash
   sudo apt update && sudo apt install ansible -y
   ```
2. Run the playbook:
   ```bash
   ansible-playbook -i inventory.ini playbook.yml
   ```
3. Tools will be installed in `/opt/tools/` and categorized accordingly.

---

## **Customization**
You can modify the `tasks/` files to:
- Add or remove specific tools
- Change installation methods (APT, Git, or manual compilation)
- Define additional categories if needed

---

Let me know if you need any modifications! 🚀
