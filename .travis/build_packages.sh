#!/bin/bash

DOCKERFILE_DIR=".travis/dockerfiles/"
PACKAGES_DIR="/packages"
set -ev

cd .travis/dockerfiles

if [ ! -d "$PACKAGES_DIR" ]; then
    sudo mkdir "$PACKAGES_DIR"
fi

echo -en "travis_fold:start:deb_packaging\\r"
apt-get update && apt-get install -y pbuilder debootstrap devscripts ubuntu-dev-tools qemu qemu-user-static && mkdir /root/agent-pkg-debian
for arch in amd64 i386 armel armhf;
do
    pbuilder-dist precise $arch create;
done
sh /root/pbuilder-bootstrap.sh
dpkg-source -b /build/src/sd-agent
for arch in amd64 i386 armel armhf; do
    pbuilder-dist precise $arch build \
    --buildresult "$PACKAGES_DIR"/ubuntu/pool/main/s/sd-agent/ *.dsc
done

find /packages
echo -en "travis_fold:end:deb_packaging\\r"


echo -en "travis_fold:start:rpm_packaging\\r"
for d in * ; do (echo -en "travis_fold:start:build_${d}_container\\r" && cd "$d" && docker build -t serverdensity:"${d}" . && cd .. && echo -en "travis_fold:end:build_${d}_container\\r"); done

cd $TRAVIS_BUILD_DIR

for d in .travis/dockerfiles/* ; do (echo -en "travis_fold:start:run_${d#$DOCKERFILE_DIR}_container\\r" && sudo docker run --volume=/home/travis/build/serverdensity/sd-agent:/sd-agent:rw --volume=/packages:/packages:rw serverdensity:"${d#$DOCKERFILE_DIR}" && ls /packages && echo -en "travis_fold:end:run_${d#$DOCKERFILE_DIR}_container\\r"); done

find /packages
echo -en "travis_fold:end:rpm_packaging\\r"

