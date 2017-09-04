#!/bin/bash

echo ">> ${EXTRA_ARGS}"

/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
