#!/bin/bash

DOCKERFILE_DIR=".travis/dockerfiles/"
PACKAGES_DIR="/packages"
set -ev
cd .travis/dockerfiles

if [ ! -d "$PACKAGES_DIR" ]; then
    sudo mkdir "$PACKAGES_DIR"
fi

for d in * ;
do
    echo -en "travis_fold:start:build_${d}_container\\r" \
    && cd "$d" \
    && docker build -t serverdensity:"${d}" . \
    && cd .. \
    && echo -en "travis_fold:end:build_${d}_container\\r"
done

for d in .travis/dockerfiles/* ;
do
    PRIVILEGED=""
    if [[ "$d" == "precise" ]]; then
        PRIVILEGED="--privileged"
    fi
    echo -en "travis_fold:start:run_${d}_container\\r" \
    && sudo docker run --volume="${TRAVIS_BUILD_DIR}":/sd-agent:rw --volume=/packages:/packages:rw "${PRIVILEGED}" serverdensity:"${d}" \
    && ls /packages \
    && echo -en "travis_fold:end:run_${d}_container\\r"
done

find /packages
