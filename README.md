![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

Contents:

- Bash script for deploying NVidia-Docker on new 14.04/16.04/17.04 hosts
- Dockerfile to create X-accelerated containers with novnc frontend, image hosted on Dockerhub

Start X [CUDA] session

[nvidia-]docker run -d --device=/dev/dri:/dev/dri twobombs/deploy-nvidia-docker /root/run[-nv]

Initial vnc password is 00000000
noVNC website is avaliable at port 6080

- Initial v0.1 pre-release
- Wine v0.2 addon pre-release
- Nvidia-Docker 2.0 integration release
