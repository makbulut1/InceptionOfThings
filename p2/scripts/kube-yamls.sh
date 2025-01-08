    #!/bin/bash
    while ! kubectl get nodes; do
      sleep 5
    done
    echo "K3s is ready"

    echo "Deploying Nginx"
    kubectl apply -f /vagrant/confs/app-one.yaml
    kubectl apply -f /vagrant/confs/app-two.yaml
    kubectl apply -f /vagrant/confs/app-three.yaml
    kubectl apply -f /vagrant/confs/ingress.yaml
    echo "Nginx deployed"