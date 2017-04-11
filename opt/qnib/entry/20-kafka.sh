#!/bin/bash
set -x

if [[ -z ${KAFKA_BROKER_ID} ]] && [[ -n ${SWARM_TASK_ID} ]];then
    KAFKA_BROKER_ID=$(echo ${SWARM_TASK_ID}-1 | bc)
else
    KAFKA_BROKER_ID=0
fi

if [[ -z ${ADVERTISED_LISTENERS} ]];then
    ADVERTISED_LISTENERS=${HOSTNAME}:${KAFKA_PORT}
fi

mkdir -p /opt/kafka/config
echo "[II] Write config using: KAFKA_PORT=${KAFKA_PORT}, ZK_SERVERS=${ZK_SERVERS}, KAFKA_BROKER_ID=${KAFKA_BROKER_ID}"
cat /opt/qnib/kafka/conf/server.properties \
   | sed -e "s/KAFKA_PORT/${KAFKA_PORT}/" \
         -e "s/ZK_SERVERS/${ZK_SERVERS}/" \
         -e "s/KAFKA_BROKER_ID/${KAFKA_BROKER_ID}/" \
         -e "s/ADVERTISED_LISTENERS/${ADVERTISED_LISTENERS}/" \
   > /opt/kafka/config/server.properties
