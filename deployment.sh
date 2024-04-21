#!/bin/bash

# Load the variables from the .env file
source .env

DOCKER_USERNAME=$(echo $DOCKER_USERNAME | tr -d '\r') # Remove carriage return character if present. Can cause the script to fail.
IMAGE_NAME="modul-347"
TAG="v1.0"
REGISTRY_URL="docker.io"

# Build the Docker image
docker build -t $IMAGE_NAME .

# Log in to Docker
echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

# Check if the login was successful
if [ $? -eq 0 ]; then
    # Tag the Docker image with the full repository path
    docker tag $IMAGE_NAME $DOCKER_USERNAME/$IMAGE_NAME:$TAG

    # Push the Docker image to the registry
    docker push $DOCKER_USERNAME/$IMAGE_NAME:$TAG
else
    echo "Failed to login to Docker registry."
fi
