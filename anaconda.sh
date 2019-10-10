#!/usr/bin/bash

read -p "Default/Manual  [D/m]:" VAR
VAR=${VAR:-'D'}
shopt -s nocasematch

case "$VAR" in 
    "d" )
        echo "Default Linux 64bit python 3.7"
        echo "Downloading Anaconda Distribution"
        wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
        bash Anaconda3-2019.07-Linux-x86_64.sh
        conda config --set auto_activate_base false;;
    "m" )
        echo "Installation for Anaconda"
        echo "1. MacOS"
        echo "2. Linux"

        read choice1

        case $choice1 in 
            1 ) 
                echo "Default 64 bit commandline python 3.7"
                echo "Downloading Anaconda distribution"
                wget https://repo.anaconda.com/archive/Anaconda3-2019.07-MacOSX-x86_64.pkg
                bash Anaconda3-2019.07-Linux-x86_64.sh;;
            2 )
                echo "Default 64 bit python 3.7"
                echo "Downloading Anaconda distribution"
                wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
                bash Anaconda3-2019.07-Linux-x86_64.sh
                conda config --set auto_activate_base false;;
        esac;;
    *)
        echo "Skipping"
esac

