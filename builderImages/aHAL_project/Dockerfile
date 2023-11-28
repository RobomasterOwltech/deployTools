# This image is for compiling STM32 HAL Projects
# May even work with RTOS Projects
# You need to add the reference for the project build

# My reference from: https://www.youtube.com/watch?v=imUiQkO9YHM

#TODO: Select version for the compiler

FROM ubuntu:22.04

# Update repos
RUN apt update && apt upgrade
RUN apt install cmake make 

# Install compiler
ARG comp_dnld_link=https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=CA590209F5774EE1C96E6450E14A3E26
RUN wget -cO - ${comp_dnld_link} > /tmp/compiler.tar.xz
RUN tar -xf /tmp/compiler.tar.xz -C /opt/gcc-arm-none-eabi-13.2

# Update the path, note how we don't use export to set it globally
ENV PATH="$PATH:/opt/gcc-arm-none-eabi-13.2/bin" 

WORKDIR /opt/gcc-arm-none-eabi-13.2

# Print versions to check everything was setup correctly.
RUN arm-none-eab-gcc 
RUN arm-none-eab-g++ 

