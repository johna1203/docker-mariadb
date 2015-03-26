FROM johna1203/docker-debian:latest
MAINTAINER Johnathan Froeming <johnathan@kodokux.com>
ENV MARIADB_DB NONE
ENV MARIADB_USER docker
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
RUN echo "deb http://ftp.yz.yamagata-u.ac.jp/pub/dbms/mariadb/repo/10.0/debian wheezy main" > /etc/apt/sources.list.d/mariadb.list
RUN echo "deb-src http://ftp.yz.yamagata-u.ac.jp/pub/dbms/mariadb/repo/10.0/debian wheezy main" >> /etc/apt/sources.list.d/mariadb.list
RUN apt-get update && apt-get install -y mariadb-server
RUN apt-get clean
RUN	echo -n > /var/lib/apt/extended_states

RUN sed -i -e "s/^bind-address/#bind-address/" /etc/mysql/my.cnf && \
	sed -i -e "s/^datadir.*=.*/datadir = \/data/" /etc/mysql/my.cnf && \
	sed -i -e "s/^innodb_buffer_pool_size.*=.*/innodb_buffer_pool_size = 64M/" /etc/mysql/my.cnf
ADD config /config
ADD supervisord.conf /etc/supervisor/conf.d/mariadb.conf
EXPOSE 3306
