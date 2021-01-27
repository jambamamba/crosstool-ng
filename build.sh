#!/bin/bash -ex
set -ex

TOOLCHAIN_DIR=${HOME}/${DOCKERUSER}/.leila/toolchains/raspberrypi4

function parseArgs()
{
  for change in $@; do
      set -- `echo $change | tr '=' ' '`
      echo "variable name == $1  and variable value == $2"
      #can assign value to a variable like below
      eval $1=$2;
  done
}


function build()
{
    #sudo apt-get install -y bison cvs flex gperf texinfo automake libtool unzip help2man gawk libtool-bin libtool-doc libncurses5-dev libncursesw5-dev protobuf-compiler kpartx

    parseArgs "$@"

    if [ ! -f config.h ]; then
        ./bootstrap
        ./configure --prefix=${PWD}/build
    fi
    make -j$(getconf _NPROCESSORS_ONLN)
    make install

    export TOOLCHAIN_DIR=${TOOLCHAIN_DIR}
    mkdir -p ${TOOLCHAIN_DIR}

    mkdir -p staging
    pushd staging
    mkdir -p downloads
    unset CC
    unset CXX
    unset LD_LIBRARY_PATH
    #ln -fs ../raspi0.config .config
    ln -fs ../raspi4.config .config

    #We already have a .config file, so we do not need to go through the menuconfig steps
    # ../build/bin/ct-ng menuconfig
    #The menuconfig presents a UI that lets you create the .config file.
    #In the UI, follow these steps:
    #Paths and misc options > Prefix directory >  /home/oosman/pi2/x-tools/${CT_TARGET}
    #			> Number of parallel jobs 8
    #Target options > Target Architecture 	> arm
    #					> Suffix to the arch-part > rpi
    #					> Floating point : hardward FPU
    #					> Emit assembly for CPU (none)
    #					> tune for cpu (nothing, no ev4)
    #Operating System > Target OS > linux
    #Binary utilities > Linkers to enable > ld,gold
    #					> Enable threaded gold
    #C-library > Version of glibc (2.29)
    #	  > Create /etc/ld.so.conf file
    #C compiler > C++
    #Companion tools > autoconf
    #			> automake
    #			> libtool
    #			> make
    #Exit
    #Save
    #
    #For a different target, lets grap the raspberrypi3 for example:
    # ./build/bin/ct-ng list-samples | grep rpi
    # ./build/bin/ct-ng aarch64-rpi3-linux-gnu
    # ../build/bin/ct-ng menuconfig
    # save exit
    # https://ilyas-hamadouche.medium.com/creating-a-cross-platform-toolchain-for-raspberry-pi-4-5c626d908b9d

    ../build/bin/ct-ng build
    sudo chown -R dev:dev ${TOOLCHAIN_DIR}
    popd
    cp -f Toolchain.cmake ${TOOLCHAIN_DIR}/Toolchain.cmake
}

function clean()
{
    sudo rm -fr ${TOOLCHAIN_DIR}
    rm config.h
}

if [ "$1" == "clean" ]; then
    clean
else
    build TOOLCHAIN_DIR=${TOOLCHAIN_DIR}
fi



