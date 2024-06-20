DROP DATABASE IF EXISTS projectus;
CREATE DATABASE IF NOT EXISTS projectus;

USE projectus;

CREATE TABLE IF NOT EXISTS Utenti (
    ID_Utente INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    isAdmin BOOL
);

CREATE TABLE IF NOT EXISTS Squadre (
    Nome VARCHAR(50) PRIMARY KEY,
    urlImmagine VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Prodotti (
    Id_Prodotto INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Prezzo DECIMAL(10, 2) NOT NULL,
    Tipologia VARCHAR(50) NOT NULL CHECK (Tipologia IN ('Maglia', 'Scarpa', 'Pallone')),
    Squadra VARCHAR(50) DEFAULT NULL,
    Produttore VARCHAR(50) DEFAULT NULL,
    Collezione VARCHAR(50) DEFAULT NULL,
    urlImmagine VARCHAR(50) NULL,
    FOREIGN KEY (Squadra) REFERENCES Squadre(Nome) ON DELETE CASCADE,
    CONSTRAINT checkProdotti CHECK (Tipologia = 'Maglia' OR Squadra IS NULL)
);

CREATE TABLE IF NOT EXISTS Taglie (
    Taglia VARCHAR(5) PRIMARY KEY,
    Tipologia VARCHAR(50) NOT NULL CHECK (Tipologia IN ('Maglia', 'Scarpa', 'Pallone')),
    Descrizione VARCHAR(100) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS ProdottiTaglie (
    Prodotto INT,
    Taglia VARCHAR(5),
    Quantita INT,
    PRIMARY KEY (Prodotto, Taglia),
    FOREIGN KEY (Prodotto) REFERENCES Prodotti(Id_Prodotto) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Taglia) REFERENCES Taglie(Taglia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Ordini (
    ID_Ordine INT,
    Utente INT,
    Prodotto INT,
    Taglia VARCHAR(5),
    Quantita INT,
    Prezzo DECIMAL(10, 2) DEFAULT 0,
    PRIMARY KEY(ID_Ordine, Utente, Prodotto, Taglia),
    FOREIGN KEY (Utente) REFERENCES Utenti(ID_Utente) on delete cascade ON UPDATE CASCADE,
    FOREIGN KEY (Prodotto, Taglia) REFERENCES ProdottiTaglie(Prodotto, Taglia) ON DELETE cascade ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Carrello (
    Utente INT,
    Prodotto INT,
    Taglia VARCHAR(5),
    Quantita INT,
    PRIMARY KEY(Utente, Prodotto, Taglia),
    FOREIGN KEY(Utente) REFERENCES Utenti(ID_Utente) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Prodotto, Taglia) REFERENCES ProdottiTaglie(Prodotto, Taglia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TRIGGER checkProdottiTaglie BEFORE INSERT ON ProdottiTaglie
FOR EACH ROW
BEGIN
    DECLARE prodTipo VARCHAR(50);
    DECLARE tagliaTipo VARCHAR(50);

    -- cattura tipologia prodotto
    SELECT tipologia INTO prodTipo FROM Prodotti WHERE ID_Prodotto = NEW.Prodotto;

    -- cattura tipologia taglia
    SELECT tipologia INTO tagliaTipo FROM Taglie WHERE Taglia = NEW.Taglia;

    -- verifica uguaglianza
    IF prodTipo != tagliaTipo THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipologie prodotto e taglia non corrispondono';
    END IF;
END;

CREATE TRIGGER checkQuantitaOrdini BEFORE INSERT ON Ordini
FOR EACH ROW
BEGIN
    DECLARE disponibile INT;

    -- cattura quantità
    SELECT Quantita INTO disponibile FROM ProdottiTaglie WHERE Prodotto = NEW.Prodotto AND Taglia = NEW.Taglia;

    -- verifica
    IF NEW.Quantita > disponibile THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La quantità ordinata è maggiore della quantità disponibile';
    END IF;
END;

CREATE TRIGGER checkQuantitaCarrello BEFORE INSERT ON Carrello
FOR EACH ROW
BEGIN
    DECLARE disponibile INT;

    -- cattura quantità
    SELECT Quantita INTO disponibile FROM ProdottiTaglie WHERE Prodotto = NEW.Prodotto AND Taglia = NEW.Taglia;

    -- verifica
    IF NEW.Quantita > disponibile THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La quantità inserita nel carrello è maggiore della quantità disponibile';
    END IF;
END;

CREATE TRIGGER setPrezzo BEFORE INSERT ON Ordini
FOR EACH ROW
BEGIN
    DECLARE prezzoProdotto DECIMAL(10, 2);

    -- cattura prezzo prodotto
    SELECT Prezzo INTO prezzoProdotto FROM Prodotti WHERE ID_Prodotto = NEW.Prodotto;

    -- imposta
    SET NEW.Prezzo = prezzoProdotto * NEW.Quantita;
END;

CREATE TRIGGER updateQuantita AFTER INSERT ON Ordini
FOR EACH ROW
BEGIN
    -- aggiorna quantità disponibile
    UPDATE ProdottiTaglie SET Quantita = Quantita - NEW.Quantita WHERE Prodotto = NEW.Prodotto AND Taglia = NEW.Taglia;
END;

-- insersco cose a caso
INSERT INTO Utenti VALUES
    (1, 'domeCiri', 'domenicoCirillo@gmail.com', 'e42e43478ac14e5045d138fc992f2577d3643782', TRUE), -- password: dom25!
    (2, 'micheAnn', 'micheleAnnunziata@gmail.com', 'd70ba364c4c6374d020b95ac74521079760a7274', TRUE); -- password: micAnn_20

INSERT INTO Squadre VALUES
    ('Milan', 'img/squadre/Milan.png'),
    ('Napoli', 'img/squadre/Napoli.png'),
    ('Barcelona', 'img/squadre/Barcelona.png'),
    ('Liverpool', 'img/squadre/Liverpool.png'),
    ('Juventus', 'img/squadre/Juventus.png');

INSERT INTO Prodotti VALUES
    (1, 'Maglia Milan Home 23/24', 99.99, 'Maglia', 'Milan', 'Puma', 'Serie A 23/24', 'img/prod/1.png'),
    (2, 'Maglia Napoli Home 23/24', 89.99, 'Maglia', 'Napoli', 'Emporio Armani', 'Serie A 23/24', 'img/prod/2.png');

INSERT INTO Taglie(Taglia, Tipologia) VALUES
    ('L', 'Maglia'), ('5', 'Pallone'), ('M', 'Maglia'), ('XL', 'Maglia');

INSERT INTO ProdottiTaglie VALUES
    (1, 'L', 100), (1, 'M', 30), (2, 'L', 20);

INSERT INTO Ordini(ID_Ordine, Utente, Prodotto, Taglia, Quantita) VALUES
    (1, 1, 1, 'L', 2), (1, 1, 2, 'L', 1);

INSERT INTO Carrello VALUES (1, 2, 'L', 19);