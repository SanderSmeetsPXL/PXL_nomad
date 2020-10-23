log_level = "DEBUG"
data_dir = "/tmp/server1"
bind_addr= "192.168.60.101"
name = "server"

server {
	enabled = true

	bootstrap_expect = 1
}

consul {
	address = "192.168.60.101:8500"
}
