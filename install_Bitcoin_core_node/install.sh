#!/usr/bin/bash

read -p "1. Debian\n2. Fedora" VAR
VAR=${VAR:-1}
#shopt -s nocasematch

case $VAR in 
    1 )
        echo "Warning: This is for Debain based Distributions only;"
        echo "Installing Dependencies..."

        sudo apt install wget autoconf libtool libboost* libcurl4-openssl-dev libevent-dev

        echo "Going Home"

        cd $HOME
        #git clone https://github.com/bitcoin/bitcoin.git

        cd bitcoin
        git checkout v0.19.0.1
        git status

        echo "Running Autogen"
        ./autogen.sh

        sleep 2

        echo "Configuring"
        ./configure --with-boost-libdir=/usr/lib/x86_64-linux-gnu

        make
        sudo make install

        echo "Successfully installed Bitcoin Core NODE"
        ;;

    2 )
        echo "Warning: This is for RPM based Distributions only;"
        echo "Installing Dependencies..."

        sudo dnf install autoconf automake libtool gcc-c++ libdb4-cxx-devel boost-devel openssl-devel libevent-devel

        echo "Going Home"

        cd $HOME
        git clone https://github.com/bitcoin/bitcoin.git

        cd bitcoin
        git checkout v0.19.0.1
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


