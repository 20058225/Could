#!/bin/bash

# Updating system
echo "@@ Updating system..."
sudo apt update && apt upgrade -y

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

if ! grep -q "$GITHUB_HOST" "$KNOWN_HOSTS_FILE" 2>/dev/null; then
    echo "@@ Adding $GITHUB_HOST to known_hosts..."
    mkdir -p ~/.ssh
    ssh-keyscan -H $GITHUB_HOST >> "$KNOWN_HOSTS_FILE"
else
    echo "@@ $GITHUB_HOST already in known_hosts"
fi

echo "@@ Adding server key to known_hosts if not present..."
if ! grep -q "$SERVER_IP" "$KNOWN_HOSTS_FILE"; then
    ssh-keyscan -H "$SERVER_IP" >> "$KNOWN_HOSTS_FILE"
    echo "@@ Server key added to known_hosts."
else
    echo "@@ Server key already exists in known_hosts."
fi

# Install Java and verify
echo "@@ Installing Java..."
sudo apt install -y fontconfig openjdk-17-jre
java -version

# Download and install Jenkins
echo "@@ Adding Jenkins repository key..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

  echo "@@ Configuring Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
    echo "@@ Installing Jenkins..."
sudo apt update
sudo apt install -y jenkins

echo "@@ Checking Jenkins version..."
jenkins --version

# Start Jenkins and enable on boot
echo "@@ Starting Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins
    sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

# Check Jenkins status
sudo systemctl status jenkins