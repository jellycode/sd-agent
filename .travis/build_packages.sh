#!/bin/bash
set -ev

pwd
ls -alh
ls -alh
cd .travis/dockerfiles
for D in *; do
    if [ -d "${D}" ]; then
        docker build "${D}"/Dockerfile -t serverdensity:${D}  # your processing here
        docker run
    fi
done
docker images -a
