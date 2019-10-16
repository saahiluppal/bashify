#!/usr/bin/bash

echo "Installing dependencies"

sudo dnf install @development-tools
sudo dnf install kernel-devel kernel-headers dkms qt5-qtx11extras  elfutils-libelf-devel zlib-devel


wget https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0-6.0.14_133895_fedora29-1.x86_64.rpm

sudo rpm -i VirtualBox-6.0-6.0.12_133076_fedora29-1.x86_64.rpm

sudo usermod -a -G vboxusers $LOGNAME