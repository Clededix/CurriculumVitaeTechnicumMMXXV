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