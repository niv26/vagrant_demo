# -*- mode: ruby -*-
# vi: set ft=ruby :

elkRam = 2048
prestoRam = 1024
postgresRam = 512


#$elk_script = <<SCRIPT
##!/bin/bash
#yum install curl -y
#SCRIPT

$hosts_script = <<SCRIPT
cat > /etc/hosts <<EOF
127.0.0.1       localhost
10.10.10.100   elk
10.10.10.101   presto
10.10.10.102   pg

EOF
SCRIPT

Vagrant.configure("2") do |config|

  # Define base image
  config.vm.box = "bento/centos-7.2"
  #config.vm.box = "centos/7"

  # Manage /etc/hosts on host and VMs
  config.hostmanager.enabled = false
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = true
  config.hostmanager.ignore_private_ip = false

  config.vm.define :elk do |elk|
    elk.vm.provider :virtualbox do |v|
      v.name = "vm-demo-elk"
      v.customize ["modifyvm", :id, "--memory", "#{elkRam}" ]
    end
    elk.vm.network :private_network, ip: "10.10.10.100"
    elk.vm.network "forwarded_port", guest: 9200, host: 9200, guest_ip: "10.10.10.100",host_ip: "127.0.0.1", id: 'elasticsearch'
    elk.vm.network "forwarded_port", guest: 5601, host: 5601, guest_ip: "10.10.10.100", host_ip: "127.0.0.1", id: 'kibana'
    elk.vm.hostname = "vm-demo-elk"
    elk.vm.provision :shell, :inline => $hosts_script
    elk.vm.provision :shell, :path => "provision_for_elk.sh"
  end
#
#  config.vm.define :presto do |presto|
#    presto.vm.provider :virtualbox do |v|
#      v.name = "vm-demo-presto"
#      v.customize ["modifyvm", :id, "--memory", "#{prestoRam}" ]
#    end
#    presto.vm.network :private_network, ip: "10.10.10.101"
#    presto.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1", id: 'presto'
#    presto.vm.hostname = "vm-demo-presto"
#    presto.vm.provision :shell, :inline => $hosts_script
#    presto.vm.provision :shell, :path => "provision_for_presto.sh"
#
#  end

  config.vm.define :postgres do |postgres|
    postgres.vm.provider :virtualbox do |v|
      v.name = "vm-demo-postgres"
      v.customize ["modifyvm", :id, "--memory", "#{postgresRam}"]
    end
    postgres.vm.network :private_network, ip: "10.10.10.102"
    postgres.vm.network "forwarded_port", guest: 5432, host: 5432, host_ip: "127.0.0.1", id: 'postgres'
    postgres.vm.hostname = "vm-demo-postgres"
    postgres.vm.provision :shell, :inline => $hosts_script
    postgres.vm.provision :shell, :path => "provision_for_postgres.sh"

  end

end