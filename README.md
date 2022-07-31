# Welcome to HardeningKitty Liaison Officer

## Introduction

This project is part of the Bachelor thesis "IT Infrastructure Hardening Automation". HardeningKitty Liaison Officer is a solution based on [HardeningKitty](https://github.com/scipag/HardeningKitty).
Its purpose is to provide the ability to perform Hardening on remote machines. In addition, in order to make the use of HardeningKitty more user friendly, we have created a menu to perform the different commands.

HardeningKitty Liaison Officer is composed of Powershell Scripts. It uses SCP and SSH protocols for file transfer and remote access.

## How it works

HardeningKitty Liaison Officer is composed of 3 Scripts :

load.ps1 to transfer the files and directories needed to run HardeningKitty Liaison Officer on the Slave machine.

menu.ps1 to run the various features of HardeningKitty.

remove.ps1 to clean up the Slave machine and remove all files transferred and generated by the use of HardeningKitty Liaison Officer.


## How to run it?

A full user guide is available in French here : [guide de l'utilisateur](https://github.com/Luysky/HardeningKitty-LiaisonOfficer/blob/master/GuideUtilisateur.pdf).
If you are not fluent in French, please note that this guide includes many screenshots and that the commands are in English. An English version is under development.

#### Requirements for each machines

1. Activation of OpenSSH Server
2. Unrestricted -ExecutionPolicy for Scripts
3. SSH public key authentification (recommended)
4. Username, password or passphrase and IP address

#### Steps of implementation on Master machine

1. Download HardeningKitty Liaison Officer
2. Execute .load.ps1 
3. Execute .menu.ps1
4. Execute .remove.ps1
