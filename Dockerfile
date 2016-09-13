FROM centos:7

RUN yum update && \
yum install --no-cache bash \
  git \
  python \
  openssh \
  sudo

# this folder must be created in the base images
ADD . /root/micro-api/

#now run set up
RUN /bin/bash /root/micro-api/setup.sh

ENTRYPOINT ["/root/micro-api/boot.sh"]
