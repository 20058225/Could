#!/bin/bash

# Script to install Terraform

TERRAFORM_VERSION="1.5.6"

# Download Terraform
echo "Downloading Terraform..."
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Unzip the Terraform package
echo "Unzipping Terraform..."
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Move the Terraform binary to /usr/local/bin
echo "Installing Terraform..."
sudo mv terraform /usr/local/bin/

# Verify the installation
echo "Verifying the Terraform installation..."
terraform --version

# Clean up
echo "Cleaning up..."
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

echo "Terraform installation complete."
