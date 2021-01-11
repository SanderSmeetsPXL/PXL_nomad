# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vbguest.auto_update = false
  config.vm.box = "centos/7"
  config.vm.synced_folder "prometheus", "/opt/prometheus", type: "rsync", rsync__chown: false

  config.vm.define :server do |server|
    server.vm.hostname = "server"
    server.vm.network "private_network", ip: "10.0.0.10", virtualbox_intnet:"mynetwork" 
    server.vm.network "forwarded_port", guest: 4646, host: 4646, auto_correct: true, host_ip: "127.0.0.1"
	  server.vm.network "forwarded_port", guest: 8500, host: 8500, auto_correct: true, host_ip: "127.0.0.1"
    server.vm.network "forwarded_port", guest: 9090, host: 9090, auto_correct: true, host_ip: "127.0.0.1"
    server.vm.synced_folder "jobs", "/opt/jobs", type: "rsync", rsync__chown: false
    
    server.vm.provision "ansible_local" do |ansible|
      ansible.config_file = "ansible/ansible.cfg"
      ansible.playbook = "ansible/plays/server.yml"
      ansible.groups = {
        "servers" => ["server"],

      }
      ansible.host_vars = {

      }

    end

 end

  config.vm.define :host1 do |host1|
    host1.vm.hostname = "host1"
    host1.vm.network "private_network", ip: "10.0.0.11", virtualbox_intnet:"mynetwork" 
    host1.vm.provision "ansible_local" do |ansible|
      ansible.config_file = "ansible/ansible.cfg"
      ansible.playbook = "ansible/plays/server.yml"
      ansible.groups = {
        "hosts" => ["host1"]}
    end
  end

  config.vm.define :host2 do |host2|
    host2.vm.hostname = "host2"
    host2.vm.network "private_network", ip: "10.0.0.12",virtualbox_intnet:"mynetwork" 
    host2.vm.provision "ansible_local" do |ansible|
      ansible.config_file = "ansible/ansible.cfg"
      ansible.playbook = "ansible/plays/server.yml"
      ansible.groups = {
        "hosts" => ["host2"]}
    end
  end
    config.vm.define :host3 do |host3|
    host3.vm.hostname = "host3"
    host3.vm.network "private_network", ip: "10.0.0.13",virtualbox_intnet:"mynetwork" 
    host3.vm.provision "ansible_local" do |ansible|
      ansible.config_file = "ansible/ansible.cfg"
      ansible.playbook = "ansible/plays/server.yml"
      ansible.groups = {
        "hosts" => ["host3"]}
    end
  end
end
