#!/usr/bin/env bash

#echo "Creating httpbin services"
#kubectl delete -f k8s/k8-service-api.yaml -f k8s/k8-service-client-fetch.yaml

echo "deleting virtual services"
glooctl delete virtualservice client-fetch-auth0-vs
glooctl delete virtualservice httpbin-auth0-vs


echo "Recreating gloo entities"
kubectl apply \
    -f ./gloo/gloo-vs-api.yaml \
    -f ./gloo/gloo-vs-client-fetch.yaml

glooctl check

glooctl get vs
