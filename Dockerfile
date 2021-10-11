FROM ubuntu:16.04
MAINTAINER Lawrence-Tang <tangzongsheng@gmail.com>

RUN set -x; \
    mkdir -p ~/.pip
COPY ./files/pip.conf ~/.pip/pip.conf

RUN apt-get update; \
    apt-get -y install libc6-dev-i386; \
    apt-get -y install gcc-multilib g++-multilib debootstrap qemu-user-static device-tree-compiler

RUN apt-get -y install sudo bc whiptail curl aria2 wget make lsb-release openssh-client vim tree exfat-fuse exfat-utils u-boot-tools mediainfo \
    libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libxcb-xinerama0 libxcb-xinerama0-dev \
    libopenal-dev libalut-dev libpulse-dev libuv1-dev libmicrohttpd-dev bridge-utils ifplugd \
    libbluetooth3-dev libjpeg8 libjpeg8-dev libjpeg-turbo8 libjpeg-turbo8-dev libvpx-dev \
    libgtk2.0-dev libnss3 libgconf-2-4 gconf2 gconf2-common libx11-dev libxext-dev libxtst-dev \
    libxrender-dev libxmu-dev libxmuu-dev libxfixes-dev libxfixes3 libpangocairo-1.0-0 \
    libpangoft2-1.0-0 libdbus-1-dev libdbus-1-3 libusb-0.1-4 libusb-dev \
    bison gperf flex ruby python libasound2-dev libbz2-dev libcap-dev \
    libcups2-dev libdrm-dev libegl1-mesa-dev libgcrypt11-dev libnss3-dev libpci-dev libpulse-dev libudev-dev \
    libxtst-dev gyp ninja-build  \
    libssl-dev libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev \
    libfontconfig1-dev libxss-dev libsrtp0-dev libwebp-dev libjsoncpp-dev libopus-dev libminizip-dev \
    libavutil-dev libavformat-dev libavcodec-dev libevent-dev libcups2-dev libpapi-dev

RUN apt-get -y install libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 libx32z1 libzadc1 lib32z1
RUN apt-get -y install libx11-xcb-dev libglu1-mesa-dev libfontconfig1 libxkbcommon-x11-0
RUN apt-get -y install build-essential dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev
RUN apt-get -y install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
RUN apt-get -y install firefox
RUN ln -s /usr/include/asm-generic/ /usr/include/asm

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

# build git from source
COPY ./files/git-v2.30.2.tar.gz /
RUN tar xzf /git-v2.30.2.tar.gz
RUN cd /git-2.30.2/; \
	make configure; \
	./configure --prefix=/usr; \
	make all; \
    make install
RUN rm -rf /git-2.30.2 /git-v2.30.2.tar.gz

# install jdk
COPY ./files/java-8-openjdk-amd64.tgz /
COPY ./files/jdk1.6.0_45.tgz /
RUN mkdir -p /usr/lib/jvm/
RUN tar xzf /java-8-openjdk-amd64.tgz -C /usr/lib/jvm/
RUN tar xzf /jdk1.6.0_45.tgz -C /usr/lib/jvm/
RUN rm -f /java-8-openjdk-amd64.tgz /jdk1.6.0_45.tgz

# install android-sdk
RUN apt-get -y install android-sdk
COPY ./files/commandlinetools-linux-6609375_latest.zip /
RUN unzip /commandlinetools-linux-6609375_latest.zip -d cmdline-tools; \
	rm -rf /usr/lib/android-sdk/cmdline-tools; \
	mv cmdline-tools /usr/lib/android-sdk; \
	/usr/lib/android-sdk/cmdline-tools/tools/bin/sdkmanager "build-tools;28.0.3"; \
	rm -f /commandlinetools-linux-6609375_latest.zip

# install android-ndk
COPY ./files/android-ndk-r21e-linux-x86_64.zip /
RUN cd /usr/lib/; unzip /android-ndk-r21e-linux-x86_64.zip
RUN rm -f /android-ndk-r21e-linux-x86_64.zip

# install qt-5.12.11
COPY ./files/qt-opensource-linux-x64-5.12.11.run /
RUN chmod +x /qt-opensource-linux-x64-5.12.11.run

# clean
RUN apt-get -y autoremove

# user
RUN echo "root:fa" | chpasswd
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu
RUN echo "ubuntu:fa" | chpasswd

USER ubuntu
ENV HOME /home/ubuntu

RUN echo "all done."
