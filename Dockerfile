FROM        debian:8

MAINTAINER WikiToLearn

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update
RUN apt-get -y --force-yes install iptables && rm -f /var/cache/apt/archives/*deb
RUN apt-get -y --force-yes install net-tools && rm -f /var/cache/apt/archives/*deb
RUN apt-get -y --force-yes install netcat-openbsd && rm -f /var/cache/apt/archives/*deb
RUN apt-get clean

ADD ./run.sh /run.sh
RUN chmod +x /run.sh

CMD ["./run.sh"]
