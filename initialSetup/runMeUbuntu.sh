#!/bin/bash

# TODO: 
# * Complete packages list

installDependencies(){
    apps=( "containerd" "docker" "screen")
    
    for app in "${apps[@]}"
    do
        if [[ "$1" == *ubuntu* ]]; then
    sudo apt -y install "$app"
        fi
    done
}

#echo "        ,o."
#echo "       (   )"
#echo "        ) ("
#echo "      ,'   `."
#echo "  ,-'/       \`-."
#echo " (   `-.___,-'   )"
#echo "  `-.         ,-'"
#echo "     /`,---.'\"
#echo "    / /     \ \"
#echo "   ( (       ) )"
#echo "    \ `-._,-' /"
#echo "      `-._,-'"
echo " ===== Welcome to the team! ===== "
echo "This repo will setup most of the things yo need to start developing."

# verify docker is install
if ! snap list | grep -q docker; then
    sudo apt-get install docker
else
    echo "Docker ya está instalado"
fi

sudo apt-get update   
sudo apt-get --fix-missing install runc   
sudo apt-get --fix-missing install containerd

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
