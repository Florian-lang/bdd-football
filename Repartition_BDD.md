
# Documentation de la Répartition de la Base de Données par Région

Cette documentation détaille la **répartition horizontale, verticale, et la réplication** des tables entre les différents sites régionaux. Chaque site dispose de données spécifiques et partage certaines informations critiques via des **vues matérialisées**.

---

## **1. Fragmentation de la Table `club_sportif`**

### **Instructions :**
- **Site Est** :
  ```sql
  CREATE TABLE club_sportif_est AS
  SELECT * FROM club_sportif WHERE region = 'Auvergne-Rhone-Alpes';
  ```

- **Site Nord** :
  ```sql
  CREATE TABLE club_sportif_nord AS
  SELECT * FROM club_sportif WHERE region = 'Ile-de-France';
  ```

- **Site Ouest** :
  ```sql
  CREATE TABLE club_sportif_ouest AS
  SELECT * FROM club_sportif WHERE region = 'Monaco';
  ```

- **Site Sud** :
  ```sql
  CREATE TABLE club_sportif_sud AS
  SELECT * FROM club_sportif WHERE region = 'Provence-Alpes-Cote';
  ```

---

## **2. Réplication de la Table `dirigeant`**

Cette table est **répliquée** sur tous les sites.

```sql
CREATE MATERIALIZED VIEW dirigeant_repliqué AS
SELECT * FROM dirigeant;
```

- Si aucune donnée ne s’affiche, **rafraîchir la vue** :
  ```sql
  REFRESH MATERIALIZED VIEW dirigeant_repliqué;
  ```

---

## **3. Fragmentation de la Table `staff_technique`**

Chaque site conserve le **staff technique** de ses clubs.

- **Site Nord** :
  ```sql
  CREATE TABLE staff_technique_nord AS
  SELECT * FROM staff_technique
  WHERE code_club IN (SELECT code_club FROM club_sportif_nord);
  ```

- **Site Est** :
  ```sql
  CREATE TABLE staff_technique_est AS
  SELECT * FROM staff_technique
  WHERE code_club IN (SELECT code_club FROM club_sportif_est);
  ```

- **Site Ouest** :
  ```sql
  CREATE TABLE staff_technique_ouest AS
  SELECT * FROM staff_technique
  WHERE code_club IN (SELECT code_club FROM club_sportif_ouest);
  ```

- **Site Sud** :
  ```sql
  CREATE TABLE staff_technique_sud AS
  SELECT * FROM staff_technique
  WHERE code_club IN (SELECT code_club FROM club_sportif_sud);
  ```

---

## **4. Fragmentation de la Table `stade`**

Chaque site conserve ses propres stades.

- **Site Est** :
  ```sql
  CREATE TABLE stade_est AS
  SELECT * FROM stade WHERE region = 'Auvergne-Rhone-Alpes';
  ```

- **Site Nord** :
  ```sql
  CREATE TABLE stade_nord AS
  SELECT * FROM stade WHERE region = 'Ile-de-France';
  ```

- **Site Ouest** :
  ```sql
  CREATE TABLE stade_ouest AS
  SELECT * FROM stade WHERE region = 'Monaco';
  ```

- **Site Sud** :
  ```sql
  CREATE TABLE stade_sud AS
  SELECT * FROM stade WHERE region = 'Provence-Alpes-Cote';
  ```

---

## **5. Réplication de la Table `joueur`**

Chaque site réplique les informations sur les joueurs.

```sql
CREATE MATERIALIZED VIEW joueur_replique AS
SELECT * FROM joueur;
```

---

## **6. Fragmentation de la Table `equipe`**

Chaque site conserve les équipes de ses clubs.

- **Site Est** :
  ```sql
  CREATE TABLE equipe_est AS
  SELECT * FROM equipe WHERE code_club IN (SELECT code_club FROM club_sportif_est);
  ```

- **Site Nord** :
  ```sql
  CREATE TABLE equipe_nord AS
  SELECT * FROM equipe WHERE code_club IN (SELECT code_club FROM club_sportif_nord);
  ```

- **Site Ouest** :
  ```sql
  CREATE TABLE equipe_ouest AS
  SELECT * FROM equipe WHERE code_club IN (SELECT code_club FROM club_sportif_ouest);
  ```

- **Site Sud** :
  ```sql
  CREATE TABLE equipe_sud AS
  SELECT * FROM equipe WHERE code_club IN (SELECT code_club FROM club_sportif_sud);
  ```

---

## **7. Création de la Table `equipe_contrats` sur Tous les Sites**

```sql
CREATE TABLE equipe_contrats AS
SELECT code_joueur, date_debut_contrat, date_fin_contrat
FROM equipe;
```

---

## **8. Réplication de la Table `arbitre`**

```sql
CREATE MATERIALIZED VIEW arbitres_repliqués AS
SELECT * FROM arbitre;
```

---

## **9. Fragmentation de la Table `personnel`**

- **Site Est** :
  ```sql
  CREATE TABLE personnel_est AS
  SELECT * FROM personnel WHERE region = 'Auvergne-Rhone-Alpes';
  ```

- **Site Nord** :
  ```sql
  CREATE TABLE personnel_nord AS
  SELECT * FROM personnel WHERE region = 'Ile-de-France';
  ```

- **Site Ouest** :
  ```sql
  CREATE TABLE personnel_ouest AS
  SELECT * FROM personnel WHERE region = 'Monaco';
  ```

- **Site Sud** :
  ```sql
  CREATE TABLE personnel_sud AS
  SELECT * FROM personnel WHERE region = 'Provence-Alpes-Cote';
  ```

---

## **10. Fragmentation de la Table `match`**

- **Site Est** :
  ```sql
  CREATE TABLE match_est AS
  SELECT * FROM match WHERE code_stade IN (
    SELECT code FROM stade WHERE region = 'Auvergne-Rhone-Alpes'
  );
  ```

- **Site Nord** :
  ```sql
  CREATE TABLE match_nord AS
  SELECT * FROM match WHERE code_stade IN (
    SELECT code FROM stade WHERE region = 'Ile-de-France'
  );
  ```

---

## **11. Réplication de la Table `calendrier`**

```sql
CREATE MATERIALIZED VIEW calendrier_global AS
SELECT code_match, date_match, heure FROM calendrier;
```

Chaque site conserve aussi ses informations locales :

- **Site Est** :
  ```sql
  CREATE MATERIALIZED VIEW calendrier_local_est AS
  SELECT * FROM calendrier WHERE stade IN (
    SELECT code FROM stade WHERE region = 'Auvergne-Rhone-Alpes'
  );
  ```

---

## **12. Réplication de la Table `bureau`**

```sql
CREATE MATERIALIZED VIEW bureau_replique AS
SELECT * FROM bureau;
```
