#!/bin/bash
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get -y install linux-image-extra-$(uname -r)
# sudo wget -qO- https://get.docker.com/ | sh
apt install docker.io
sudo apt-get -y install nvidia-cuda-toolkit ubuntu-desktop
sudo apt-get -y install nvidia-modprobe

distribution=$(. /etc/os-release;echo ubuntu22.04) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update
sudo apt-get -y install nvidia-docker2
sudo service docker restart
