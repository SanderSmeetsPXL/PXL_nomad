In dit project wordt nomad, consul en redis gemonitord door prometheus en grafana.

## Prometheus
Prometheus wordt als monitoringstool gebruikt en is een job. Via de prometheus.yml file worden de configuraties van de jobs ingesteld. 

## Grafana
Grafana wordt gebruikt als dashboard. Via de json files in de dashboard map kunnen de dashboards ingeladen worden.

## Nomad monitoring
Via de prometheus.yml file kunnen we nomad monitoren en alerts aanmaken door de nomad metrics mee te geven.

```bash
 - job_name: 'nomad_metrics'
    consul_sd_configs:
      - server: '10.0.0.10:8500'
        datacenter: 'dc1'
        services: ['nomad-client', 'nomad']
    relabel_configs:                          
    - source_labels: ['__meta_consul_tags']   
      regex: '(.*)http(.*)'                   
      action: keep                            
                                              
    scrape_interval: 5s                       
    metrics_path: /v1/metrics                 
    params:                                   
      format: ['prometheus'] 
```     

## Consul exporter
Via een consul exporter worden er alert rules aangemaakt voor consul.

```bash  
  - job_name: 'consul-exporter'
    consul_sd_configs:
    - server: '10.0.0.10:8500'
      services: ['consul-exporter']
    relabel_configs:
    - source_labels: [__meta_consul_service]
      target_label: job

      scrape_interval: 5s
      metrics_path: /metrics
      params:
        format: ['prometheus']    
```  

## Node-exporter
Is een job dat ingeladen wordt in nomad en op alle nodes gaat opspinnen als docker container met de node exporters service. 
De node exporter gaat ervoor zorgen dat we de nodes kunnen monitoren op CPU,disk,memory,etc.

```bash  
  - job_name: 'nodes'
    consul_sd_configs:
    - server: '10.0.0.10:8500'
      services: ['node-exporter']
    relabel_configs:
    - source_labels: [__meta_consul_service]
      target_label: job
    
    scrape_interval: 5s
    metrics_path: /metrics
    params:
      format: ['prometheus']
```

## Alertmanager
Door de alertmanager job kunnen we alert rules toevoegen aan prometheus.

## Redis
Redis is een data structure store en word mee gemonitord met prometheus en grafana.

## Redis exporter
Door een redis exporter job aan te maken is het mogelijk redis alerts te voorzien.
```bash 
- job_name: redis-exporter
    consul_sd_configs:
    - server: '10.0.0.10:8500'
      services: ['redis-exporter']   
    relabel_configs:
    - source_labels: ['__meta_consul_service']
      target_label: job

      scrape_interval: 5s
      metrics_path: /metrics
      params:
        format: ['prometheus']   
```

## Taakverdeling
We hebben niet echt een taakverdeling gemaakt.We hebben beid overal aan gewerkt.

## Bronvermelding

https://github.com/oliver006/redis_exporter <br>
https://github.com/prometheus/consul_exporter <br>


