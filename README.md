# Docker Workshop

Il Workshop si articolerà secondo i seguenti punti:

* Introduzione a virtualizzazione e containers
* Panoramica all'approccio docker
* containers4dev: come li vede lo sviluppatore
* Docker containers e gestione immagini
* Fondamenti della containerizzazione di applicazioni
* Docker Volumes
* Docker Networking Basics
* containers4ops: come li vede il sysadmin
* Cenni su Docker Compose
* Cenni su docker Swarm
* containers e l'approccio devops
* Commiato finale e bomboniere

# Come si articolano gli esempi

dopo una panoramica su docker e il suo ecosistema vedremo come creare una immagine docker a partire da codice.

Supporremo di avere Tre teams nella nostra ideale azienda

* Frontend
* Backend
* Infra

L'obiettivo e' di rendere ogni team autonomo e in grado di rilasciare deliverables in modo indipendente. Questo si ottiene grazie ad un opportuno disaccoppiamento e definizione di chiare interfacce:

### Tra frontend e backend

Il frontend puo' contare sul fatto che il backend rispettera' le seguenti [API Specs](https://github.com/gothinkster/realworld/tree/master/spec)

### Backend
 * we will use a java application, developed using hapijs:
   https://github.com/gothinkster/hapijs-realworld-example-app

   ```bash
   $ git clone https://github.com/gothinkster/hapijs-realworld-example-app
   $ docker-compose up
   ```

   it uses mongodb as backend

### Frontend
 * Questo frontned e' sviluppato in angularjs
 https://github.com/gothinkster/angularjs-realworld-example-app.git
 ```bash
 git clone https://github.com/gothinkster/angularjs-realworld-example-app.git
 ```
 If you want to change the API URL to a local server, simply edit `src/js/config/app.constants.js`

## containers4dev: come li vede lo sviluppatore

Uno dei punti piu' desiderati dagli sviluppatori e' un ambiente di sviluppo uniforme, meglio se autocontenuto e versionabile insieme al codice.

Nel nostro esempio abbiamo due team di sviluppo, frontend e backend. I due team utilizzano tecnologie che possono essere anche molto diverse tra loro e ovviamente diversi ambienti di sviluppo. Il frontend:

* Framework: AngularJS
* nodejs (to test stuff)
* npm package manager
* gulp (build, test and debug)

mentre il backend:

* 

Uno dei possibili scenari e setup che lo sviluppatore frontend potrebbe abbraciare e' quello classico in cui 