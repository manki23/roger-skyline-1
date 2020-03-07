# Roger-Skyline-1

*Résumé: Ce document est un sujet d’initiation à l’Administration Système et Réseau.*

## Créer la VM avec VirtualBox

- click on *__New__*
- __name__: Roger
- __Machine folder__: /sgoinfre/goinfre/Perso/manki/VirtualBox VMs
- __Type__: ```Linux```
- __Version__: ```Debian (64-bits)```

- __Memory size__: ```4096MB```

- __Create a virtual hard disk now__

- __VDI (Virtual Hard Disk Image)__

- __Fixed size__

- ```8.00GB``` (I didn't change the path of the .vdi file)

2 min wait => once finished, do not start the VM before changing the settings

### Settings
#### Generals:
- __Shared Clipboard__: Bi-derectional
- __Drag and drop__: Bi directional
#### System:
- __System->Floppy->__ uncheck
- __Processor__: 4CPU
- __Storage__ => in Storage Devices click on empty, then in Attributes, click
on the blue circle next to optical drive, and choose debian-10.1.0-amd64-netinst.iso
(you may have to download your own .iso)
- __Network->Adapter 1-> attached to__: Bridge Adapter
- __Shared Folder__: pour creer des dossier partagés entre la VM et ma session

### VM installation 
- __START__ the VM and click on ```Install```
- __Select a language__: French
- __Situation Geographique__: France
- __clavier__: Etats-Unis
- __Nom de machine__: Roger
- __Domaine__: ```<empty>```

#### Creer les utilisateurs et choisir les mot de passe :
- mdp root : root
- nom complet du nouvel utilisateur : Myriam
- id user : manki
- mdp user : manki

#### Changer la taille des disques
- __Partitionnement assisté->manuel__:
  - click on __SCSI3(0,0,0)(sda)...__
  - __faut-il creer une nouvelle table des partitions sur ce disque ?__ ```oui```
  - click on __pri/log 8.6 GB Espace Libre__
    - __creer une nouvelle partition__:
      - ```4.5GB```,
      - ```Primaire```,
      - __Emplacement__: ```Debut```,
      - __Utiliser comme__: ```systeme de fichiers ext2```,
      - __Point de montage__: ```/```,
      - __Fin du paramettrage de cette partition__
  - click on __pri/log 4.0 GB Espace Libre__
    - __creer une nouvelle partition__:
      - ```4.1GB```,
      - ```Logique```,
      - __Utiliser comme__: ```espace d'echange swap```,
      - __Fin du paramettrage de cette partition__
  - __Terminer le Partitionnement et appliquer les changements__
- __Faut-il appliquer les changement sur les disques__ => ```oui```

- __Analyser un autre cd__ -> ```non```
- ```France```
- __Debian archive mirror__: ```ftp.fr.debian.org```
- __mandataire http__: ```<leave empty>```
- __Participer a l'etude__: ```non```

#### Selection des logiciels :
- __serveur ssh__
- __utilitaires usuels du systeme__
#### Pour finir :
- __Installer GRUB__ : oui, dans ```/dev/sta...```
- __Fin d'installation du systeme__

*__FIN CREATION VM__*
***

## Paramètrer la VM

#### Login
- __login__: ```root```
- __Password__: ```root```

#### Installer git, Télécharger les scripts & lancer l'installation
```apt-get install git```

```cd ; git clone https://github.com/manki23/roger-skyline-1.git ; cd roger-skyline-1```

```sh install.sh```

### __NB__ :
- dans le fichier *__enp0s3__* on choisis l'addresse ip __10.11.32.32__
    - __10__ correspond à l'école
    - __11__ correspond à l'__e1__ (mettre __12__ pour l'__e2__, __13__ pour l'__e3__)
    - *les deux derniers nombres sont libre de choix*
- dans __/scripts/script_crontab.sh__ changer *manki@student.42.fr* par votre addresse mail, ne pas mettre une addresse ___gmail___ sinon le mail sera bloqué.
- idem dans ___install.sh___
***

## Commandes Utiles
- ```sudo fdisk -l``` => debian disk infos pour vérifier la taille des partitions  
- ```sudo vim /etc/sudoers``` : pour forcer la configuration les sudo users  
- ```sudo vim /etc/network/interfaces``` => to configure a static IP address.  
- ```ip addr``` pour remplacer ```ifconfig```
- ```vi``` pour remplacer ```vim```  
- ```sudo service sshd restart``` => à faire à chaque fois qu'on modifie sshd_config, pour prendre les changement en compte  
- ```apt-get update``` & ```apt-get -y upgrade```  
- ```apt list --installed > tmp ; vi tmp``` ou ```grep " install " /var/log/dpkg.log > tmp ; vi tmp``` pour verifier les packets installés  
```
sudo adduser name
sudo adduser name sudo
sudo deluser name sudo
```  
- lister les sudo users : ```getent group sudo```  
- see all user : ```cat /etc/passwd``` ou (```cut -d: -f1 /etc/passwd```)  
- ```sudo service --status-all``` : voir le status des services installés  
- ```sudo service nomDuService status``` (```sudo service dhcp status```) => pour vérifier le status d'un service en particulier  
- lister les regles de parefeu (iptables): ```sudo iptables -L```  
- lister les ports ouverts :  
  - ```apt-get install net-tools```  
  - ```netstat -paunt``` ==> pour lister les ports ouverts  
  
__NB__ : Ce à quoi correspond les numéros de port :  
    port 80 = http  
    port 443 = https  
    port 587 = smtp email message submission  
    port 25 = SMTP simple mail transfert protocol  
    (https://fr.wikipedia.org/wiki/Liste_de_ports_logiciels)  
```sudo service --status-all```  

__NB__ : Ce à quoi sert chaque service :  
```
apache2 => serveur http
cron => gestionnaire des taches
dbus => D-Bus est actuellement un démon permettant la communication inter-processus
kmod => outils pour gérer les modules du noyau Linux
netfilter-persistent => necessaire pour rendre les modification d'iptables persistentes
networking => gestion des connections reseau
procps => Utilitaires pour le système de fichiers /proc
rsyslog => permet de transférer les messages de journalisation sur un réseau IP
sendmail => le service sendmail fonctionne en tant que relai SMTP afin d'envoyer les courriels plus rapidement
udev => gestionnaire de peripheriques
```  

___verifier que le script d'update fonctionne (script_log.sh)___  
supprimer le contenu de ```vi /var/log/update_script.log```  
faire ```sudo reboot```  
verifier dans ```vi /var/log/update_script.log``` que l'update a ete faite  

___verifier le script de modification :___  
modifier le timestamp dans ```/etc/crontab``` et vérifier que le mail a bien été envoyé au temps indiqué  

***
