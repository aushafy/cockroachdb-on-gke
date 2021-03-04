# Create single kubernetes cluster with Google Kubernetes Engine
gcloud container clusters create cockroachdb --machine-type n1-standard-4 --zone asia-southeast1-a --num-nodes 3

# Run gcloud info command to get your email
gcloud info | grep Account

# create cluster role binding to give cockroachDB access to our cluster
kubectl create clusterrolebinding $USER-cluster-role-binding --clusterrole=cluster-admin --user=aushafy.setyawan@infracom-tech.com

# apply Custom Resource Definition (CRD) for the cockroachDB operator
kubectl apply -f crdbcustomresourcedefinition.yaml

# apply operator manifest
kubectl apply -f crdboperator.yaml

# validate the operator is running
kubectl get pods

# configure cockroachDB cluster
more example.yaml

# apply the cockroachDB cluster configuration
kubectl apply -f example.yaml

# validate the cockroachDB cluster deployment
kubectl get statefulset

kubectl get service

kubectl get pv

# use built in SQL client 
kubectl exec -it cockroachdb-2 -- ./cockroach sql --certs-dir cockroach-certs

CREATE DATABASE bank;
CREATE TABLE bank.accounts (id INT PRIMARY KEY, balance DECIMAL);
INSERT INTO bank.accounts VALUES (1, 1000.50);
SELECT * FROM bank.accounts;
CREATE USER aushafy WITH PASSWORD 'aushafy123';
GRANT admin TO aushafy;
\q

# expose the cockroachDB cluster VIP Load Balancer
kubectl edit svc/cockroachdb-public

# access the external IP
kubectl get svc