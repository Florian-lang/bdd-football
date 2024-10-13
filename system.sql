-- Creation de la table Dirigeant
CREATE TABLE Dirigeant (
    code INT PRIMARY KEY,
    nom VARCHAR(20),
    prenom VARCHAR(25),
    Profession VARCHAR(100)
);

-- Insertion de 5 lignes dans la table Dirigeant
INSERT INTO Dirigeant (code, nom, prenom, Profession) VALUES 
(1, 'Dupont', 'Jean', 'President'),
(2, 'Martin', 'Marie', 'Secretaire Generale'),
(3, 'Durand', 'Pierre', 'Tresorier'),
(4, 'Bernard', 'Sophie', 'Vice-Presidente'),
(5, 'Petit', 'Francois', 'Membre du conseil');

-- Creation de la table Bureau
CREATE TABLE Bureau (
    Region VARCHAR(20) PRIMARY KEY,
    Nom VARCHAR(100),
    Adresse VARCHAR(200),
    DateCreation DATE
);

-- Insertion de données dans la table Bureau
INSERT INTO Bureau (Region, Nom, Adresse, DateCreation) VALUES
('Ile-de-France', 'Bureau Paris', 'Adresse Paris', DATE '2000-01-01'),
('Auvergne-Rhone-Alpes', 'Bureau Lyon', 'Adresse Lyon', DATE '2000-01-01'),
('Provence-Alpes-Cote', 'Bureau Marseille', 'Adresse Marseille', DATE '2000-01-01'),
('Occitanie', 'Bureau Toulouse', 'Adresse Toulouse', DATE '2000-01-01'),
('Monaco', 'Bureau Monaco', 'Adresse Monaco', DATE '2000-01-01');

-- Creation de la table ClubSportif
CREATE TABLE ClubSportif (
    CodeClub INT PRIMARY KEY,
    Dirigeant INT,
    NomClub VARCHAR(100),
    Region VARCHAR(20),
    DateCreation DATE,
    Ville VARCHAR(100),
    FOREIGN KEY (Dirigeant) REFERENCES Dirigeant(code),
    FOREIGN KEY (Region) REFERENCES Bureau(Region)
);

-- Insertion de 5 lignes dans la table ClubSportif
INSERT INTO ClubSportif (CodeClub, Dirigeant, NomClub, Region, DateCreation, Ville) VALUES 
(1001, 1, 'FC Paris', 'Ile-de-France', DATE '1990-05-12', 'Paris'),
(1002, 2, 'Olympique Lyonnais', 'Auvergne-Rhone-Alpes', DATE '1950-08-15', 'Lyon'),
(1003, 3, 'Marseille FC', 'Provence-Alpes-Cote', DATE '1920-09-01', 'Marseille'),
(1004, 4, 'Toulouse FC', 'Occitanie', DATE '1970-11-22', 'Toulouse'),
(1005, 5, 'AS Monaco', 'Monaco', DATE '1960-04-01', 'Monaco');

-- Creation de la table Stade
CREATE TABLE Stade (
    Code INT PRIMARY KEY,
    Nom VARCHAR(100),
    Ville VARCHAR(100),
    Region VARCHAR(20),
    Capacite INT,
    FOREIGN KEY (Region) REFERENCES Bureau(Region)
);

-- Insertion de 5 lignes dans la table Stade
INSERT INTO Stade (Code, Nom, Ville, Region, Capacite) VALUES 
(1, 'Stade de France', 'Saint-Denis', 'Ile-de-France', 81000),
(2, 'Groupama Stadium', 'Lyon', 'Auvergne-Rhone-Alpes', 59000),
(3, 'Stade Velodrome', 'Marseille', 'Provence-Alpes-Cote', 67000),
(4, 'Stadium de Toulouse', 'Toulouse', 'Occitanie', 33000),
(5, 'Stade Louis II', 'Monaco', 'Monaco', 18500);

-- Creation de la table StaffTechnique
CREATE TABLE StaffTechnique (
    Code INT PRIMARY KEY,
    Nom VARCHAR(100),
    CodeClub INT,
    Fonction VARCHAR(100),
    FOREIGN KEY (CodeClub) REFERENCES ClubSportif(CodeClub)
);

