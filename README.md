# Cloud
# Infrastructure Setup

This repository contains scripts to install Terraform, Ansible, and Docker on your VM Azure.

## Initial Installation
   1. Install Azure CLI   
      ```curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash```
   2. Login   
      ```az login```
   3. Access by URL and code to authenticate   
      ```https://microsoft.com/devicelogin ```
   4. Update Package List   
      ```sudo apt-get update```
   5. Install the Packages   
      ```sudo apt-get install -y gnupg software-properties-common curl```
   6. Verify Installation   
      ```gpg --version```   
      ```apt-cache policy software-properties-common```   
      ```curl --version```
      
## Clone this repository:
      git clone https://github.com/20058225/infra-setup-azure.git
      
      cd infra-setup-azure
   
   ### Make the script executable by giving it the correct permissions. 
      chmod +x install_terraform.sh install_ansible.sh install_docker.sh

   - Terraform install and verify
      1. ```./install_terraform.sh```   
      2. ```terraform --version```   
      3. ```terraform init```   
      4. ```terraform plan```   
      5. ```terraform apply```   
   - Ansible install and verify -> in process
      1. ```./install_ansible.sh```   
      2. ```ansible --version```   
      3. ```???```            
   - Docker install and verify
      1. ```./install_docker.sh```   
      1. ```docker --version```   
      3. ```???```   
     
         
 
   
