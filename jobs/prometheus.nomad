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


    task "prometheus" {

    driver = "docker"

      config {
        image = "prom/prometheus:latest"
        network_mode="host"

        volumes = [
          "/opt/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml",
          "/opt/alerting/alert.rules:/etc/alerting/alert.rules",

        ],

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
        memory = 100
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
