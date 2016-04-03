FROM debian:jessie
MAINTAINER Benjamin Böhmke <benjamin@boehmke.net>


# update system and get base packages
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl git rsync cmake \
        libc6-i386 lib32stdc++6 zlib1g:i386 qt4-dev-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get root file system of raspberry
RUN mkdir /raspi/ && \
    curl -sSL http://data.boehmke.net/raspberry_rootfs.tar.gz | tar -v -C /raspi/ -xz

# prepare cross compiler
RUN git clone git://github.com/raspberrypi/tools.git /raspi/rpi-tools && \
    rm -rf /raspi/rpi-tools/.git

# add toolchain file
COPY raspi.cmake /raspi/raspi.cmake

# set PATH
ENV PATH /raspi/rpi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# prepare build directory
VOLUME /build/
WORKDIR /build/