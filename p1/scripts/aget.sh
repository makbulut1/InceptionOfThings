      MASTER_IP="192.168.56.110"
      export K3S_TOKEN=$(cat /vagrant/confs/worker-token.env)

      echo $K3S_TOKEN

      export K3S_URL="https://$MASTER_IP:6443"
      curl -sfL https://get.k3s.io | sh -