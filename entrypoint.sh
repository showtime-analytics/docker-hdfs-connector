#! /bin/bash -eu

set -o pipefail

export KAFKA_HOST=${KAFKA_HOST:="localhost"}
export KAFKA_PORT=${KAFKA_PORT:="9092"}
export KAFKA_SERVICE=${KAFKA_SERVICE:="$KAFKA_HOST:$KAFKA_PORT"}

export SCHEMA_REGISTRY_HOST=${SCHEMA_REGISTRY_HOST:="localhost"}
export SCHEMA_REGISTRY_PORT=${SCHEMA_REGISTRY_PORT:="8081"}
export SCHEMA_REGISTRY_SERVICE=${SCHEMA_REGISTRY_SERVICE:="http://$SCHEMA_REGISTRY_HOST:$SCHEMA_REGISTRY_PORT"}

export SERVICE_NAME=${SERVICE_NAME:="hdfs-connector"}
export TASKS=${TASKS:="1"}
export TOPICS=${TOPICS:="test"}
export HDFS_SERVICE=${HDFS_SERVICE:="hdfs://nameservice1"}
export HDFS_PATH=${HDFS_PATH:="/data"}
export HDFS_LOGS_PATH=${HDFS_LOGS_PATH:="/logs"}

export HIVE_INTEGRATION=${HIVE_INTEGRATION:="false"}
export HIVE_HOST=${HIVE_HOST:="localhost:9083"}
export HIVE_SERVICE=${HIVE_SERVICE:="thrift://$HIVE_HOST"}
export HIVE_DATABASE=${HIVE_DATABASE:="database"}

export SCHEMA_COMPAT=${SCHEMA_COMPAT:="BACKWARD"}
export SCHEMA_CACHE=${SCHEMA_CACHE:=1000}

export KERBEROS_AUTH=${KERBEROS_AUTH:="false"}
export KERBEROS_PRINCIPAL=${KERBEROS_PRINCIPAL:="principal@EXAMPLE.COM"}
export KERBEROS_KEYTAB=${KERBEROS_KEYTAB:="/opt/docker/auth/"}
export KERBEROS_HDFS_PRINCIPAL=${KERBEROS_HDFS_PRINCIPAL:="hdfs/nameservice1@EXAMPLE.COM"}
export KERBEROS_TICKET_RENEW=${KERBEROS_TICKET_RENEW:="3600000"}

export FLUSH_SIZE=${FLUSH_SIZE:="1000"}
export ROTATE_INTERVAL=${ROTATE_INTERVAL:="-1"}
export ROTATE_SCHEDULE_INTERVAL=${ROTATE_SCHEDULE_INTERVAL:="60000"}
export RETRY_BACKOFF=${RETRY_BACKOFF:="10000"}
export SHUTDOWN_TIMEOUT=${SHUTDOWN_TIMEOUT:="3000"}
export PARTITIONER=${PARTITIONER:="io.confluent.connect.hdfs.partitioner.TimeBasedPartitioner"}
export PARTITION_FIELD=${PARTITION_FIELD:="id"}
export PARTITION_DURATION=${PARTITION_DURATION:="60000"}
export PARTITION_FORMAT=${PARTITION_FORMAT:="YYYY/MM/dd/HH/"}
export LOCALE=${LOCALE:="en"}
export TIMEZONE=${TIMEZONE:="UTC"}
export FILENAME_ZERO_PAD=${FILENAME_ZERO_PAD:="10"}

envsubst < /opt/docker/conf/connect-avro.template > /opt/docker/conf/connect-avro.properties
envsubst < /opt/docker/conf/hdfs-sink.template > /opt/docker/conf/hdfs-sink.properties

exec "$@"
