#!/bin/bash
set -ev

ls -alh
cd sd-agent/
ls -alh
cd sd-agent/.travis/dockerfiles
for D in *; do
    if [ -d "${D}" ]; then
        docker build "${D}"/Dockerfile -t serverdensity:${D}  # your processing here
    fi
done
docker ps -a
