# This image is for compiling STM32 HAL Projects
# May even work with RTOS Projects
# ===== ===== ===== ===== ===== =====
# ===== =====  Arguments  ===== =====
# Download GNU ARM
ARG comp_dnld_link=https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=CA590209F5774EE1C96E6450E14A3E26
# Host project location 
#ARG wDirHost
    # You actually can't have a variable for the mounting point
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
RUN <<EOT 
    #!/bin/bash
    apt update 
    apt upgrade
    apt install cmake make xz-utils -y
    mkdir -p /opt/gcc-arm-none-eabi/ /tmp/gcc-arm-none-eabi/
EOT

# ===== Install compiler

ADD https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=CA590209F5774EE1C96E6450E14A3E26 /tmp/compiler.tar.xz

RUN tar xf /tmp/compiler.tar.xz -C /tmp/gcc-arm-none-eabi/ \
    && mv /tmp/gcc-arm-none-eabi/arm-gnu-toolchain-*/* /opt/gcc-arm-none-eabi/ \
    && rm -rf /tmp/*

# Symlink to /usr/local/bin
    # TODO: Why?
RUN ln -s /opt/gcc-arm-none-eabi/bin/* /usr/local/bin

# Add compiler to the path, note how we don't use export to set it globally
ENV PATH="$PATH:/opt/gcc-arm-none-eabi/bin" 

# ===== ===== Build Project ===== =====

# Create volume mounting point
VOLUME /tmp/myProject

# Change working dir to project location in container
WORKDIR /tmp/myProject


