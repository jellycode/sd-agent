#!/bin/bash
set -ev

pwd
ls -alh
ls -alh
cd .travis/dockerfiles
for D in *; do
    if [ -d "${D}" ]; then
        echo "${D}"
        docker build "${D}"/Dockerfile -t serverdensity:"${D}"
        docker run serverdensity:"${D}"
    fi
done
docker images -a
