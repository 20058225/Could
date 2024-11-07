#!/bin/bash

# Install dependencies
echo "Installing necessary dependencies..."
sudo apt-get update
sudo apt-get install -y gnupg software-properties-common curl unzip

# Add HashiCorp GPG key and repo
wget https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip
unzip terraform_1.9.8_linux_amd64.zip
sudo mv terraform /usr/local/bin/


# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install Terraform using apt-get
echo "Installing Terraform..."
sudo apt-get install -y terraform

# Verify Terraform installation
echo "Verifying the Terraform installation..."
terraform --version

# removing files
rm LICENSE.txt
rm terraform_1.9.8_linux_amd64.zip
# Installation complete
echo "Terraform installation complete."

# Access to folder terraform and command init
cd Terraform
terraform init

# Validation of terraform files and planning
echo "Terraform validation in progress..."
terraform validate
chmod +x ~/.ssh/id_ed25519.pub
echo "Terraform planning in progress..."
terraform plan


# Run terraform with ssh
echo "Terraform applying in progress..."
terraform apply -var="private_key_path=~/.ssh/id_rsa" -var="public_key_path=~/.ssh/id_rsa.pub" -auto-approve
