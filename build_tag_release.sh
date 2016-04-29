#!/bin/bash -x

# build beta images for GitHub tags
if [[ "$GIT_TAG_NAME" == *beta* ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$GIT_TAG_NAME.beta .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$GIT_TAG_NAME.beta

elif [[ "$GIT_TAG_NAME" == *test* ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$GIT_TAG_NAME.test .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$GIT_TAG_NAME.test

elif [[ "$GIT_TAG_NAME" == *prod* ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$GIT_TAG_NAME.prod .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/:$GIT_TAG_NAME.prod
fi

# build images for GitHub releases
if [["$IS_RELEASE" == true ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/$RELEASE_NAME .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/$RELEASE_NAME
fi
