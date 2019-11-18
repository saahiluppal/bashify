#!/usr/bin/bash

echo "Warning: This is for RPM based Distributions only;"
echo "Installing Dependencies..."

sudo dnf install autoconf automake libtool gcc-c++ libdb4-cxx-devel boost-devel openssl-devel libevent-devel

echo "Going Home"

cd $HOME
git clone https://github.com/bitcoin/bitcoin.git

cd bitcoin
git checkout v0.18.1
git status

echo "Running Autogen"
./autogen.sh

sleep 2

echo "Configuring"
./configure --disable-dependency-tracking

# Install make if you don't have

sudo dnf install make  
make # -j4 (If required)
sudo make install

echo "Successfully installed BTC_Core_Node"


