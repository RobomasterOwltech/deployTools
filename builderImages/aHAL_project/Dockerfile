# This image is for compiling STM32 HAL Projects
# May even work with RTOS Projects
# ===== ===== ===== ===== ===== =====
# ===== =====  Arguments  ===== =====
# Download GNU ARM
ARG comp_dnld_link=https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=CA590209F5774EE1C96E6450E14A3E26
# Host project location 
ARG projectFolderOnHost='Docs'
# ===== ===== ===== ===== ===== =====

# My reference from: https://www.youtube.com/watch?v=imUiQkO9YHM

# TODO: 
#   * Select version for the compiler
#   * Define version for cmake, make
#   * Set arguments as directives?

# ===== ===== Actual image ===== =====
FROM ubuntu:22.04

# ===== Update repos
    # As a multi-line script
RUN <<EOT bash
    #!/bin/bash
    apt update 
    apt upgrade
    apt install cmake make -y
EOT

# ===== Install compiler
ADD comp_dnld_link /tmp/compiler.tar.xz
RUN tar -xf /tmp/compiler.tar.xz -C /opt/gcc-arm-none-eabi

# Add compiler to the path, note how we don't use export to set it globally
ENV PATH="$PATH:/opt/gcc-arm-none-eabi-13.2/bin" 

# Print versions to check everything was setup correctly.
RUN arm-none-eab-gcc 
RUN arm-none-eab-g++ 

# ===== ===== Build Project ===== =====

# Mount project direcory into container
VOLUME projectFolderOnHost /tmp/myProject
# Change working dir to project location in container
WORKDIR /tmp/myProject

# Get the binary from the container to the host

