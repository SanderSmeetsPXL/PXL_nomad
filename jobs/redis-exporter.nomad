job "redis-exporter" {
    datacenters = ["dc1"]
    type        = "service"

    group "redis-exporter" {
        count = 5
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
                args = [
                    "--redis.addr=127.0.0.1:6379"
                    ]
                
            }
            resources {
      	        memory = 100
            }  
  	    } 
    }
}
