#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Prompt for the new username
read -p "Enter the new username: " USERNAME

# Check if the username already exists
if id "$USERNAME" &>/dev/null; then
  echo "User $USERNAME already exists!"
  exit 1
fi

# Add the new user using adduser
adduser "$USERNAME" --disabled-password

# Check if the user was added successfully
if [ $? -eq 0 ]; then
  echo "User $USERNAME created successfully!"
else
  echo "Failed to create user $USERNAME."
  exit 1
fi

# Prompt to add the user to a group
read -p "Would you like to add $USERNAME to a sudo group? (y/n): " GROUP_ADD
if [[ "$GROUP_ADD" =~ ^[Yy]$ ]]; then
  # Add the user to the sudo group
  usermod -aG sudo "$USERNAME"
  if [ $? -eq 0 ]; then
    echo "User $USERNAME has been added to the sudo group."
  else
    echo "Failed to add $USERNAME to the sudo group."
    exit 1
  fi
else
  echo "User $USERNAME does not exist. Please create the user first."
  exit 1
fi
# Define the user and the sudo privilege rule
SUDO_RULE="$USERNAME ALL=(ALL:ALL) NOPASSWD:ALL"

# Backup the sudoers file
cp /etc/sudoers /etc/sudoers.bak
if [ $? -ne 0 ]; then
  echo "Failed to create a backup of the sudoers file!"
  exit 1
fi

# Check if the rule already exists
if grep -Fxq "$SUDO_RULE" /etc/sudoers; then
  echo "The sudo rule already exists for user $USERNAME."
  exit 0
fi

# Add the rule using visudo
echo "$SUDO_RULE" | EDITOR="tee -a" visudo >/dev/null
if [ $? -eq 0 ]; then
  echo "Successfully added sudo privileges for $USERNAME."
else
  echo "Failed to add sudo privileges for $USERNAME. Restoring backup."
  cp /etc/sudoers.bak /etc/sudoers
  exit 1
fi

echo "User $USERNAME setup completed!"

