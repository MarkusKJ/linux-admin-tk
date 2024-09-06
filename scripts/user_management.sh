#!/bin/bash

# user_management.sh
# Script for managing users and their SSH keys

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Function to add a new user
add_user() {
    read -p "Enter username: " username
    read -s -p "Enter password: " password
    echo
    useradd -m "$username"
    echo "$username:$password" | chpasswd
    echo "User $username added successfully."
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    userdel -r "$username"
    echo "User $username deleted successfully."
}

# Function to modify a user
modify_user() {
    read -p "Enter username to modify: " username
    read -p "Enter new shell (e.g., /bin/bash): " new_shell
    usermod -s "$new_shell" "$username"
    echo "User $username's shell changed to $new_shell."
}

# Function to add SSH key for a user
add_ssh_key() {
    read -p "Enter username: " username
    read -p "Enter SSH public key: " ssh_key
    user_home=$(eval echo ~$username)
    mkdir -p "$user_home/.ssh"
    echo "$ssh_key" >> "$user_home/.ssh/authorized_keys"
    chown -R "$username:$username" "$user_home/.ssh"
    chmod 700 "$user_home/.ssh"
    chmod 600 "$user_home/.ssh/authorized_keys"
    echo "SSH key added for $username."
}

# Main menu
while true; do
    echo "
    User Management Menu:
    1. Add user
    2. Delete user
    3. Modify user
    4. Add SSH key for user
    5. Exit
    "
    read -p "Enter your choice: " choice
    case $choice in
        1) add_user ;;
        2) delete_user ;;
        3) modify_user ;;
        4) add_ssh_key ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
