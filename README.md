# CRIMEPULSE L.A Shiny App 

## Introduction
L'application CRIMEPULSE L.A offre une expérience intéractive pour explorer et comprendre les tendances de criminalité à Los Angeles, de 2020 à 2023.

Voici un aperçu de l'application : 

<img width="1440" alt="apercu" src="https://github.com/CeliaMarty/Projet-R-Shiny-/assets/152623002/36008021-53c6-4b47-96ca-9f1686ab0da9">


## Comment éxécuter l'application
- Avoir R et R studio sur votre machine
- Téléchagez l'ensemble du projet depuis le [Répository R-Shiny](https://github.com/CeliaMarty/Projet-R-Shiny-)
- Téléchargez le jeu de données via ce lien [Crime-Data](https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-Present/2nrs-mtv8/about_data)
- Installez les packages nécéssaires en utilisant le script R : packages.R
- Lancer le script : global.R
- Ouvrez ensuite le fichier : Webapp_DataCrime.R
- Appuyez sur Run App pour lancer l'application
  

## Fonctionnalités de l'Application

### Onglet "Accueil"
Présente une introduction à l'application, affiche quelques chiffres clés et comprend un graphique montrant le nombre de délits par année.

### Onglet "Victimes"
Permet de visualiser la répartition des délits en fonction du sexe et de l'âge des victimes pour une année séléctionnée.

### Onglet "Localisation"
Affiche une carte intéractive qui représente la répartition des délits ainsi que leur type par quartiers (uniquement en 2023).

### Onglet "Type de délit"
Permet de filter les données par type de délits avec l'affichage d'une table intéractive.
