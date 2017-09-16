#!/bin/bash

#Variables
#-----------------------------------#
PRESTO_VERSION='0.180'
PRESTO_HOME="/root/presto-server-$PRESTO_VERSION/"

# Install java 8 (shoudl be oracle, but openjdk is good enough for the demo)
#-----------------------------------#
yum install java-1.8.0-openjdk.x86_64 -y

#Presto
#-----------------------------------#
#Download and extract presto server
curl https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.180/presto-server-0.180.tar.gz -o presto-server-0.180.tar.gz
tar -zxvf presto-server-0.180.tar.gz

#create folder stracture
mkdir -p $PRESTO_HOME/etc
mkdir -p $PRESTO_HOME/etc/catalog
mkdir -p $PRESTO_HOME/data

#Configure presto
cd $PRESTO_HOME

cat > etc/node.properties <<EOF
node.environment=demo
node.id=ffffffff-ffff-ffff-ffff-fffffffffff1
node.data-dir=PRESTO_HOME/data
EOF

cat > etc/jvm.config <<EOF
-server
-Xmx1G
-XX:+UseG1GC
-XX:G1HeapRegionSize=32M
-XX:+UseGCOverheadLimit
-XX:+ExplicitGCInvokesConcurrent
-XX:+HeapDumpOnOutOfMemoryError
-XX:+ExitOnOutOfMemoryError
EOF

cat > etc/config.properties <<EOF
coordinator=true
node-scheduler.include-coordinator=true
http-server.http.port=8080
query.max-memory=512MB
query.max-memory-per-node=128MB
discovery-server.enabled=false
discovery.uri=http://example.net:8080
EOF

cat > etc/log.properties <<EOF
com.facebook.presto=INFO
EOF

cat > etc/catalog/jmx.properties <<EOF
connector.name=jmx
EOF

#Run presto 
bin/launcher start

