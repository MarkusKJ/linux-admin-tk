#!/bin/bash

# backup_script.sh
# Script for performing incremental backups using rsync
# sudo apt-get install rsync

# Configuration
SOURCE_DIR="/pathforsourcedir" #Modify these
BACKUP_DIR="/pathforbackupdir" #Modify these
DATETIME=$(date "+%Y-%m-%d_%H-%M-%S")
BACKUP_PATH="$BACKUP_DIR/$DATETIME"
LATEST_LINK="$BACKUP_DIR/latest"

# Remote backup configuration (uncomment and modify if needed)
# REMOTE_USER="username"
# REMOTE_HOST="hostname_or_ip"
# REMOTE_DIR="/path/to/remote/backup"

# Log file
LOG_FILE="/var/log/backup_script.log"

# Function to log messages
log_message() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") - $1" >> "$LOG_FILE"
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Perform the backup
log_message "Starting backup"

if rsync -avh --delete --link-dest="$LATEST_LINK" "$SOURCE_DIR" "$BACKUP_PATH"; then
    log_message "Backup completed successfully"

    # Update the 'latest' symlink
    rm -f "$LATEST_LINK"
    ln -s "$BACKUP_PATH" "$LATEST_LINK"

    # For remote backup (uncomment and modify if needed)
    # rsync -avz "$BACKUP_PATH" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"
    # log_message "Remote backup completed"
else
    log_message "Backup failed"
fi

# Clean up old backups (keeping last 7 days)
find "$BACKUP_DIR" -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;
log_message "Old backups cleaned up"

echo "Backup process completed. Check $LOG_FILE for details."
