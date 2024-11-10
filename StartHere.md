

Terraform Folder:
Contains .tf files defining infrastructure resources, variables, and outputs. Files such as main.tf, variables.tf, and outputs.tf manage Azure VMs, networks, and resource configurations.
Ansible Folder:

Contains YAML playbooks for server configuration, possibly installing software like Docker or setting up security configurations on the VMs.
Docker Folder:

Likely includes a Dockerfile to build and deploy a sample application, plus any scripts for running or configuring Docker containers on the VM.


Terraform Files:

main.tf: Usually contains primary configuration to provision resources like VMs, networks, and storage on Azure.
variables.tf: Defines configurable parameters such as VM sizes, network ranges, and region.
outputs.tf: Specifies outputs (e.g., VM IP addresses) for easier reference after deployment.
Ansible Playbooks:

playbook.yml: Likely contains tasks to configure VMs, install Docker, or perform other software setup.
inventory: Lists the servers or VMs where Ansible should execute tasks.
Docker Folder:

Dockerfile: Defines instructions to create a Docker image for a sample application or tool.
