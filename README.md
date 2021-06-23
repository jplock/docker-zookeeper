docker-zookeeper
================

Custom docker image for Zookeeper.
To build and publish use `publish.sh`

```
docker build -t etleap/zookeeper:3.5.5 .
```

Push image to ECR

```
docker tag etleap/zookeeper:3.5.5 841591717599.dkr.ecr.us-east-1.amazonaws.com/zookeeper:3.5.5
docker push 841591717599.dkr.ecr.us-east-1.amazonaws.com/zookeeper:3.5.5
```
