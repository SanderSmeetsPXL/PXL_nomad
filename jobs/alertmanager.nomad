job "alertmanager" {
  datacenters = ["dc1"]
  type = "service"

  group "alerting" {
    count = 1
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }
    ephemeral_disk {
      size = 300
    }

    task "alertmanager" {
      
            driver = "docker"
            config {
      	        image = "prom/alertmanager:latest"
                ports = ["alertmanager_ui"]
                logging {
        	        type = "journald"
                    config {
          	            tag = "ALERTMANAGER"
                    }
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
            }
            resources {
      	        memory = 100
            }
  	    }       
    }
}