-- Insertion de 5 lignes dans la table StaffTechnique
INSERT INTO StaffTechnique (Code, Nom, CodeClub, Fonction) VALUES 
(1, 'Jean Dupont', 1001, 'Entraineur Principal'),
(2, 'Marie Martin', 1002, 'Entraineur Adjoint'),
(3, 'Pierre Durand', 1003, 'Preparateur Physique'),
(4, 'Sophie Bernard', 1004, 'Analyste de Performance'),
(5, 'Francois Petit', 1005, 'Medecin Sportif');

-- Creation de la table Joueur
CREATE TABLE Joueur (
    Code INT PRIMARY KEY,
    Nom VARCHAR(100),
    Prenom VARCHAR(100),
    DateNaissance DATE,
    Nationalite VARCHAR(50),
    Poids DECIMAL(5,2),
    Taille DECIMAL(5,2),
    Classe VARCHAR(50)
);

-- Insertion de 5 lignes dans la table Joueur
INSERT INTO Joueur (Code, Nom, Prenom, DateNaissance, Nationalite, Poids, Taille, Classe) VALUES 
(1, 'Dupont', 'Alex', DATE '1995-05-12', 'Française', 75.0, 1.80, 'Attaquant'),
(2, 'Martin', 'Sophie', DATE '1997-08-22', 'Française', 60.0, 1.65, 'Milieu de terrain'),
(3, 'Durand', 'Paul', DATE '1990-11-05', 'Française', 80.0, 1.85, 'Défenseur'),
(4, 'Bernard', 'Lucie', DATE '1998-02-15', 'Française', 55.0, 1.70, 'Gardien'),
(5, 'Petit', 'François', DATE '2000-04-30', 'Française', 70.0, 1.78, 'Ailier');

-- Creation de la table Equipe
CREATE TABLE Equipe (
    CodeClub INT,
    CodeJoueur INT,
    DateDebutContrat DATE,
    DateFinContrat DATE,
    NumeroMaillot INT,
    Poste VARCHAR(50),
    FOREIGN KEY (CodeClub) REFERENCES ClubSportif(CodeClub),
    FOREIGN KEY (CodeJoueur) REFERENCES Joueur(Code)
);

-- Insertion de 5 lignes dans la table Equipe
INSERT INTO Equipe (CodeClub, CodeJoueur, DateDebutContrat, DateFinContrat, NumeroMaillot, Poste) VALUES 
(1001, 1, DATE '2022-07-01', DATE '2025-07-01', 9, 'Attaquant'),
(1001, 2, DATE '2021-07-01', DATE '2024-07-01', 8, 'Milieu de terrain'),
(1002, 3, DATE '2023-01-01', DATE '2026-01-01', 5, 'Défenseur'),
(1002, 4, DATE '2022-09-01', DATE '2025-09-01', 1, 'Gardien'),
(1003, 5, DATE '2023-03-01', DATE '2026-03-01', 7, 'Ailier');

-- Creation de la table Arbitre
CREATE TABLE Arbitre (
    Code INT PRIMARY KEY,
    Nom VARCHAR(100),
    Prenom VARCHAR(100),
    DateDeNaissance DATE,
    Region VARCHAR(20),
    ClubPrefere VARCHAR(100),
    FOREIGN KEY (Region) REFERENCES Bureau(Region)
);

-- Insertion de 5 lignes dans la table Arbitre
INSERT INTO Arbitre (Code, Nom, Prenom, DateDeNaissance, Region, ClubPrefere) VALUES 
(1, 'Leroy', 'Alice', DATE '1985-04-15', 'Ile-de-France', 'FC Paris'),
(2, 'Girard', 'Lucas', DATE '1990-03-25', 'Auvergne-Rhone-Alpes', 'Olympique Lyonnais'),
(3, 'Martinez', 'Isabelle', DATE '1988-12-05', 'Provence-Alpes-Cote', 'Marseille FC'),
(4, 'Dupuis', 'Nicolas', DATE '1992-07-12', 'Occitanie', 'Toulouse FC'),
(5, 'Bonnet', 'Clara', DATE '1995-11-30', 'Monaco', 'AS Monaco');

-- Creation de la table Personnel
CREATE TABLE Personnel (
    Code INT PRIMARY KEY,
    Nom VARCHAR(100),
    Prenom VARCHAR(100),
    DateDeNaissance DATE,
    Fonction VARCHAR(100),
    Region VARCHAR(20),
    Ville VARCHAR(100),
    FOREIGN KEY (Region) REFERENCES Bureau(Region)
);

