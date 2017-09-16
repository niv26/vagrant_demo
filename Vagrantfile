# -*- mode: ruby -*-
# vi: set ft=ruby :

# -------------- Config -------------- #
elk_ram = 2048
agent_ram = 512
# -------------- inline scripts -------------- #

$hosts_script = <<SCRIPT
cat > /etc/hosts <<EOF
127.0.0.1       localhost
10.10.10.100   elk
10.10.10.101   agent
EOF
SCRIPT

# -------------- Vagrant -------------- #

Vagrant.configure("2") do |config|

  # Define base image
  config.vm.box = "bento/centos-7.2"
  #config.vm.box = "centos/7"

 
  config.vm.define :elk do |elk|
    elk.vm.provider :virtualbox do |v|
      v.name = "vm-elk"
      v.customize ["modifyvm", :id, "--memory", "#{elk_ram}" ]
    end
    elk.vm.network :private_network, ip: "10.10.10.100"
    elk.vm.network "forwarded_port", guest: 9200, host: 9200, guest_ip: "10.10.10.100",host_ip: "127.0.0.1", id: 'elasticsearch'
    elk.vm.network "forwarded_port", guest: 5601, host: 5601, guest_ip: "10.10.10.100", host_ip: "127.0.0.1", id: 'kibana'
    elk.vm.hostname = "elk-server"
    elk.vm.provision :shell, :inline => $hosts_script
    elk.vm.provision :shell, :path => "provision/provision_for_elk.sh"
  end

  config.vm.define :agent do |agent|
    agent.vm.provider :virtualbox do |v|
      v.name = "vm-agent"
      v.customize ["modifyvm", :id, "--memory", "#{agent_ram}" ]
    end
    agent.vm.network :private_network, ip: "10.10.10.101"
    agent.vm.hostname = "vm-agent"
    agent.vm.provision :shell, :inline => $hosts_script

  end
end