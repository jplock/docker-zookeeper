# DOCKER-VERSION 0.5.3
# VERSION        0.2

FROM ubuntu
MAINTAINER Justin Plock <jplock@gmail.com>

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y -q openjdk-7-jre-headless
ADD ./zookeeper-3.4.5 /opt/zookeeper-3.4.5
RUN cp /opt/zookeeper-3.4.5/conf/zoo_sample.cfg /opt/zookeeper-3.4.5/conf/zoo.cfg

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181

CMD ["/opt/zookeeper-3.4.5/bin/zkServer.sh", "start-foreground"]
