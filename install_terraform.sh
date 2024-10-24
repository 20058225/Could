#!/bin/bash

# Install dependencies
echo "Installing necessary dependencies..."
sudo apt-get update
sudo apt-get install -y gnupg software-properties-common curl unzip

# Add HashiCorp GPG key and repo
echo "Adding HashiCorp GPG key and repository..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install Terraform using apt-get
echo "Installing Terraform..."
sudo apt-get install -y terraform

# Verify Terraform installation
echo "Verifying the Terraform installation..."
terraform --version

# Installation complete
echo "Terraform installation complete."
