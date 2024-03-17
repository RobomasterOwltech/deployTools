#!/bin/bash

# TODO: 
#   * Complete packages list

installDependencies(){
    apps=( "containerd", "docker", "screen", "arm-none-eabi" )
    
    for app in "${apps[@]}"
    do
        if [ "$1" ~ "ubuntu" ]; then
            sudo apt -y install "$app"
        fi
    done
}

echo "        ,o."
echo "       (   )"
echo "        ) ("
echo "      ,'   `."
echo "  ,-'/       \`-."
echo " (   `-.___,-'   )"
echo "  `-.         ,-'"
echo "     /`,---.'\"
echo "    / /     \ \"
echo "   ( (       ) )"
echo "    \ `-._,-' /"
echo "      `-._,-'"
echo " ===== Welcome to the team! ===== "
echo "This repo will setup most of the things yo need to start developing."

installDependencies "ubuntu";

echo ""
echo " ===== Generating ssh keys for your github ===== " 
ssh-keygen -f ~/.ssh/git_"$(whoami)"_key -t ed25519 -N ""

# Add docker to start-up and sudoers
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

# Restart, to make changes take effect :)
sudo reboot now
