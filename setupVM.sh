#!/bin/bash

# The environment is being prepared
  echo "The environment is being prepared"
    echo "..."
     echo "..."

# Update system
sudo apt update -y

    echo "Git is being installed"
# Install Git
sudo apt install git -y

    echo "Node.js and npm are being installed"
# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

    echo "Check installations"
# Check installations
git --version
node --version
npm --version