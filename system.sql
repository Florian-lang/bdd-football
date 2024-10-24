-- Creation de la table dirigeant
CREATE TABLE "dirigeant" (
    "code" INT PRIMARY KEY,
    "nom" VARCHAR(20),
    "prenom" VARCHAR(25),
    "profession" VARCHAR(100)
);

-- Insertion de 5 lignes dans la table dirigeant
INSERT INTO "dirigeant" ("code", "nom", "prenom", "profession") VALUES 
(1, 'Dupont', 'Jean', 'President'),
(2, 'Martin', 'Marie', 'Secretaire Generale'),
(3, 'Durand', 'Pierre', 'Tresorier'),
(4, 'Bernard', 'Sophie', 'Vice-Presidente'),
(5, 'Petit', 'Francois', 'Membre du conseil');

-- Creation de la table bureau
CREATE TABLE "bureau" (
    "region" VARCHAR(20) PRIMARY KEY,
    "nom" VARCHAR(100),
    "adresse" VARCHAR(200),
    "date_creation" DATE
);

-- Insertion de données dans la table bureau
INSERT INTO "bureau" ("region", "nom", "adresse", "date_creation") VALUES
('Ile-de-France', 'Bureau Paris', 'Adresse Paris', DATE '2000-01-01'),
('Auvergne-Rhone-Alpes', 'Bureau Lyon', 'Adresse Lyon', DATE '2000-01-01'),
('Provence-Alpes-Cote', 'Bureau Marseille', 'Adresse Marseille', DATE '2000-01-01'),
('Occitanie', 'Bureau Toulouse', 'Adresse Toulouse', DATE '2000-01-01'),
('Monaco', 'Bureau Monaco', 'Adresse Monaco', DATE '2000-01-01');

-- Creation de la table club_sportif
CREATE TABLE "club_sportif" (
    "code_club" INT PRIMARY KEY,
    "dirigeant" INT,
    "nom_club" VARCHAR(100),
    "region" VARCHAR(20),
    "date_creation" DATE,
    "ville" VARCHAR(100),
    FOREIGN KEY ("dirigeant") REFERENCES "dirigeant"("code"),
    FOREIGN KEY ("region") REFERENCES "bureau"("region")
);

-- Insertion de 5 lignes dans la table club_sportif
INSERT INTO "club_sportif" ("code_club", "dirigeant", "nom_club", "region", "date_creation", "ville") VALUES 
(1001, 1, 'FC Paris', 'Ile-de-France', DATE '1990-05-12', 'Paris'),
(1002, 2, 'Olympique Lyonnais', 'Auvergne-Rhone-Alpes', DATE '1950-08-15', 'Lyon'),
(1003, 3, 'Marseille FC', 'Provence-Alpes-Cote', DATE '1920-09-01', 'Marseille'),
(1004, 4, 'Toulouse FC', 'Occitanie', DATE '1970-11-22', 'Toulouse'),
(1005, 5, 'AS Monaco', 'Monaco', DATE '1960-04-01', 'Monaco');

-- Creation de la table stade
CREATE TABLE "stade" (
    "code" INT PRIMARY KEY,
    "nom" VARCHAR(100),
    "ville" VARCHAR(100),
    "region" VARCHAR(20),
    "capacite" INT,
    FOREIGN KEY ("region") REFERENCES "bureau"("region")
);

-- Insertion de 5 lignes dans la table stade
INSERT INTO "stade" ("code", "nom", "ville", "region", "capacite") VALUES 
(1, 'Stade de France', 'Saint-Denis', 'Ile-de-France', 81000),
(2, 'Groupama Stadium', 'Lyon', 'Auvergne-Rhone-Alpes', 59000),
(3, 'Stade Velodrome', 'Marseille', 'Provence-Alpes-Cote', 67000),
(4, 'Stadium de Toulouse', 'Toulouse', 'Occitanie', 33000),
(5, 'Stade Louis II', 'Monaco', 'Monaco', 18500);

-- Creation de la table staff_technique
CREATE TABLE "staff_technique" (
    "code" INT PRIMARY KEY,
    "nom" VARCHAR(100),
    "code_club" INT,
    "fonction" VARCHAR(100),
    FOREIGN KEY ("code_club") REFERENCES "club_sportif"("code_club")
);

