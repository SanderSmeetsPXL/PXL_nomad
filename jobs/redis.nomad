job "redis" {

  datacenters = ["dc1"]
  type = "service"


  constraint {
     attribute = "${attr.kernel.name}"
     value     = "linux"
   }

  update {

    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    auto_revert = false
    canary = 0
  }

  group "database" {
    
    task "redis" {
    
      driver = "docker"


      config {
        image = "redis:3.2"
        port_map {
          db = 6379
        }
      }

  
      resources {
        memory = 100
        network {
  		    port "db" {
    	        to = 6379
      	         static = 6379
			}
		}
      }
      service {
	        name = "redis"
            tags =  [
                "redis", "metrics"
            ]
            port = "db"
           heck {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
        }


    }
  }
}
