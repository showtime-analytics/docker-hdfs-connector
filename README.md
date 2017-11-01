docker-hdfs-connector
=====================

# What is the HDFS Connector?

[Kafka Connect](https://docs.confluent.io/current/connect/intro.html)  is a framework for scalably and reliably streaming data between Apache Kafka and other data systems. Connect makes it simple to use existing connector implementations for common data sources and sinks to move data into and out of Kafka.

This image contains the binary distribution of the [Confluent Platform](https://www.confluent.io/product/confluent-platform/) and the necessary configurations for using the HDFS-Kafka connector included in it. The purpose of this image is to ease the use of this connector trying to keep image size (and configuration) to a minimum.

# How to use this image

Run this as a executable image

    docker run -t showtimeanalytics/hdfs-connector:latest

Take into account that you'll need a few other services running (at least Kafka, Schema Registry and HDFS) for this to work and you'll need to include a few files/folders, like the hadoop-conf folder, the hive-conf folder (if using the Hive integration) and the kerberos keytab (if using kerberos authentication).

All that is configurable through environment variables (almost everything in the connector should be) and exposed volumes, look at entrypoint.sh to see all the environment variables this image uses and their default values.

Also, as said before, the open source version of the Confluent platform is installed in the image at /opt/docker, so there's nothing stopping you from running any of the other commands and tools included in it.

# Building

Build with the usual

    docker build -t showtimeanalytics/hdfs-connector .


# User Feedback

## Issues

If you have any problems with or questions about this image, please contact us
through a [GitHub issue](https://github.com/showtime-analytics/docker-hdfs-connector/issues).

## Acknowledgments

- [Confluent official image](https://hub.docker.com/r/confluentinc/cp-kafka-connect/) (This image is based on it)
