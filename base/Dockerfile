FROM ubuntu:bionic-20191029

ARG web_port=80
ARG time_zone="Asia/Taipei"

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu bionic main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu bionic-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu bionic-security main universe\n" >> /etc/apt/sources.list

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    tzdata \
    sudo \
    unzip \
    wget \
    jq \
    curl \
    supervisor \
    gnupg2 \
    openssh-server \
    nano \
    iputils-ping \
    net-tools \
    psmisc \
    nginx \
    keepalived \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ ${time_zone}
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

#========================================
# Add normal user with passwordless sudo
#========================================
RUN useradd -ou 0 -g 0 test \
         --shell /bin/bash  \
         --create-home \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'test:123123' | chpasswd
ENV HOME=/home/test

#=======================================
# Create shared / common bin directory
#=======================================
RUN  mkdir -p /opt/bin 


#======================================
# Add script
#======================================
COPY entry_point.sh /opt/bin/
RUN chmod +x /opt/bin/entry_point.sh

#======================================
# Add Supervisor configuration file
#======================================
COPY supervisord.conf /etc
COPY ssh_service.conf /etc/supervisor/conf.d/



#======================================
# Setup ssh login
#======================================
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin  yes /' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


RUN  mkdir -p /var/run/supervisor /var/log/supervisor \
  && chmod -R 777 /var/run/supervisor /var/log/supervisor /etc/passwd \
  && chgrp -R 0 /var/run/supervisor /var/log/supervisor \
  && chmod -R g=u /var/run/supervisor /var/log/supervisor

# ===================================================
# Run the following commands as non-privileged user
# ===================================================


EXPOSE ${web_port}


CMD ["/opt/bin/entry_point.sh"]
