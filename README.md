# Cloud
# Infrastructure Setup

This repository contains scripts to install Terraform, Ansible, and Docker on your VM.

## Installation
   | -- Update Package List
      sudo apt-get update
   | -- Install the Packages
      sudo apt-get install -y gnupg software-properties-common curl
   | -- Verify Installation
      gpg --version
      apt-cache policy software-properties-common
      curl --version

1. Clone this repository:
   ```bash
   git clone https://github.com/20058225/infra-setup-azure.git
   cd infra-setup-azure

   # Make the script executable by giving it the correct permissions. 
      chmod +x install_terraform.sh install_ansible.sh install_docker.s

   |- Terraform install and verify 
     ./install_terraform.sh
         terraform --version
   |- Ansible install and verify 
     ./install_ansible.sh
         ansible --version
   |- Docker install and verify 
     ./install_docker.sh
         docker --version
 
   
