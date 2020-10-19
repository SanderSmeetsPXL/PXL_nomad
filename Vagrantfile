Vagrant.configure("2") do |config|

  
  config.vm.provision "shell", inline: "hostname"
  config.vm.box = "centos/7"
 

  config.vm.define "server" do |server|
    server.vm.hostname = "server"
    server.vm.network "private_network", ip: "192.168.60.101", virtualbox__intnet: "mynetwork"
    server.vm.provision "shell", path: "scripts/scriptInstall.sh"
    server.vm.provision "shell", path: "scripts/enableNomadServer.sh"
  end
  

  config.vm.define "agent1" do |agent1|
  agent1.vm.hostname = "agent1"
  agent1.vm.network "private_network", ip: "192.168.60.102", virtualbox__intnet: "mynetwork"
  agent1.vm.provision "shell", path:"scripts/scriptInstall.sh"
  agent1.vm.provision "shell", path:"scripts/enableNomadClient1.sh"
  end
  
  config.vm.define "agent2" do |agent2|
  agent2.vm.hostname = "agent2"
  agent2.vm.network "private_network", ip: "192.168.60.103", virtualbox__intnet: "mynetwork"
  agent2.vm.provision "shell", path: "scripts/scriptInstall.sh"
  agent2.vm.provision "shell", path: "scripts/enableNomadClient2.sh"
  end
  
end
