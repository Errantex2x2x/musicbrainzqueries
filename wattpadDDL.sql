/*
--Use this to delete all tables
DROP TABLE IF EXISTS "categoria" CASCADE;
DROP TABLE IF EXISTS "utente" CASCADE;
DROP TABLE IF EXISTS "associazionecat" CASCADE;
DROP TABLE IF EXISTS "commento" CASCADE;
DROP TABLE IF EXISTS "libro" CASCADE;
DROP TABLE IF EXISTS "scritturacorrelata" CASCADE;
DROP TABLE IF EXISTS "capitolo" CASCADE;
DROP TABLE IF EXISTS "paragrafo" CASCADE;
DROP TABLE IF EXISTS "categoriasito" CASCADE;
DROP TABLE IF EXISTS "correlazione" CASCADE;
DROP TABLE IF EXISTS "follow" CASCADE;
DROP TABLE IF EXISTS "lettura" CASCADE;
DROP TABLE IF EXISTS "elencodilettura" CASCADE;
DROP TABLE IF EXISTS "composizioneelencolettura" CASCADE;

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
DataIscr      DATE NOT NULL,
Nome          VARCHAR(127),
Cognome       VARCHAR(127),
Descrizione   VARCHAR(255),
NumOpere      INTEGER NOT NULL DEFAULT '0',
NumELettura   INTEGER NOT NULL DEFAULT '0',
PRIMARY KEY (Username)
);

CREATE TABLE Libro  (
Titolo        VARCHAR(127),
Autore        VARCHAR(127),
Descrizione   VARCHAR(255),
NumVoti       INTEGER NOT NULL DEFAULT '0',
Numletture    INTEGER NOT NULL DEFAULT '0',
NumCapitoli   INTEGER NOT NULL DEFAULT '0',
CatSito       VARCHAR(127),
PRIMARY KEY (Titolo, Autore),
FOREIGN KEY (CatSito) REFERENCES CategoriaSito(TitoloCatSito), --Can be null
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
DataFollow    DATE NOT NULL,
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
IsTag         BOOLEAN NOT NULL,
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
TitoloCapitolo VARCHAR(127) NOT NULL,
PRIMARY KEY (NumCapitolo, TitoloLibro, AutoreLibro),
FOREIGN KEY (TitoloLibro,AutoreLibro) REFERENCES Libro(Titolo,Autore)
);

CREATE TABLE Paragrafo  (
IdParagrafo   INTEGER,
NumCapitolo   INTEGER NOT NULL,
TitoloLibro   VARCHAR(127) NOT NULL,
AutoreLibro   VARCHAR(127) NOT NULL,
Testo         TEXT NOT NULL,
PRIMARY KEY (IdParagrafo),
FOREIGN KEY (NumCapitolo, TitoloLibro, AutoreLibro) REFERENCES Capitolo(NumCapitolo, TitoloLibro, AutoreLibro)
);

CREATE TABLE Commento  (
IdParagrafo   INTEGER,
Username      VARCHAR(127),
DataOra       DATE,
TestoCommento VARCHAR(127) NOT NULL,
PRIMARY KEY (IdParagrafo, Username, DataOra),
FOREIGN KEY (IdParagrafo) REFERENCES Paragrafo(IdParagrafo),
FOREIGN KEY (Username) REFERENCES Utente(Username)
);
