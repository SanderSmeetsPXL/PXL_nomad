job "prometheus" {
  region = "global"
  datacenters = ["dc1"]
  type = "service"

  group "app" {
    count = 1

    task "prometheus" {
      driver = "docker"
      

      config {
        image = "prom/prometheus:latest"
        force_pull = true
        port_map = {
          http = 9090
        }
        volumes = [
          "/opt/prometheus/:/etc/prometheus/",                    
   
        ]
        args = [
          "--config.file=/etc/prometheus/prometheus.yml",
          "--storage.tsdb.path=/prometheus",
		      "--web.enable-lifecycle",
          "--web.console.libraries=/usr/share/prometheus/console_libraries",
          "--web.console.templates=/usr/share/prometheus/consoles",
          "--web.enable-admin-api"
        ]
      
        logging {
          type = "journald"
          config {
            tag = "PROMETHEUS"
          }
        }
      }

      service {
        name = "prometheus"
       
        tags = [
          "metrics"
        ]
        port = "http"
      }

      resources {
        memory = 100

        network {
          port "http" {
            static = "9090"
          }
        }
      }
    }
  }
}