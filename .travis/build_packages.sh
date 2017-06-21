#!/bin/bash
set -ev

cd $TRAVIS_BUILD_DIR

pwd
ls -alh

cd .travis/dockerfiles

sudo mkdir /packages

for d in * ; do (echo "$d" && cd "$d" && docker build -t serverdensity:"${d}" . && docker run serverdensity:"${d}" -v /packages:/packages -v "$TRAVIS_BUILD_DIR":/sd-agent); done

find /packages

cd $TRAVIS_BUILD_DIR

pwd

docker images -a
