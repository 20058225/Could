# System Preparation
echo "System Preparation in progress..."
  sudo apt update
  sudo apt install software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt install ansible

# Installing pip
echo "Installing pip in progress..."
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py --user
  sudo apt-get install python3-pip
    #Shows the version 
    python3 -m pip -V

# Setting Up the Python Virtual Environment
echo "Setting Up the Python Virtual Environment in progress..."
  sudo apt install python3-venv
  python3 -m venv myenv
  source myenv/bin/activate
  pip install ansible
  # Creating and activating a virtual environment keeps the Ansible installation isolated from the system Python, reducing potential conflicts.

# Testing Ansible with an Inventory and Playbook
echo "Testing Ansible with an Inventory and Playbook in progress..."
  ansible all -i inventory -m ping
  cd ansible
  ansible-playbook -i inventory install_docker.yml

