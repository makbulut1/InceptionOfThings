#!/bin/bash

# kubectl kurulumu
curl -LO "https://dl.k8s.io/release/v1.31.2/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/v1.31.2/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# K3s kurulumu (Master Node)
curl -sfL https://get.k3s.io | sh -

# Kubeconfig dosyasını oluştur
mkdir -p ~/.kube
sudo k3s kubectl config view --raw | tee ~/.kube/config
cat /var/lib/rancher/k3s/server/token > /vagrant_data/master_node
# Dosya izinlerini ayarla
chmod 600 ~/.kube/config
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

# Master node'un IP adresini almak (Vagrant'tan alınan IP)
MASTER_IP=$(hostname -I | awk '{print $1}')
echo "Master Node IP: $MASTER_IP"

