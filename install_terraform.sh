#!/bin/bash

# Install dependencies
echo "Installing necessary dependencies..."
sudo apt-get update
sudo apt-get install -y gnupg software-properties-common curl unzip

# Get the latest version URL dynamically
LATEST_VERSION=$(curl -sL https://releases.hashicorp.com/terraform/ | grep -oP 'terraform/[\d.]+/' | head -1 | sed 's#/##g')
echo "Latest version: $LATEST_VERSION"

# Download Terraform
echo "Downloading Terraform..."
curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Unzip the Terraform package
echo "Unzipping Terraform..."
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Move Terraform to /usr/local/bin
echo "Installing Terraform..."
sudo mv terraform /usr/local/bin/

# Verify installation
echo "Verifying the Terraform installation..."
terraform --version

# Clean up
echo "Cleaning up..."
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
echo "Terraform installation complete."
