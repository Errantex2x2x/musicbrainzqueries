/*
--Use this to delete all tables
drop table if exists "categoria" cascade;
drop table if exists "utente" cascade;
drop table if exists "associazionecat" cascade;
drop table if exists "commento" cascade;
drop table if exists "libro" cascade;
drop table if exists "scritturacorrelata" cascade;
drop table if exists "partizionamentocapitolo" cascade;
drop table if exists "capitolo" cascade;
drop table if exists "paragrafo" cascade;
drop table if exists "categoriasito" cascade;
drop table if exists "correlazione" cascade;
drop table if exists "follow" cascade;
drop table if exists "lettura" cascade;
drop table if exists "elencodilettura" cascade;
drop table if exists "composizioneelencolettura" cascade;

--use this to get a query to delete all tables
select 'drop table if exists "' || tablename || '" cascade;' 
from pg_tables
where schemaname = 'public'; -- or any other schema
*/

CREATE TABLE CategoriaSito  (
TitoloCatSito VARCHAR(127),
Descrizione   VARCHAR(127),
PRIMARY KEY (TitoloCatSito)
);


CREATE TABLE Utente  (
Username      VARCHAR(127),
DataIscr      DATE,
Nome          VARCHAR(127),
Cognome       VARCHAR(127),
Descrizione   VARCHAR(255),
NumOpere      INTEGER,
NumELettura   INTEGER,
PRIMARY KEY (Username)
);

CREATE TABLE Libro  (
Titolo        VARCHAR(127),
Autore        VARCHAR(127),
Descrizione   VARCHAR(255),
NumVoti       INTEGER,
Numletture    INTEGER,
NumCapitoli   INTEGER,
CatSito       VARCHAR(127),
PRIMARY KEY (Titolo, Autore),
FOREIGN KEY (CatSito) REFERENCES CategoriaSito(TitoloCatSito),
FOREIGN KEY (Autore) REFERENCES Utente(Username)
);

CREATE TABLE Correlazione  (
Libro1        VARCHAR(127),
Autore1       VARCHAR(127),
Libro2        VARCHAR(127),
Autore2       VARCHAR(127),
PRIMARY KEY (Libro1, Autore1, Libro2, Autore2),
FOREIGN KEY (Libro1, Autore1) REFERENCES Libro(Titolo, Autore),
FOREIGN KEY (Libro2, Autore2) REFERENCES Libro(Titolo, Autore)
);

CREATE TABLE Follow  (
Seguitore     VARCHAR(127),
Seguito       VARCHAR(127),
DataFollow    DATE,
PRIMARY KEY (Seguitore, Seguito),
FOREIGN KEY (Seguitore) REFERENCES Utente(Username),
FOREIGN KEY (Seguito) REFERENCES Utente(Username)
);

CREATE TABLE ElencoDiLettura  (
Nome          VARCHAR(127),
Creatore      VARCHAR(127),
Privato		  BOOLEAN,
PRIMARY KEY (Nome, Creatore),
FOREIGN KEY (Creatore) REFERENCES Utente(Username)
);

CREATE TABLE Lettura  (
NomeElenco      VARCHAR(127),
CreatoreElenco  VARCHAR(127),
Username      	VARCHAR(127),
PRIMARY KEY (NomeElenco, CreatoreElenco, Username),
FOREIGN KEY (Username) REFERENCES Utente(Username)
);

CREATE TABLE ComposizioneElencoLettura  (
NomeElenco      VARCHAR(127),
CreatoreElenco  VARCHAR(127),
TitoloLibro   VARCHAR(127),
AutoreLibro   VARCHAR(127),
PRIMARY KEY (NomeElenco, CreatoreElenco, TitoloLibro, AutoreLibro),
FOREIGN KEY (NomeElenco,CreatoreElenco) REFERENCES ElencoDiLettura(Nome,Creatore),
FOREIGN KEY (TitoloLibro,AutoreLibro) REFERENCES Libro(Titolo,Autore)
);

CREATE TABLE Categoria  (
TitoloCat     VARCHAR(127),
Descrizione   VARCHAR(127),
IsTag         BOOLEAN,
PRIMARY KEY (TitoloCat)
);

CREATE TABLE AssociazioneCat  (
TitoloCat     VARCHAR(127),
TitoloLibro   VARCHAR(127),
AutoreLibro   VARCHAR(127),
PRIMARY KEY (TitoloCat, TitoloLibro, AutoreLibro),
FOREIGN KEY (TitoloCat) REFERENCES Categoria(TitoloCat),
FOREIGN KEY (TitoloLibro,AutoreLibro) REFERENCES Libro(Titolo,Autore)
);

CREATE TABLE ScritturaCorrelata  (
TitoloCat     VARCHAR(127),
Username      VARCHAR(127),
PRIMARY KEY (TitoloCat, Username),
FOREIGN KEY (Username) REFERENCES Utente(Username)
);

CREATE TABLE Capitolo  (
NumCapitolo   INTEGER,
TitoloLibro   VARCHAR(127),
AutoreLibro   VARCHAR(127),
TitoloCapitolo VARCHAR(127),
PRIMARY KEY (NumCapitolo, TitoloLibro, AutoreLibro),
FOREIGN KEY (TitoloLibro,AutoreLibro) REFERENCES Libro(Titolo,Autore)
);

CREATE TABLE Paragrafo  (
IdParagrafo   INTEGER,
Testo         TEXT,
PRIMARY KEY (IdParagrafo)
);

CREATE TABLE PartizionamentoCapitolo  (
IdParagrafo   INTEGER,
NumCapitolo   INTEGER,
TitoloLibro   VARCHAR(127),
AutoreLibro   VARCHAR(127),
PRIMARY KEY (IdParagrafo, NumCapitolo, TitoloLibro, AutoreLibro),
FOREIGN KEY (IdParagrafo) REFERENCES Paragrafo(IdParagrafo),
FOREIGN KEY (TitoloLibro,AutoreLibro) REFERENCES Libro(Titolo,Autore)
);

CREATE TABLE Commento  (
IdParagrafo   INTEGER,
Username      VARCHAR(127),
DataOra       DATE,
TestoCommento VARCHAR(127),
PRIMARY KEY (IdParagrafo, Username, DataOra),
FOREIGN KEY (IdParagrafo) REFERENCES Paragrafo(IdParagrafo),
FOREIGN KEY (Username) REFERENCES Utente(Username)
);
