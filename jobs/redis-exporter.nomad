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
                args = ["-redis.addr", "localhost:6379", "-web.listen-address", "localhost:9021"]
                
            }
            resources {
      	        memory = 100
            }  
  	    } 
    }
}
