#!/bin/bash

mkdir -p /tmp/hadoop /tmp/spark-events

case $1 in
  hdfs-master)
    echo "Starting HDFS NameNode"
    $HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive
    $HADOOP_HOME/bin/hdfs namenode
    ;;
  hdfs-worker)
    echo "Starting HDFS DataNode"
    $HADOOP_HOME/bin/hdfs datanode
    ;;
  yarn-master)
    echo "Starting YARN ResourceManager"
    $HADOOP_HOME/bin/yarn resourcemanager
    ;;
  yarn-worker)
    echo "Starting YARN NodeManager"
    $HADOOP_HOME/bin/yarn nodemanager
    ;;
  spark-history)
    echo "Starting Spark History Server"
    $SPARK_HOME/bin/spark-class org.apache.spark.deploy.history.HistoryServer
    ;;
  *)
    exec "$@"
    ;;
esac