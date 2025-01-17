#!/bin/bash


 sudo apt-get update -y
 sudo apt-get install ca-certificates curl -y
 sudo install -m 0755 -d /etc/apt/keyrings
 sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
 sudo chmod a+r /etc/apt/keyrings/docker.asc

 echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 sudo apt-get update -y

 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

 curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" --output /tmp/kubectl
 sudo install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl

 wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

 sudo k3d cluster create cluster --network host

 mkdir ~/.kube
 sudo k3d kubeconfig get cluster > ~/.kube/config
 chmod 600 ~/.kube/config

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 10

kubectl wait --for=condition=ready pod --all -n argocd --timeout=300s

#kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

kubectl apply -f /vagrant/confs/application.yaml
kubectl apply -f /vagrant/confs/argocd-configmap.yaml
kubectl rollout restart deployment argocd-server -n argocd
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd

echo -n "pass: "
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
echo

#kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0

