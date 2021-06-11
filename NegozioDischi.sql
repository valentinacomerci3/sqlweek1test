

CREATE DATABASE NegozioDischi



CREATE TABLE Album(
	ID INT IDENTITY(1, 1),
	BandID INT NOT NULL,
	Titolo VARCHAR(20),
	AnnoUscita INT,
	CasaDiscografica VARCHAR(20),
	Genere VARCHAR (20),
	Supporto VARCHAR (20),
	
	

	PRIMARY KEY (ID),
	FOREIGN KEY (BandID) REFERENCES Band(ID),

	CHECK (AnnoUscita > 0),
	CHECK (Genere IN ('Classico', 'Jazz','Pop', 'Rock','Metal')),
	CHECK (Supporto IN ('CD', 'Vinile', 'Streaming')),
	UNIQUE(Titolo, AnnoUscita, CasaDiscografica, Genere, Supporto)
	
)

CREATE TABLE Band(
	ID INT IDENTITY(1, 1),
	Nome VARCHAR(20),
	NumeroComponenti INT,

	PRIMARY KEY (ID),

	CHECK (NumeroComponenti > 0),
	
)


CREATE TABLE BraniAlbum(
	BranoID INT NOT NULL,
	AlbumID INT NOT NULL,

	FOREIGN KEY (BranoID) REFERENCES Brano(ID),
	FOREIGN KEY (AlbumID) REFERENCES Album(ID)
)


CREATE TABLE Brano(
	ID int IDENTITY(1, 1) NOT NULL,
	Titolo VARCHAR(20) NOT NULL,
	Durata INT NOT NULL,

	PRIMARY KEY (ID),
	
	CHECK (Durata > 0),
	
)

--                                               INSERIMENTO DATI

INSERT INTO Band VALUES ('Maneskin',  4)
INSERT INTO Band VALUES ('883',  3)
INSERT INTO Band VALUES ('TheGiornalisti',  4)
INSERT INTO Band VALUES ('Beatles',  4)


INSERT INTO Album VALUES (1,'Teatro', 2018,'Foe', 'Rock','CD')
INSERT INTO Album VALUES (2,'Ballo', 2016,'Doe', 'Pop','CD')
INSERT INTO Album VALUES (4,'Chosen', 1987,'Doe', 'Pop','Vinile')
INSERT INTO Album VALUES (2,'Verde', 2003,'Doe', 'Rock','CD')
INSERT INTO Album VALUES (1,'Hello', 2018,'Foe', 'Rock','CD')
INSERT INTO Album VALUES (3,'Wow', 2002,'Fer',  'Pop','Streaming')
INSERT INTO Album VALUES (4,'Matita', 1970,'Doe',  'Pop','Vinile')
INSERT INTO Album VALUES (3,'Schermo', 2016, 'Fer','Pop','Streaming')


INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 320)
INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 200)
INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 187)
INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 134)
INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 200)
INSERT INTO Brano VALUES ( '2020-05-04', 210)
INSERT INTO Brano VALUES ( '2020-05-04', 210)


INSERT INTO BraniAlbum VALUES (1, 3)
INSERT INTO BraniAlbum VALUES (2, 1)
INSERT INTO BraniAlbum VALUES (3, 1)
INSERT INTO BraniAlbum VALUES (4, 2)
INSERT INTO BraniAlbum VALUES (1, 3)
INSERT INTO BraniAlbum VALUES (2, 1)
INSERT INTO BraniAlbum VALUES (3, 1)
INSERT INTO BraniAlbum VALUES (4, 2)
INSERT INTO BraniAlbum VALUES (1, 3)
INSERT INTO BraniAlbum VALUES (2, 1)
INSERT INTO BraniAlbum VALUES (3, 1)
INSERT INTO BraniAlbum VALUES (4, 2)
INSERT INTO BraniAlbum VALUES (1, 3)
INSERT INTO BraniAlbum VALUES (2, 1)
INSERT INTO BraniAlbum VALUES (3, 1)
INSERT INTO BraniAlbum VALUES (4, 2)



SELECT * FROM Album
SELECT * FROM Band
SELECT * FROM Brano
SELECT * FROM BraniAlbum


--                                                   QUERIES
---------------------------------------------------------------------------------------------------------------------------------

--1)Scrivere una query che restituisca i titoli degli album degli “883”;

SELECT a.Titolo, bd.Nome 
FROM Album a
JOIN Band bd
on a.BandID = bd.ID
WHERE bd.Nome='883' 



--2) Selezionare tutti gli album editi dalla casa editrice nell’anno x;

SELECT a.Titolo, a.AnnoUscita, a.CasaDiscografica, bd.Nome
FROM Album a
JOIN Band bd
ON bd.ID = a.BandID
WHERE a.CasaDiscografica= 'Doe' AND a.AnnoUscita=1987



--3) Scrivere una query che restituisca tutti i titoli delle canzoni dei “Maneskin” appartenenti ad album pubblicati prima del 2019;
SELECT b.Titolo, a.Titolo, a.AnnoUscita,bd.Nome
FROM Brano b
JOIN BraniAlbum ba 
ON b.ID = ba.AlbumID
JOIN Album a
ON ba.AlbumID = a.ID 
join Band bd
ON Bd.ID = a.BandID
WHERE bd.Nome = 'Maneskin' AND a.AnnoUscita<2019


--4) Individuare tutti gli album in cui è contenuta la canzone “Imagine”;
SELECT a.Titolo, bd.Nome, a.AnnoUscita
FROM Brano b
JOIN BraniAlbum ba 
ON b.ID = ba.AlbumID
JOIN Album a
ON ba.AlbumID = a.ID 
join Band bd
ON Bd.ID = a.BandID
WHERE a.ID = ALL
  (SELECT a.ID
  FROM Brano
  WHERE Brano.Titolo = 'Imagine');


--5) Restituire il numero totale di canzoni eseguite dalla band “The Giornalisti”;
SELECT Count(*), b.ID, b.Titolo,a.Titolo, a.AnnoUscita AS'Canzoni Di The Giornalisti'
FROM Brano b
JOIN BraniAlbum ba 
ON b.ID = ba.AlbumID
JOIN Album a
ON ba.AlbumID = a.ID 
join Band bd
ON bd.ID = a.BandID
WHERE bd.Nome = 'The Giornalisti' 


--6) Contare per ogni album, la somma dei minuti dei brani contenuti.

SELECT SUM(Durata)
FROM Brano b
JOIN BraniAlbum ba 
ON b.ID = ba.AlbumID
JOIN Album a
ON ba.AlbumID = a.ID 
join Band bd
ON bd.ID = a.BandID
GROUP BY a.ID

                                                       -----VIEW-----
CREATE VIEW [Info-Maneskin] AS
SELECT bd.Nome,bd.NumeroComponenti, a.Titolo, a.AnnoUscita,a.Genere,a.CasaDiscografica, a.Supporto, b.Titolo,b.Durata
FROM Brano b
JOIN BraniAlbum ba 
ON b.ID = ba.AlbumID
JOIN Album a
ON ba.AlbumID = a.ID 
join Band bd
ON bd.ID = a.BandID

WHERE bd.Nome = 'Maneskin';