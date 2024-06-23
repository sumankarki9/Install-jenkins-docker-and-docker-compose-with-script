#!/bin/bash

# Updating system for the first time
sudo apt-get update -y && sudo apt upgrade -y 

# Installing dependencies - Java
sudo apt-get install fontconfig openjdk-17-jre -y

# Adding Keys
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Updating latest packages and installing Jenkins
sudo apt-get update -y && sudo apt-get install jenkins -y

echo "Jenkins installation completed"



# Docker and Docker Compose Installation

# Update your package list
sudo apt-get update

# Install prerequisites
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker APT repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y

# Update the package database with the Docker packages from the newly added repo
sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker-ce

# Enable Docker to start on boot and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add your user to the Docker group
sudo usermod -aG docker $USER

sudo usermod -aG docker jenkins

# Download Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Create a symbolic link to /usr/bin
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Verify the installation
docker-compose --version

# Reboot to apply changes
echo "Rebooting to apply Docker group changes..."
sudo reboot