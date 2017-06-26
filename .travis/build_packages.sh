#!/bin/bash

DOCKERFILE_DIR=".travis/dockerfiles/"
PACKAGES_DIR="/packages"
set -ev

cd .travis/dockerfiles

if [ ! -d "$PACKAGES_DIR" ]; then
    sudo mkdir "$PACKAGES_DIR"
fi

for d in * ; do (echo -en 'travis_fold:start:build_${d}_container\\r' && cd "$d" && docker build -t serverdensity:"${d}" . && cd .. && echo -en 'travis_fold:end:build_${d}_container\\r'); done

docker images -a

cd $TRAVIS_BUILD_DIR

for d in .travis/dockerfiles/* ; do (echo -en 'travis_fold:start:run_${d#$DOCKERFILE_DIR}_container\\r' && sudo docker run --volume=/home/travis/build/serverdensity/sd-agent:/sd-agent:rw --volume=/packages:/packages:rw serverdensity:"${d#$DOCKERFILE_DIR}" && ls /packages && echo -en 'travis_fold:start:run_${d#$DOCKERFILE_DIR}_container\\r'); done

find /packages


