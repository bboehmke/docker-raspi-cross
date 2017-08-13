#!/bin/bash
set -e

# create temp directory
mkdir -p $TMP_DIR

# load required packages
debootstrap --no-check-gpg --arch armhf --variant=minbase --download-only --include=$PACKAGES jessie /raspi/tmp http://archive.raspbian.org/raspbian

# extract 
for filename in $TMP_DIR/var/cache/apt/archives/*.deb; do 
    echo "$filename"
    dpkg-deb --extract "$filename" $ROOT_FS
done

# remove temp directory
rm -r $TMP_DIR

# remove unneeded files
rm -r $ROOT_FS/{bin,boot,dev,etc,home,proc,root,run,sbin,sys,tmp,var}
rm -r $ROOT_FS/usr/{bin,sbin}
rm -r $ROOT_FS/usr/share/{perl,man,fonts,doc}
