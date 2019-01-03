FROM ubuntu:16.04
MAINTAINER Lawrence-Tang <tangzongsheng@gmail.com>

# cn source
COPY ./files/sources-1604.list /etc/apt/sources.list
RUN set -x; \
    mkdir -p ~/.pip
COPY ./files/pip.conf ~/.pip/pip.conf

RUN apt-get update; \
    apt-get -y install libc6-dev-i386; \
    apt-get -y install gcc-multilib g++-multilib debootstrap qemu-user-static device-tree-compiler

RUN apt-get -y install curl aria2 wget make lsb-release openssh-client vim tree exfat-fuse exfat-utils u-boot-tools mediainfo \
    libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libxcb-xinerama0 libxcb-xinerama0-dev \
    libopenal-dev libalut-dev libpulse-dev libuv1-dev libmicrohttpd-dev libssl-dev bridge-utils ifplugd \
    libbluetooth3-dev libjpeg8 libjpeg8-dev libjpeg-turbo8 libjpeg-turbo8-dev libvpx-dev \
    libgtk2.0-dev libnss3 libgconf-2-4 gconf2 gconf2-common libx11-dev libxext-dev libxtst-dev \
    libxrender-dev libxmu-dev libxmuu-dev libxfixes-dev libxfixes3 libpangocairo-1.0-0 \
    libpangoft2-1.0-0 libdbus-1-dev libdbus-1-3 libusb-0.1-4 libusb-dev \
    bison build-essential gperf flex ruby python libasound2-dev libbz2-dev libcap-dev \
    libcups2-dev libdrm-dev libegl1-mesa-dev libgcrypt11-dev libnss3-dev libpci-dev libpulse-dev libudev-dev \
    libxtst-dev gyp ninja-build  \
    libssl-dev libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev \
    libfontconfig1-dev libxss-dev libsrtp0-dev libwebp-dev libjsoncpp-dev libopus-dev libminizip-dev \
    libavutil-dev libavformat-dev libavcodec-dev libevent-dev libcups2-dev libpapi-dev

RUN apt-get -y install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
RUN ln -s /usr/include/asm-generic/ /usr/include/asm

RUN echo "root:fa" | chpasswd
USER root

# install qt-sdk
COPY ./files/qtsdk-friendlyelec/s5p4418 /qtsdk-friendlyelec/s5p4418
RUN echo "> install QtSDK for s5p4418"; \
    cd /qtsdk-friendlyelec/s5p4418/; chmod 755 install.sh; ./install.sh

COPY ./files/qtsdk-friendlyelec/s5p6818 /qtsdk-friendlyelec/s5p6818
RUN echo "> install QtSDK for s5p6818"; \
    cd /qtsdk-friendlyelec/s5p6818/; chmod 755 install.sh; ./install.sh

COPY ./files/qtsdk-friendlyelec/s905 /qtsdk-friendlyelec/s905
RUN echo "> install QtSDK for s905"; \
    cd /qtsdk-friendlyelec/s905/; chmod 755 install.sh; ./install.sh

COPY ./files/qtsdk-friendlyelec/h3 /qtsdk-friendlyelec/h3
RUN echo "> install QtSDK for allwinne h3/h5"; \
    cd /qtsdk-friendlyelec/h3/; chmod 755 install.sh; ./install.sh

COPY ./files/qtsdk-friendlyelec/rk3399-lubuntu /qtsdk-friendlyelec/rk3399-lubuntu
RUN echo "> install QtSDK for rk3399-lubuntu"; \
    cd /qtsdk-friendlyelec/rk3399-lubuntu/; chmod 755 install.sh; ./install.sh

RUN rm -rf /qtsdk-friendlyelec

RUN echo "all done."
