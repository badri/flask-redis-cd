#!/bin/sh

mkdir -p /etc/redis
cp /tmp/redis/redis.conf /etc/redis/redis.conf

# The hostname of the pod is injected into each pod as an environment variable by Kubernetes.
POD_NAME=$(hostname)

# Extract the base name and index of the pod. Assumes the format "<statefulset-name>-<index>".
POD_BASE_NAME=$(echo $POD_NAME | sed 's/-[0-9]*$//')
POD_INDEX=$(echo $POD_NAME | sed 's/^.*-//')

# The master's hostname; assumes the first pod in the StatefulSet is the master.
MASTER_POD_NAME="${POD_BASE_NAME}-0.redis"

# The Redis configuration file path.
REDIS_CONF="/etc/redis/redis.conf"

# Check if this pod is the master.
if [ "$POD_INDEX" = "0" ]; then
    echo "Starting as as master..."
else
    echo "Setting up as replica of $MASTER_POD_NAME..."
    echo "replicaof $MASTER_POD_NAME 6379" >> $REDIS_CONF
fi

# Start Redis with the updated configuration.
redis-server $REDIS_CONF
