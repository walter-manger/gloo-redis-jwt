#!/usr/bin/env bash

echo "Creating Auth0 Client Secret"
glooctl create secret oauth --namespace gloo-system --name auth0-client-secret --client-secret "$CLIENT_SECRET"

echo "Creating httpbin services"
kubectl apply -f k8s/k8-service-api.yaml -f k8s/k8-service-client-fetch.yaml

echo "Creating tls secret"
kubectl create secret tls upstream-tls \
    --key certificate/tls.key \
    --cert certificate/tls.crt \
    --namespace gloo-system

echo "Creating gloo entities"
kubectl apply \
    -f gloo/gloo-upstream-jwks.yaml \
    -f gloo/gloo-auth-config-api.yaml \
    -f gloo/gloo-vs-api.yaml \
    -f gloo/gloo-vs-client-fetch.yaml
