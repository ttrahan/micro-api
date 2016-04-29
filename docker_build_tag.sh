#!/bin/bash -x

# push beta images

if [[ "$GIT_TAG_NAME" == *beta* ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/beta:$GIT_TAG_NAME .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$GIT_TAG_NAME
elif [[ "$GIT_TAG_NAME" == *test* ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/test:$GIT_TAG_NAME .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$GIT_TAG_NAME
elif [[ "$GIT_TAG_NAME" == *prod* ]]; then
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/prod:$GIT_TAG_NAME .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:$GIT_TAG_NAME
fi
