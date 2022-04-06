#!/usr/bin/env bash

gcloud config set compute/zone "$ZONE_NAME"

gcloud container clusters create "$CLUSTER_NAME" \
    --create-subnetwork name="$SUBNET_NAME" \
    --no-enable-master-authorized-networks \
    --enable-ip-alias \
    --enable-private-nodes \
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
