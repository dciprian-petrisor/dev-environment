#!/bin/sh -eux

popos_version="`lsb_release -r | awk '{print $2}'`";
major_version="`echo $popos_version | awk -F. '{print $1}'`";

if [ "$major_version" -ge "18" ]; then
echo "Create netplan config for eth0"
cat <<EOF >/etc/netplan/01-netcfg.yaml;
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true
EOF
else
  # Adding a 2 sec delay to the interface up, to make the dhclient happy
  echo "pre-up sleep 2" >> /etc/network/interfaces;
fi

# Disable Predictable Network Interface names and use eth0
[ -e /etc/network/interfaces ] && sed -i 's/en[[:alnum:]]*/eth0/g' /etc/network/interfaces;
