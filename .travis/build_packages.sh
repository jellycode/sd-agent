#!/bin/bash
set -ev

pwd
ls -alh
cd .travis/dockerfiles
for D in *; do
    if [ -d "${D}" ]; then
        echo "${D}"
        cd "${D}"
        pwd
        docker build -t serverdensity:"${D}" .
        docker run serverdensity:"${D}"
    fi
done
docker images -a
