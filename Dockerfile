FROM nvidia/cuda:8.0-devel-ubuntu16.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y && apt-get install -y git net-tools nvidia-375 cuda

RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y xfce4 xfce4-goodies ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal

RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y x11vnc tightvncserver vnc4server novnc xvfb firefox 

EXPOSE 5900 5901 6080
