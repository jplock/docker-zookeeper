# DOCKER-VERSION 1.0.1
# VERSION        0.5

FROM debian:9.13

RUN apt-get update && apt-get install -y openjdk-8-jre-headless wget

ARG ZOOKEEPER_VERSION
ENV ZOOKEEPER_VERSION ${ZOOKEEPER_VERSION}
RUN echo "Building etleap/zookeeper ${ZOOKEEPER_VERSION}"

RUN wget -q -O - https://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz | tar -xzf - -C /opt \
    && mv /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

# Make ZooKeeper clean up files regularly
RUN sed -i 's/#autopurge.snapRetainCount=3/autopurge.snapRetainCount=5/' /opt/zookeeper/conf/zoo.cfg \
    && sed -i 's/#autopurge.purgeInterval=1/autopurge.purgeInterval=1/' /opt/zookeeper/conf/zoo.cfg 

# Increase the tick time so we can increase the session timeout to 5 minutes
RUN sed -i 's/tickTime=2000/tickTime=15000/' /opt/zookeeper/conf/zoo.cfg

# ZK cluster shutdown unexpectedly and without a clear reason 
# To try and fix this update the initLimit from 10 (default) to 100
# increasing initLimit to a value that allows the snapshot transfer to complete fixed this problem
# see: https://www.pivotaltracker.com/story/show/182252378/comments/231697522
RUN sed -i 's/initLimit=10/initLimit=100/' /opt/zookeeper/conf/zoo.cfg

# Whitelist this commands
RUN echo "4lw.commands.whitelist=stat, ruok, conf, isro" >> /opt/zookeeper/conf/zoo.cfg

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

COPY docker-entrypoint.sh /opt/zookeeper/

ENTRYPOINT ["/opt/zookeeper/docker-entrypoint.sh"]
CMD ["start-foreground"]
