#!/bin/bash

# Updating system
echo "@@ Updating system..."
sudo apt update && sudo apt upgrade -y

# Creates a memory for swap file
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Checking if Git is installed, install if missing
if ! command -v git &> /dev/null; then
    echo "@@ Installing Git..."
    sudo apt install git -y
else
    echo "@@ Git is already installed"
fi

# Setting path to Git executable
GIT_PATH=$(which git)
echo "@@ Git path set to: $GIT_PATH"

# Configure known_hosts entry for GitHub
KNOWN_HOSTS_FILE=~/.ssh/known_hosts
GITHUB_HOST="github.com"
SERVER_IP="104.45.38.12"
mkdir -p ~/.ssh

for HOST in "$GITHUB_HOST" "$SERVER_IP"; do
    if ! ssh-keygen -F "$HOST" &>/dev/null; then
        echo "@@ Adding $HOST to known_hosts..."
        ssh-keyscan -H "$HOST" >> "$KNOWN_HOSTS_FILE"
    else
        echo "@@ $HOST already exists in known_hosts"
    fi
done

# Install Java
echo "@@ Installing Java..."
sudo apt install -y fontconfig openjdk-17-jre
java -version

# Install Jenkins
echo "@@ Adding repository key..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "@@ Updating list file.."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "@@ Updating and installing Jenkins..."
sudo apt update && sudo apt install -y jenkins

echo "@@ Checking Jenkins version"
jenkins --version

# Docker group for Jenkins user
sudo usermod -aG docker jenkins

# Start and enable Jenkins
echo "@@ Starting Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Restart Jenkins to apply Docker group permissions
echo "@@ Restarting Jenkins to apply permissions..."
sudo systemctl restart jenkins

# Check Jenkins status
sudo systemctl status jenkins