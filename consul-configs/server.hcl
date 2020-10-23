server = true
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
client_addr = "{{ GetInterfaceIP \"eth1\" }}"
bootstrap_expect = 1
data_dir = "/tmp/consul"

