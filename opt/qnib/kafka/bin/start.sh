#!/bin/bash
export EXTRA_ARGS="$EXTRA_ARGS -javaagent:/opt/prometheus/jmx/prometheus_javaagent.jar=${JMX_PROM_PORT}:/opt/prometheus/jmx/kafka.yml"

/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
