ARG DOCKER_REGISTRY=docker.io
FROM ${DOCKER_REGISTRY}/qnib/alplain-openjre8

ARG KAFKA_VER=0.10.2.1
ARG API_VER=2.12
ARG PROM_JMX_AGENT_VER=0.6
ARG PROM_JMX_AGENT_URL=https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent
ARG PROM_JMX_CONFIG_VER=0-8-2
ENV KAFKA_PORT=9092 \
    JMX_PROM_PORT=7071 \
    ENTRYPOINTS_DIR=/opt/qnib/entry \
    ZK_SERVERS=tasks.zookeeper \
    INTER_BROKER_PROTOCOL_VERSION=0.10.2-IV0 \
    LOG_MESSAGE_FORMAT_VERSION=0.10.2-IV0 \
    KAFKA_ID_OFFSET=0 \
    KAFKA_BROKER_ID=1
RUN apk --no-cache add curl bc wget \
 && curl -fLs http://apache.mirrors.pair.com/kafka/${KAFKA_VER}/kafka_${API_VER}-${KAFKA_VER}.tgz | tar xzf - -C /opt \
 && mv /opt/kafka_${API_VER}-${KAFKA_VER} /opt/kafka/ \
 && mkdir -p /opt/prometheus/jmx \
 && wget -qO /opt/prometheus/jmx/prometheus_javaagent.jar ${PROM_JMX_AGENT_URL}/${PROM_JMX_AGENT_VER}/jmx_prometheus_javaagent-${PROM_JMX_AGENT_VER}.jar \
 && wget -qO /opt/prometheus/jmx/kafka.yml  https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/kafka-${PROM_JMX_CONFIG_VER}.yml \
 && apk --no-cache del curl wget
COPY opt/qnib/entry/20-kafka.sh /opt/qnib/entry/
COPY opt/qnib/kafka/bin/start.sh /opt/qnib/kafka/bin/
COPY opt/qnib/kafka/conf/server.properties /opt/qnib/kafka/conf/
HEALTHCHECK --interval=2s --retries=15 --timeout=1s \
    CMD netstat -plnt |grep 9092
CMD ["/opt/qnib/kafka/bin/start.sh"]
