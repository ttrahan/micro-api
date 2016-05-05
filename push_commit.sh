#!/bin/bash -x

# build images for commit
docker tag $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:latest \
$REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$BRANCH.$BUILD_NUMBER

docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$BRANCH.$BUILD_NUMBER