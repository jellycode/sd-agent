#!/bin/bash
set -ev

git clone https://github.com/serverdensity/sd-agent.git
ls -alh
cd sd-agent/
ls -alh
cd .travis/dockerfiles
for D in *; do
    if [ -d "${D}" ]; then
        docker build "${D}"/Dockerfile -t serverdensity:${D}  # your processing here
    fi
done
docker ps -a
