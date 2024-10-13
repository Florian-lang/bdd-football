# Projet Bases de Données Réparties - UQAC Automne 2024

## Objectif
Le projet consiste à concevoir et à implémenter un système de gestion de bases de données réparties pour la Fédération française de football. Ce système est distribué à travers cinq sites régionaux situés dans le nord, l'est, l'ouest, le centre et le sud de la France. Chaque site gère certaines données spécifiques tout en collaborant avec un site central qui coordonne la gestion des informations nationales.

## Description du Système
Le système repose sur une base de données contenant des informations liées aux clubs sportifs, dirigeants, joueurs, matchs, stades, et autres entités pertinentes pour la gestion du football en France. La répartition des données et des responsabilités est divisée entre un site central et quatre sites régionaux :

- **Site central (Région 1 - Paris)** : Gère les bureaux régionaux, le calendrier national, les arbitres et les statistiques globales.
- **Sites régionaux (Région 2 à 5)** : Gèrent les données locales (clubs, stades, matchs, personnel) propres à leur région, sauf pour les arbitres.

## Travail Demandé
1. **Création des tables** : Concevoir les tables de la base de données centralisée et y insérer des données initiales.
2. **Création des comptes régionaux** : Créer des comptes d'utilisateur pour chaque site régional et leur accorder les privilèges nécessaires.
3. **Fragmentation et répartition** : Proposer une décomposition de la base de données en utilisant des techniques de fragmentation horizontale, verticale ou mixte, ainsi que la réplication des données.
4. **Création des fragments** : Allouer chaque fragment de données au site correspondant, en tenant compte des contraintes et des mises à jour.
5. **Création de déclencheurs** : Mettre en place des déclencheurs pour assurer l'intégrité des données entre les sites et les mises à jour nécessaires.
6. **Tests** : Tester les déclencheurs et les vues matérialisées.
7. **Couche logicielle** : Ajouter une couche logicielle qui masquera la répartition des données pour l'utilisateur final.
8. **Évaluation par les pairs** : Chaque membre de l'équipe doit évaluer ses coéquipiers sur leur contribution au projet.

## Résultats Attendus
Le projet doit aboutir à un système fonctionnel où les données sont réparties de manière cohérente entre les différents sites, avec un niveau élevé de disponibilité et d'intégrité. Une démonstration vidéo présentant les différentes étapes de configuration et de tests sera fournie.

## Date de Remise
Le projet doit être soumis avant le **24 octobre 2024 à 23H55**.