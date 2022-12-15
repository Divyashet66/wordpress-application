#!/bin/bash
git_repo=https://github.com/Divyashet66/java-application.git
builder=cnbs/sample-builder:bionic
image_name=java
src_folder_name=java-application/

deployment_metadata_name=java-app
replicas=1
selector_name=java-app
template_label_name=java-app
container_name=java-app
image=gcr.io/tech-rnd-project/java
container_port=8080

kubeContext=gke_tech-rnd-project_us-central1-a_network18-cluster
manifest1=k8/deployment.yaml
manifest2=k8/service.yaml
profile=staging
skaffold_metadata_name=staging-prod-deploy

service_metadata_name=java-app
service_port=8080
service_target_port=8080
type=LoadBalancer
selector_app=java-app

