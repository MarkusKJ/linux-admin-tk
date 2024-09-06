#!/bin/bash

# log_analyzer.sh
# Script to analyze various system and application log files

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Function to print section headers
print_section() {
    echo "==== $1 ===="
}

# Function to analyze a log file
analyze_log() {
    local log_file=$1
    local search_term=$2
    local lines=${3:-10}

    if [[ -f "$log_file" ]]; then
        print_section "Analysis of $log_file"
        echo "Last $lines lines containing '$search_term':"
        grep "$search_term" "$log_file" | tail -n "$lines"
        echo ""
    else
        echo "Log file $log_file not found."
    fi
}

# Analyze system log
analyze_log "/var/log/syslog" "error" 15

# Analyze authentication log
analyze_log "/var/log/auth.log" "Failed password" 10

# Analyze Apache error log (if exists)
analyze_log "/var/log/apache2/error.log" "error" 10

# Analyze MySQL error log (if exists)
analyze_log "/var/log/mysql/error.log" "ERROR" 10

# Check for large log files
print_section "Large Log Files"
find /var/log -type f -size +100M -exec ls -lh {} \;

# Count occurrences of common HTTP status codes in Apache access log
if [[ -f "/var/log/apache2/access.log" ]]; then
    print_section "Apache HTTP Status Codes"
    awk '{print $9}' /var/log/apache2/access.log | sort | uniq -c | sort -rn | head -n 10
fi

# Display recent system reboots
print_section "Recent System Reboots"
last reboot | head -n 5

# Display failed SSH login attempts
print_section "Failed SSH Login Attempts"
grep "Failed password" /var/log/auth.log | awk '{print $1,$2,$3,$11}' | sort | uniq -c | sort -nr | head -n 10

# Display top resource-consuming processes from syslog
print_section "Top Resource-Consuming Processes"
grep "CPU\|Memory" /var/log/syslog | tail -n 20

echo "Log analysis completed."
