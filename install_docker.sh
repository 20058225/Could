#-----CREATING EXPRESS DOCKER IMAGE--------#

# Create a new directory for the application and install node.js
[ ! -d app ] && mkdir app
cd app

# Install Git
    echo "@@ Git is being installed"
sudo apt install git -y

# Installing npm and expres
    echo "@@ Installing npm and expres"
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
sudo apt install -y npm
npm init -y
npm install express 
cd ..

# Running Ansible to automate the image creation and run
    echo "@@ Running Ansible to automate the image creation and run"
ansible-playbook -i inventory.ini deploy_app.yml

# Create a docker image and run docker container
    echo "@@ Create a docker image and run docker container"
docker buildx build -t express:latest .

# Configure known_hosts entry for GitHub
DOCKER_ID=20058225
DOCKER_ACCESS_TOKEN=

# Tag and push the image to Docker Hub
echo "@@ Tagging and pushing the image to Docker Hub"
docker login -u "$DOCKER_ID" --password-stdin <<< "<your-access-token>"
docker tag express:latest $DOCKER_ID/express:latest
docker push $DOCKER_ID/express:latest


# Stop any containers using port 3000
    echo "@@ Stop any containers using port 3000"
docker ps -q --filter "publish=3000" | xargs docker stop

# Run the Docker container
    echo "@@ Running Docker container"
docker run -p 3000:3000 express

# Container is running
    echo "@@ Container is running"
containerId=$(docker ps -l -q)
docker logs "$containerId"