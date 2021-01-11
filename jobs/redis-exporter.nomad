job "redis-exporter" {
    datacenters = ["dc1"]
    type        = "service"

    group "redis-exporter" {
        count = 2
  	    network {
  		    port "redis-exporter-port" {
    	        to = 9121
      	         static = 9121
			}
		}
        service {
	        name = "redis-exporter"
            tags =  [
                "redis-exporter", "metrics"
            ]
            port = "redis-exporter-port"
        }
	    task "redis-exporter" {
            driver = "docker"
            config {
      	        image = "oliver006/redis_exporter"
                ports = ["redis-exporter-port"]
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
