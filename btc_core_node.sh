#!/usr/bin/bash

read -p "Debian_Based/Fedora [D/f]" VAR
VAR=${VAR:-'D'}
shopt -s nocasematch

case "$VAR" in 
    "d" )
        echo "Warning: This is for Debain based Distributions only;"
        echo "Installing Dependencies..."

        sudo apt install wget autoconf

        echo "Going Home"

        cd $HOME
        git clone https://github.com/bitcoin/bitcoin.git

        cd bitcoin
        git checkout v0.9.5
        git status

        echo "Running Autogen"
        ./autogen.sh

        sleep 2
        ;;

    "f" )
        echo "Warning: This is for RPM based Distributions only;"
        echo "Installing Dependencies..."

        sudo dnf install autoconf automake libtool gcc-c++ libdb4-cxx-devel boost-devel openssl-devel libevent-devel

        echo "Going Home"

        cd $HOME
        git clone https://github.com/bitcoin/bitcoin.git

        cd bitcoin
        git checkout v0.9.5
        git status

        echo "Running Autogen"
        ./autogen.sh

        sleep 2

        echo "Configuring"
        ./configure

        # Install make if you don't have

        sudo dnf install make  
        make # -j4 (If required)
        sudo make install

        echo "Successfully installed BTC_Core_Node"
        ;;
    * ) 
        echo "Skipping"
esac


