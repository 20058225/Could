# Cloud
# Infrastructure Setup

This repository contains scripts to install Terraform, Ansible, and Docker on your VM Azure.

## Prepare Environment 
   1. Create VM Linux as a Server using [Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal)
       > Create a VM using your SSH data as an administrator account.
   2. Access your Server VM through your local terminal using SSH
       > [WSL](https://ubuntu.com/desktop/wsl) | PowerShell | Command Prompt       
     ```ssh your_user@ServerVM_public_ip``` or ```ssh your_user@ServerVM_DNS```      
   3. Create an SSH Key for the Server VM and insert the local ssh on your new server.
      ```ssh-keygen```
      ```cp ~/.ssh/id_ed25519.pub /path_to_your_terraform_project/id_ed25519.pub```
      
      ```ssh-keygen -t rsa -b 2048 -C your_user```
      ```cp ~/.ssh/id_rsa /path_to_your_terraform_project/id_rsa.pub```
      

## Initial Installation
   1. Install Azure CLI   
      ```curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash```
   2. Login   
      ```az login```
   3. Access by URL and code to authenticate   
      [Device Login](https://microsoft.com/devicelogin)
   4. Update Package List   
      ```sudo apt update && sudo apt upgrade -y```
      
## Clone this repository:
   ```git clone https://github.com/20058225/infra-setup-azure.git```   
   ```cd infra-setup-azure```
   
   ### Make the script executable by giving it the correct permissions.   
   ```chmod +x install_terraform.sh install_docker.sh install_ansible.sh```   

## Terraform install and verify
      ./install_terraform.sh
      ssh-copy-id -i ~/.ssh/id_ed25519.pub useradmin@your_new_VM
## Ansible install and verify 
      ./install_ansible.sh
## Docker install and verify 
      ./install_docker.sh


     
         
   
