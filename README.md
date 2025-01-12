# website__resume_CV
Projet perso : site web CV

Notes pour moi (brouillon de README):

Jekyll ?
Prend des fichiers .md ou .html et les transformes en sites statiques
evite la gestion de BDD
fonctionne svt de paire avec Girhub pages

_______________
Installation de Docker (conteneur) afin de ne pas avoir de mauvaise surprise en utlisant des repo Github publics

git clone (avec clé SSH)
+ sécurisé
pas besoin de log à chaque requete

J avais déjà paramétré une clé SSH, donc pas besoin de le refaire
mais bien vérifier que tout est OK :
ssh -T git@github.com    //doit répondre ‘Hi ...shell access’

Git Bash et non Power Shell sur VSCode

	Git clone du repo (check si on est dans le bon dossier)

	Creation fichier Dockerfile
       
____________
Dockerfile :
pas d extension au fichier
le contenu dépendra de ce que l on veut faire mais ces points sont à remplir
- FROM+... syst d’expl ou env (comme ruby par ex)
- RUN+... gere tous les outils dont on va avoir besoin (install de bibli par ex)
- WORKDIR+… chemin vers le repo de travail, d’où tout émanera
- RUN gem install+… install dss dépendances de Ruby =gems pour Jekyll
- RUN git clone+… pour créer repo (déjà fait )
- EXPOSE 4000
- CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]


