FROM qnib/alplain-openjre8

ARG KAFKA_VER=0.10.0.1
ARG API_VER=2.11
ENV KAFKA_PORT=9092 \
    ZK_SERVERS=zookeeper \
    KAFKA_BROKER_ID=0 \
    ADVERTISED_LISTENERS=kafka_broker \
    INTER_BROKER_PROTOCOL_VERSION=0.10.0-IV1 \
    LOG_MESSAGE_FORMAT_VERSION=0.10.0-IV1
RUN apk --no-cache add curl \
 && curl -fLs http://apache.mirrors.pair.com/kafka/${KAFKA_VER}/kafka_${API_VER}-${KAFKA_VER}.tgz | tar xzf - -C /opt \
 && mv /opt/kafka_${API_VER}-${KAFKA_VER} /opt/kafka/ \
 && apk --no-cache del curl
COPY opt/qnib/entry/20-kafka.sh /opt/qnib/entry/
COPY opt/qnib/kafka/bin/start.sh /opt/qnib/kafka/bin/
COPY opt/qnib/kafka/conf/server.properties /opt/qnib/kafka/conf/
HEALTHCHECK --interval=2s --retries=15 --timeout=1s \
    CMD netstat -plnt |grep 9092
CMD ["/opt/qnib/kafka/bin/start.sh"]
