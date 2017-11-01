FROM showtimeanalytics/alpine-java:8u131b11_jdk_unlimited

MAINTAINER Miguel Alonso <miguel@showtimeanalytics.com>

LABEL confluent.version="3.3.0" \
      description="Kafka Connect is a framework for scalably and reliably streaming data between Apache Kafka and other data systems." \
      maintainer="Miguel Alonso <miguel@showtimeanalytics.com>"
ARG CONFLUENT_VERSION=3.3
ARG CONFLUENT_VERSION_MINOR=0
ARG BASE_URL=http://packages.confluent.io/archive/${CONFLUENT_VERSION}

COPY conf /tmp/conf

RUN set -ex \
 && apk --update add curl gettext \
 && mkdir -p /opt/docker/offsets /opt/docker/auth \
 && curl -fsSL -o /tmp/confluent.tar.gz ${BASE_URL}/confluent-oss-${CONFLUENT_VERSION}.${CONFLUENT_VERSION_MINOR}-2.11.tar.gz \
 && tar -xzf /tmp/confluent.tar.gz -C /opt/docker --strip-components=1 \
 && ln -s /opt/docker/bin/connect-standalone /usr/bin/connect-standalone \
 && mv /tmp/conf /opt/docker/conf \
 && mkdir -p /opt/docker/conf/hadoop-conf /opt/docker/conf/hive-conf \
 && apk del curl \
 && rm -f /tmp/confluent.tar.gz \
 && rm -r /var/cache/apk/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /opt/docker

VOLUME /opt/docker/offsets
VOLUME /opt/docker/auth
VOLUME /opt/docker/conf/hive-conf
VOLUME /opt/docker/conf/hadoop-conf

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["./bin/connect-standalone", "/opt/docker/conf/connect-avro.properties", "/opt/docker/conf/hdfs-sink.properties"]
