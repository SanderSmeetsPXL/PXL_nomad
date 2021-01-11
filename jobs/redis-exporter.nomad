job "redis-exporter" {
    datacenters = ["dc1"]
    type        = "service"

    group "redis-exporter" {
        count = 4
  	    network {
  		    port "redis_exporter_port" {
    	        to = 9121
      	         static = 9121
			}
		}
        service {
	        name = "redis-exporter"
            tags =  [
                "redis-exporter", "metrics"
            ]
            port = "redis_exporter_port"
        }
	    task "redis-exporter" {
            driver = "docker"
            config {
      	        image = "oliver006/redis_exporter"
                ports = ["redis_exporter_port"]
                args = [
                    "--redis.addr=127.0.0.1:6379",
                ]
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
