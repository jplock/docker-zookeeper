#!/bin/bash

source .env

docker build --build-arg ZOOKEEPER_VERSION=${ZOOKEEPER_VERSION} -t etleap/zookeeper:${ZOOKEEPER_VERSION} .

docker tag etleap/zookeeper:${ZOOKEEPER_VERSION} 841591717599.dkr.ecr.us-east-1.amazonaws.com/zookeeper:${ZOOKEEPER_VERSION}
docker push 841591717599.dkr.ecr.us-east-1.amazonaws.com/zookeeper:${ZOOKEEPER_VERSION}
