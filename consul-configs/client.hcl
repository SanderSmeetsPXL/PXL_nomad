bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
data_dir = "/tmp/consul"
retry_join = ["192.168.60.101"]
