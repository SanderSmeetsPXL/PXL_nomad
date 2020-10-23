data_dir = "/tmp/client"

bind_addr = "{{ GetInterfaceIP \"eth1\" }}"

client {
	enabled = true
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
