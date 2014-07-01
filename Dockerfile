# DOCKER-VERSION 1.0.1
# VERSION        0.5

FROM debian:jessie
MAINTAINER Justin Plock <justin@plock.net>

RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt
RUN cp /opt/zookeeper-3.4.6/conf/zoo_sample.cfg /opt/zookeeper-3.4.6/conf/zoo.cfg

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888

ENTRYPOINT ["/opt/zookeeper-3.4.6/bin/zkServer.sh"]
CMD ["start-foreground"]
