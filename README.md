![](https://img.shields.io/docker/build/jrottenberg/ffmpeg.svg)
![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

Contents:

- Bash script for deploying NVidia-Docker on new 14.04/16.04/17.04 hosts
- Dockerfile to create X-accelerated containers with novnc frontend, image hosted on Duckerhub

Start X [CUDA] session

[nvidia-]docker run -d -v /tmp/.X11-unix:/tmp/.X11-unix --device=/dev/dri:/dev/dri twobombs/deploy-nvidia-docker [/root/run-nv]

Initial vnc password is 00000000
noVNC website is avaliable at port 6080
