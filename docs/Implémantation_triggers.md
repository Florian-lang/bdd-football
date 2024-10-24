# Documentation : Mise en Place des Triggers et Fonctions pour Synchronisation

Cette documentation décrit en détail l'implémentation des **triggers et fonctions** nécessaires pour garantir la **synchronisation automatique** des données entre les **sites régionaux** et le **site central**. Les triggers sont utilisés pour maintenir la cohérence des vues matérialisées et pour gérer automatiquement les mises à jour.

---

## **1. Gestion des Arbitres : Rafraîchissement de la Vue Matérialisée**

Sur **chaque site régional** (sauf le site central), exécutez les requêtes suivantes pour rafraîchir automatiquement la vue matérialisée `arbitres_repliques` après une modification des arbitres.

```sql
CREATE OR REPLACE FUNCTION refresh_arbitres_repliques() RETURNS TRIGGER AS $$
BEGIN
   REFRESH MATERIALIZED VIEW arbitres_repliques;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_refresh_arbitres_repliques
AFTER INSERT OR UPDATE ON arbitre
FOR EACH ROW EXECUTE FUNCTION refresh_arbitres_repliques();
```

---

## **2. Gestion des Calendriers Locaux**

### **Site Est :**
```sql
CREATE OR REPLACE FUNCTION refresh_calendrier_local_est() RETURNS TRIGGER AS $$
BEGIN
   EXECUTE 'REFRESH MATERIALIZED VIEW calendrier_local_est';
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_refresh_calendrier_local_est
AFTER INSERT OR UPDATE ON calendrier
FOR EACH ROW EXECUTE FUNCTION refresh_calendrier_local_est();
```

### **Site Nord :**
```sql
CREATE OR REPLACE FUNCTION refresh_calendrier_local_nord() RETURNS TRIGGER AS $$
BEGIN
   EXECUTE 'REFRESH MATERIALIZED VIEW calendrier_local_nord';
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_refresh_calendrier_local_nord
AFTER INSERT OR UPDATE ON calendrier
FOR EACH ROW EXECUTE FUNCTION refresh_calendrier_local_nord();
```

### **Site Ouest :**
```sql
CREATE OR REPLACE FUNCTION refresh_calendrier_local_ouest() RETURNS TRIGGER AS $$
BEGIN
   EXECUTE 'REFRESH MATERIALIZED VIEW calendrier_local_ouest';
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_refresh_calendrier_local_ouest
AFTER INSERT OR UPDATE ON calendrier
FOR EACH ROW EXECUTE FUNCTION refresh_calendrier_local_ouest();
```

### **Site Sud :**
```sql
CREATE OR REPLACE FUNCTION refresh_calendrier_local_sud() RETURNS TRIGGER AS $$
BEGIN
   EXECUTE 'REFRESH MATERIALIZED VIEW calendrier_local_sud';
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_refresh_calendrier_local_sud
AFTER INSERT OR UPDATE ON calendrier
FOR EACH ROW EXECUTE FUNCTION refresh_calendrier_local_sud();
```

---

## **3. Synchronisation des Équipes après Modification des Clubs**

```sql
CREATE OR REPLACE FUNCTION update_equipe_on_club_change() RETURNS TRIGGER AS $$
BEGIN
   UPDATE equipe
   SET nom_club = NEW.nom_club
   WHERE code_club = NEW.code_club;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_equipe
AFTER UPDATE ON club_sportif
FOR EACH ROW EXECUTE FUNCTION update_equipe_on_club_change();
```

---

## **4. Gestion du Personnel Technique après Suppression d’un Club**

```sql
CREATE OR REPLACE FUNCTION update_staff_on_club_change() RETURNS TRIGGER AS $$
BEGIN
   UPDATE staff_technique
   SET code_club = NULL
   WHERE code_club = OLD.code_club;
   RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_staff
AFTER DELETE ON club_sportif
FOR EACH ROW EXECUTE FUNCTION update_staff_on_club_change();
```