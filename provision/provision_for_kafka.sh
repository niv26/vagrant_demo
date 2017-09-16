#!/bin/bash

#Variables
#-----------------------------------#

cd ~

#Install kafka
#-----------------------------------#
curl http://apache.mivzakim.net/kafka/0.11.0.0/kafka_2.11-0.11.0.0.tgz -o ./kafka_2.11-0.11.0.0.tgz
tar zxf kafka_2.11-0.11.0.0.tgz.tgz
cd kafka_2.11-0.11.0.0
nohup bin/zookeeper-server-start.sh config/zookeeper.properties &
nohup bin/kafka-server-start.sh config/server.properties &




