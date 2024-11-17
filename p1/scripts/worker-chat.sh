#!/bin/bash

# kubectl kurulumu
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# K3s worker node kurulumu (Master node IP ve token kullanılarak)
MASTER_IP="192.168.56.110"
K3S_TOKEN=$(cat /vagrant/sync/master_node)
cat /vagrant_data/master_node/*
# K3s'i worker node olarak kur
curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$K3S_TOKEN sh -
# Kubeconfig dosyasını oluştur
mkdir -p ~/.kube
sudo k3s kubectl config view --raw | tee ~/.kube/config

# Dosya izinlerini ayarla
chmod 600 ~/.kube/config
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
