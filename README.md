# PowerShell TimeZone Scripts

Ce dépôt contient deux scripts PowerShell conçus pour faciliter la gestion des fuseaux horaires sur les systèmes Windows.

## Scripts Inclus

1. **Change_Timezone_Manually_Git.ps1**: Une interface graphique permettant à l'utilisateur de sélectionner un fuseau horaire en fonction du continent et du pays.
2. **Change_Timezone_Automatically_by_GPO_Git.ps1**: Un script qui détermine automatiquement le fuseau horaire de l'utilisateur en fonction de son adresse IP et met à jour le système en conséquence.

## Installation

Pour utiliser ces scripts, téléchargez-les dans un dossier de votre choix sur votre système Windows.

## Utilisation

### TimeZoneSelector.ps1

1. Ouvrez PowerShell ISE.
2. Naviguez jusqu'au dossier contenant le script.
3. Exécutez le script en tapant `.\Change_Timezone_Manually.ps1`.
4. Suivez les instructions à l'écran pour sélectionner un continent et un pays, puis confirmez pour mettre à jour votre fuseau horaire.

### AutoTimeZoneSetter.ps1

1. Ouvrez PowerShell ISE.
2. Naviguez jusqu'au dossier contenant le script.
3. Exécutez le script en tapant `.\Change_Timezone_Automatically_by_GPO.ps1`.
4. Le script déterminera automatiquement votre localisation et mettra à jour votre fuseau horaire.

## Configuration via GPO

Pour déployer ces scripts sur plusieurs machines via une stratégie de groupe (GPO), veuillez consulter la section "Fiche tutorielle" de ce README.

## Fiche tutorielle

**Mise en place par GPO d'un script PowerShell automatique**

1. **Préparation du script**:
   - Testez le script pour tester son fonctionnement (exemple: changer manuellement le fuseau horaire avec le premier script, puis lancer le deuxième).

2. **Création d'une GPO**:
   - Dans Gestion de stratégie de groupe, créez une nouvelle GPO et liez-la à l'OU souhaitée (il est bien sûr souhaitable que les ordinateurs et Utilisateurs soient impacté par cette GPO).

3. **Configuration de la GPO**:
   - Modifiez la GPO avec un clic droit, pour exécuter le script au démarrage ou à l'ouverture de session.
   - Configuration Ordinateur -> Stratégie -> Paramètres Windows -> Scripts -> Démarrage
   - Ajouter votre script dans Scripts Powershell -> copier le fichier Change_Timezone_Automatically_by_GPO.ps1 dans Startup, puis le choisir
   - Configuration Utilisateur -> Stratégie -> Paramètres Windows -> Scripts -> Démarrage
   - Ajouter votre script dans Scripts Powershell -> copier le fichier Change_Timezone_Automatically_by_GPO.ps1 dans Logon, puis le choisir

4. **Test et déploiement**:
   - Testez la GPO dans une OU de test avant de l'appliquer à l'ensemble des utilisateurs et ordinateurs.
   - Testez la GPO pour tester son fonctionnement (exemple: changer manuellement le fuseau horaire avec le premier script, puis redémmarrer l'ordinateur).

5. **Surveillance et maintenance**:
   - Surveillez l'application de la GPO et mettez à jour les scripts ou les paramètres selon les besoins (je n'ai pas mis tout les pays du monde.

## Contribuer

Les contributions à ce projet sont bienvenues. N'hésitez pas à forker le dépôt, apporter vos modifications et soumettre une pull request.

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](https://github.com/Kirua6/Change_Timezone_Automatically_by_GPO/blob/main/LICENSE) pour plus de détails.

