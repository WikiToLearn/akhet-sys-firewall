FROM debian:8

MAINTAINER wikitolearn sysadmin@wikitolearn.org
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

ADD ./sources.list /etc/apt/sources.list

RUN apt-get update && apt-get -y --force-yes install iptables && rm -f /var/cache/apt/archives/*deb && find /var/lib/apt/lists/ -type f -delete && find /var/log/ -type f -delete
RUN apt-get update && apt-get -y --force-yes install net-tools && rm -f /var/cache/apt/archives/*deb && find /var/lib/apt/lists/ -type f -delete && find /var/log/ -type f -delete
RUN apt-get update && apt-get -y --force-yes install netcat-openbsd && rm -f /var/cache/apt/archives/*deb && find /var/lib/apt/lists/ -type f -delete && find /var/log/ -type f -delete

ADD ./run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
