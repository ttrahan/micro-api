#!/bin/bash -x

# build images when tagged or marked as releases

if [[ "$GIT_TAG_NAME" == *beta* ]]; then
  echo "beta build processing..."
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/beta:$GIT_TAG_NAME .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/beta:$GIT_TAG_NAME
elif [[ "$GIT_TAG_NAME" == *test* ]]; then
  echo "test build processing..."
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/test:$GIT_TAG_NAME .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/test:$GIT_TAG_NAME
elif [[ "$GIT_TAG_NAME" == *prod* ]]; then
  echo "prod build processing..."
  docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/prod:$GIT_TAG_NAME .
  docker push $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE/prod:$GIT_TAG_NAME
fi
