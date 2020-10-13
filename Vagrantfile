Vagrant.configure("2") do |config|

  
  config.vm.provision "shell", inline: "hostname"
  config.vm.box = "centos/7"
 

  config.vm.define "server" do |server|
    server.vm.hostname = "server"
    server.vm.network "private_network", ip: "192.168.60.101"
    server.vm.provision "shell", path: "scripts/scriptInstall.sh"
    server.vm.provision "shell", inline: <<-SHELL
    echo create webserver job...
    sudo nomad job plan /vagrant/webserver-job/webserver.nomad
    sudo nomad job run /vagrant/webserver-job/webserver.nomad
    SHELL
  end
  

  config.vm.define "agent1" do |agent1|
  agent1.vm.hostname = "agent1"
  agent1.vm.network "private_network", ip: "192.168.60.102"
  agent1.vm.provision "shell", path:"scripts/scriptInstall.sh"

  end
  
  config.vm.define "agent2" do |agent2|
  agent2.vm.hostname = "agent2"
  agent2.vm.network "private_network", ip: "192.168.60.103"
  agent2.vm.provision "shell", path: "scripts/scriptInstall.sh"
  
  end
  
end
