Overview
linux_admin_tk is a collection of bash scripts designed to assist system administrators in managing and monitoring Linux systems. This toolkit provides a set of utilities for common administrative tasks, security auditing, and system maintenance.


The toolkit includes the following scripts:

system_info.sh: Displays comprehensive system information
user_management.sh: Manages user accounts and SSH keys
backup_script.sh: Performs incremental backups of specified directories
security_audit.sh: Conducts a basic security audit of the system
loglyzer.sh: Analyzes various system and application log files

Requirements

Bash shell (version 4.0 or later)
Root or sudo access on the target system
Standard Linux utilities (e.g., awk, sed, grep)

Installation

Clone the repository or download the scripts to your Linux system.
Make the scripts executable:
Copychmod +x *.sh

(Optional) Move the scripts to a directory in your PATH, e.g.:
Copysudo mv *.sh /usr/local/bin/


Usage
Each script can be run independently. Here's a brief overview of how to use each script:
system_info.sh
Displays system information including CPU, memory, disk usage, and network details.
Copysudo ./system_info.sh
user_management.sh
Provides a menu-driven interface for user account management.
Copysudo ./user_management.sh
backup_script.sh
Performs an incremental backup of specified directories. Edit the script to set source and destination directories before running.
Copysudo ./backup_script.sh
security_audit.sh
Conducts a basic security audit of the system and outputs the results.
Copysudo ./security_audit.sh
log_analyzer.sh
Analyzes various log files and provides a summary of important events.
Copysudo ./log_analyzer.sh
Configuration
Some scripts may require configuration before use. Open each script in a text editor and look for configuration variables at the top of the file. Adjust these as needed for your system.
Security Considerations

These scripts require root or sudo access. Review each script carefully before running it on your system.
The backup_script.sh and log_analyzer.sh scripts may handle sensitive data. Ensure proper permissions are set on backup destinations and log files.
The security_audit.sh script is not a replacement for a comprehensive security audit by a professional.


If you encounter issues:

Ensure you have the necessary permissions to run the scripts.
Check that all required utilities are installed on your system.
Review the script outputs for any error messages.
Consult the individual script documentation for script-specific troubleshooting.


Contributions to this toolkit are welcome!! Please fork the repository, make your changes, and submit a pull request.
License


This project is licensed under the MIT License - see the LICENSE file for details.
Disclaimer
This toolkit is provided as-is, without any warranties. Always test scripts in a non-production environment before using them on critical systems.
For questions, issues, or suggestions, please open an issue in the GitHub repository or contact the project maintainer.
