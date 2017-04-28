FROM phusion/baseimage

RUN apt-get update && apt-get install -y ubuntu-desktop novnc

EXPOSE 6080
