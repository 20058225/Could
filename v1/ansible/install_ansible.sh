# System Preparation
echo "System Preparation in progress..."
  sudo apt update
  sudo apt install software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt install ansible -y

# Installing pip
echo "Installing pip in progress..."
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py --user
  sudo apt-get install python3-pip -y

# Shows the python version installed
echo "Python Version installed"
  python3 -m pip -V

# Setting Up the Python Virtual Environment
echo "Setting Up the Python Virtual Environment in progress..."
  sudo apt install python3-venv -y
  python3 -m venv myenv
  source myenv/bin/activate
  pip install ansible -y

# Verifying Ansible Installation
echo "Verifying the Ansible Installation..."
  ansible --version

# create files required for Ansible run
 touch inventory.ini #pull it from Github?
 touch docker_install.yml #pull it from Github?

# Runing Ansible with an Inventory and Playbook
cd ansible
echo "Runing Ansible with an Inventory and Playbook in progress..."
  ansible all -i inventory -m ping
  ansible-playbook -i inventory.ini install_docker.yml

