FROM qnib/alplain-jre8

ARG KAFKA_VER=0.10.0.1
ARG API_VER=2.11
ENV KAFKA_PORT=9092 \
    ZK_SERVERS=zookeeper \
    KAFKA_BROKER_ID=0
RUN apk --no-cache add curl \
 && curl -fLs http://apache.mirrors.pair.com/kafka/${KAFKA_VER}/kafka_${API_VER}-${KAFKA_VER}.tgz | tar xzf - -C /opt \
 && mv /opt/kafka_${API_VER}-${KAFKA_VER} /opt/kafka/ \
 && apk --no-cache del curl
COPY opt/qnib/entry/20-kafka.sh /opt/qnib/entry/
COPY opt/qnib/kafka/bin/start.sh /opt/qnib/kafka/bin/
COPY opt/qnib/kafka/conf/server.properties /opt/qnib/kafka/conf/
