#!/bin/bash -xe
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
pwd
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
build "el7"
