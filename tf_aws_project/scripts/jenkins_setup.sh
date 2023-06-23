#!/bin/bash
sudo apt update
sudo apt install openjdk-11-jdk -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

# install nginx
sudo apt install nginx -y
sudo cat <<EOT > jenkinsapp
upstream jenkinsapp {

  server 127.0.0.1:8080;

}

server {
  listen 80;
  location / {
    proxy_pass http://jenkinsapp;
  }
}

EOT

sudo mv jenkinsapp /etc/nginx/sites-available/jenkinsapp
sudo rm -rf /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/jenkinsapp /etc/nginx/sites-enabled/jenkinsapp

# restart nginx service
sudo setsebool httpd_can_network_connect on
sudo systemctl restart nginx
