job "node_exporter" {
    datacenters = ["dc1"]
    type        = "service"

    group "node-exporter" {
        count = 2
  	    network {
  		    port "node_exporter_port" {
    	        to = 9100
      	         static = 9100
			}
		}
        service {
	        name = "node-exporter"
            tags =  [
                "node_exporter", "metrics"
            ]
            port = "node_exporter_port"
        }
	    task "node_exporter" {
            driver = "docker"
            config {
      	        image = "prom/node-exporter:latest"
                ports = ["node_exporter_port"]
                logging {
        	        type = "journald"
                    config {
          	            tag = "NODE_EXPORTER"
                    }
                }
            }
            resources {
      	        memory = 100
            }  
  	    } 
    }
}
