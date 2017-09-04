#!/bin/bash
set -x

sed -i'' -e "s/JMX_PORT/${JMX_PORT}/" /opt/prometheus/jmx/kafka.yml
