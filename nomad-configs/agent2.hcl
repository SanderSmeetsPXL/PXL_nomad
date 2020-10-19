log_level = "DEBUG"

data_dir = "/tmp/client"
bind_addr= "192.168.60.103"
name = "agent2"

client {
	enabled = true
	servers = 192.168.60.101:4647
}

ports {
	http = 5656
}

plugin "docker" {
	config {
		gc {
			dangling_containers {
				enabled = false
			}
		}
	}
}
