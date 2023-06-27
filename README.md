![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

Contents:

- Bash scripts for deploying NVidia-Docker on new 14.04/16.04/18.04/20.04/22.04 hosts
- Dockerfile to create X-accelerated containers with novnc frontend, image hosted on Dockerhub
- comes in the following flavours :latest for runtime :dev developer-tools and :minimum tag for minimum CPU-only with user jail

Start X CUDA session

With Nvidia Docker enabled
- docker run --gpus all --device=/dev/dri:/dev/dri -d twobombs/deploy-nvidia-docker

Docker only
- docker run --device=/dev/dri:/dev/dri -d twobombs/deploy-nvidia-docker

Minimalistic Docker CPU-only version with user jailed in xterm
- docker run -d twobombs/deploy-nvidia-docker:minimal

Initial vnc password is 00000000
- noVNC website is avaliable at port 6080 
- xRDP running at port 3389 to vnc 127.0.0.1:5900

<img width="1435" alt="Screenshot 2021-05-04 at 15 10 27" src="https://user-images.githubusercontent.com/12692227/117008533-21d79280-aceb-11eb-993a-efa7d1123a1f.png">

Version history:
- Upgrade CUDA version to 12.1
- Upgrade dev and latest image to Ubuntu 22.04
- Upgrade cpu only image to Ubuntu 22.04
- Minimalistic CPU-only jail version added
- Dev and Runtime version separated
- Upgrade image to CUDA 11.0 and Ubuntu 20.04
- Docker 19.03+ NV integration
- Nvidia-Docker 2.0 integration release
- Wine v0.2 addon pre-release
- Initial v0.1 pre-release

Because of Docker integration with nvidia, all orchestrators, including Rancher, should play nice with NV GPU container instances.
