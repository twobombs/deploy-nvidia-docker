Contents:

- Bash script for deploying NVidia-Docker on new 14.04/16.04/17.04 hosts
- Dockerfile to create X-accelerated containers with novnc frontend

[under development] 

Start X CUDA session

nvidia-docker run -d -v /tmp/.X11-unix:/tmp/.X11-unix:rw twobombs/deploy-nvidia-docker startxfce4&&x0vncserver -display :0 -passwordfile ~/.vnc/passwd&&/root/noVNC/utils/launch.sh --vnc localhost:5900
