FROM nvidia/cuda:11.0-devel-ubuntu20.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# install glvnd
RUN dpkg --add-architecture i386 && apt-get update && export DEBIAN_FRONTEND=noninteractive && apt install -y software-properties-common && add-apt-repository multiverse && apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends pkg-config libglvnd-dev libglvnd-dev:i386 libgl1-mesa-dev libgl1-mesa-dev:i386 libegl1-mesa-dev libegl1-mesa-dev:i386 libgles2-mesa-dev libgles2-mesa-dev:i386 && apt-get clean all && apt -y autoremove

# install baseline x, vnc
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y apt-utils software-properties-common && dpkg --add-architecture i386 && apt-get upgrade -y && apt-get install -y git wget curl net-tools qemu-kvm qemu nvidia-modprobe qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager linux-tools-generic && apt-get clean all && apt -y autoremove
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y  --install-recommends xfce4 xfce4-goodies libsdl1.2-dev mesa-utils && apt-get clean all && apt -y autoremove
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y x11vnc  tightvncserver tigervnc-scraping-server novnc xvfb firefox mc lynx open-vm-tools ssh-askpass-gnome && apt-get clean all && apt -y autoremove
RUN cp /usr/share/novnc/vnc.html /usr/share/novnc/index.html && mkdir /root/.vnc

# install wine32 wine64 steam
RUN export DEBIAN_FRONTEND=noninteractive && apt-get -y -f install libtasn1-bin && apt-get update && apt-get install -y wine32 wine64 steam && apt-get clean all && apt -y autoremove

# add system frameworks
RUN export DEBIAN_FRONTEND=noninteractive && apt-get -y -f install  lm-sensors hddtemp python3-pip clinfo freeglut3 && apt-get clean all && apt -y autoremove

# cleanup idle cpu usage
# RUN apt-get -y remove xscreensaver

#copy run scripts
COPY run /root
RUN chmod 755 /root/run
COPY run-nv /root
RUN chmod 755 /root/run-nv

# vnc settings
COPY xorg.conf /usr/share/X11/xorg.conf.d/
COPY passwd /root/.vnc/
COPY xstartup /root/.vnc/
RUN chmod 755 /root/.vnc/xstartup

EXPOSE 5900 6080
