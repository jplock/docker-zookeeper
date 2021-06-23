#!/bin/bash

ZOOKEEPER_VERSION=3.5.5

docker build -t etleap/zookeeper:${ZOOKEEPER_VERSION} .

docker tag etleap/zookeeper:${ZOOKEEPER_VERSION} 841591717599.dkr.ecr.us-east-1.amazonaws.com/zookeeper:${ZOOKEEPER_VERSION}
docker push 841591717599.dkr.ecr.us-east-1.amazonaws.com/zookeeper:${ZOOKEEPER_VERSION}
