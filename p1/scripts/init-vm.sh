#!/bin/bash
# Common commands that we need to run on both of the VMs

export bashrc_file=/home/vagrant/.bashrc
sudo apt update
sudo apt install -y curl
sudo apt install -y net-tools
echo "alias k=kubectl" > $bashrc_file
