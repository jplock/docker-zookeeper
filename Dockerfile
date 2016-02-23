FROM gliderlabs/alpine:3.3
MAINTAINER Justin Plock <justin@plock.net>

LABEL name="zookeeper" version="3.4.8"

RUN apk-install openjdk7-jre wget bash
RUN mkdir /opt \
    && wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.8 /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-1.7-openjdk

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
