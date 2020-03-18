#!/bin/sh

VERSION=1.5.5

if [ -z "${dockerRepo:=}" ]; then # If 'dockerRepo' is unset
  echo "'dockerRepo' variable is not set, doing nothing"
else
  # dockerRepo variable has some value
  docker build \
      --build-arg MOSQUITTO_VERSION=${VERSION} \
      -t ${dockerRepo}/arielev/mosquitto:${VERSION} .
  if [ -z "${push:=}" ]; then # If 'push' is unset
    echo "build does not contain push variable, skipping docker push";
  else
    echo "push variable is set, pushing image to ${dockerRepo}";
    # Only jenkins should push images
    docker push ${dockerRepo}/arielev/mosquitto:${VERSION}
  fi
fi
