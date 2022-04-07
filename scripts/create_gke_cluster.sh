#!/usr/bin/env bash

gcloud config set compute/zone "$ZONE_NAME"

gcloud container clusters create "$CLUSTER_NAME" \
    --create-subnetwork name="$SUBNET_NAME" \
    --no-enable-master-authorized-networks \
    --enable-ip-alias \
    --enable-private-nodes \
    --enable-autoprovisioning \
    --min-cpu 1 \
    --max-cpu 3 \
    --min-memory 1 \
    --max-memory 3 \
    --autoprovisioning-scopes=https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring,https://www.googleapis.com/auth/devstorage.read_only \
    --master-ipv4-cidr "$MASTER_NETWORK" \
    --no-enable-basic-auth \
    --no-issue-client-certificate

P_ID=$(gcloud config get-value project)
export PROJECT_ID="$P_ID"

gcloud container clusters get-credentials "$CLUSTER_NAME" --zone "$ZONE_NAME" --project "$PROJECT_ID"

kubectl create clusterrolebinding cluster-admin-binding \
--clusterrole cluster-admin \
--user "$(gcloud config get-value account)"

glooctl install gateway enterprise --with-gloo-fed false --license-key "$GLOO_KEY"

echo "Check the cluster and see if everything is running properly"

echo ""

echo "Removing Unnecessary Deployments"
kubectl delete deployments.apps -n gloo-system gloo-fed
kubectl delete deployments.apps -n gloo-system gloo-fed-console
kubectl delete deployments.apps -n gloo-system glooe-grafana
kubectl delete deployments.apps -n gloo-system glooe-prometheus-kube-state-metrics
kubectl delete deployments.apps -n gloo-system glooe-prometheus-server

echo ""

echo "Add this to your /etc/hosts (without the port)"
echo "$(glooctl proxy address) client-fetch.glootest.com"
echo "$(glooctl proxy address) api.glootest.com"
