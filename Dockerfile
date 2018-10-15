FROM alpine:latest

ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 1.1.1
ENV KAFKA_HOME /opt/kafka_$SCALA_VERSION-$KAFKA_VERSION
ENV KAFKA_CONF_DIR /conf
ENV KAFKA_LOG_DIR /logs
ENV PATH=$PATH:$KAFKA_HOME/bin
ENV JMX_PORT 9999

RUN apk add --no-cache openjdk8 curl bash && \
    mkdir -p $KAFKA_HOME && \
    mkdir -p $KAFKA_CONF_DIR && \
    mkdir -p $KAFKA_LOG_DIR && \
    curl http://mirror.cc.columbia.edu/pub/software/apache/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz -o /tmp/kafka.tgz && \
    tar xzf /tmp/kafka.tgz -C /opt && \
    rm -f /tmp/kafka.tgz && \
    cp $KAFKA_HOME/config/server.properties $KAFKA_CONF_DIR/server.properties


VOLUME ["$KAFKA_CONF_DIR", "$KAFKA_LOG_DIR"]

EXPOSE 9092

CMD $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_CONF_DIR/server.properties
