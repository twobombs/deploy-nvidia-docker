FROM nvidia/cuda:12.5.1-base-ubuntu24.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# image upgrades
RUN apt update && apt -y upgrade && apt clean all

# install glvnd ( temp key fix )
RUN apt-get clean && \
    apt-key adv --fetch-keys "https://developer.download.nvidia.com/compute/cuda/repos/$(cat /etc/os-release | grep '^ID=' | awk -F'=' '{print $2}')$(cat /etc/os-release | grep '^VERSION_ID=' | awk -F'=' '{print $2}' | sed 's/[^0-9]*//g')/x86_64/3bf863cc.pub" && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt install -y software-properties-common && add-apt-repository multiverse && apt update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends pkg-config libglvnd-dev && apt-get -f -y install && dpkg --configure -a && apt-get clean all && apt -y autoremove
# add new mesa+zink framework for opengl over vulkan
RUN add-apt-repository ppa:kisak/kisak-mesa -y && apt update && apt -y upgrade && apt clean all && apt -y autoremove

# install baseline x, vnc
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y apt-utils net-tools software-properties-common && dpkg --add-architecture i386 && apt-get update -y && apt-get install -y git wget curl net-tools nvidia-modprobe qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager linux-tools-generic && apt-get clean all && apt -y autoremove
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y  --install-recommends xrdp xfce4 xfce4-goodies libsdl1.2-dev mesa-utils libgl1-mesa-dev libegl1-mesa-dev libgles2-mesa-dev && apt-get clean all && apt -y autoremove
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y x11vnc neofetch tightvncserver tigervnc-scraping-server novnc xvfb xterm mc lynx open-vm-tools ssh-askpass-gnome && apt-get clean all && apt -y autoremove
RUN cp /usr/share/novnc/vnc.html /usr/share/novnc/index.html && mkdir /root/.vnc

# add system frameworks
RUN export DEBIAN_FRONTEND=noninteractive && apt-get -y -f install lm-sensors python3-pip clinfo freeglut3-dev && apt-get clean all && apt -y autoremove

# get chrome-repo in apt
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# install browsers
RUN apt update && apt install -y google-chrome-stable falkon && apt clean all  && apt -y autoremove

# cleanup idle shutdown
RUN apt-get -y remove xfce4-power-manager

# gnome-terminal invocation fix
RUN apt install -y locales && apt remove -y gnome-terminal && apt purge -y gnome-terminal && apt install -y gnome-terminal && apt clean all

# set desktop background
COPY teleportation.png /usr/share/backgrounds/xfce/xfce-verticals.png

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

EXPOSE 3389 5900 6080
ENTRYPOINT /root/run-nv
