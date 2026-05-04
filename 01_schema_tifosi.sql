-- 1. Création sécurisée de la base (Correction du correcteur)
DROP DATABASE IF EXISTS tifosi;
CREATE DATABASE tifosi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tifosi;

-- 2. Création de l'utilisateur avec les bons privilèges (Correction du correcteur)
CREATE USER IF NOT EXISTS 'tifosi'@'localhost' IDENTIFIED BY 'mot_de_passe_tifosi';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- 3. Création des tables principales
CREATE TABLE marque (
    id_marque INT PRIMARY KEY,
    nom_marque VARCHAR(45) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE ingredient (
    id_ingredient INT PRIMARY KEY,
    nom_ingredient VARCHAR(45) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE focaccia (
    id_focaccia INT PRIMARY KEY,
    nom_focaccia VARCHAR(45) NOT NULL,
    prix_focaccia DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE boisson (
    id_boisson INT PRIMARY KEY,
    nom_boisson VARCHAR(45) NOT NULL,
    id_marque INT NOT NULL,
    FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
) ENGINE=InnoDB;

-- Correction : email en VARCHAR(45)
CREATE TABLE client (
    id_client INT PRIMARY KEY,
    nom_client VARCHAR(45) NOT NULL,
    age INT,
    cp_client INT,
    email VARCHAR(45) 
) ENGINE=InnoDB;

-- Correction : suppression de 'est_constitue' et ajout de id_focaccia directement ici
CREATE TABLE menu (
    id_menu INT PRIMARY KEY,
    nom_menu VARCHAR(45) NOT NULL,
    prix_menu DECIMAL(5,2) NOT NULL,
    id_focaccia INT NOT NULL,
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
) ENGINE=InnoDB;

-- 4. Création des tables de liaison
CREATE TABLE comprend (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    PRIMARY KEY (id_focaccia, id_ingredient),
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia),
    FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
) ENGINE=InnoDB;

CREATE TABLE contient (
    id_menu INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
) ENGINE=InnoDB;

-- Correction : ajout du champ quantité
CREATE TABLE achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    jour DATE NOT NULL,
    quantite INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_client, id_menu, jour),
    FOREIGN KEY (id_client) REFERENCES client(id_client),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
) ENGINE=InnoDB;