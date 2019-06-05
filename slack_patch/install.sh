#!/bin/sh

cd "$(dirname "$0")"

# Install required packages
if [ $(dpkg --get-selections | grep wmctrl | wc -l) = 0 ]
then
  sudo apt-get install wmctrl
fi

if [ ! -f /usr/local/bin/xseticon ]
then
  cd xseticon
  sudo apt-get install libxmu-headers libgd-dev libxmu-dev libglib2.0-dev
  make
  sudo cp xseticon /usr/local/bin
  cd ..
fi

# Copy the script to it's final place
sudo cp slack.sh /usr/local/bin/slack.sh

# Change the desktop file to use the new script
sudo sed -i '/Exec=/c\Exec=/usr/local/bin/slack.sh' /usr/share/applications/slack.desktop
