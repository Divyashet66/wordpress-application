#!/bin/bash
source template-java/template/config.sh
git clone $git_repo
pid=$!
wait $pid

# pack build $image_name --path $src_folder_name -t $image --builder $builder
# pid=$!
# wait $pid

# docker run -d -p $container_port:$container_port --rm --name $image_name $image_name
# wait $pid

# open "http://localhost:$container_port"
# pid=$!
# wait $pid

# docker push $image
# wait $pid

# cd template-java/template
# wait $pid
# pwd

# skaffold run --profile $profile
# wait $pid

# cd ..
# cd ..
pwd
cp -r template-java/template/k8 template-java/template/skaffold.yaml $src_folder_name
cp -r template-java/template/Jenkinsfile $src_folder_name

cd $src_folder_name
pwd
git branch
git add -A
git status
git commit -m "initial commit"
git push 

