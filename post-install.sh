#!/usr/bin/bash
#     _    ____  
#    / \  / ___|   Alexandre Stanescot
#   / _ \ \___ \   http://alexstan67.github.io/profile/
#  / ___ \ ___) |  https://github.com/alexstan67/
# /_/   \_\____/ 
#
# Date:	   29/09/2024
# Update:  29/09/2024
# Title: Installation script after Ubuntu 24.04.1-LTS autoinstall.yaml script

echo "####################################################################"
echo "-----------  Docker and Docker compose"
echo "####################################################################"
# https://docs.docker.com/engine/install/ubuntu/
# https://docs.docker.com/engine/install/linux-postinstall/
#
# Add Docker's official GPG key:
sudo apt-get update
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

# Install latest version
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Post-install to run docker as non-root
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Configure Docker to start on boot with systemd
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
