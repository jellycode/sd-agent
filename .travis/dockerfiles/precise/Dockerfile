FROM ubuntu:precise
WORKDIR /root
RUN apt-get update && apt-get install -y pbuilder debootstrap devscripts ubuntu-dev-tools qemu qemu-user-static binfmt-support sbuild qemu-block-extra qemu-system-arm qemu-system-common qemu-utils sharutils
RUN echo 'for arch in amd64 i386 armel armhf; do pbuilder-dist precise $arch create; done' > /root/pbuilder-bootstrap.sh
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
