# 2am Monday cook

Tomas och David sitter i Idéet och kommer på dumma ideer om hur saker borde se ut i framtiden


## Naming stuff

Blossom blir en subdomän för okd (ex. magnolia.blossom.dsek.se). Precis som att ovirt heter dimman

Asgard blir en subdomän för nuvarande pando, beehive, gjallarbron och bifrost (ex. bifrost.asgard.dsek.se) vi byter även namn på beehive till Yggdrasil eftersom det passar med både blossom och Asgard temat (kan även ha en ascii version av gamla rootm loggan som sin logga). Även kanske en idé att byta namn på pando till något som passar både (kanske Balder).

Idet blir vårt nya IoT nätverk, som även inkluderar Uffe och aktu-pcn (ex. sparky.idet.dsek.se).


Detta är allt för att göra det lättare att fatta hur nätet är uppbyggt och för att kunna se på någots namn var det hör hemma eller var man kan hitta det.


\
## File storage


Vi vill gärna ha ssds i alla noder för hastighet till våra tjänster, och Kubernetes behöver mycket reads (minst 256gb storage behövs per nod). Vi kan sno 3 drives för detta från turbo the snail i Pando. (Se bit längre ner om detta).


Vad händer med Pando?


Om det som finns på Pando är sporadisk access (typ backups och arkiv storage), så kan man ha manuell failover av load balancing (typ starta den på Bifrost eller gjallarbron eller eventuellt cloudflare/annan onlinetjänst med ett klick), så att saker kan vara uppe även om Pando går ner.


Turbo the snail ska dö och vi snor drivsen för okd.


Klusterbitar ska bli vår egna filserver, arkivet, egen drive? Eventuellt även någon form av okd storage. Saker som man kan leva utan under ett tag kan hamna här. David ska kolla på CEPH


Save me är kvar ungefär som det är nu men vi behöver en lösning för backup and restore för okd storage. (Minio kanske relevant för s3 storage pool på ett filsystem).


Vi behöver garanterat en lösning för backups som går att skriva till ett vanligt filsystem pga vår off-site backup till DF.

## Other

Vi kan behöva öppna port 5000 för att komma åt image repot. Pratar den http så är det lugnt men är det rå tcp så behöver vi öppna. Kan vara skönt att ha något web gui över vårt imagerepo också så att man kan se vad som finns lätt och smidigt.


"Snälla, vi kommer väl ha typ 100% uptime" - @[David Agardh](mention://905b4efd-f3ef-46a4-ad5b-70814bc47b09/user/b7aca933-2918-4648-8de7-a9692cd6e477) 


\