-- Insertion de 5 lignes dans la table staff_technique
INSERT INTO "staff_technique" ("code", "nom", "code_club", "fonction") VALUES 
(1, 'Jean Dupont', 1001, 'Entraineur Principal'),
(2, 'Marie Martin', 1002, 'Entraineur Adjoint'),
(3, 'Pierre Durand', 1003, 'Preparateur Physique'),
(4, 'Sophie Bernard', 1004, 'Analyste de Performance'),
(5, 'Francois Petit', 1005, 'Medecin Sportif');

-- Creation de la table joueur
CREATE TABLE "joueur" (
    "code" INT PRIMARY KEY,
    "nom" VARCHAR(100),
    "prenom" VARCHAR(100),
    "date_naissance" DATE,
    "nationalite" VARCHAR(50),
    "poids" DECIMAL(5,2),
    "taille" DECIMAL(5,2),
    "classe" VARCHAR(50)
);

-- Insertion de 5 lignes dans la table joueur
INSERT INTO "joueur" ("code", "nom", "prenom", "date_naissance", "nationalite", "poids", "taille", "classe") VALUES 
(1, 'Dupont', 'Alex', DATE '1995-05-12', 'Française', 75.0, 1.80, 'Attaquant'),
(2, 'Martin', 'Sophie', DATE '1997-08-22', 'Française', 60.0, 1.65, 'Milieu de terrain'),
(3, 'Durand', 'Paul', DATE '1990-11-05', 'Française', 80.0, 1.85, 'Défenseur'),
(4, 'Bernard', 'Lucie', DATE '1998-02-15', 'Française', 55.0, 1.70, 'Gardien'),
(5, 'Petit', 'François', DATE '2000-04-30', 'Française', 70.0, 1.78, 'Ailier');

-- Creation de la table equipe
CREATE TABLE "equipe" (
    "code_club" INT,
    "code_joueur" INT,
    "date_debut_contrat" DATE,
    "date_fin_contrat" DATE,
    "numero_maillot" INT,
    "poste" VARCHAR(50),
    FOREIGN KEY ("code_club") REFERENCES "club_sportif"("code_club"),
    FOREIGN KEY ("code_joueur") REFERENCES "joueur"("code")
);

-- Insertion de 5 lignes dans la table equipe
INSERT INTO "equipe" ("code_club", "code_joueur", "date_debut_contrat", "date_fin_contrat", "numero_maillot", "poste") VALUES 
(1001, 1, DATE '2022-07-01', DATE '2025-07-01', 9, 'Attaquant'),
(1001, 2, DATE '2021-07-01', DATE '2024-07-01', 8, 'Milieu de terrain'),
(1002, 3, DATE '2023-01-01', DATE '2026-01-01', 5, 'Défenseur'),
(1002, 4, DATE '2022-09-01', DATE '2025-09-01', 1, 'Gardien'),
(1003, 5, DATE '2023-03-01', DATE '2026-03-01', 7, 'Ailier');

-- Creation de la table arbitre
CREATE TABLE "arbitre" (
    "code" INT PRIMARY KEY,
    "nom" VARCHAR(100),
    "prenom" VARCHAR(100),
    "date_de_naissance" DATE,
    "region" VARCHAR(20),
    "club_prefere" VARCHAR(100),
    FOREIGN KEY ("region") REFERENCES "bureau"("region")
);

-- Insertion de 5 lignes dans la table arbitre
INSERT INTO "arbitre" ("code", "nom", "prenom", "date_de_naissance", "region", "club_prefere") VALUES 
(1, 'Leroy', 'Alice', DATE '1985-04-15', 'Ile-de-France', 'FC Paris'),
(2, 'Girard', 'Lucas', DATE '1990-03-25', 'Auvergne-Rhone-Alpes', 'Olympique Lyonnais'),
(3, 'Martinez', 'Isabelle', DATE '1988-12-05', 'Provence-Alpes-Cote', 'Marseille FC'),
(4, 'Dupuis', 'Nicolas', DATE '1992-07-12', 'Occitanie', 'Toulouse FC'),
(5, 'Bonnet', 'Clara', DATE '1995-11-30', 'Monaco', 'AS Monaco');

-- Creation de la table personnel
CREATE TABLE "personnel" (
    "code" INT PRIMARY KEY,
    "nom" VARCHAR(100),
    "prenom" VARCHAR(100),
    "date_de_naissance" DATE,
    "fonction" VARCHAR(100),
    "region" VARCHAR(20),
    "ville" VARCHAR(100),
    FOREIGN KEY ("region") REFERENCES "bureau"("region")
);

