#!/usr/bin/env bash

export NETWORK=default
export SUBNET_NAME=private-gke-cluster
export MASTER_NETWORK=192.168.42.0/28
export CLUSTER_NAME=auth0-session-jwt
export REGION_NAME=us-east1
export ZONE_NAME=us-east1-b
export GLOO_KEY=<gloo_enterprise_key>
export CLIENT_SECRET=<auth0_client_secret>
