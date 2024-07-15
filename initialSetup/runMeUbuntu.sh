#!/bin/bash

# TODO: 
# Do a oneliner for the apt install?

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

installDependencies(){
    apps=("containerd" "docker" "screen" "runc" \
        "build-essential" "synaptic" "python3-dev" \
        "python3-pip" "openssl" "libssl-dev" \
        "gnome-shell-extensions")

    sudo apt update -y
    sudo apt upgrade -y
    for app in "${apps[@]}"
    do
        if [[ "$1" == "ubuntu" ]]; then
            sudo apt -y install "$app"
        fi
    done
}

printf "        .o. \n"
printf "       (   ) \n"
printf "        ) ( \n"
printf "      .'   '. \n"
printf "  .-'/       \\'-. \n"
printf " (   '-.___.-'   ) \n"
printf "  '-.         .-' \n"
printf "     /'.---.'\\ \n"
printf "    / /     \ \\ \n"
printf "   ( (       ) ) \n"
printf "    \ '-._.-' / \n"
printf "      '-._.-' \n"

echo " ===== Welcome to the team! ===== "
echo "This repo will setup most of the things yo need to start developing."
echo "Your computer will restart once finished."

installDependencies "ubuntu";

echo ""
echo " ===== Generating ssh keys for your github ===== " 
ssh-keygen -f ~/.ssh/git_"$(whoami)"_key -t ed25519 -N ""

# Add docker to start-up and sudoers
sudo groupadd docker
sudo usermod -aG docker "$USER"
sudo systemctl enable docker

# Restart, to make changes take effect :)
sudo reboot now
