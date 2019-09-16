#!/bin/bash

# this script should be able to isntall Python 3.7.3
# under redhat-like or debian-like system automatically

declare -A release_info;
release_info[/etc/redhat-release]=yum
release_info[/etc/debian_version]=apt

# packages which will be removed after the installation of Python
declare -A package_info;
package_info[yum]="make automake gcc gcc-c++ kernel-devel bzip2-devel sqlite-devel openssl-devel readline-devel xz-devel gdbm-devel zlib-devel libuuid-devel libuuid libffi-devel"
package_info[apt]="build-essential libbz2-dev libdb5.3-dev libexpat1-dev libffi-dev libgdbm-dev liblzma-dev libncurses5-dev libncursesw5-dev libreadline-dev libreadline6-dev libsqlite3-dev libssl-dev llvm llvm-3.9-dev llvm-3.9-runtime llvm-6.0-dev llvm-6.0-runtime tk-dev xz-utils zlib1g-dev"

# pick package manager based on release info file existence
for rls in ${!release_info[@]}; do
	if [[ -f $rls ]]; then
		pack_man=${release_info[$rls]}
	fi
done

compulsory_packages="build-essential wget make"
eval "sudo $pack_man install -y $compulsory_packages ${package_info[$pack_man]}"


# get the source code package and unzip it
wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz
tar xf Python-3.7.3.tar.xz
cd Python-3.7.3

# configure and install python to specific location
./configure --enable-optimizations --with-ensurepip=install --prefix=/usr/local/python3.7.3
make -j 8
sudo make altinstall

# clear used materials
cd ..
sudo rm -r Python-3.7.3
rm Python-3.7.3.tar.xz

# ensure pip target python version
./python -m ensurepip --default-pip

#link the current version to system
sudo rm /usr/bin/python3
sudo ln -s /usr/local/python3.7.3/bin/python3.7 python /usr/bin/python3


# clear library to reduce system size
eval "sudo $pack_man remove -y ${package_info[$pack_man]}"
eval "sudo $pack_man autoremove -y"
eval "sudo $pack_man clean"

