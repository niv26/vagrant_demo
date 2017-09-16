#!/bin/bash
#Variables
#-----------------------------------#
ELASTIC_PORT='9200'
ELASTIC_IP='10.10.10.100'
ELASTIC_CONF='/etc/elasticsearch/'
ELASTIC_VERSION='5.5.0'

KIBANA_PORT='5601'
KIBANA_IP='10.10.10.100'
KIBANA_CONF='/etc/kibana/'
KIBANA_VERSION='5.5.0'

cd ~

# Install java 8 (shoudl be oracle, but openjdk is good enough for the demo)
#-----------------------------------#
yum install java-1.8.0-openjdk.x86_64 -y

# ELASTIC
#-----------------------------------#
# Download and install elasticsearch
echo 'Downloading elasticsearch'
curl https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.0.rpm -o elasticsearch.rpm
echo 'Installing elasticsearch'
sudo rpm -Uvh elasticsearch.rpm
# Set elastic configuration
cat /dev/null  > $ELASTIC_CONF/elasticsearch.yml
echo "cluster.name: elk-test" >> $ELASTIC_CONF/elasticsearch.yml
echo "node.name: node-1" >> $ELASTIC_CONF/elasticsearch.yml
echo "network.host: $ELASTIC_IP" >> $ELASTIC_CONF/elasticsearch.yml
echo "http.port: $ELASTIC_PORT" >> $ELASTIC_CONF/elasticsearch.yml
# start & enable on start
systemctl start elasticsearch.service
systemctl enable elasticsearch.service
#clean up 
rm -f elasticsearch.rpm

#KIBANA
#-----------------------------------#
#Download and install kibana
echo 'Downloading Kibana'
curl https://artifacts.elastic.co/downloads/kibana/kibana-5.5.0-x86_64.rpm -o kibana.rpm
echo 'Installing Kibana'
rpm -Uvh kibana.rpm
# Set kibana configuration
cat /dev/null  > $KIBANA_CONF/kibana.yml
echo "server.port: $KIBANA_PORT" >> $KIBANA_CONF/kibana.yml
echo "server.host: $KIBANA_IP" >> $KIBANA_CONF/kibana.yml
echo 'server.name: "elk-test"' >> $KIBANA_CONF/kibana.yml
echo "elasticsearch.url: http://$ELASTIC_IP:$ELASTIC_PORT" >> $KIBANA_CONF/kibana.yml
# start & enable on start
sudo systemctl start kibana.service
sudo systemctl enable kibana.service
#clean up 
rm -f kibana.rpm


#LOGSTASH
#-----------------------------------#
#Download and install logstash
echo 'Downloading Logstash'
curl https://artifacts.elastic.co/downloads/logstash/logstash-5.5.0.rpm -o logstash.rpm
echo 'Installing Logstash'
rpm -Uvh logstash.rpm
#clean up
rm -f logstash.rpm


#Refresh 
systemctl restart kibana.service
