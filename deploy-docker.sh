# for Docker 19.03+ NV integration is now default
# only need to install drivers and toolkit
#
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get -y install linux-image-extra-$(uname -r)
sudo wget -qO- https://get.docker.com/ | sh
sudo apt-get -y install nvidia-375 nvidia-cuda-toolkit
sudo apt-get -y install nvidia-modprobe
