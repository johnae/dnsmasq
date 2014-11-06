FROM ubuntu:14.04
MAINTAINER John Axel Eriksson <john@insane.se>

RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty main' | tee /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty main' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates main' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates main' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty universe' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty universe' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates universe' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates universe' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb http://security.ubuntu.com/ubuntu trusty-security main' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://security.ubuntu.com/ubuntu trusty-security main' | tee -a /etc/apt/sources.list
RUN echo 'deb http://security.ubuntu.com/ubuntu trusty-security universe' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://security.ubuntu.com/ubuntu trusty-security universe' | tee -a /etc/apt/sources.list
RUN echo 'deb http://security.ubuntu.com/ubuntu trusty-security multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://security.ubuntu.com/ubuntu trusty-security multiverse' | tee -a /etc/apt/sources.list

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get update &&\
    apt-get upgrade -y -q &&\
    apt-get dist-upgrade -y -q &&\
    apt-get -y -q autoclean &&\
    apt-get -y -q autoremove &&\
    apt-get install --force-yes -y -q dnsmasq dnsutils &&\
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    apt-get clean

ADD start /start
ADD set_host /usr/local/bin/set_host

EXPOSE 53

VOLUME ["/etc/dnsmasq.d"]

CMD ["/start"]
