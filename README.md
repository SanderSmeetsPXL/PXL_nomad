Er werd gekozen om Ansible te gebruiken voor de uitwerking van dit project. De uitwerken heeft dus geheel plaatsgevonden onder de ansible directory.

# Playbooks
De playbook bevat enkel referenties naar roles die alle tasks uitvoeren.

# Prereq
Deze role installeerd alle software die nodig is om de andere roles te doen werken, o.a. unzip.

# Docker

# Consul
Consul wordt geïnstalleerd via een archief van de Hashicorp website. Er wordt eerst gecontroleerd of Consul al geïnstalleerd is om te verkomen dat er onnodig gedownload wordt. Via een template wordt het juiste configuratiebestand gekopieerd naar server en hosts. Er is ook een handler aanwezig die geroepen wordt bij het wijzigen van het systemd service bestand.

# Nomad

