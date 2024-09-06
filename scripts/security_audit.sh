#!/bin/bash

# security_audit.sh
# Script to perform a basic security audit of the system


# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Function to print section headers
print_section() {
    echo "==== $1 ===="
}

# Check for users with UID 0 (root privileges)
print_section "Users with UID 0"
awk -F: '($3 == "0") {print}' /etc/passwd

# Check for empty passwords
print_section "Users with empty passwords"
awk -F: '($2 == "") {print}' /etc/shadow

# List sudoers
print_section "Users with sudo privileges"
grep -Po '^sudo.+:\K.*$' /etc/group

# Check SSH configuration
print_section "SSH Configuration"
grep -i "PermitRootLogin" /etc/ssh/sshd_config
grep -i "PasswordAuthentication" /etc/ssh/sshd_config

# Check for listening ports
print_section "Open ports"
ss -tuln

# Check for running services
print_section "Running services"
systemctl list-units --type=service --state=running

# Check for failed login attempts
print_section "Failed login attempts"
grep "Failed password" /var/log/auth.log | tail -n 5

# Check for available updates
print_section "Available updates"
if command -v apt > /dev/null; then
    apt list --upgradable
elif command -v yum > /dev/null; then
    yum check-update
else
    echo "Unknown package manager"
fi

# Check firewall status
print_section "Firewall status"
if command -v ufw > /dev/null; then
    ufw status
elif command -v firewall-cmd > /dev/null; then
    firewall-cmd --state
    firewall-cmd --list-all
else
    echo "No recognized firewall found"
fi

# Check for world-writable files in important directories
print_section "World-writable files in /etc"
find /etc -type f -perm -2 -ls

# Check for unowned files
print_section "Files without user"
find / -xdev -nouser

# Check for files without a group
print_section "Files without group"
find / -xdev -nogroup

echo "Security audit completed."
