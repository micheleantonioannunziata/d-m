drop database if exists projectus;
create database if not exists projectus;

use projectus;

create table if not exists utenti (
                                      id_utente int primary key auto_increment,
                                      username varchar(50) not null unique,
    email varchar(100) not null unique,
    passwordhash varchar(255) not null,
    isadmin bool
    );

create table if not exists squadre (
    nome varchar(50) primary key,
    urlimmagine varchar(255) not null
    );

create table if not exists prodotti (
                                        id_prodotto int primary key auto_increment,
                                        nome varchar(100) not null,
    prezzo decimal(10, 2) not null,
    tipologia varchar(50) not null check (tipologia in ('Maglia', 'Scarpa', 'Pallone')),
    squadra varchar(50) default null,
    produttore varchar(50) default null,
    collezione varchar(50) default null,
    urlimmagine varchar(50) null,
    foreign key (squadra) references squadre(nome) on delete cascade,
    constraint checkprodotti check (tipologia = 'Maglia' or squadra is null)
    );

create table if not exists taglie (
    taglia varchar(5) primary key,
    tipologia varchar(50) not null check (tipologia in ('Maglia', 'Scarpa', 'Pallone')),
    descrizione varchar(100) default null
    );

create table if not exists prodottitaglie (
                                              prodotto int,
                                              taglia varchar(5),
    quantita int,
    primary key (prodotto, taglia),
    foreign key (prodotto) references prodotti(id_prodotto) on delete cascade on update cascade,
    foreign key (taglia) references taglie(taglia) on delete cascade on update cascade
    );

create table if not exists ordini (
                                      id_ordine int,
                                      utente int,
                                      prodotto int,
                                      taglia varchar(5),
    quantita int,
    prezzo decimal(10, 2) default 0,
    primary key(id_ordine, utente, prodotto, taglia),
    foreign key (utente) references utenti(id_utente) on delete cascade on update cascade,
    foreign key (prodotto, taglia) references prodottitaglie(prodotto, taglia) on delete cascade on update cascade
    );

create table if not exists carrello (
                                        utente int,
                                        prodotto int,
                                        taglia varchar(5),
    quantita int,
    primary key(utente, prodotto, taglia),
    foreign key(utente) references utenti(id_utente) on delete cascade on update cascade,
    foreign key (prodotto, taglia) references prodottitaglie(prodotto, taglia) on delete cascade on update cascade
    );

create trigger checkprodottitaglie before insert on prodottitaglie
    for each row
begin
    declare prodtipo varchar(50);
    declare tagliatipo varchar(50);

    -- cattura tipologia prodotto
    select tipologia into prodtipo from prodotti where id_prodotto = new.prodotto;

    -- cattura tipologia taglia
    select tipologia into tagliatipo from taglie where taglia = new.taglia;

    -- verifica uguaglianza
    if prodtipo != tagliatipo then
        signal sqlstate '45000' set message_text = 'Tipologie prodotto e taglia non corrispondono';
end if;
end;

create trigger checkquantitaordini before insert on ordini
    for each row
begin
    declare disponibile int;

    -- cattura quantità
    select quantita into disponibile from prodottitaglie where prodotto = new.prodotto and taglia = new.taglia;

    -- verifica
    if new.quantita > disponibile then
        signal sqlstate '45000' set message_text = 'La quantità ordinata è maggiore della quantità disponibile';
end if;
end;

create trigger checkquantitacarrello before insert on carrello
    for each row
begin
    declare disponibile int;

    -- cattura quantità
    select quantita into disponibile from prodottitaglie where prodotto = new.prodotto and taglia = new.taglia;

    -- verifica
    if new.quantita > disponibile then
        signal sqlstate '45000' set message_text = 'La quantità inserita nel carrello è maggiore della quantità disponibile';
end if;
end;

create trigger setprezzo before insert on ordini
    for each row
begin
    declare prezzoprodotto decimal(10, 2);

    -- cattura prezzo prodotto
    select prezzo into prezzoprodotto from prodotti where id_prodotto = new.prodotto;

    -- imposta
    set new.prezzo = prezzoprodotto * new.quantita;
end;

create trigger updatequantita after insert on ordini
    for each row
begin
    -- aggiorna quantità disponibile
    update prodottitaglie set quantita = quantita - new.quantita where prodotto = new.prodotto and taglia = new.taglia;
end;

-- inserisco cose a caso
insert into utenti values
                       (1, 'domeCiri', 'domenicocirillo@gmail.com', 'e42e43478ac14e5045d138fc992f2577d3643782', true), -- password: dom25!
                       (2, 'micheAnn', 'micheleannunziata@gmail.com', 'd70ba364c4c6374d020b95ac74521079760a7274', true); -- password: micAnn_20

insert into squadre values
                        ('Milan', 'img/squadre/Milan.png'),
                        ('Napoli', 'img/squadre/Napoli.png'),
                        ('Barcelona', 'img/squadre/Barcelona.png'),
                        ('Liverpool', 'img/squadre/Liverpool.png'),
                        ('Juventus', 'img/squadre/Juventus.png');

insert into prodotti values
                         (1, 'Maglia Milan Home 23/24', 99.99, 'Maglia', 'Milan', 'Puma', 'Serie A 23/24', 'img/prod/1.png'),
                         (2, 'Maglia Napoli Home 23/24', 89.99, 'Maglia', 'Napoli', 'Emporio Armani', 'Serie A 23/24', 'img/prod/2.png');

insert into taglie(taglia, tipologia) values
                                          ('L', 'Maglia'), ('5', 'Pallone'), ('M', 'Maglia'), ('XL', 'Maglia');

insert into prodottitaglie values
                               (1, 'L', 100), (1, 'M', 30), (2, 'L', 20);

insert into ordini(id_ordine, utente, prodotto, taglia, quantita) values
                                                                      (1, 1, 1, 'L', 2), (1, 1, 2, 'L', 1);

insert into carrello values (1, 2, 'L', 19);
