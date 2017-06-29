#!/bin/bash

DOCKERFILE_DIR=".travis/dockerfiles/"
PACKAGES_DIR="/packages"
set -ev
cd .travis/dockerfiles

if [ ! -d "$PACKAGES_DIR" ]; then
    sudo mkdir "$PACKAGES_DIR"
fi
if [ ! -d "$CACHE_DIR" ]; then
    sudo mkdir "$CACHE_DIR"
fi

for d in * ;
do
    echo -en "travis_fold:start:build_${d}_container\\r"
    if [ -f ${CACHE_FILE_${d}} ]; then
        gunzip -c ${CACHE_FILE_${d}} | docker load;
    else
        cd "$d"
        docker build -t serverdensity:"${d}" .
        cd ..
        if [ ! -f ${CACHE_FILE_${d}} ]; then
            docker save serverdensity:${d} | gzip > ${CACHE_FILE_${d}};
        fi
    fi

    echo -en "travis_fold:end:build_${d}_container\\r"
done

for d in * ;
do
    if [[ "$d" == "precise" ]]; then
        echo -en "travis_fold:start:run_${d}_container\\r"
        sudo docker run --volume="${TRAVIS_BUILD_DIR}":/sd-agent:rw --volume=/packages:/packages:rw --privileged serverdensity:"${d}"
        echo -en "travis_fold:end:run_${d}_container\\r"
    else
        echo -en "travis_fold:start:run_${d}_container\\r"
        sudo docker run --volume="${TRAVIS_BUILD_DIR}":/sd-agent:rw --volume=/packages:/packages:rw serverdensity:"${d}"
        echo -en "travis_fold:end:run_${d}_container\\r"
    fi
done

find /packages
