.PHONY: help

help:
	@echo "Run some commands"
	@echo "Remember to source env.sh!"

cluster:
	@echo "Running Cluster Commands"
	./scripts/create_gke_cluster.sh

entities:
	@echo "Running Gloo Commands"
	./scripts/create_gloo_entities.sh

recreate:
	@echo "Recreating gloo entities"
	./scripts/recreate_gloo_entities.sh

resecure:
	@echo "Recreating gloo entities"
	kubectl apply -f ./gloo/gloo-entities-no-extauth.yaml
	kubectl apply \
		-f gloo/gloo-vs-api.yaml \
		-f gloo/gloo-vs-client-fetch.yaml

destroy:
	@echo "Destroying Cluster '$(CLUSTER_NAME)'"
	gcloud container clusters delete $(CLUSTER_NAME)
