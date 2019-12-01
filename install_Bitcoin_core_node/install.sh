#!/usr/bin/bash

echo -e "1. Debian\n2. Fedora"
read VAR
VAR=${VAR:-1}
#shopt -s nocasematch

case $VAR in 
    1 )
        if which bitcoind >/dev/null; then
            echo "Already installed";
            exit 1
        fi

        echo "Warning: This is for Debain based Distributions only;"
        echo "Installing Dependencies..."

        sudo apt install wget autoconf libtool libboost* libcurl4-openssl-dev libevent-dev libssl-dev
        bash libdb

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
        ./configure #--with-boost-libdir=/usr/lib/x86_64-linux-gnu

        make
        sudo make install

        if which bitcoind >/dev/null; then
            echo "Successfully installed Bitcoin Core NODE"
        else
            echo "Unable to install Bitcoin Core NODE"
        fi
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

        # Install make if you dont have

        sudo dnf install make  
        make # -j4 (If required)
        sudo make install

        echo "Successfully installed BTC_Core_Node"
        ;;
    * ) 
        echo "Skipping"
esac
