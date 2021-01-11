In dit project wordt nomad, consul en redis gemonitord door prometheus en grafana.

# Prometheus
Prometheus wordt als monitoringstool gebruikt en is een job. Via de prometheus.yml file worden de configuraties van de jobs ingesteld. 

# Grafana
Grafana wordt gebruikt als dashboard. Via de json files in de dashboard map kunnen de dashboards ingeladen worden.

# Nomad monitoring
Via de prometheus.yml file kunnen we nomad monitoren door de nomad metrics mee te geven.

```bash
scrape_configs:
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

## Consul Monitoring


# Node-exporter
Is een job dat ingeladen wordt in nomad en op alle nodes gaat opspinnen als docker container met de node exporters service. 
De node exporter gaat ervoor zorgen dat we de nodes kunnen monitoren op CPU,disk,memory,etc.


# Alertmanager


# Redis
Redis is een data structure store en word mee gemonitord met prometheus en grafana.

# Taakverdeling
We hebben niet echt een taakverdeling gemaakt.We hebben samen aan alles gewerkt.

# Bronvermelding

https://github.com/oliver006/redis_exporter <br>
https://github.com/prometheus/consul_exporter <br>


