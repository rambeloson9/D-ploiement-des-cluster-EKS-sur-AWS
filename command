$ export AWS_ACCES_KEY_ID=

$ export AWS_SECRET_ACCES_KEY=

$ export AWS_DEFAULT_REGION= us-east-1

$ sudo apt update

$ sudo apt install -y unzip

# Après, on va télécharger l'utilitaire eksctl

$ curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

$ sudo mv /tmp/eksctl /usr/local/bin

$ eksctl

# on install la CLI d'AWS

$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

$ unzip awscliv2.zip

$ sudo ./aws/install

# Ensuite, on va installer kubectl

$ curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/

$ sudo chmod +x ./kubectl

$ sudo mv ./kubectl/usr/local/bin

# Création de cluster

$ eksctl create cluster --name=tasarov --ssh-acces --ssh-public-key training --nodes=1 --nodes-max 5 --asg-access

# Test

$ kubectl get nodes

++++++++***********++++++++++++++++
# Récuperation des commandes eksctl...

$ eksctl utils write-kubeconfig --name=tasarov --kubeconfig=$HOME/tasarov

# Pour utuliser à nouveau, il faut exporter

$ export KUBECONFIG=$HOME/tasarov

++++++++++++++++**************++++++++

# On va utiliser un utilitaire d'auto completion bash

$ sudo echo ' source <(kubectl completion bash)' >> ${HOME}/.bashrc && source ${HOME}/.bashrc

# Ensuite, on va proceder à l'installation de l'application
#** Mais avant, on doit créer un namespace

$ kubectl create namespace my-namespace

# Création du fichier yaml simple-service

$ vi sample-service.yaml

$ kubectl apply -f sample-service.yaml

$ kubectl get all -n my-namespace

# Récuperation de nom de POD

$ POD=$(kubectl get -n my-namespace pod -l app=my-app -o jsonpath="{.item[0].metadata.name}")

# Execution (entrer à l'interieur) du POD

$ kubectl -n my-namespace exec -it $POD -n my-namespace -- /bin/bash

# Pour pouvoir joindre un service

$ cat /etc/hosts

$ curl my-service.my-namespace.svc.cluster.local

# Pour la suppression d'un cluster

$ eksctl delete cluster --name=tasarov
