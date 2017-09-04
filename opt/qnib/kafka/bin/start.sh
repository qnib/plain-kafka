#!/bin/bash
PROMETHEUS_ENABLE=${PROMETHEUS_ENABLE:-false}
JMX_ENABLE=${JMX_ENABLE:-false}
JMX_PORT=${JMX_PORT:-1234}
PROMETHEUS_PORT=${PROMETHEUS_PORT:-7071}
if [[ ${PROMETHEUS_ENABLE} == "true" ]];then
  JMX_ENABLE=true
fi
if [[ ${JMX_ENABLE} == "true" ]];then
  export EXTRA_ARGS="${EXTRA_ARGS} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
  export EXTRA_ARGS="${EXTRA_ARGS} -Dcom.sun.management.jmxremote.port=${JMX_PORT}"
fi
if [[ ${PROMETHEUS_ENABLE} == "true" ]];then
  export EXTRA_ARGS="${EXTRA_ARGS} -javaagent:/opt/prometheus/jmx/prometheus_javaagent.jar=${PROMETHEUS_PORT}:/opt/prometheus/jmx/kafka.yml"""
fi

/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