________________
*sous Linux, la racine de « tout » est /*
*ecouter un port = attend et reçoit des connexions entrantes sur un port réseau spécifique. *
*yml (YAML) est un format de données lisible par l'humain, utilisé pour écrire des fichiers de configuration. * 
        
__________
	ajout d un fichier docker-compose.yml
car Le Dockerfile définit l'image d'un conteneur (les instructions pour créer une image Docker). Le docker-compose.yml utilise ces images pour lancer des conteneurs avec des configurations spécifiques (ports, volumes, variables d'environnement, etc.). 

__________
	creation repo Git pour Github
git init (crée la structure nécessaire pour pouvoir commencer à versionner les fichiers)

le repo jekyll est déjà un repo Github, donc je vais l ajouter au .gitignore
	creation d un fichier .gitignore
                                                          
git add .    !=    git reset +nom_fichier 
git push -u origin master
   
commit 01

________________

reprise après les vacances 05 01 25

- suppr du .odt de prise de note -> README
- MAJ dockerfile
- creation du gitignore
- projet de base : site via Infomaniak
changement pour Github Pages (je voudrais tester)

##"Creation" de Github pages pour mon repo :
Sur Github > repo concerné > Settings > Pages etc

Ne fonctionne pas (je reçois un mail de Github me l'indiquant)
Recherche du problème :

Peut etre est-ce dû à une diff entre repo local et distant
Tentives de résolution :
- mauvaise config du git ignore : ajout de / à la fin d'une ligne de gitignore (dossier)
- suppression manuelle du dossier Jekyll (push avant que je l'indique dans le gitignore) puis commit puis push
- vide cash Git avec git rm -r --cached .
- vérification si le dossier est bien ignoré avec 
git check-ignore -v nom_du_dossier
Cela fonctionne car :
.gitignore:3:nom_du_dossier/
gitignore : règle provient de gitignore
3 : num de ligne
nom_ddosier

Le problème persiste :
## Ajout d'un sous module
= dépot Git imbriqué à l'int d un autre dépot
Les sous-modules sont utilisés pour inclure des bibliothèques ou des dépendances externes dans un projet sans les copier directement


___________ 07 01 25
J'ai déplacé avec l expl W le dossier du pr Jekyll

Je vais finalement plutot utiliser ce depo : 
https://github.com/mmistakes/minimal-mistakes

Reprise de l'utilisation de Docker en vue du téléchargement du pr Jekyll Github

/*cd dans Bash : change directory

Clonage du nouveau repo Jekyll minimal

Fichier Dockerfile : OK

## Construction image Docker
cd repo du pr Jekyll (là où gemfile)
bundle install
docker build -t mon_site_jekyll .
erreurs de versions (gem) et de contenu dans Gemfile

__________________________11 01 25

## Lancer le conteneur Docker

En me déplaçant dans le dossier contenant le pr Jekyll, je me retrouve dans une branche master. 
Je l'ai renommée en 'main' avec :
git branch -m master main
MAJ Github, bien se mettre dans le dossier parent sinon le push essaie d 'accéder au repo du pr Jekyll
(donc celui de l'auteur.e)

Se replacer dans le dossier contenant le pr Jekyll.

/*HEAD : branche courante

L'image du conteneur a été créée. On va pvr exécuter le prog Jekyll dans un conteneur avec :
docker run --rm -p 4000:4000 -v $(pwd):/srv/jekyll minimal-mistakes
	avec :
	--rm 					Suppr conteneur qd il arrête de fonctionner
	-p 4000:4000  			Mappe le port 4000 du conteneur au port 4000 de mon PC machine
							ce qui me permettra d'accéder au site Jekyll via http://localhost:4000
	-v $(pwd):/srv/jekyll	Monte le repo de pr local dans le conteneur à l'emplacement /srv/jekyll
							ce qui permet à Docker d'accéder et de modifier mes fichiers locaux
	minimal-mistakes 		Le nom de l'image Docker à exécuter

	Bash me renvoit cette erreur :
	docker: invalid reference format: repository name (library/perso\site-web-cv;C) must be lowercase.
	L'erreur lowercase inclut aussi les espaces dans les noms de dossier !!

## Construction de l image Docker

docker build -t minimal-mistakes .
	docker build : construit une imge Docker à partir du dockerfile présent
	-t minimal-mistakes : futur nom de l img construite
	. : répo courant

/* .. : repo parent du repo courant
tag : nom

Image bien présente dans le repo, vérif avec
docker images	//liste tous les fichiers docker de mon système

## Execution du conteneur Docker avec l img créée 
docker run --rm -p 4000:4000 -v $(pwd):/srv/jekyll minimal-mistakes

server accessible à 
http://localhost:4000

Côté Docker Desktop, un container est apparu

/* fonctionnement de Docker et des containers :
	docker engine : c'est le moteur : crée, exécute, modifie, gère les conteneurs
	conteneur : léger, isolé, permet de faire fonctionner des prog
				contient tout le nécessaire : syst d'expl, bibli...
	images Docker : ~class.java, modèle, plan...
	Docker Hub : service similaire à Github pour stock & partage d'images Docker
	Docker Desktop Interface : GUI, complète le CLI
								visualisation, gestion et inspection des conteneurs
	Docker Compose : permet d'utiliser plusieurs conteneurs en mm temps 
	WSL 2 : Windows Subsystem for Linux, moteur de virtualisation Linux pour W
			plus rapide et plus léger
	
	quelques cmdes CLI
		docker ps			Liste des conteneurs en cours d'exécution
		docker ps -a 		ous les conteneurs mm ceux pas en cours d'exécution
		docker start <nom_conteneur> Démarre un conteneur arrêté

## Lancement du pr Jekyll de base
docker-compose up
mais erreur 
no configuration file provided: not found
Il manque un fichier essentiel pour le fonctionnement de docker compose :
docker-compose.yml
Je le crée

MAJ Github commit du ..

docker-compose up
erreur
Error response from daemon: driver failed programming external connectivity on endpoint [blabla] for 0.0.0.0:4000 failed: port is already allocated

Donc mon port :4000 est déjà en cours d'utilisation (par Docker ?)
On va vérifier qui l'utilise.
Power Shell : netstat -ano | findstr :4000
Liste des processus utilisant le port 4000 : 2x 11520 et 1x 7412
Pour les identifier :
tasklist /fi "PID eq [blabla]"
C'est bien Docker et WSL.

/* PID : un ID unique de processus affecté à chaq prog
wslrelay.exe = WSL

Je change donc le port "4001:4000" dans le fichier docker-compose.yml

/*mappage de ports entre le conteneur Docker et l'hôte.
    4001 est le port de l'hôte (mon PC) via lequel je peux accéder au service exécuté dans le conteneur
    4000 est le port à l'intérieur du conteneur, celui sur lequel le service à l'intérieur du conteneur écoute */

	Relance de Docker compose :
	docker-compose up
erreur
Dependency Error: Yikes! It looks like you don't have jekyll-paginate or one of its dependencies installed.
J'ajoute la gem jekyll-paginate à mon fichier gemfile (root) :
gem 'jekyll-paginate'
Ensuite j'installe les dépendances qui me manquent avec
bundle install
Vérification de la config de la pagination dans _config.yml
Modification du fichier 'default' dans _layouts : ajout de la logique de pagination

Commit