-- Insertion de 5 lignes dans la table Personnel
INSERT INTO Personnel (Code, Nom, Prenom, DateDeNaissance, Fonction, Region, Ville) VALUES 
(1, 'Lemoine', 'Jean', DATE '1980-03-12', 'Physiotherapeute', 'Ile-de-France', 'Paris'),
(2, 'Dubois', 'Claire', DATE '1985-06-25', 'Securite', 'Auvergne-Rhone-Alpes', 'Lyon'),
(3, 'Roche', 'Sophie', DATE '1992-08-30', 'Responsable logistique', 'Provence-Alpes-Cote', 'Marseille'),
(4, 'Petit', 'Laurent', DATE '1975-11-15', 'Kinesitherapeute', 'Occitanie', 'Toulouse'),
(5, 'Garcia', 'Antoine', DATE '1988-09-22', 'Assistant medical', 'Monaco', 'Monaco');

-- Creation de la table Match
CREATE TABLE Match (
    CodeMatch INT PRIMARY KEY,
    NbreButsClubA INT,
    NbreButsClubB INT,
    NbreSpectateurs INT,
    CodeArbitre INT,
    CodeStade INT,
    FOREIGN KEY (CodeArbitre) REFERENCES Arbitre(Code),
    FOREIGN KEY (CodeStade) REFERENCES Stade(Code)
);

-- Insertion de 5 lignes dans la table Match
INSERT INTO Match (CodeMatch, NbreButsClubA, NbreButsClubB, NbreSpectateurs, CodeArbitre, CodeStade) VALUES 
(1, 2, 1, 50000, 1, 1),
(2, 3, 2, 45000, 2, 2),
(3, 1, 1, 60000, 3, 3),
(4, 0, 0, 30000, 4, 4),
(5, 4, 3, 20000, 5, 5);

-- Creation de la table Palmares
CREATE TABLE Palmares (
    CodeClub INT,
    Annee INT,
    Trophee VARCHAR(100),
    NbreMatchsGagnes INT,
    NbreMatchsPerdus INT,
    FOREIGN KEY (CodeClub) REFERENCES ClubSportif(CodeClub)
);

-- Insertion de 5 lignes dans la table Palmares
INSERT INTO Palmares (CodeClub, Annee, Trophee, NbreMatchsGagnes, NbreMatchsPerdus) VALUES 
(1001, 2020, 'Championnat de France', 25, 5),
(1002, 2021, 'Coupe de France', 18, 2),
(1003, 2022, 'Trophee des Champions', 20, 3),
(1004, 2021, 'Ligue 1', 22, 4),
(1005, 2023, 'Coupe de la Ligue', 15, 5);

-- Creation de la table Calendrier
CREATE TABLE Calendrier (
    CodeMatch INT,
    DateMatch DATE,
    Heure VARCHAR(100),
    ClubA INT,
    ClubB INT,
    Stade INT,
    PRIMARY KEY (CodeMatch),
    FOREIGN KEY (CodeMatch) REFERENCES Match(CodeMatch),
    FOREIGN KEY (ClubA) REFERENCES ClubSportif(CodeClub),
    FOREIGN KEY (ClubB) REFERENCES ClubSportif(CodeClub),
    FOREIGN KEY (Stade) REFERENCES Stade(Code)
);

-- Insertion de 5 lignes dans la table Calendrier
INSERT INTO Calendrier (CodeMatch, DateMatch, Heure, ClubA, ClubB, Stade) VALUES 
(1, DATE '2024-10-15', '20:00', 1001, 1002, 1),
(2, DATE '2024-10-22', '18:30', 1003, 1004, 3),
(3, DATE '2024-11-05', '21:00', 1005, 1001, 5),
(4, DATE '2024-11-12', '19:00', 1002, 1003, 2),
(5, DATE '2024-11-19', '16:00', 1004, 1005, 4);

-- Remplacer DESCRIBE par \d pour PostgreSQL
-- \d Dirigeant;
-- \d ClubSportif;
-- \d StaffTechnique;
-- \d Stade;
-- \d Joueur;
-- \d Equipe;
-- \d Arbitre;
-- \d Personnel;
-- \d Match;
-- \d Palmares;
-- \d Calendrier;
-- \d Bureau;

-- Corriger les commandes ALTER TABLE
ALTER TABLE Arbitre ALTER COLUMN Region TYPE VARCHAR(30);
ALTER TABLE ClubSportif ALTER COLUMN Region TYPE VARCHAR(30);
ALTER TABLE Bureau ALTER COLUMN Region TYPE VARCHAR(30);