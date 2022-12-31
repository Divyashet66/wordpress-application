docker build -t gcr.io/tech-rnd-project/wp-app .
docker push gcr.io/tech-rnd-project/wp-app
skaffold dev
