FROM debian:jessie
MAINTAINER Benjamin Böhmke <benjamin@boehmke.net>


# update system and get base packages
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl git rsync cmake \
        libc6-i386 lib32stdc++6 zlib1g:i386 debootstrap \
        qtbase5-dev-tools qt5-qmake qt4-dev-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# prepare cross compiler
RUN mkdir -p /raspi/rootfs && \
    git clone --depth 1 https://github.com/raspberrypi/tools.git /raspi/rpi-tools && \
    rm -rf /raspi/rpi-tools/.git

# add toolchain file
COPY raspi.cmake /raspi/raspi.cmake

# set PATH
ENV PATH /raspi/rpi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV ROOT_FS /raspi/rootfs/
ENV PACKAGES cmake,qt5-default,qttools5-dev,qt4-default,qt4-dev-tools,libc6-dev,libstdc++-4.9-dev

# get root file system of raspberry
RUN mkdir -p /raspi/tmp && \
    debootstrap --no-check-gpg --arch armhf --variant=minbase --download-only --include=$PACKAGES jessie /raspi/tmp http://archive.raspbian.org/raspbian && \
    for filename in /raspi/tmp/var/cache/apt/archives/*.deb; do echo "$filename"; dpkg-deb --extract "$filename" $ROOT_FS; done

# fix qt moc
RUN rm -r $ROOT_FS/usr/lib/arm-linux-gnueabihf/qt5/bin/* && \
    cp -r /usr/lib/x86_64-linux-gnu/qt5/bin/* $ROOT_FS/usr/lib/arm-linux-gnueabihf/qt5/bin/

# fix libQt5Core.so.5.3.2 __cxa_throw_bad_array_new_length@CXXABI_1.3.8
RUN cp $ROOT_FS/usr/lib/arm-linux-gnueabihf/libstdc++.so.6.0.20 /raspi/rpi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/arm-linux-gnueabihf/lib/libstdc++.so.6.0.19

# prepare build directory
VOLUME /build/
WORKDIR /build/