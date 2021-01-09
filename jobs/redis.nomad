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

  group "cache" {
    
    ephemeral_disk {

      size = 150
    }

    task "redis" {
    
      driver = "docker"


      config {
        image = "redis:3.2"
        port_map {
          db = 6379
        }
      }

  
      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
        network {
          mbits = 10
          port "db" {}
        }
      }

      service {
        name = "global-redis-check"
        tags = ["global", "cache", "urlprefix-/redis" ]
        port = "db"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }


    }
  }
}
