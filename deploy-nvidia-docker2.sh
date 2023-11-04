#!/bin/bash
# set nvidia repos + keys
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y ppa:graphics-drivers/ppa

# install current linux image source 
sudo apt-get update
sudo apt-get -y install linux-image-extra-$(uname -r)

# install docker.io
apt install docker.io

# install nvidia cuda toolkit+modules
sudo apt-get -y install nvidia-cuda-toolkit
sudo apt-get -y install nvidia-modprobe

# select nvidia docker2 repo+keys
distribution=$(. /etc/os-release;echo ubuntu22.04) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# install nvidia-docker2
sudo apt-get update
sudo apt-get -y install nvidia-docker2
sudo service docker restart

# nvidia-smi for output test through nvidia-docker2
docker run --rm --gpus all ubuntu nvidia-smi
