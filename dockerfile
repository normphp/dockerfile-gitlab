FROM debian:10.9
MAINTAINER pizepei "pizepei@pizepei.com"
SHELL ["/bin/sh", "-c"],
ENV LANG=C.UTF-8
# http://ftp.jp.debian.org/debian/pool/main/g/gcc-8/libatomic1_8.3.0-6_arm64.deb
COPY libatomic1_8.3.0-6_arm64.deb libatomic1_8.3.0-6_arm64.deb
# Expose web & ssh
EXPOSE 443 80 22
RUN echo 'deb http://ftp.de.debian.org/debian buster main' >>/etc/apt/sources.list \
&& apt-get update &&  apt-get upgrade  \
&&  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      sudo git \
      curl \
      ca-certificates \
      openssh-server \
      wget \
      vim \
      tzdata \
      nano gnupg \
      less -y
# COPY gitlab-ce_13.10.2-ce.0_arm64.deb gitlab-ce_13.10.2-ce.0_arm64.deb
# RUN  sudo dpkg -i  gitlab-ce_13.10.2-ce.0_arm64.deb
RUN  dpkg -i  libatomic1_8.3.0-6_arm64.deb
RUN apt-get install libatomic1 -y
RUN sudo curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash \
&& sudo apt install  gitlab-ce -y \
&& rm -rf /var/lib/apt/lists/*
# && sudo gitlab-ctl reconfigure
# HEALTHCHECK --interval=60s --timeout=30s --retries=5 \
# CMD /opt/gitlab/bin/gitlab-healthcheck --fail --max-time 10
