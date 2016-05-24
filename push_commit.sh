#!/bin/bash -x

# build and push images for commit
docker tag $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:latest \
$REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$BRANCH.$BUILD_NUMBER

docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$BRANCH.$BUILD_NUMBER

# build additional image for Docker Hub

docker tag $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:latest \
ttrahan/$SERVICE:$BRANCH.$BUILD_NUMBER

docker push ttrahan/$SERVICE:$BRANCH.$BUILD_NUMBER
