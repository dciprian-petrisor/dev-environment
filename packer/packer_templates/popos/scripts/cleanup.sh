#!/bin/sh -eux

echo "Cleaning up install..."

echo "Remove libreoffice"
dpkg --list \
  | awk '{ print $2 }' \
  | grep 'libreoffice.*' \
  | xargs -i sh -c "apt-get -y purge {}";

echo "Pop! OS may not have some of these compared to Ubuntu, we remove what is possible."
echo "remove linux-headers"
dpkg --list \
  | awk '{ print $2 }' \
  | grep 'linux-headers' \
  | xargs -i sh -c "apt-get -y purge {} || true";

echo "remove specific Linux kernels, such as linux-image-3.11.0-15-generic but keeps the current kernel and does not touch the virtual packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep 'linux-image-.*-generic' \
    | grep -v `uname -r` \
    | xargs -i sh -c "apt-get -y purge {} || true";

echo "remove old kernel modules packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep 'linux-modules-.*-generic' \
    | grep -v `uname -r` \
    | xargs -i sh -c "apt-get -y purge {} || true";

echo "remove linux-source package"
dpkg --list \
    | awk '{ print $2 }' \
    | grep linux-source \
    | xargs -i sh -c "apt-get -y purge {} || true";

echo "remove all development packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep -- '-dev\(:[a-z0-9]\+\)\?$' \
    | xargs -i sh -c "apt-get -y purge {} || true";

echo "remove docs packages"
dpkg --list \
    | awk '{ print $2 }' \
    | grep -- '-doc$' \
    | xargs -i sh -c "apt-get -y purge {} || true";

# Exclude the files we don't need w/o uninstalling linux-firmware
echo "Setup dpkg excludes for linux-firmware"
cat <<_EOF_ | cat >> /etc/dpkg/dpkg.cfg.d/excludes
path-exclude=/lib/firmware/*
path-exclude=/usr/share/doc/linux-firmware/*
_EOF_

echo "delete the massive firmware files"
rm -rf /lib/firmware/*
rm -rf /usr/share/doc/linux-firmware/*

echo "autoremoving packages and cleaning apt data"
apt-get -y autoremove;
apt-get -y clean;

echo "remove /usr/share/doc/"
rm -rf /usr/share/doc/*

echo "remove /var/cache"
find /var/cache -type f -exec rm -rf {} \;

echo "truncate any logs that have built up during the install"
find /var/log -type f -exec truncate --size=0 {} \;

echo "blank netplan machine-id (DUID) so machines get unique ID generated on boot"
truncate -s 0 /etc/machine-id

echo "remove the contents of /tmp and /var/tmp"
rm -rf /tmp/* /var/tmp/*

echo "force a new random seed to be generated"
rm -f /var/lib/systemd/random-seed

echo "clear the history so our install isn't there"
rm -f /root/.wget-hsts
export HISTSIZE=0
