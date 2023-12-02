#!/bin/bash
# This is a template script to install the external project
# You should create a configuration folder and copy this script
# to the folder for actual installation.
config=$(basename "${BASH_SOURCE[0]}" .sh)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
root="$script_dir/.."
source_dir="$script_dir/../source"
build_dir="$script_dir/../build/$OCP_COMPILER/$config"
install_dir="$script_dir/../install/$OCP_COMPILER/$config"

mkdir -p $build_dir
cp -r $source_dir/* $build_dir
cd $build_dir
# replace the IDXTYPEWIDTH number with 32 
sed -i 's/^#define IDXTYPEWIDTH [0-9]*$/#define IDXTYPEWIDTH 64/' metis/include/metis.h
make config cc=$OCP_CC cxx=$OCP_CXX prefix=$install_dir
make -j$(($(nproc) - 1))
make install
cd -

cd $build_dir/metis
make config cc=$OCP_CC cxx=$OCP_CXX prefix=$install_dir
make -j$(($(nproc) - 1))
make install
cd -