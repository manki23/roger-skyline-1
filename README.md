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
#### generals:
- __Shared Clipboard__: Bi-derectional
- __Drag and drop__: Bi directional
####System:
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
- __Domaine__: <empty>

#### Creer les utilisateurs et choisir les mot de passe :
- mdp root : root
- nom complet du nouvel utilisateur : Myriam
- id user : manki
- mdp user : manki

#### Changer la taille des disques
- __Partitionnement assiste->manuel__:
  - click on __SCSI3(0,0,0)(sda)...__
  - __faut-il creer une nouvelle table des partitions sur ce disque ?__ ```oui```
  - click on __pri/log 8.6 GB Espace Libre__
    - creer une nouvelle partition
      - 4.5GB,
      - Primaire,
      - emplacement: Debut,
      - utiliser comme: systeme de fichiers ext2,
      - point de montage /,
      - fin du paramettrage de cette partition
  - click on pri/log 4.0 GB Espace Libre
    - creer une nouvelle partition
      - 4.1GB,
      - Logique,
      - utiliser comme: espace d'echange swap,
      - fin du paramettrage de cette partition
  - Terminer le Partitionnement et appliquer les changements
- Faut-il appliquer les changement sur les disques => oui

- Analyser un autre cd -> non
- France
- Debian archive mirror: ftp.fr.debian.org
- mandataire http : <leave empty>
- Participer a l'etude, non

#### Selection des logiciels :
- serveur ssh
- utilitaires usuels du systeme
- Installer GRUB : oui, dans /dev/sta...
- fin d'installation du systeme

*__FIN CREATION VM__*

## Login
- login : root
- Password: root 
