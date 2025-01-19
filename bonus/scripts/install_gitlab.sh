#!/bin/bash

kubectl create namespace gitlab

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm install gitlab gitlab/gitlab -f /vagrant/confs/values.yaml -n gitlab

kubectl wait --for=condition=ready pod --all -n gitlab --timeout=600s

echo "Gitlab Pass: "
kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode
echo

kubectl delete ingress gitlab-webservice-default -n gitlab

kubectl apply -f /vagrant/confs/gitlab_ingress.yaml