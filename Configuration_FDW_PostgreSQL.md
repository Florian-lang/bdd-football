
# Configuration et Mise en Place des Connexions FDW entre Sites PostgreSQL

Ce fichier détaille les étapes nécessaires pour configurer l'accès aux bases de données du **site central (centre)** depuis les autres **sites régionaux** à l'aide de **Foreign Data Wrapper (FDW)**. Cela permettra à chaque site d'interroger directement les données du site central sans duplication inutile.

---

## Étape 1 : Activer l'Extension FDW

Exécuter la commande suivante sur **tous les sites**, y compris le site **centre** :

```sql
CREATE EXTENSION IF NOT EXISTS postgres_fdw;
```

Cette extension permet d'utiliser le **Foreign Data Wrapper**, une fonctionnalité de PostgreSQL permettant d'accéder aux bases de données distantes.

---

## Étape 2 : Créer un Serveur Distant (FDW)

Exécuter les commandes suivantes sur **tous les sites** sauf le site **centre**. Ces commandes définissent un serveur distant pour accéder à la base de données du site central.

```sql
CREATE SERVER centre_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'centre', port '5432', dbname 'postgres');
```

Cette commande crée une référence au **serveur du site central**. Assurez-vous que le port 5432 est ouvert et accessible.

---

## Étape 3 : Créer un Mapping Utilisateur

Toujours sur **tous les sites sauf le site centre**, exécutez la commande suivante pour mapper l'utilisateur **postgres** local à l'utilisateur distant sur le site central.

```sql
CREATE USER MAPPING FOR postgres
SERVER centre_server
OPTIONS (user 'postgres', password 'centre');
```

Cela permet aux utilisateurs des sites régionaux d’utiliser les **informations d’identification du site central** pour accéder à la base de données.

---

## Étape 4 : Importer le Schéma du Site Central

Exécutez cette commande sur **chaque site régional** (nord, sud, est, ouest) pour importer le schéma **public** du site central. Cela rendra les tables du site central disponibles localement.

```sql
IMPORT FOREIGN SCHEMA public
FROM SERVER centre_server
INTO public;
```

Cette opération permet aux sites régionaux de consulter directement les tables du site central, comme si elles faisaient partie de leur propre base de données.

---

## Vérification et Tests

1. **Vérifiez la présence des tables importées** sur chaque site :
   ```sql
   \dt
   SELECT * FROM club_sportif LIMIT 10;
   ```

2. **Test d’insertion à travers le site régional** :
   Depuis un site régional, insérez un nouveau club dans la base du site central :
   ```sql
   INSERT INTO club_sportif (code_club, nom_club, date_creation, ville, region)
   VALUES ('202', 'Lyon FC', '1950-05-15', 'Lyon', 'Sud');
   ```

3. **Vérifiez que l'insertion a bien été effectuée** en interrogeant directement le site central :
   ```sql
   SELECT * FROM club_sportif WHERE code_club = '202';
   ```

