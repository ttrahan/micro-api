#!/bin/bash -x

# build images for commit
docker build -t $REGISTRY_ACCOUNT/$APPLICATION/$SERVICE:latest .
