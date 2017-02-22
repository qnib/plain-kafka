#!/bin/bash


mkdir -p /opt/kafka/config
echo "[II] Write config using: KAFKA_PORT=${KAFKA_PORT}, ZK_SERVERS=${ZK_SERVERS}, KAFKA_BROKER_ID=${KAFKA_BROKER_ID}"
cat /opt/qnib/kafka/conf/server.properties \
   | sed -e "s/KAFKA_PORT/${KAFKA_PORT}/" \
         -e "s/ZK_SERVERS/${ZK_SERVERS}/" \
         -e "s/KAFKA_BROKER_ID/${KAFKA_BROKER_ID}/" \
         -e "s/HOSTNAME/${HOSTNAME}/" \
   > /opt/kafka/config/server.properties
