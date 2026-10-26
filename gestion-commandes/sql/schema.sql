-- Etape 2 : schema MySQL traduit du diagramme de classes
DROP DATABASE IF EXISTS gestion_commandes;
CREATE DATABASE gestion_commandes CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gestion_commandes;

CREATE TABLE client (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  nom        VARCHAR(100) NOT NULL,
  prenom     VARCHAR(100) NOT NULL,
  email      VARCHAR(150) NOT NULL UNIQUE,
  telephone  VARCHAR(30),
  adresse    VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE produit (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  designation VARCHAR(150) NOT NULL,
  prix        DECIMAL(10,2) NOT NULL CHECK (prix >= 0),
  stock       INT NOT NULL DEFAULT 0 CHECK (stock >= 0)
) ENGINE=InnoDB;

-- Association Client 1 --- * Commande
CREATE TABLE commande (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  date_commande DATE NOT NULL,
  statut        VARCHAR(20) NOT NULL DEFAULT 'EN_ATTENTE',
  client_id     INT NOT NULL,
  CONSTRAINT fk_commande_client FOREIGN KEY (client_id) REFERENCES client(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Classe d'association Commande * --- * Produit
CREATE TABLE ligne_commande (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  commande_id   INT NOT NULL,
  produit_id    INT NOT NULL,
  quantite      INT NOT NULL CHECK (quantite > 0),
  prix_unitaire DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_ligne_commande FOREIGN KEY (commande_id) REFERENCES commande(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_ligne_produit FOREIGN KEY (produit_id) REFERENCES produit(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Jeu de donnees de test
INSERT INTO client (nom, prenom, email, telephone, adresse) VALUES
 ('Alaoui','Sara','sara.alaoui@example.com','0600000001','Tanger'),
 ('Bennani','Youssef','youssef.bennani@example.com','0600000002','Tetouan');
INSERT INTO produit (designation, prix, stock) VALUES
 ('Clavier mecanique', 450.00, 25),
 ('Souris sans fil',   180.00, 60),
 ('Ecran 24 pouces',  1500.00, 10);
INSERT INTO commande (date_commande, statut, client_id) VALUES ('2026-10-20','VALIDEE',1);
INSERT INTO ligne_commande (commande_id, produit_id, quantite, prix_unitaire) VALUES
 (1,1,1,450.00),(1,2,2,180.00);
