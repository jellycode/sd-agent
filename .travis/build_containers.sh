#!/bin/bash
set -ev
cd .travis/dockerfiles
if [ ! -d "$CACHE_DIR" ]; then
    sudo mkdir "$CACHE_DIR"
fi

for d in * ;
do
    echo -en "travis_fold:start:build_${d}_container\\r"
    TEMP="\${CACHE_FILE_${d}}"
    DOCKER_CACHE=$(eval echo "$TEMP")
    if [ -f "$DOCKER_CACHE"  ]; then
        gunzip -c "$DOCKER_CACHE" | docker load;
    else
        cd "$d"
        docker build -t serverdensity:"${d}" .
        cd ..
        if [ ! -f "$DOCKER_CACHE"  ]; then
            docker save serverdensity:${d} | gzip > "$DOCKER_CACHE";
        fi
    fi

    echo -en "travis_fold:end:build_${d}_container\\r"
done
