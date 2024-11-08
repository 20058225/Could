#-----CREATING EXPRESS DOCKER IMAGE--------#

# Create a new directory for the application and install node.js
mkdir app
cd app

    echo "Git is being installed"
# Install Git
sudo apt install git -y

# Installing npm and expres
    echo "Installing npm and express"
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    
sudo apt install -y nodejs
sudo apt install -y npm
    npm init -y
    npm install express 
cd ..
# Running Ansible to automate the image creation and run
    echo "Running Ansible to automate the image creation and run"
ansible-playbook -i inventory.ini install_express.yml

# Create a docker image and run docker container
    echo "Create a docker image and run docker container"
docker build -t express .
docker run -p 3000:3000 express

# Container is running
    echo "Container is running"
docker ps -a
docker logs [container ID]

 












