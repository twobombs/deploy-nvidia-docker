FROM phusion/baseimage

RUN apt-get update && apt-get -y upgrade && apt-get install -y ubuntu-desktop novnc
RUN apt-get -y install nvidia-375 nvidia-cuda-toolkit nvidia-modprobe

EXPOSE 6080
