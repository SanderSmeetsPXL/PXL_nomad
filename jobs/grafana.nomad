
job "grafana" {
    datacenters = ["dc1"]
    type        = "service"

    group "grafana" {
        count = 1
  	    network {
  		    port "grafana_ui" {
    	        to = 3000
      	         static = 3000
			}
		}
        service {
	        name = "grafana"
        }
	    task "grafana" {
            driver = "docker"
            config {
      	        image = "grafana/grafana:latest"
                port_map {
                   grafana_ui = 3000
                }
                logging {
        	        type = "journald"
                    config {
          	            tag = "GRAFANA"
                    }
                }
            } 
  	    } 
    }
}

      
