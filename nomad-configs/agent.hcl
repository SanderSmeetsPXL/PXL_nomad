log_level = "DEBUG"

data_dir = "/tmp/client"
bind_addr= "192.168.60.102"

client {
	enabled = true
	servers = nomad.service.discovery:4647
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
