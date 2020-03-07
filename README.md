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

## Settings
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

## VM installation 
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

## Login
- __login__: ```root```
- __Password__: ```root``` 
