# Initial Installation

  echo "Initial Installation"
# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "Install the Docker packages"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add HashiCorp GPG key and repo
sudo apt update
sudo apt install -y pass
sudo apt install jq

wget -O docker-credential-pass https://github.com/docker/docker-credential-helpers/releases/download/v0.8.2/docker-credential-pass-v0.8.2.linux-amd64
sudo mv docker-credential-pass /usr/local/bin/
sudo chmod +x /usr/local/bin/docker-credential-pass

gpg --gen-key
pass init "Brenda Lopes <20058225@dbs.ie>"

echo "Install Azure CLI"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
echo "Login Azure"
az login

