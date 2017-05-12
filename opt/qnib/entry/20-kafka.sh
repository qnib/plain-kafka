#!/bin/bash

KAFKA_ID_OFFSET=${KAFKA_ID_OFFSET:-0}

if [[ "${KAFKA_ID_OFFSET}" != 0 ]];then
    echo "> Adjust KAFKA_BROKER_ID: ${KAFKA_BROKER_ID} by offset ${KAFKA_ID_OFFSET}"
    KAFKA_BROKER_ID=$(echo ${KAFKA_BROKER_ID} + ${KAFKA_ID_OFFSET} |bc)
fi

mkdir -p /opt/kafka/config
echo "[II] Write config using: KAFKA_PORT=${KAFKA_PORT}, ZK_SERVERS=${ZK_SERVERS}, KAFKA_BROKER_ID=${KAFKA_BROKER_ID}, INTER_BROKER_PROTOCOL_VERSION=${INTER_BROKER_PROTOCOL_VERSION}, LOG_MESSAGE_FORMAT_VERSION=${LOG_MESSAGE_FORMAT_VERSION}"
cat /opt/qnib/kafka/conf/server.properties \
   | sed -e "s/KAFKA_PORT/${KAFKA_PORT}/" \
         -e "s/ZK_SERVERS/${ZK_SERVERS}/" \
         -e "s/KAFKA_BROKER_ID/${KAFKA_BROKER_ID}/" \
         -e "s/INTER_BROKER_PROTOCOL_VERSION/${INTER_BROKER_PROTOCOL_VERSION}/" \
         -e "s/LOG_MESSAGE_FORMAT_VERSION/${LOG_MESSAGE_FORMAT_VERSION}/" \
> /opt/kafka/config/server.properties
