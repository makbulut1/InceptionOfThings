#!/bin/bash

mkdir -p /home/vagrant/.kube
cp /vagrant/confs/kubeconfig /home/vagrant/.kube/config
export K3S_TOKEN=$(cat /vagrant/confs/node-token.env)
export K3S_URL="https://192.168.56.110:6443"
export INSTALL_K3S_EXEC="--node-ip=192.168.56.111"

curl -sfL https://get.k3s.io | sh -
rm -rf /vagrant/confs/
