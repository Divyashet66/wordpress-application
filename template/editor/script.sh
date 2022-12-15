#!/bin/bash
source java-template/template/config.sh
yq e '.spec.template.spec.containers[0].image="'$image'"' -i java-template/template/k8/deployment.yaml 
yq e '.metadata.name="'$deployment_metadata_name'"' -i java-template/template/k8/deployment.yaml
yq e '.spec.replicas='$replicas'' -i java-template/template/k8/deployment.yaml 
yq e '.spec.selector.matchLabels.app="'$selector_name'"' -i java-template/template/k8/deployment.yaml
yq e '.spec.template.metadata.labels.app="'$template_label_name'"' -i java-template/template/k8/deployment.yaml
yq e '.spec.template.spec.containers[0].name="'$container_name'"' -i java-template/template/k8/deployment.yaml
yq e '.spec.template.spec.containers[0].ports[0].containerPort='$container_port'' -i java-template/template/k8/deployment.yaml

yq e '.profiles[0].deploy.kubeContext="'$kubeContext'"' -i java-template/template/skaffold.yaml
yq e '.profiles[0].deploy.kubectl.manifests[0]="'$manifest1'"' -i java-template/template/skaffold.yaml
yq e '.profiles[0].deploy.kubectl.manifests[1]="'$manifest2'"' -i java-template/template/skaffold.yaml
yq e '.profiles[0].name="'$profile'"' -i java-template/template/skaffold.yaml
yq e '.metadata.name="'$skaffold_metadata_name'"' -i java-template/template/skaffold.yaml

yq e '.metadata.name="'$service_metadata_name'"' -i java-template/template/k8/service.yaml
yq e '.spec.ports[0].port='$service_port'' -i java-template/template/k8/service.yaml
yq e '.spec.ports[0].targetPort='$service_target_port'' -i java-template/template/k8/service.yaml
yq e '.spec.type="'$type'"' -i java-template/template/k8/service.yaml
yq e '.spec.selector.app="'$selector_app'"' -i java-template/template/k8/service.yaml 