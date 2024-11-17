#!/bin/bash
curl -LO "https://dl.k8s.io/release/v1.31.2/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/v1.31.2/bin/linux/amd64/kubectl.sha256"
echo "  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
########
curl -sfL https://get.k3s.io | sh -
mkdir -p ~/.kube
sudo k3s kubectl config view --raw | tee ~/.kube/config
chmod 600 ~/.kube/config
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
