FROM nvidia/cuda:8.0-devel-ubuntu16.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y && apt-get install -y git xfce4 xfce4-goodies tightvncserver net-tools ubuntu-desktop novnc ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal x11vnc vnc4server xvfb firefox nvidia-375 cuda

EXPOSE 5900 5901 6080
