FROM centos:7

RUN yum update && \
yum -y install \
  git \
  python \
  openssh \
  sudo \
  epel-release \
  nodejs \
  npm && \
node --version

# this folder must be created in the base images
ADD . /root/micro-api/

#now run set up
RUN /bin/bash /root/micro-api/setup.sh

ENTRYPOINT ["/root/micro-api/boot.sh"]
