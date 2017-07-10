#!/bin/bash

PACKAGES_DIR="/packages"
REPOSITORY_DIR="/archive"
set -ev

if [ ! -d "$CACHE_DIR" ]; then
    sudo mkdir "$CACHE_DIR"
fi

if [ ! -d "$REPOSITORY_DIR" ]; then
    sudo mkdir "$REPOSITORY_DIR"
fi

if [ -f "$CACHE_FILE_PACAKGES_LINUX"  ]; then
    tar -zxvf "$CACHE_FILE_PACAKGES_LINUX" -C "$REPOSITORY_DIR"
fi

if [ -f "$CACHE_FILE_PACAKGES_MAC"  ]; then
    tar -zxvf "$CACHE_FILE_PACAKGES_MAC" -C "$REPOSITORY_DIR"
fi

find "$REPOSITORY_DIR"

#curl -H "Authorization: token ${GITHUB_TOKEN}" -H 'Accept: application/vnd.github.v3.raw' -L https://api.github.com/repos/serverdensity/travis-softlayer-object-storage/contents/bootstrap-generic.sh | sed 's|export SLOS_INPUT=${TRAVIS_BUILD_DIR}|export SLOS_INPUT=${REPOSITORY_DIR}|g' | sed 's:export SLOS_NAME=`echo "${TRAVIS_REPO_SLUG}" | cut -f 2 -d /`:export SLOS_NAME=agent-repo:g' | /bin/sh
