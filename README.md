![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

Contents:

- Bash script for deploying NVidia-Docker2 on [Ubuntu](https://github.com/twobombs/deploy-nvidia-docker/blob/master/deploy-nvidia-docker2.sh)
- Dockerfile to create X-accelerated containers with novnc frontend, image hosted on [Dockerhub](https://hub.docker.com/r/twobombs/deploy-nvidia-docker)
- comes in the following flavours `:latest` for runtime `:dev` developer-tools and `:minimum` tag for minimum CPU-only with user jail

Start X CUDA session

With Nvidia Docker enabled
```bash
docker run --gpus all --device=/dev/kfd --device=/dev/dri:/dev/dri -d twobombs/deploy-nvidia-docker
````

Docker only
```bash
docker run --device=/dev/dri:/dev/dri -d twobombs/deploy-nvidia-docker
````

Minimalistic Docker CPU-only version with user jailed in xterm
```bash
docker run -d twobombs/deploy-nvidia-docker:minimal
````

Initial vnc password is `00000000`
- noVNC website is avaliable at port `6080`
- xRDP running at port `3389` to vnc `127.0.0.1:5900`

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

Because of Docker integration with nvidia all k8s orchestrators should play nice with NV GPU container instances.
