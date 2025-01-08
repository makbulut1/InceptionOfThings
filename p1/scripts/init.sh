#!/bin/bash
bashrc_file="/home/vagrant/.bashrc"
apt update
apt install curl -y
apt install net-tools -y
echo "alias k='kubectl'" >> $bashrc_file