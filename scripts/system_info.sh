#!/bin/bash

# system_info.sh
# Script to display various system information

# Function to print section headers
print_section() {
    echo "=================================="
    echo "$1"
    echo "=================================="
}

# System update time
print_section "System Update Time"
echo "Last system update: $(date -r /var/lib/apt/periodic/update-success-stamp)"

# OS Information
print_section "OS Information"
echo "OS: $(lsb_release -d | cut -f2)"
echo "Kernel: $(uname -r)"

# CPU Information
print_section "CPU Information"
echo "CPU Model: $(lscpu | grep "Model name" | cut -f2 -d ":" | awk '{$1=$1}1')"
echo "CPU Cores: $(nproc)"

# Memory Information
print_section "Memory Information"
free -h

# Disk Usage
print_section "Disk Usage"
df -h /

# Network Information
print_section "Network Information"
ip -brief address show

# Current system load
print_section "System Load"
uptime

# List of running processes (top 5 by CPU usage)
print_section "Top 5 Processes by CPU Usage"
ps aux --sort=-%cpu | head -n 6

# List of open ports
print_section "Open Ports"
ss -tuln

# Last few system log entries
print_section "Recent System Logs"
tail -n 5 /var/log/syslog

# End of script
echo "Script execution completed."
