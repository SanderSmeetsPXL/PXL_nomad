job "prometheus" {
  datacenters = ["dc1"]
  type = "service"

  group "app" {
    count = 1

    restart {
      attempts = 3
      delay    = "15s"
      mode     = "fail"
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
      }

      service {
        name = "prometheus"
        address_mode = "driver"
        tags = [
          "metrics"
        ]
        port = "http"

        check {
          type = "http"
          path = "/targets"
          interval = "10s"
          timeout = "2s"
          address_mode = "driver"
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