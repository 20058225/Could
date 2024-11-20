# Cloud Azure
# Infrastructure Setup

This repository contains scripts to install Terraform, Ansible, and Docker on your VM Azure.
With it, you will be able to create your VM and run scripts to 

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
   1. Make the script executable and run the script
   ```chmod +x ./environment.sh```
      ```./environment.sh```
   2. Access by URL and code to authenticate Azure Login 
      [Device Login](https://microsoft.com/devicelogin)
   3. Access by URL and code to authenticate DockerHub
      run ```docker login``` and click on [DockerHub Login](https://login.docker.com/activate)
   4. Update Package List   
      ```sudo apt update && sudo apt upgrade -y```
            
## Clone this repository:
   ```git clone https://github.com/20058225/infra-setup-azure.git```   
   ```cd infra-setup-azure```
   
   ### Make the script executable by giving it the correct permissions.   
   ```chmod +x setup_jenkins.sh install_terraform.sh install_ansible.sh install_docker.sh```   

## Jenkins install and verify 
```./setup_jenkins.sh``` 
## Terraform install and verify
```./install_terraform.sh```  
```ssh-copy-id -i ~/.ssh/id_ed25519.pub useradmin@your_new_VM```
## Ansible install and verify
```./install_ansible.sh```
## Docker install and verify 
```./install_docker.sh```