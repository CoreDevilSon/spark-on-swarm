FROM openjdk:8-jdk-slim

ENV SPARK_VERSION=3.4.1
ENV HADOOP_VERSION=3.3.4
ENV SPARK_HOME=/opt/spark
ENV HADOOP_HOME=/opt/hadoop
ENV JAVA_HOME=/usr/local/openjdk-8
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

RUN apt-get update && apt-get install -y wget procps && rm -rf /var/lib/apt/lists/*

# Download and install Spark with Hadoop
RUN wget -q https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop3.tgz && \
    tar -xzf spark-$SPARK_VERSION-bin-hadoop3.tgz && \
    mv spark-$SPARK_VERSION-bin-hadoop3 $SPARK_HOME && \
    rm spark-$SPARK_VERSION-bin-hadoop3.tgz

# Download and install Hadoop
RUN wget -q https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
    tar -xzf hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION $HADOOP_HOME && \
    rm hadoop-$HADOOP_VERSION.tar.gz

COPY configs/ $HADOOP_HOME/etc/hadoop/
COPY configs/spark-defaults.conf $SPARK_HOME/conf/
COPY scripts/start-service.sh /start-service.sh

RUN chmod +x /start-service.sh

EXPOSE 7077 8080 8081 8088 8042 9870 9000

ENTRYPOINT ["/start-service.sh"]