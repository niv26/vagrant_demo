#!/bin/bash

#Variables
#-----------------------------------#

cd ~

#Install pyton packages
#-----------------------------------#
# install pip
curl https://bootstrap.pypa.io/get-pip.py -o ./get-pip.py
python get-pip.py
#install virtualenv
pip install virtualenv
#install conda installer
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
#export PATH="$HOME/miniconda/bin:$PATH"





# Install java 8 (shoudl be oracle, but openjdk is good enough for the demo)
#-----------------------------------#
yum install java-1.8.0-openjdk.x86_64 -y







