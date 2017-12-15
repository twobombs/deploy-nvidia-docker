FROM nvidia/cuda:8.0-devel-ubuntu16.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y software-properties-common && add-apt-repository -y ppa:wine/wine-builds && dpkg --add-architecture i386 && apt-get upgrade -y && apt-get install -y git net-tools qemu-kvm qemu nvidia-modprobe virt-manager virt-viewer libvirt-bin net-tools && apt-get clean all

RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y  --install-recommends xfce4 xfce4-goodies ubuntu-desktop cuda-samples-8-0 gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal libsdl1.2-dev mesa-utils && cd /usr/local/cuda-8.0/samples && make -k && apt-get clean all

RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y x11vnc  tightvncserver vnc4server novnc xvfb firefox mc lynx open-vm-tools && apt-get clean all

RUN apt-get -y -f install libtasn1-3-bin && apt-get update && apt-get install -y wine-staging && apt-get clean all && apt -y autoremove

RUN cd /root && wget http://upload.aspeedtech.com/BIOS/v103_linux_freebsd_solaris.zip && unzip /root/v103_linux_freebsd_solaris.zip

RUN cd /root &&git clone git://github.com/novnc/noVNC v1.0.0-testing.2 && mv v1.0.0-testing.2 noVNC && cp /root/noVNC/vnc.html /root/noVNC/index.html && mkdir /root/.vnc

RUN systemctl disable lightdm.service

COPY run /root
RUN chmod 755 /root/run

COPY run-nv /root
RUN chmod 755 /root/run-nv

COPY xorg.conf /usr/share/X11/xorg.conf.d/
COPY passwd /root/.vnc/
COPY xstartup /root/.vnc/

RUN chmod 755 /root/.vnc/xstartup

EXPOSE 5900 6080
