FROM ubuntu:16.04
MAINTAINER Lawrence-Tang <tangzongsheng@gmail.com>

RUN set -x; 
RUN apt-get update; \
    apt-get -y install libc6-dev-i386; \
    apt-get -y install gcc-multilib g++-multilib debootstrap qemu-user-static

RUN apt-get -y install aria2 wget make lsb-release vim tree exfat-fuse exfat-utils mediainfo \
    libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libxcb-xinerama0 libxcb-xinerama0-dev \
    libopenal-dev libalut-dev libpulse-dev libuv1-dev libmicrohttpd-dev bridge-utils ifplugd \
    libbluetooth3-dev libjpeg8 libjpeg8-dev libjpeg-turbo8 libjpeg-turbo8-dev libvpx-dev \
    libnss3 libgconf-2-4 gconf2 gconf2-common libx11-dev libxext-dev libxtst-dev \
    libxrender-dev libxmu-dev libxmuu-dev libxfixes-dev libxfixes3 libpangocairo-1.0-0 \
    libpangoft2-1.0-0 libdbus-1-dev libdbus-1-3 libusb-0.1-4 libusb-dev \
    bison build-essential gperf flex ruby python libasound2-dev libbz2-dev libcap-dev \
    libcups2-dev libegl1-mesa-dev libgcrypt11-dev libnss3-dev libpci-dev libpulse-dev \
    libxtst-dev gyp ninja-build  \
    libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev \
    libfontconfig1-dev libxss-dev libsrtp0-dev libwebp-dev libjsoncpp-dev libopus-dev libminizip-dev \
    libavutil-dev libavformat-dev libavcodec-dev libevent-dev libcups2-dev libpapi-dev

# buildroot
RUN apt-get -y install repo git u-boot-tools device-tree-compiler mtools parted libudev-dev libusb-1.0-0-dev python-linaro-image-tools linaro-image-tools gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu autoconf autotools-dev m4 intltool libdrm-dev curl sed make binutils build-essential gcc g++ bash patch gzip bzip2 perl tar cpio python unzip file bc wget libncurses5 libqt4-dev libglib2.0-dev libgtk2.0-dev libglade2-dev cvs mercurial rsync openssh-client subversion asciidoc w3m dblatex graphviz python-matplotlib libssl-dev pv e2fsprogs fakeroot devscripts libi2c-dev libncurses5-dev texinfo liblz4-tool genext2fs live-build
# buildroot fail
# lib32gcc-7-dev libstdc++-7-dev libsigsegv3
RUN apt-get -y install g++-aarch64-linux-gnu g++-arm-linux-gnueabihf
RUN ln -s /usr/include/asm-generic/ /usr/include/asm

RUN apt-get -y install binfmt-support 
COPY ./packages /packages
RUN dpkg -i --force-all /packages/*

RUN echo "root:fa" | chpasswd
USER root

RUN echo "all done."
