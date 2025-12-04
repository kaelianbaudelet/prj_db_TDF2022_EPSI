-- 1.	La création de la base de données
CREATE DATABASE db_Tour_De_France;
GO
USE db_Tour_De_France;

-- 2.	La création des tables
CREATE TABLE Pays(
   code_pays VARCHAR(3),
   nom_pays VARCHAR(50) NOT NULL,
   PRIMARY KEY(code_pays)
);

CREATE TABLE Coureur(
   id_coureur INT,
   nom_coureur VARCHAR(255) NOT NULL,
   prenom_coureur VARCHAR(255) NOT NULL,
   date_naissance DATE NOT NULL,
   PRIMARY KEY(id_coureur),
   UNIQUE(nom_coureur)
);

CREATE TABLE Edition(
   id_edition INT,
   distance_km DECIMAL(15,2) NOT NULL,
   annee INT NOT NULL,
   PRIMARY KEY(id_edition)
);

CREATE TABLE Ville(
   id_ville INT,
   nom_ville VARCHAR(50) NOT NULL,
   code_postal VARCHAR(10) NOT NULL,
   code_pays VARCHAR(3) NOT NULL,
   PRIMARY KEY(id_ville),
   FOREIGN KEY(code_pays) REFERENCES Pays(code_pays)
);

CREATE TABLE Equipe(
   num_equipe VARCHAR(50),
   nom_equipe VARCHAR(50) NOT NULL,
   code_pays VARCHAR(3) NOT NULL,
   PRIMARY KEY(num_equipe),
   FOREIGN KEY(code_pays) REFERENCES Pays(code_pays)
);

CREATE TABLE Etape(
   id_edition INT,
   num_etape INT,
   date_etape DATETIME NOT NULL,
   type_etape VARCHAR(50) NOT NULL,
   distance_etape INT NOT NULL,
   nom_etape VARCHAR(255) NOT NULL,
   id_ville_depart INT NOT NULL,
   id_ville_arrive INT NOT NULL,
   PRIMARY KEY(id_edition, num_etape),
   FOREIGN KEY(id_edition) REFERENCES Edition(id_edition),
   FOREIGN KEY(id_ville_depart) REFERENCES Ville(id_ville),
   FOREIGN KEY(id_ville_arrive) REFERENCES Ville(id_ville)
);

CREATE TABLE edition_equipe_coureur(
   id_coureur INT,
   id_edition INT,
   num_equipe VARCHAR(50),
   PRIMARY KEY(id_coureur, id_edition, num_equipe),
   FOREIGN KEY(id_coureur) REFERENCES Coureur(id_coureur),
   FOREIGN KEY(id_edition) REFERENCES Edition(id_edition),
   FOREIGN KEY(num_equipe) REFERENCES Equipe(num_equipe)
);

CREATE TABLE etape_coureur(
   id_edition INT,
   num_etape INT,
   id_coureur INT,
   bonification INT,
   penalite TIME,
   a_abandonne BIT,
   est_exclu BIT,
   motif_exclusion TEXT,
   heure_arrive TIME NOT NULL,
   PRIMARY KEY(id_edition, num_etape, id_coureur),
   FOREIGN KEY(id_edition, num_etape) REFERENCES Etape(id_edition, num_etape),
   FOREIGN KEY(id_coureur) REFERENCES Coureur(id_coureur)
);

CREATE TABLE edition_coureur(
   id_coureur INT,
   id_edition INT,
   num_dossard INT NOT NULL,
   PRIMARY KEY(id_coureur, id_edition),
   FOREIGN KEY(id_coureur) REFERENCES Coureur(id_coureur),
   FOREIGN KEY(id_edition) REFERENCES Edition(id_edition)
);


