#-----CREATING EXPRESS DOCKER IMAGE--------#

# Create a new directory for the application and install node.js

# Create and Access to directory /app/  
    echo "Create and Access to directory /app/"
mkdir app
cd app

# Installing npm and expres
    echo "Installing npm and express"
sudo apt install npm
npm init -y
npm install express

# Running Ansible to automate the image creation and run
    echo "Running Ansible to automate the image creation and run"
ansible-playbook -i inventory.ini docker-express.yml

# Create a docker image and run docker container
    echo "Create a docker image and run docker container"
docker build -t express-app
docker run -p 3000:3000 express-app

# Container is running
    echo "Container is running"
docker ps -a
docker logs [container ID]

 












