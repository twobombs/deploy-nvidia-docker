FROM nvidia/cudagl:10.0-devel-ubuntu18.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# install baseline x, vnc and wine
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y apt-utils software-properties-common && dpkg --add-architecture i386 && apt-get upgrade -y && apt-get install -y git wget curl net-tools qemu-kvm qemu nvidia-modprobe virt-manager virt-viewer libvirt-bin  bridge-utils linux-tools-generic && apt-get clean all && apt -y autoremove
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y  --install-recommends xfce4 xfce4-goodies libsdl1.2-dev mesa-utils && apt-get clean all && apt -y autoremove
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y x11vnc  tightvncserver vnc4server novnc xvfb firefox mc lynx open-vm-tools ssh-askpass-gnome && apt-get clean all && apt -y autoremove
RUN cp /usr/share/novnc/vnc.html /usr/share/novnc/index.html && mkdir /root/.vnc
RUN apt-get -y -f install libtasn1-bin && apt-get update && apt-get install -y wine-stable && apt-get clean all && apt -y autoremove

# add system frameworks
RUN apt-get -y -f install  lm-sensors hddtemp python3-pip clinfo freeglut3 && apt-get clean all && apt -y autoremove

# add OCL dev
# RUN apt-get -y -f install ocl-icd-libopencl1 opencl-headers ocl-icd-opencl-dev opencl-icd-* && apt-get clean all && apt -y autoremove

# cleanup idle cpu usage
RUN apt-get -y remove xscreensaver

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
