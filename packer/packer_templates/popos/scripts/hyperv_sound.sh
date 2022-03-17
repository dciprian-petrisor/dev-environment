#!/bin/bash

case "$PACKER_BUILDER_TYPE" in
hyperv-iso)

apt-get -y install meson git libpulse-dev autoconf m4 intltool build-essential dpkg-dev libtool libsndfile-dev libspeexdsp-dev libudev-dev libtdb-dev check

cp /etc/apt/sources.list /etc/apt/sources.list~
sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
apt-get -y update
apt build-dep pulseaudio -y
cd /tmp
git clone https://git.launchpad.net/~ubuntu-audio-dev/pulseaudio

cd /tmp/pulseaudio
meson build
meson compile -C build

git clone https://github.com/neutrinolabs/pulseaudio-module-xrdp.git
cd pulseaudio-module-xrdp
./bootstrap
./configure PULSE_DIR="/tmp/pulseaudio"
make
cd /tmp/pulseaudio/pulseaudio-module-xrdp/src/.libs
install -t "/var/lib/xrdp-pulseaudio-installer" -D -m 644 *.so

apt-get -y purge meson autoconf m4 intltool libtool

esac