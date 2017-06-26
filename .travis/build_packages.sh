#!/bin/bash

DOCKERFILE_DIR=".travis/dockerfiles/"
PACKAGES_DIR="/packages"
set -ev

cd .travis/dockerfiles

if [ ! -d "$PACKAGES_DIR" ]; then
    sudo mkdir "$PACKAGES_DIR"
fi

for d in * ; do (echo "$d" && cd "$d" && docker build -t serverdensity:"${d}" . && cd ..); done

docker images -a

cd $TRAVIS_BUILD_DIR

for d in .travis/dockerfiles/* ; do (echo "${d#$DOCKERFILE_DIR}" && sudo docker run --volume=/home/travis/build/serverdensity/sd-agent:/sd-agent:rw --volume=/packages:/packages:rw serverdensity:"${d#$DOCKERFILE_DIR}" && ls /packages); done

find /packages


