#!/bin/bash
set -ev

cd .travis/dockerfiles

sudo mkdir /packages

for d in * ; do (echo "$d" && cd "$d" && docker build -t serverdensity:"${d}" . && cd ..); done

cd $TRAVIS_BUILD_DIR

dockerfile_dir=".travis/dockerfiles/"

for d in .travis/dockerfiles/* ; do (echo "${d#$dockerfile_dir}" &&  docker run serverdensity:"${d#$dockerfile_dir}" -v /packages:/packages -v "${pwd}":/sd-agent:rw); done

find /packages

cd $TRAVIS_BUILD_DIR

pwd

docker images -a
