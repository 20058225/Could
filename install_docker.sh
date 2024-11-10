# Create a new directory for the application and install node.js
[ ! -d app ] && mkdir app
cd app
 
# Install Git
    echo "@@ Git is being installed"
sudo apt update && sudo apt install -y git

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
DOCKER_ACCESS_TOKEN=$(jq -r '.auths["https://index.docker.io/v1/"].auth' ~/.docker/config.json | base64 --decode | cut -d: -f2)

# Log in to Docker Hub securely
    echo "$DOCKER_ACCESS_TOKEN" | docker login -u "$DOCKER_ID" --password-stdin

# Tag and push the image to Docker Hub
    echo "@@ Tagging and pushing the image to Docker Hub..."
docker tag express:latest "$DOCKER_ID"/express:latest
docker push "$DOCKER_ID"/express:latest

# Stop any containers using port 3000
echo "@@ Stopping any containers using port 3000..."
docker ps -q --filter "publish=3000" | xargs -r docker stop

# Run the Docker container
echo "@@ Running Docker container..."
docker run -d -p 3000:3000 express

# Display the container logs
echo "@@ Container is running. Displaying logs..."
containerId=$(docker ps -l -q)
docker logs "$containerId"