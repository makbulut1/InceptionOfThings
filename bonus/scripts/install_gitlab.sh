#!/bin/bash

kubectl create namespace gitlab

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm install gitlab gitlab/gitlab \
  --namespace gitlab \
  --set global.hosts.domain=local.gitlab.com \
  --set global.hosts.externalIP=192.168.56.110 \
  --set certmanager-issuer.email=admin@karabay.com

kubectl wait --for=condition=ready pod --all -n gitlab --timeout=600s

echo "Gitlab Pass: "
kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode
echo

kubectl apply -f ../confs/gitlab-ingress.yaml