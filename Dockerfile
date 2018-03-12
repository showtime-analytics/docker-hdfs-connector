FROM showtimeanalytics/alpine-java:8u131b11_jdk_unlimited
MAINTAINER Miguel Alonso <miguel@showtimeanalytics.com>

LABEL confluent.version="4.0.0" \
      description="Kafka Connect is a framework for scalably and reliably streaming data between Apache Kafka and other data systems." \
      maintainer="Miguel Alonso <miguel@showtimeanalytics.com>"

ARG S6_OVERLAY_VERSION=v1.19.1.1
ARG S6_OVERLAY_URL=https://github.com/just-containers/s6-overlay/releases/download

ARG CONFD_VERSION=0.14.0
ARG CONFD_URL=https://github.com/kelseyhightower/confd/releases/download

ARG CONFLUENT_VERSION=4.0
ARG CONFLUENT_VERSION_MINOR=0
ARG CONFLUENT_BASE_URL=http://packages.confluent.io/archive/${CONFLUENT_VERSION}

ENV CONFD_HOME=/opt/confd
ENV SERVICE_HOME=/opt/docker

RUN set -ex \
 && apk --update add curl gettext su-exec \
 && echo  "====> Install s6 overlay" \
 && curl -sL ${S6_OVERLAY_URL}/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz \
    | tar -zx -C / \
 \
 && echo "===> Download confd and install" \
 && mkdir -p "${CONFD_HOME}/bin" \
 && curl -fsSL -o ${CONFD_HOME}/bin/confd ${CONFD_URL}/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64  \
 && chmod +x ${CONFD_HOME}/bin/confd \
 \
 && echo "===> Install confluent platform" \
 && mkdir -p /opt/docker/offsets /opt/docker/auth \
 && curl -fsSL -o /tmp/confluent.tar.gz ${CONFLUENT_BASE_URL}/confluent-oss-${CONFLUENT_VERSION}.${CONFLUENT_VERSION_MINOR}-2.11.tar.gz \
 && tar -xzf /tmp/confluent.tar.gz -C /opt/docker --strip-components=1 \
 && ln -s /opt/docker/bin/connect-standalone /usr/bin/connect-standalone \
 && mkdir -p /opt/docker/conf/hadoop-conf /opt/docker/conf/hive-conf \
 \
 && echo "===> Add group, user and grant permissions" \
 && chmod +x ${SERVICE_HOME}/bin/* \
 \
 && echo "===> Cleanup" \
 && rm -f /tmp/confluent.tar.gz \
 && rm -r /var/cache/apk/*

EXPOSE 9092

VOLUME /opt/docker/offsets
VOLUME /opt/docker/auth
VOLUME /opt/docker/conf/hive-conf
VOLUME /opt/docker/conf/hadoop-conf

WORKDIR ${SERVICE_HOME}

COPY root /
ENTRYPOINT ["/init"]

#CMD ["./bin/connect-standalone", "/opt/docker/conf/connect-avro.properties", "/opt/docker/conf/hdfs-sink.properties"]
