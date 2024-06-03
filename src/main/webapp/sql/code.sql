drop database if exists projectus;
create database if not exists projectus;

use projectus;

create table if not exists Utenti (
                                      ID_Utente int primary key auto_increment,
                                      Username varchar(50) not null unique, -- forse bisogna mettere unique
    Email varchar(100) not null unique,
    PasswordHash varchar(255) not null,
    isAdmin bool
    );

create table if not exists Squadre (
    Nome varchar(50) primary key,
    urlImmagine varchar(255) not null
    );


create table if not exists Prodotti (
                                        Id_Prodotto int primary key auto_increment,
                                        Nome varchar(100) not null,
    Prezzo decimal(10, 2) not null,
    Tipologia varchar(50) not null
    check (Tipologia in ('Maglia', 'Scarpa', 'Pallone')),
    Squadra varchar(50) default null,
    Produttore varchar(50) default null,
    Collezione varchar(50) default null,
    urlImmagine varchar(50) null,

    foreign key (Squadra) references Squadre(Nome),

    constraint checkProdotti
    check (Tipologia = "Maglia" or Squadra is null)
    );

create table if not exists Taglie (
    Taglia varchar(5) primary key,
    Tipologia varchar(50) not null
    check (Tipologia in ('Maglia', 'Scarpa', 'Pallone')),
    Descrizione varchar(100) default null
    );

create table if not exists ProdottiTaglie (
                                              Prodotto int, Taglia varchar(5),
    Quantita int,
    primary key (Prodotto, Taglia),
    foreign key (Prodotto) references Prodotti(ID_Prodotto),
    foreign key (Taglia) references Taglie(Taglia)
    );

-- poi vediamo come generare il codice dell'ordine
create table if not exists Ordini (
                                      ID_Ordine int, Utente int,
                                      Prodotto int, Taglia varchar(5), Quantita int,
    Prezzo decimal(10, 2) default 0, -- ridondante, calcolato da un trigger
    primary key(ID_Ordine, Utente, Prodotto, Taglia),
    foreign key (Utente) references Utenti(ID_Utente),
    foreign key (Prodotto, Taglia) references ProdottiTaglie(Prodotto, Taglia)
    );

-- prima di inserire una tupla in prodottiTaglie,
-- controlla che la tipologia di prodotto sia uguale
-- a quella della taglia
create trigger checkProdottiTaglie before insert on ProdottiTaglie
    for each row
begin
    declare prodTipo varchar(50);
    declare tagliaTipo varchar(50);

    -- cattura tipologia prodotto
    select tipologia into prodTipo FROM Prodotti
    where ID_Prodotto = new.Prodotto;

    -- cattura tipologia taglia
    select tipologia into tagliaTipo from Taglie
    where Taglia = new.Taglia;

    -- verifica uguaglianza
    if prodTipo != tagliaTipo then
        signal sqlstate '45000'
        set message_text = 'Tipologie prodotto e taglia non corrispondono';
end if;
end;

-- se si vuole fare che un prodotto sia in più collezioni
# create table if not exists Collezioni(
    #   	Nome varchar(50) primary key,
    #     Tipologia varchar(50) not null
    #           check (Tipologia in ('Maglia', 'Scarpa', 'Pallone')),
    #     Descrizione varchar(100) default null
    # );

# create table if not exists ProdottiCollezioni(
                                                   # 		Prodotto int, Collezione varchar(50),
    #   	primary key (Prodotto, Collezione),
    #     foreign key (Prodotto) references Prodotti(ID_Prodotto),
    #     foreign key (Collezione) references Collezioni(Nome)
    # );

-- prima di inserire una tupla in prodottiCollezioni,
-- controlla che la tipologia di prodotto sia uguale
-- a quella della collezione
# create trigger checkProdottiCollezioni before insert on ProdottiCollezioni
    # for each row
# begin
#     declare prodTipo varchar(50);
#     declare collTipo varchar(50);

#     -- cattura tipologia prodotto
#     select tipologia into prodTipo FROM Prodotti
                                              #     where ID_Prodotto = new.Prodotto;

#     -- cattura tipologia taglia
#     select tipologia into collTipo from Collezioni
                                              #     where Nome = new.Collezione;

#     -- verifica uguaglianza
#     if prodTipo != collTipo then
#         signal sqlstate '45000'
#         set message_text = 'Tipologie prodotto e collezione non corrispondono';
#     end if;
# end;

-- prima di inserire una tupla in ordini
-- controlla che la quantità ordinata sia minore o uguale
-- alla quantità disponibile del prodotto con quella taglia
create trigger checkQuantita before insert on Ordini
    for each row
begin
    declare disponibile int;

    -- cattura quantità
    select Quantita into disponibile from ProdottiTaglie
    where Prodotto = new.Prodotto and Taglia = new.Taglia;

    -- verifica
    if new.Quantita > disponibile then
       	signal sqlstate '45000'
        set message_text = 'La quantità ordinata è maggiore della quantità disponibile';
end if;
end;

-- quando inserisci un ordine calcola il prezzo
-- in base alla quantità ed impostalo
create trigger setPrezzo before insert on Ordini
    for each row
begin
    declare prezzoProdotto decimal(10, 2);

    -- cattura prezzo prodotto
    select Prezzo into prezzoProdotto from Prodotti
    where ID_Prodotto = new.Prodotto;

    -- imposta
    set new.Prezzo = prezzoProdotto * new.Quantita;
end;

-- dopo aver inserito un ordine aggiorna la disponibilità
-- di quel prodotto con quella taglia
create trigger updateQuantita after insert on Ordini
    for each row
begin
    -- aggiorna quantità disponibile
    update ProdottiTaglie
    set Quantita = Quantita - new.Quantita
    where Prodotto = new.Prodotto and Taglia = new.Taglia;
end;

-- insersco cose a caso
insert into Utenti values
                       (1, "domeCiri", "domenicoCirillo@gmail.com", "e42e43478ac14e5045d138fc992f2577d3643782", true), -- password: dom25!
                       (2, "micheAnn", "micheleAnnunziata@gmail.com", "d70ba364c4c6374d020b95ac74521079760a7274", true); -- password: micAnn_20

insert into Squadre values
                        ("Milan", "img/squadre/Milan.png"),
                        ("Napoli", "img/squadre/Napoli.png"),
                        ("Barcelona", "img/squadre/Barcelona.png"),
                        ("Liverpool", "img/squadre/Liverpool.png"),
                        ("Juventus",  "img/squadre/Juventus.png");

insert into Prodotti values
                         (1, "Maglia Milan Home 23/24", 99.99, "Maglia", "Milan", "Puma", "Serie A 23/24", "img/prod/1.png"),
                         (2, "Maglia Napoli Home 23/24", 89.99, "Maglia", "Napoli", "Emporio Armani", "Serie A 23/24", "img/prod/2.png");

insert into Taglie(Taglia, Tipologia) values
                                          ("L", "Maglia"), ("5", "Pallone");

insert into ProdottiTaglie values
                               (1, "L", 100), (2, "L", 20);

insert into Ordini(ID_Ordine, Utente, Prodotto, Taglia, Quantita) values
                                                                      (1, 1, 1, "L", 2), (1, 1, 2, "L", 1);
