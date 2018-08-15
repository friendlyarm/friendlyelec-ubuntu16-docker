## **FriendlyELEC-Ubuntu16-Docker**

This docker image is used to cross-compile Qt application for FriendlyELEC's boards, support for the following qt versions:  
* Qt5.10.0 on FriendlyCore Xenial(for S5P4418/S5P6818/S905)  
* Qt5.10.0 on Lubuntu Xenial(for RK3399 Lubuntu OS)  
* Qt4.8.6 (for Allwinner H3/H5)  

Build docker image with qt-sdk and toolchain added
------------

Download the qt-sdk package from the following url:     
http://dl.friendlyarm.com/qt-sdk-friendlyelec  

Once you've done that then:
```
$ git clone https://github.com/friendlyarm/friendlyelec-ubuntu16-docker.git
$ tar xvzf qtsdk-friendlyelec.tgz -C friendlyelec-ubuntu16-docker/files/
$ docker build -t "fa-ubuntu16" friendlyelec-ubuntu16-docker
```

Run
------------

Enter docker shell:  
```
$ mkdir -p ~/work
$ docker run -it  -v ~/work:/work fa-ubuntu16 /bin/bash
```

This will mount the local ~/work directory to the container's /work directory.  

Cross compile qt application
------------

We took QtE-Demo as an example to show how to cross compile qt application:

* Qt5.10.0 (for S5P4418 platform)
```
$ cd /work
$ git clone https://github.com/friendlyarm/QtE-Demo
$ mkdir build && cd build
$ /usr/local/Trolltech/Qt-5.10.0-nexell32-sdk/bin/qmake ../QtE-Demo/QtE-Demo.pro
$ make
```
* Qt5.10.0 (for S5P6818 platform)
```
$ cd /work
$ git clone https://github.com/friendlyarm/QtE-Demo
$ mkdir build && cd build
$ /usr/local/Trolltech/Qt-5.10.0-nexell64-sdk/bin/qmake ../QtE-Demo/QtE-Demo.pro
$ make
```
* Qt4.8.6 (for Allwinner H3/H5 platform)  
```
$ cd /work/
$ export PATH=/opt/FriendlyARM/toolchain/4.9.3/bin/:$PATH
$ git clone https://github.com/friendlyarm/QtE-Demo
$ mkdir build && cd build
$ /usr/local/Trolltech/QtEmbedded-4.8.6-arm/bin/qmake ../QtE-Demo/QtE-Demo-Qt4.pro
$ make
```
* Qt5.9.1 (for S905 platform)  
```
$ cd /work/
$ export PATH=/opt/FriendlyARM/toolchain/6.4-aarch64/bin/:$PATH
$ git clone https://github.com/friendlyarm/QtE-Demo
$ mkdir build && cd build
$ /usr/local/Trolltech/QtEmbedded-5.9.1-arch64/bin/qmake ../QtE-Demo/QtE-Demo.pro
$ make
```
* Qt5.10.0 armhf X11 (for RK3399 Lubuntu OS) 
```
$ cd /work/
$ git clone https://github.com/friendlyarm/QtE-Demo
$ mkdir build && cd build
$ /usr/local/Trolltech/Qt-5.10.0-rk32xcb-sdk/bin/qmake ../QtE-Demo/QtE-Demo.pro
$ make
```

You can see the qt binary files in the ~/work directory of the host system.    
Refer to the following guidelines to know how to run Qt application on the development board:  
http://wiki.friendlyarm.com/wiki/index.php/How_to_Build_and_Install_Qt_Application_for_FriendlyELEC_Boards

Currently supported boards
------------
* Allwinner H3/H5  
NanoPi Neo  
NanoPi Neo Air  
NanoPi Duo  
NanoPi NEO2  
NanoPi NEO Plus2  
NanoPi M1  
NanoPi M1 Plus  
NanoPi NEO Core  
NanoPi NEO Core2  
NanoPi K1 Plus  

* S5P4418  
NanoPi Fire2A  
NanoPi M2A  
NanoPi S2  
NanoPC T2  
Smart4418  

* S5P6818  
NanoPi Fire3  
NanoPi M3  
NanoPC T3  
NanoPC T3 Plus  

* S905  
NanoPi K2  

* RK3399  
NanoPC T4

Resources
------------
* How to Install and Use Docker on Ubuntu 18.04  
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
* How to Build and Install Qt Application for FriendlyELEC Boards
http://wiki.friendlyarm.com/wiki/index.php/How_to_Build_and_Install_Qt_Application_for_FriendlyELEC_Boards


## License

The MIT License (MIT)
Copyright (C) 2018 FriendlyELEC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
