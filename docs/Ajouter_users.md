## Créer un Nouvel Utilisateur pour Chaque Site

Pour chaque site, y compris le site **centre**, exécutez les commandes suivantes pour créer un nouvel utilisateur avec les privilèges nécessaires pour accéder aux bases de données distantes.

### Créer un Utilisateur

Exécutez la commande suivante pour créer un nouvel utilisateur. Remplacez `nouvel_utilisateur` et `mot_de_passe` par les valeurs appropriées.

```sql
CREATE USER nouvel_utilisateur WITH PASSWORD 'mot_de_passe';
```

Accordez les privilèges nécessaires à l'utilisateur pour qu'il puisse se connecter et interroger les bases de données.

```sql
GRANT CONNECT ON DATABASE football TO nouvel_utilisateur;
GRANT USAGE ON SCHEMA public TO nouvel_utilisateur;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO nouvel_utilisateur;
```

## Exemple Complet
Voici un exemple complet des commandes à exécuter pour créer un utilisateur nommé `fdw_user` avec le mot de passe `fdw_password` :

```sql
CREATE USER fdw_user WITH PASSWORD 'fdw_password';
GRANT CONNECT ON DATABASE football TO fdw_user;
GRANT USAGE ON SCHEMA public TO fdw_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO fdw_user;
```
