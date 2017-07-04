#!/bin/bash


REPOSITORY_DIR="/archive"
set -ev
if [ -f "$REPOSITORY_DIR"  ]; then
    echo 'Yes, we have cache'
    #curl -H "Authorization: token ${GITHUB_TOKEN}" -H 'Accept: application/vnd.github.v3.raw' -L https://api.github.com/repos/serverdensity/travis-softlayer-object-storage/contents/bootstrap.sh | sed 's|export SLOS_INPUT=${TRAVIS_BUILD_DIR}/build|export SLOS_INPUT=${REPOSITORY_DIR}|g' | /bin/sh
fi
find "$REPOSITORY_DIR"
sudo rm -rf "$REPOSITORY_DIR"
