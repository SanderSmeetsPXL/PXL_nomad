job "consul-exporter" {
    datacenters = ["dc1"]
    type        = "service"

    group "consul-exporter" {
        count = 1
  	    network {
  		    port "consul_exporter_port" {
    	        to = 9107
      	         static = 9107
			}
		}
        service {
	        name = "consul-exporter"
            tags =  [
                "consul-exporter", "metrics"
            ]
            port = "consul_exporter_port"
        }
	    task "consul_exporter" {
            driver = "docker"
            config {
      	        image = "prometheus/consul_exporter"
                ports = ["consul_exporter_port"]
                args = [
                    "--consul.server=10.0.0.10:8500",
                ]
                logging {
        	        type = "journald"
                    config {
          	            tag = "CONSUL-EXPORTER"
                    }
                }
            }
            resources {
      	        memory = 100
            } 
  	    } 
    }
}