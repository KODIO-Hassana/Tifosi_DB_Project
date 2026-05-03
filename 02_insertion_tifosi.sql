-- 1. Création de la base de données
CREATE DATABASE IF NOT EXISTS tifosi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tifosi;

-- 2. Création de l'utilisateur (à exécuter avec les droits root/administrateur)
CREATE USER IF NOT EXISTS 'tifosi'@'localhost' IDENTIFIED BY 'MotDePasse123!';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

-- 3. Création des tables "Simples" (sans clés étrangères)
CREATE TABLE IF NOT EXISTS marque (
    id_marque INT PRIMARY KEY,
    nom_marque VARCHAR(45) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ingredient (
    id_ingredient INT PRIMARY KEY,
    nom_ingredient VARCHAR(45) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS focaccia (
    id_focaccia INT PRIMARY KEY,
    nom_focaccia VARCHAR(45) NOT NULL,
    prix_focaccia DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS client (
    id_client INT PRIMARY KEY,
    nom_client VARCHAR(45) NOT NULL,
    email_client VARCHAR(45) NOT NULL UNIQUE,
    cp_client INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS menu (
    id_menu INT PRIMARY KEY,
    nom_menu VARCHAR(45) NOT NULL,
    prix_menu DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB;

-- 4. Création des tables "Enfants" (avec clés étrangères)
CREATE TABLE IF NOT EXISTS boisson (
    id_boisson INT PRIMARY KEY,
    nom_boisson VARCHAR(45) NOT NULL,
    id_marque INT NOT NULL,
    FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
) ENGINE=InnoDB;

-- 5. Création des tables de liaison (pour relier les éléments entre eux)
CREATE TABLE IF NOT EXISTS comprend (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    PRIMARY KEY (id_focaccia, id_ingredient),
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia),
    FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS contient (
    id_menu INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS est_constitue (
    id_menu INT NOT NULL,
    id_focaccia INT NOT NULL,
    PRIMARY KEY (id_menu, id_focaccia),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    jour DATE NOT NULL,
    PRIMARY KEY (id_client, id_menu, jour),
    FOREIGN KEY (id_client) REFERENCES client(id_client),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
) ENGINE=InnoDB;