# Uitleg opdracht

We zijn begonnen met een vagrant file aan te maken. Dit hebben we gedaan door het vagrant init commando te gebruiken. 
In de vagrant file hebben we drie vm’s laten op spinnen. Één vm is de server in het cluster verhaal, de andere twee zijn de clients. We hebben de vm’s een private network ip adres gegeven zodat we via de nomad en consul files de vm’s kunnen linken. Daarna verwijzen we naar een scriptInstall. 

In dit script wordt docker geïnstalleerd. 
Hierna wordt ook consul geïnstalleerd in het scriptInstall.  Bij deze installatie hebben we gebruik gemaakt van een if els structuur voor de juiste consul file te linken aan de juiste vm. 

Voor de server hebben we een consul server.hcl file gemaakt met daarin de code om aan consul te vertellen dat dit de server is. Ook wordt hier het ip adres van het private netwerk van die server mee gegeven zodat consul weet over welke server het gaat. Dit gebeurt door gebruik te maken van "{{ GetInterfaceIP \"eth1\" }}". Dit gaat het ip adres opvragen via de eth1 interface. Bootstrap_except gaat ons vertellen hoeveel servers er in totaal zijn. In ons geval is dat er maar één. Client_addr is het adres naar waar consul de client interfaces zal gaan binden. In ons geval het ip adres van de server. 

Voor de clients geven we een client.hcl file mee. In deze file geven we ook een bind_addr mee aan de hand van de eth1 interface. Dit doen we zodat de file kunnen gebruiken voor alle clients. We geven ook nog mee dat de client de server moet joinen. 
Als dit gebeurt is wordt via een copy commando de service file gekopieerd naar de server om de systemctl conul service te starten.

Als laatste wordt er nomad geïnstalleerd via de scriptInstall. Hier wordt ook een if els structuur gebruikt. 

Voor de server hebben we een nomad server.hcl file. 
In deze file wordt er ook een bind_addr gebruikt. Verder wordt de server enabled en meegeven dat er maar 1 server is. Ook het consul adres en port word meegegeven zodat de nomad en consul server elkaar kunnen vinden. 

Voor de clients is er een client.hcl file. Hierin wordt gebruik gemaakt van "{{ GetInterfaceIP \"eth1\" }}" als bind_addr. De client wordt enabled en er wordt een poort toegevoegd. De docker plug-in wordt meegegeven.

Als dit gebeurt is wordt via een copy commando de service file gekopieerd naar de server om de systemctl nomad service te starten.


# Bron vermelding
https://www.nomadproject.io/docs/configuration
https://learn.hashicorp.com/nomad
https://www.nomadproject.io/docs/integrations/consul-integration
https://learn.hashicorp.com/tutorials/nomad/get-started-cluster?in=nomad/get-started 
