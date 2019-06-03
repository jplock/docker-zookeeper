FROM openjdk:8-jre-alpine

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=3.5.5

LABEL name="zookeeper" version=$VERSION

RUN apk add --no-cache wget bash \
    && mkdir -p /opt/zookeeper \
    && wget -q -O - $MIRROR/zookeeper/zookeeper-$VERSION/apache-zookeeper-$VERSION-bin.tar.gz \
      | tar -xzC /opt/zookeeper --strip-components=1 \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

# Enable additional four-letter word commands
# see https://zookeeper.apache.org/doc/r3.5.5/zookeeperAdmin.html#sc_clusterOptions
RUN echo "4lw.commands.whitelist=*" >> /opt/zookeeper/conf/zoo.cfg

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

# Only checks if server is up and listening, not quorum. 
# See https://zookeeper.apache.org/doc/r3.5.5/zookeeperAdmin.html#sc_zkCommands
HEALTHCHECK CMD [ $(echo ruok | nc 127.0.0.1:2181) == "imok" ] || exit 1

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
