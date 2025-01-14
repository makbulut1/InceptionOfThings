#!/bin/bash

# Set kubeconfig file location
export KUBECONFIG=$HOME/.kube/config

# Delete resources created by init.sh
echo "Deleting ArgoCD resources..."
kubectl delete -f ../confs/ingress.yaml --ignore-not-found
kubectl delete -f ../confs/application.yaml --ignore-not-found

echo "Deleting namespaces..."
kubectl delete namespace dev --ignore-not-found
kubectl delete namespace argocd --ignore-not-found

# Delete k3d cluster
echo "Deleting k3d cluster..."
sudo k3d cluster delete cluster

# Remove kubeconfig file
echo "Cleaning up kubeconfig..."
rm -rf ~/.kube/config

# Uninstall kubectl
echo "Removing kubectl..."
sudo rm -f /usr/local/bin/kubectl

# Remove Docker
echo "Removing Docker..."
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo apt-get autoremove -y
sudo rm -rf /var/lib/docker /etc/docker

# Remove Docker repository and GPG key
echo "Removing Docker repository and GPG key..."
sudo rm -f /etc/apt/keyrings/docker.asc
sudo rm -f /etc/apt/sources.list.d/docker.list

# Clean apt cache
echo "Cleaning apt cache..."
sudo apt-get clean

# Remove ArgoCD and related aliases from bashrc
echo "Removing ArgoCD aliases..."
export bashrc_file=$HOME/.bashrc
sed -i '/alias k=kubectl/d' $bashrc_file
source $bashrc_file

echo "Cleanup complete!"