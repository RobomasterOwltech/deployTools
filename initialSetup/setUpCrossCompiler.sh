#!/bin/bash
set -e
# ===== How to run =====
# $1 -> path to the downloaded tar file
if [ -z "$1" ]; then 
    echo "You need an argument. The path to the downloaded file"
fi 

# ===== Explanations =====
# What is a toolchain: https://web.eecs.umich.edu/~prabal/teaching/resources/eecs373/toolchain-notes.pdf
# Guided video: https://www.youtube.com/watch?v=imUiQkO9YHM&t=329s

if [[ "$(whoami)" != "root" ]]; then
    echo "You are not root ( ͠° ͟ʖ ͡°)" 
    exit 1
fi
# Make sure there are no versions installed
if sudo apt remove gcc-arm-none-eabi ; then
    echo "Deleted distributed packages"
fi

# Extract to /opt
echo "Extracting tar to  /opt" 
sudo tar -xf $1 -C /opt

# Create symlinks from opt bins to /usr
echo "Creating symlinks..." 
sudo mkdir -p /usr/local/bin/gcc-arm-none-eabi

# Add /usr symlinks to path
sudo ln -s /opt/gcc-arm-none-eabi*/bin/* /usr/local/bin/gcc-arm-none-eabi/

# Add to Path
echo "Updating path" 
echo "export PATH=\"/usr/local/bin/gcc-arm-none-eabi/:\$PATH\"" >> $HOME/.bashrc

# Update path
source $HOME/.bashrc

echo "Done :D" 
