FROM centos:7

# required to resolve tty error on Centos
RUN myuser=$(whoami) && \
  echo '$myuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  echo "Defaults:$myuser "'!requiretty' >> /etc/sudoers && \
  cat /etc/sudoers

# dependencies required for Shippable build engine
RUN yum update && \
yum -y install \
  git \
  python \
  openssh \
  sudo \
  epel-release

# dependency to install Node JS on Centos using yum
RUN yum -y install epel-release

# dependencies required for Node JS application
RUN yum -y install \
  nodejs \
  npm && \
node --version

# this folder must be created in the base images
ADD . /root/micro-api/

#now run set up
RUN /bin/bash /root/micro-api/setup.sh

ENTRYPOINT ["/root/micro-api/boot.sh"]
