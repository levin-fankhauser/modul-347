#!/bin/bash

DOCKER_USERNAME="levinfankhauser"
DOCKER_PASSWORD="password"

IMAGE_NAME="modul-347"
TAG="v1.0"

docker build -t $IMAGE_NAME .

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker tag $IMAGE_NAME $DOCKER_USERNAME/$IMAGE_NAME:$TAG
docker push $DOCKER_USERNAME/$IMAGE_NAME:$TAG
