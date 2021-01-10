job "prometheus" {
  datacenters = ["dc1"]
  type        = "service"

  group "monitoring" {
    count = 1

    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    ephemeral_disk {
      size = 300
    }

    task "prometheus" {

    driver = "docker"

      config {
        image = "prom/prometheus:latest"
        network_mode="host"

        volumes = [
          "/opt/prometheus/:/etc/prometheus/"
        ]
        args = [
          "--config.file=/etc/prometheus/prometheus.yml",
          "--storage.tsdb.path=/prometheus",
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
          port_map {
          prometheus_ui = 9090
        }
      
      }
      

      resources {
        network {
  		    port "prometheus_ui" {
    	        to = 9090
      	         static = 9090
		  	}
         }
      }

      service {
        name = "prometheus"
        tags = ["urlprefix-/"]
        port = "prometheus_ui"

        check {
          name     = "prometheus_ui port alive"
          type     = "http"
          path     = "/-/healthy"
          interval = "10s"
          timeout  = "2s"
          address_mode = "driver"

        }
      }
    }
  }
}