-- Insertion de 5 lignes dans la table personnel
INSERT INTO "personnel" ("code", "nom", "prenom", "date_de_naissance", "fonction", "region", "ville") VALUES 
(1, 'Lemoine', 'Jean', DATE '1980-03-12', 'Physiotherapeute', 'Ile-de-France', 'Paris'),
(2, 'Dubois', 'Claire', DATE '1985-06-25', 'Securite', 'Auvergne-Rhone-Alpes', 'Lyon'),
(3, 'Roche', 'Sophie', DATE '1992-08-30', 'Responsable logistique', 'Provence-Alpes-Cote', 'Marseille'),
(4, 'Petit', 'Laurent', DATE '1975-11-15', 'Kinesitherapeute', 'Occitanie', 'Toulouse'),
(5, 'Garcia', 'Antoine', DATE '1988-09-22', 'Assistant medical', 'Monaco', 'Monaco');

-- Creation de la table match
CREATE TABLE "match" (
    "code_match" INT PRIMARY KEY,
    "nbre_buts_club_a" INT,
    "nbre_buts_club_b" INT,
    "nbre_spectateurs" INT,
    "code_arbitre" INT,
    "code_stade" INT,
    FOREIGN KEY ("code_arbitre") REFERENCES "arbitre"("code"),
    FOREIGN KEY ("code_stade") REFERENCES "stade"("code")
);

-- Insertion de 5 lignes dans la table match
INSERT INTO "match" ("code_match", "nbre_buts_club_a", "nbre_buts_club_b", "nbre_spectateurs", "code_arbitre", "code_stade") VALUES 
(1, 2, 1, 50000, 1, 1),
(2, 3, 2, 45000, 2, 2),
(3, 1, 1, 60000, 3, 3),
(4, 0, 0, 30000, 4, 4),
(5, 4, 3, 20000, 5, 5);

-- Creation de la table palmares
CREATE TABLE "palmares" (
    "code_club" INT,
    "annee" INT,
    "trophee" VARCHAR(100),
    "nbre_matchs_gagnes" INT,
    "nbre_matchs_perdus" INT,
    FOREIGN KEY ("code_club") REFERENCES "club_sportif"("code_club")
);

-- Insertion de 5 lignes dans la table palmares
INSERT INTO "palmares" ("code_club", "annee", "trophee", "nbre_matchs_gagnes", "nbre_matchs_perdus") VALUES 
(1001, 2020, 'Championnat de France', 25, 5),
(1002, 2021, 'Coupe de France', 18, 2),
(1003, 2022, 'Trophee des Champions', 20, 3),
(1004, 2021, 'Ligue 1', 22, 4),
(1005, 2023, 'Coupe de la Ligue', 15, 5);

-- Creation de la table calendrier
CREATE TABLE "calendrier" (
    "code_match" INT,
    "date_match" DATE,
    "heure" VARCHAR(100),
    "club_a" INT,
    "club_b" INT,
    "stade" INT,
    PRIMARY KEY ("code_match"),
    FOREIGN KEY ("code_match") REFERENCES "match"("code_match"),
    FOREIGN KEY ("club_a") REFERENCES "club_sportif"("code_club"),
    FOREIGN KEY ("club_b") REFERENCES "club_sportif"("code_club"),
    FOREIGN KEY ("stade") REFERENCES "stade"("code")
);

-- Insertion de 5 lignes dans la table calendrier
INSERT INTO "calendrier" ("code_match", "date_match", "heure", "club_a", "club_b", "stade") VALUES 
(1, DATE '2024-10-15', '20:00', 1001, 1002, 1),
(2, DATE '2024-10-22', '18:30', 1003, 1004, 3),
(3, DATE '2024-11-05', '21:00', 1005, 1001, 5),
(4, DATE '2024-11-12', '19:00', 1002, 1003, 2),
(5, DATE '2024-11-19', '16:00', 1004, 1005, 4);

-- Remplacer DESCRIBE par \d pour PostgreSQL
-- \d "dirigeant";
-- \d "club_sportif";
-- \d "staff_technique";
-- \d "stade";
-- \d "joueur";
-- \d "equipe";
-- \d "arbitre";
-- \d "personnel";
-- \d "match";
-- \d "palmares";
-- \d "calendrier";
-- \d "bureau";

-- Corriger les commandes ALTER TABLE
ALTER TABLE "arbitre" ALTER COLUMN "region" TYPE VARCHAR(30);
ALTER TABLE "club_sportif" ALTER COLUMN "region" TYPE VARCHAR(30);
ALTER TABLE "bureau" ALTER COLUMN "region" TYPE VARCHAR(30);