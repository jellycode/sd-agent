#!/bin/bash -xe
cat > $HOME/.rpmmacros << EOF_MACROS
%_topdir /root/el
%_tmppath %{_topdir}/tmp
%_signature gpg
%_gpg_name hello@serverdensity.com
%_gpg_path ~/.gnupg
EOF_MACROS
pwd
if [ ! -d /root/el ]; then
    mkdir /root/el
fi
cd /root/el
for dir in SOURCES BUILD RPMS SRPMS tmp; do
    [ -d $dir ] || mkdir $dir
done
sd_agent_version=$(awk -F'"' '/^AGENT_VERSION/ {print $2}' /sd-agent/config.py)
tar -czf /root/el/SOURCES/sd-agent-${sd_agent_version}.tar.gz /sd-agent
cp -a /sd-agent/packaging/el/{SPECS,inc,description} /root/el
cd /root/el
chown -R `id -u`:`id -g` /root/el
function build {
    rpmdir=/root/build/result/$1
    yum-builddep -y SPECS/sd-agent-$1.spec
    rpmbuild -ba SPECS/sd-agent-$1.spec && \
    (test -d $rpmdir || mkdir -p $rpmdir) && cp -a /root/el/RPMS/* $rpmdir
}
echo -en 'travis_fold:start:build_rhel6\\r'
build "el6"
echo -en 'travis_fold:end:build_rhel6\\r'
if [ ! -d /packages/el6 ]; then
    mkdir /packages/el6
fi

if [ ! -d /packages/el6/src ]; then
    mkdir /packages/el6/src
fi
cp -r /root/el/RPMS/* /packages/el6
cp -r /root/el/SRPMS/* /packages/el6/src
