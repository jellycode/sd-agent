#!/bin/bash
echo -en "travis_fold:start:pbuilder-bootstrap\\r"
chmod +x /root/pbuilder-bootstrap.sh

sh /root/pbuilder-bootstrap.sh
echo -en "travis_fold:end:pbuilder-bootstrap\\r"
echo -en "travis_fold:start:dpkg-source\\r"
dpkg-source -b /sd-agent
echo -en "travis_fold:end:pbuilder-bootstrap\\r"
echo -en "travis_fold:start:dpkg-source\\r"
for arch in amd64 i386; do
    echo -en "travis_fold:start:${arch}\\r"
    if [ ! -d /packages/precise ]; then
        mkdir /packages/precise
    fi
    if [ ! -d /packages/precise/$arch ]; then
        mkdir /packages/precise/$arch
    fi
    pbuilder-dist precise $arch build \
    --buildresult /packages/precise/$arch *.dsc
    echo -en "travis_fold:end:${arch}\\r"
done
