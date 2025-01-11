#!/bin/bash
export bashrc_file=/home/vagrant/.bashrc
export INSTALL_K3S_EXEC="--write-kubeconfig-mode 644 --bind-address=192.168.56.110 --advertise-address=192.168.56.110 --node-ip=192.168.56.110"

curl -sfL https://get.k3s.io | sh -

sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/confs/worker-token.env
echo "alias k='kubectl'" >> $bashrc_file
