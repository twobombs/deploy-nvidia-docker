FROM nvidia/cuda:8.0-devel-ubuntu16.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y && apt-get install -y git net-tools nvidia-375 cuda && apt-get clean all

RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y xfce4 xfce4-goodies ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal libsdl1.2-dev mesa-utils && apt-get clean all

RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y x11vnc  tightvncserver vnc4server novnc xvfb firefox mc lynx && apt-get clean all

RUN apt-get -y -f install libtasn1-3-bin && apt-get clean all

RUN cd /root && wget http://upload.aspeedtech.com/BIOS/v103_linux_freebsd_solaris.zip && unzip /root/v103_linux_freebsd_solaris.zip

RUN cd /root &&git clone git://github.com/novnc/noVNC && cp /root/noVNC/vnc.html /root/noVNC/index.html && mkdir /root/.vnc

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
