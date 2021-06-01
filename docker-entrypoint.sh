#!/usr/bin/env bash
# Command to start zookeeper (start-foreground)
CMD=$1

# This ZooKeeper node ID, stored in 'myid' file
if [ ! -z "$SERVER_ID" ]
then
  echo "$SERVER_ID" > /tmp/zookeeper/myid
fi

# Comma separated values with the form of 'server.X=host:port:port' 
if [ ! -z "$SERVERS" ]
then
  for server in $(echo $SERVERS | sed "s/,/ /g")
  do 
    echo "$server" >> /opt/zookeeper/conf/zoo.cfg
  done
fi

/opt/zookeeper/bin/zkServer.sh "$CMD"
