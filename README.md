Er werd gekozen om Ansible te gebruiken voor de uitwerking van dit project. De uitwerken heeft dus geheel plaatsgevonden onder de ansible directory.

# Playbooks
De playbook bevat enkel referenties naar roles die alle tasks uitvoeren.

# Prereq
Deze role installeerd alle software die nodig is om de andere roles te doen werken, o.a. unzip.

# Docker
Docker wordt via een role geïnstalleerd. De repository van docker-ce edition wordt gedownload en gekopieerd naar de server en clients. Het toevoegen van docker gebeurt in de task setup-centos.yml. Er wordt gecontroleerd dat de containerd.io zeker is geïnstalleerd omdat deze niet mag ontbreken. Verder wordt er gecontroleerd of docker opstart bij het opstarten van de systemen.   

# Consul
Consul wordt geïnstalleerd via een archief van de Hashicorp website. Er wordt eerst gecontroleerd of Consul al geïnstalleerd is om te verkomen dat er onnodig gedownload wordt. Via een template wordt het juiste configuratiebestand gekopieerd naar server en hosts. Er is ook een handler aanwezig die geroepen wordt bij het wijzigen van het systemd service bestand.

# Nomad
De nomad zip file wordt van de hashicorp website geïnstalleerd. De zip wordt gekopieerd naar de server en clients en uitgepakt in de destination folder. Een nomad configuratie directory wordt aangemaakt. Hierin wordt de hcl file met de configuratie in geplaatst. De file met de nomad service wordt ook toegevoegd in systemd. Dit wordt gedaan zodat nomad bij een boot wordt opgestart. In de service file wordt er verwezen naar de hcl configuratie file, waarin de server en clients configuratie in staat.


# Taakverdeling
Sander
  - Vagrant file
  - Prereq role
  - Consul role
  - Playbook
  - Readme 

Jolien 
  - Docker role
  - Nomad role
  - Playbook
  - Readme

# Bronvermelding
https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html

https://github.com/geerlingguy/ansible-role-docker

