#!/bin/sh

cd "$(dirname "$0")"

d_interface=wlp1s0
d_ip=192.168.42.99
d_mac=b8:69:f4:2f:b1:f7
d_remote_f=/mnt/yoda/qbittorrent/downloads
d_local_f=/home/kozaroczy/odin

read -p "Want to change defaults? (yN): " need_to_change
if [ $need_to_change = y ]
then
  read -p "Interface (default: $d_interface): " interface
  read -p "Server IP (default: $d_ip): " ip
  read -p "Router MAc (default: $d_mac): " mac
  read -p "Remote folder (default: $d_remote_f): " remote_f
  read -p "Local folder (default: $d_local_f): " local_f
fi

interface=${interface:-$d_interface}
ip=${ip:-$d_ip}
mac=${mac:-$d_mac}
remote_f=${remote_f:-$d_remote_f}
local_f=${local_f:-$d_local_f}

# Install required packages
if [ $(dpkg --get-selections | grep nfs-common | wc -l) = 0 ]
then
  sudo apt-get install nfs-common
fi

# Build script
if [ ! -d build ]
then
  mkdir build
fi

cat <<EOF > build/mount_torrent_server
#!/bin/sh
# filename: mount_odin

if [ "\$IFACE" = $interface ] && \\
   [ "\$ADDRFAM" = inet ] && \\
   [ \$(ip neigh | grep 192.168.42.1 | awk '{ print \$5 }') = $mac ]
then
  mount $ip:$remote_f $local_f
fi
EOF

# Copy script to the right place
chmod +x build/mount_torrent_server
sudo cp build/mount_torrent_server "/etc/network/if-up.d/mount_torrent_server"

# Set up additional configs
if [ $(cat /etc/network/interfaces | grep $interface | wc -l) = 0 ]
then
  sudo sh -c 'echo "auto wlp1s0" >> /etc/network/interfaces'
fi

# Remove temporary files
rm -rf build
