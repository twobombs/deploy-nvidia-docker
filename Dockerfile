FROM phusion/baseimage

RUN apt-get update && apt-get upgrade -y && apt-get install -y ubuntu-desktop novnc
RUN apt-get -y install build-essential nvidia-375

EXPOSE 6080
