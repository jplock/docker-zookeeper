#!/bin/bash

source .env

echo "Building etleap/zookeeper ${ZOOKEEPER_VERSION}"

docker build -t etleap/zookeeper:${ZOOKEEPER_VERSION} .

docker tag etleap/zookeeper:${ZOOKEEPER_VERSION} 841591717599.dkr.ecr.us-east-1.amazonaws.com/zookeeper:${ZOOKEEPER_VERSION}
docker push 841591717599.dkr.ecr.us-east-1.amazonaws.com/zookeeper:${ZOOKEEPER_VERSION}
