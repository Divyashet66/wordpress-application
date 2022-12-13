#!/bin/bash
source template-java/template/config.sh
yq e '.spec.template.spec.containers[0].image="'$image'"' -i template-java/template/k8/deployment.yaml 
yq e '.metadata.name="'$deployment_metadata_name'"' -i template-java/template/k8/deployment.yaml
yq e '.spec.replicas='$replicas'' -i template-java/template/k8/deployment.yaml 
yq e '.spec.selector.matchLabels.app="'$selector_name'"' -i template-java/template/k8/deployment.yaml
yq e '.spec.template.metadata.labels.app="'$template_label_name'"' -i template-java/template/k8/deployment.yaml
yq e '.spec.template.spec.containers[0].name="'$container_name'"' -i template-java/template/k8/deployment.yaml
yq e '.spec.template.spec.containers[0].ports[0].containerPort='$container_port'' -i template-java/template/k8/deployment.yaml

yq e '.profiles[0].deploy.kubeContext="'$kubeContext'"' -i template-java/template/skaffold.yaml
yq e '.profiles[0].deploy.kubectl.manifests[0]="'$manifest1'"' -i template-java/template/skaffold.yaml
yq e '.profiles[0].deploy.kubectl.manifests[1]="'$manifest2'"' -i template-java/template/skaffold.yaml
yq e '.profiles[0].name="'$profile'"' -i template-java/template/skaffold.yaml
yq e '.metadata.name="'$skaffold_metadata_name'"' -i template-java/template/skaffold.yaml

yq e '.metadata.name="'$service_metadata_name'"' -i template-java/template/k8/service.yaml
yq e '.spec.ports[0].port='$service_port'' -i template-java/template/k8/service.yaml
yq e '.spec.ports[0].targetPort='$service_target_port'' -i template-java/template/k8/service.yaml
yq e '.spec.type="'$type'"' -i template-java/template/k8/service.yaml
yq e '.spec.selector.app="'$selector_app'"' -i template-java/template/k8/service.yaml 