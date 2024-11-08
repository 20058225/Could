# System Preparation
echo "System Preparation in progress..."
  sudo apt update
  sudo apt install software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt install -y ansible

# Installing pip
echo "Installing pip in progress..."
  sudo apt-get install -y python3-pip

# Shows the python version installed
echo "Python Version installed"
  python3 -m pip -V

# Setting Up the Python Virtual Environment
echo "Setting Up the Python Virtual Environment in progress..."
  sudo apt install -y python3-venv
  python3 -m venv myenv
  source myenv/bin/activate
  
  pip install ansible

# Verifying Ansible Installation
echo "Verifying the Ansible Installation..."
  ansible --version

# Runing Ansible with an Inventory and Playbook
echo "Runing Ansible with an Inventory and Playbook in progress..."
  ansible all -i inventory.ini -m ping
  sudo usermod -aG docker useradmin
  ansible-playbook -i inventory.ini install_docker.yml