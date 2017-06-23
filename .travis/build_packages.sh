#!/bin/bash
set -ev

cd .travis/dockerfiles

sudo mkdir /packages

for d in * ; do (echo "$d" && cd "$d" && docker build -t serverdensity:"${d}" . && cd ..); done

cd $TRAVIS_BUILD_DIR
OS=~/build/$TRAVIS_REPO_SLUG
chmod -R a+w $OS
dockerfile_dir=".travis/dockerfiles/"

for d in .travis/dockerfiles/* ; do (echo "${d#$dockerfile_dir}" && sudo docker run serverdensity:"${d#$dockerfile_dir}" -v /packages:/packages -v /home/travis/build/serverdensity/sd-agent:/sd-agent:rw); done

find /packages

cd $TRAVIS_BUILD_DIR

pwd

docker images -a
