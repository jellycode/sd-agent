#!/bin/bash
set -ev

git clone https://github.com/serverdensity/sd-agent.git
cd sd-agent/.travis/dockerfiles
for D in *; do
    if [ -d "${D}" ]; then
        docker build "${D}"/Dockerfile -t serverdensity:${D}  # your processing here
    fi
done
docker ps -a
