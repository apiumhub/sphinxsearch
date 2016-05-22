#!/usr/bin/env bash
set -e
set -x
IMAGE=$1
docker pull $IMAGE:$TAG
. version.properties
docker tag $IMAGE:$TAG $IMAGE:$IMAGE_VERSION
docker push $IMAGE:$IMAGE_VERSION
docker rmi $IMAGE:$IMAGE_VERSION
docker rmi $IMAGE:$TAG