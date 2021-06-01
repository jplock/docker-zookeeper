# DOCKER-VERSION 1.0.1
# VERSION        0.5

FROM debian:jessie
MAINTAINER Justin Plock <justin@plock.net>

RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.14 /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

# Make ZooKeeper clean up files regularly
RUN sed -i 's/#autopurge.snapRetainCount=3/autopurge.snapRetainCount=100/' /opt/zookeeper/conf/zoo.cfg \
    && sed -i 's/#autopurge.purgeInterval=1/autopurge.purgeInterval=1/' /opt/zookeeper/conf/zoo.cfg

# Increase the tick time so we can increase the session timeout to 5 minutes
RUN sed -i 's/tickTime=2000/tickTime=15000/' /opt/zookeeper/conf/zoo.cfg

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

COPY docker-entrypoint.sh /opt/zookeeper/

ENTRYPOINT ["/opt/zookeeper/docker-entrypoint.sh"]
CMD ["start-foreground"]
