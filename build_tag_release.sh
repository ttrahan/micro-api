#!/bin/bash -x

# build images when tagged or marked as releases

if [[ "$GIT_TAG_NAME" == *beta* ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/beta:$GIT_TAG_NAME .
  if [["$IS_RELEASE" == true ]]; then
    docker tag $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/beta:$RELEASE_NAME
    docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/beta:$RELEASE_NAME
  fi
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/beta:$GIT_TAG_NAME
elif [[ "$GIT_TAG_NAME" == *test* ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/test:$GIT_TAG_NAME .
  if [["$IS_RELEASE" == true ]]; then
    docker tag $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/test:$RELEASE_NAME
    docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/test:$RELEASE_NAME
  fi
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/test:$GIT_TAG_NAME
elif [[ "$GIT_TAG_NAME" == *prod* ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/prod:$GIT_TAG_NAME .
  if [["$IS_RELEASE" == true ]]; then
    docker tag $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/prod:$RELEASE_NAME
    docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/prod:$RELEASE_NAME
  fi
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/prod:$GIT_TAG_NAME
fi
