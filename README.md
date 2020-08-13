![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

Contents:

- Bash scripts for deploying NVidia-Docker on new 14.04/16.04/18.04/20.04 hosts
- Dockerfile to create X-accelerated containers with novnc frontend, image hosted on Dockerhub

Start X CUDA session

docker run --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES='0,1' --device=/dev/dri:/dev/dri -d twobombs/deploy-nvidia-docker sh /root/run-nv  (on nvidia-docker2 18.03 or older)

docker run --gpus all --device=/dev/dri:/dev/dri -d twobombs/deploy-nvidia-docker sh /root/run-nv ( on Docker 19.03+ or newer )

Initial vnc password is 00000000
noVNC website is avaliable at port 6080

- Wine 5.x and Steam added
- Upgrade image to CUDA 11.0 and Ubuntu 20.04
- Docker 19.03+ NV integration
- Nvidia-Docker 2.0 integration release
- Wine v0.2 addon pre-release
- Initial v0.1 pre-release

Because of Docker integration with nvidia, all orchestrators, including Rancher, should play nice with NV GPU container instances.
