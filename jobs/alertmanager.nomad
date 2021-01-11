job "alertmanager" {
  datacenters = ["dc1"]
  type = "service"

  group "alerting" {
    count = 1

     network {
  		    port "alertmanager_ui" {
    	    to = 9093
      	     static = 9093
			}
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

            }
            resources {
      	        memory = 100
            }
  	    }       
    }
}
