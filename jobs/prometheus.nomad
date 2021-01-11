job "prometheus" {
  region = "global"
  datacenters = ["dc1"]
  type = "service"

  group "app" {
    count = 1

    restart {
      attempts = 3
      delay    = "20s"
      mode     = "delay"
    }

    task "prometheus" {
      driver = "docker"
 

      config {
        image = "prom/prometheus:latest"
        force_pull = true
        port_map = {
          http = 9090
        }
        volumes = [
          "/opt/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml", 
          "/opt/prometheus/alert.yml:/etc/prometheus/alert.yml"  
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

        check {
          type = "http"
          path = "/targets"
          interval = "10s"
          timeout = "2s"
        }
      }

      resources {
        cpu    = 50
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