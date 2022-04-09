# build
docker-compose -f docker-compose.dev.yml up --build
# run
docker run python-docker-dev:latest
# build image
docker build --tag python-docker-dev . --rm
# prune images
docker image prune -a
# build with key
docker build --build-arg SSH_PRIVATE_KEY="$(cat ks2_deploy)" -t python-test .
