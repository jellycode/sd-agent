#!/bin/bash -xe
echo -en "travis_fold:start:create_folders\\r"
cat > $HOME/.rpmmacros << EOF_MACROS
%_topdir /root/el
%_tmppath %{_topdir}/tmp
%_signature gpg
%_gpg_name hello@serverdensity.com
%_gpg_path ~/.gnupg
EOF_MACROS
mkdir /root/el
cd /root/el
for dir in SOURCES BUILD RPMS SRPMS; do
    [ -d $dir ] || mkdir $dir
done
echo -en "travis_fold:end:create_folders\\r"
echo -en "travis_fold:start:check_agent_version\\r"
sd_agent_version=$(awk -F'"' '/^AGENT_VERSION/ {print $2}' /sd-agent/config.py)
echo -en "travis_fold:end:check_agent_version\\r"
echo -en "travis_fold:start:unpack_agent\\r"
tar -czf /root/el/SOURCES/sd-agent-${sd_agent_version}.tar.gz /sd-agent
cp -a /sd-agent/packaging/el/{SPECS,inc,description} /root/el
cd /root/el
chown -R `id -u`:`id -g` /root/el
echo -en 'travis_fold:end:unpack_agent\\r'
echo -en 'travis_fold:start:build_rhel7\\r'
function build {
    rpmdir=/root/build/result/$1
    yum-builddep -y SPECS/sd-agent-$1.spec
    rpmbuild -ba SPECS/sd-agent-$1.spec && \
    (test -d $rpmdir || mkdir -p $rpmdir) && cp -a /root/el/RPMS/* $rpmdir
}
echo -en 'travis_fold:end:build_rhel7\\r'
echo -en 'travis_fold:start:copy_packages\\r'
build "el7"
if [ ! -d /packages/el ]; then
    mkdir /packages/el
fi

if [ ! -d /packages/el/7 ]; then
    mkdir /packages/el/7
fi

if [ ! -d /packages/src ]; then
    mkdir /packages/src
fi
cp -r /root/el/RPMS/* /packages/el/7
cp -r /root/el/SRPMS/* /packages/src
echo -en 'travis_fold:end:copy_packages\\r'
