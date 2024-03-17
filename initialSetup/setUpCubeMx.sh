#!/bin/bash

set -e
# ===== How to run =====
# $1 -> path to the downloaded tar file
if [ -z "$1" ]; then 
    echo "You need an argument"
fi 

# ===== Explanations =====
# What is a toolchain: https://web.eecs.umich.edu/~prabal/teaching/resources/eecs373/toolchain-notes.pdf
# Guided video: https://www.youtube.com/watch?v=imUiQkO9YHM&t=329s

if [[ "$(whoami)" != "root" ]]; then
    echo "You are not root ( ͠° ͟ʖ ͡°)" 
    exit 1
fi

# Create destination directory
sudo mkdir -p /opt/cubeMx

# Extract to /opt
sudo unzip $1 -d /opt/cubeMx

# Give sudo privileges to 
sudo chmod 777 /opt/cubeMx/SetupSTM32CubeMX-6.10.0

# Run installation script
echo "===== Please follow onscreen functions====="
sudo /opt/cubeMx/SetupSTM32CubeMX-6.10.0