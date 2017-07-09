#!/bin/bash



rpm -Uvh https://yum.postgresql.org/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum install -y postgresql96-server postgresql96 
/usr/pgsql-9.6/bin/postgresql96-setup initdb
systemctl start postgresql-9.6
systemctl enable postgresql-9.6


cd ~

curl https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.5.0-x86_64.rpm -o metricbeat.rpm
rpm -Uvh metricbeat.rpm
rm -f metricbeat.rpm

curl https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-5.5.0-x86_64.rpm -o packetbeat.rpm
rpm -Uvh packetbeat.rpm
rm -f packetbeat.rpm

