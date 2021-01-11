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
          redis_ui = 6379
        }
      }

  
      resources {
        memory = 100
        network {
  		    port "redis_ui" {
    	        to = 6379
      	         static = 6379
			}
		}
      }
     service {
	        name = "redis"
            port = "redis_ui"
            tags = [
      	        "metrics"
            ]
        }

    }
    }
  }
