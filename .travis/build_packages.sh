#!/bin/bash
set -ev

cd .travis/dockerfiles

for d in * ; do (echo "$d" && cd "$d" && docker build -t serverdensity:"${d}" . && docker run serverdensity:"${d}"); done

cd $TRAVIS_BUILD_DIR

pwd

docker images -a
