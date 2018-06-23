--COMPONENTI DEL GRUPPO
--Marco Maida
--Marco Perronet

--set search_path = "$user", public, musicbrainz;
﻿--Query 1:
--Contare il numero di lingue in cui le release contenute nel database sono scritte (il risultato deve contenere
--soltanto il numero delle lingue, rinominato “Numero_Lingue”).

SELECT COUNT(DISTINCT language) Numero_Lingue
FROM release

--Query 2:
--Elencare gli artisti che hanno cantato canzoni in italiano (il risultato deve contenere il nome dell’artista e il nome
--della lingua).

SELECT DISTINCT artist_credit.name AS artist_name, language.name AS language
FROM track
JOIN medium ON track.medium = medium.id
JOIN release ON medium.release = release.id
JOIN language ON release.language = language.id AND language.name = 'Italian' 
JOIN artist_credit ON track.artist_credit = artist_credit.id

--Query 3:
--Elencare le release di cui non si conosce la lingua (il risultato deve contenere soltanto il nome della release).

SELECT release.name
FROM release
JOIN language ON release.language = language.id AND language.iso_code_1 IS NULL --RIVEDERE TODO 

--Query 4:
--Elencare gli artisti il cui nome contiene tutte le vocali ed è composto da una sola parola (il risultato deve
--contenere soltanto il nome dell’artista).

SELECT name AS artist_name
FROM artist
WHERE 	    (artist.name LIKE '%A%' OR artist.name LIKE '%a%')
	AND (artist.name LIKE '%E%' OR artist.name LIKE '%e%')
	AND (artist.name LIKE '%I%' OR artist.name LIKE '%i%')
	AND (artist.name LIKE '%O%' OR artist.name LIKE '%o%')
	AND (artist.name LIKE '%U%' OR artist.name LIKE '%u%')
	AND  artist.name NOT LIKE '% %'

--Query 5:
--Elencare tutti gli pseudonimi di Prince con il loro tipo, se disponibile (il risultato deve contenere lo pseudonimo
--dell'artista, il nome dell’artista (cioè Prince) e il tipo di pseudonimo (se disponibile)).

SELECT artist.name, alias.name, type.name
FROM artist
JOIN artist_alias alias ON alias.artist = artist.id
JOIN artist_alias_type type ON alias.type = type.id
WHERE artist.name = 'Prince'


--Query 6:
--Elencare le release di gruppi inglesi ancora in attività (il risultato deve contenere il nome del gruppo e il nome
--della release e essere ordinato per nome del gruppo e nome della release)

SELECT artist.name AS artist, release_group.name AS release FROM release_group 
JOIN artist_credit ON release_group.artist_credit = artist_credit.id
JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
JOIN artist ON artist.id = artist_credit_name.artist AND artist.ended = FALSE
JOIN artist_type ON artist.type = artist_type.id AND artist_type.name = 'Group'
JOIN area ON artist.area = area.id AND area.name = 'United Kingdom' 
ORDER BY artist.name, release_group.name

--Query 7:
--Trovare le release in cui il nome dell’artista è diverso dal nome accreditato nella release (il risultato deve
--contenere il nome della release, il nome dell’artista accreditato (cioè artist_credit.name) e il nome dell’artista
--(cioè artist.name))

SELECT release.name nome_release, artist_credit.name artista_accreditato, artist.name artista
FROM release 
JOIN artist_credit ON release.artist_credit = artist_credit.id
JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
JOIN artist ON artist.id = artist_credit_name.artist
WHERE artist.name <> artist_credit.name

--Query 8:
--Trovare gli artisti con meno di tre release (il risultato deve contenere il nome dell’artista ed il numero di
--release).

--Uso la right join per contare anche chi ha zero release

SELECT artist.name, count(release.id) total_releases FROM release 
RIGHT JOIN artist_credit ON release.artist_credit = artist_credit.id
RIGHT JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
RIGHT JOIN artist ON artist.id = artist_credit_name.artist
GROUP BY artist.id
HAVING count(release.id) < 3 

--Query 9:
--Trovare la registrazione più lunga di un’artista donna (il risultato deve contenere il nome della registrazione, la
--sua durata in minuti e il nome dell’artista; tenere conto che le durate sono memorizzate in millesimi di secondo)
--(scrivere due versioni della query con e senza operatore aggregato MAX).
--07/05/18

--Versione 1:
WITH female_rec AS --TODO SIAMO SICURI CHE LA MISURA IN MINUTI SIA GIUSTA? viene una registrazione moooolto lunga
(
	SELECT recording.name AS recording_name, length, artist.name AS artist_name
	FROM recording
	JOIN artist_credit_name ON artist_credit_name.artist = recording.artist_credit
	JOIN artist ON artist.id = artist_credit_name.artist
	JOIN gender ON gender.id = artist.gender AND gender.name = 'Female'
)
SELECT DISTINCT recording_name, length/60000 + length%60/100. AS length, artist_name
FROM female_rec
WHERE length = ( SELECT MAX(length) AS max_length FROM female_rec )--Potrebbe ritornare più di un valore, in caso di pari lunghezza

--Versione 2: --TODO SUL DB ORIGINALE NON TERMINA
WITH female_rec AS --TODO SIAMO SICURI CHE LA MISURA IN MINUTI SIA GIUSTA? 
(
	SELECT recording.id, recording.name AS recording_name, length, artist.name AS artist_name
	FROM recording
	JOIN artist_credit_name ON artist_credit_name.artist = recording.artist_credit
	JOIN artist ON artist.id = artist_credit_name.artist
	JOIN gender ON gender.id = artist.gender AND gender.name = 'Female'
)
SELECT recording_name, length/60000 + length%60/100. AS length, artist_name
FROM female_rec
WHERE id NOT IN
(
	SELECT r1.id
	FROM female_rec r1
	JOIN female_rec r2 ON r1.length < r2.length
)
AND female_rec.length IS NOT NULL

--Query 10:
--Elencare le lingue cui non corrisponde nessuna release (il risultato deve contenere il nome della lingua, il numero
--di release in quella lingua, cioè 0, e essere ordinato per lingua) (scrivere due versioni della query).

--Versione 1 
SELECT *, 0 AS num_releases FROM
(
	SELECT language.name FROM language
	EXCEPT
	SELECT language.name FROM language
	JOIN release ON release.language = language.id
) AS result
ORDER BY result.name

--Versione 2   
SELECT language.name, 0 AS num_releases FROM language
LEFT JOIN release ON language.id = release.language
WHERE release.language IS NULL
ORDER BY language.name

--Query 11:
--Ricavare la seconda registrazione per lunghezza di un artista uomo (il risultato deve comprendere l'artista
--accreditato, il nome della registrazione e la sua lunghezza) (scrivere due versioni della query).

--Versione 1: --TODO SUL DB ORIGINALE NON TERMINA (termina con un errore di "memoria")
--definita male_rec come tabella contenente le registrazioni degli artisti uomini,
--prendiamo la registrazione più lunga tra tutte le registrazioni minori della più lunga in assoluto.
WITH male_rec AS 
(
	SELECT DISTINCT recording.name AS recording_name, length, artist.name
	FROM recording
	JOIN artist_credit_name ON artist_credit_name.artist = recording.artist_credit
	JOIN artist ON artist.id = artist_credit_name.artist
	JOIN gender ON gender.id = artist.gender AND gender.name = 'Male'
	WHERE length IS NOT NULL
)
SELECT DISTINCT *
FROM male_rec
WHERE length = (SELECT MAX(length) FROM male_rec WHERE length < (SELECT MAX(length) FROM male_rec))

--Versione 2: --TODO SUL DB ORIGINALE NON TERMINA
--Utilizzo il passaggio di binding per verificare che esista solamente un altro recording con lunghezza maggiore
WITH male_rec AS 
(
	SELECT DISTINCT recording.name AS recording_name, length, artist.name
	FROM recording
	JOIN artist_credit_name ON artist_credit_name.artist = recording.artist_credit
	JOIN artist ON artist.id = artist_credit_name.artist
	JOIN gender ON gender.id = artist.gender AND gender.name = 'Male'
	WHERE length IS NOT NULL
)
SELECT mr.* 
FROM male_rec AS mr
WHERE 1 = 
(
	SELECT COUNT(*) 
	FROM male_rec 
	WHERE male_rec.length > mr.length
)
 
--Query 12:
--Per ogni stato esistente riportare la lunghezza totale delle registrazioni di artisti di quello stato (il risultato deve
--comprendere il nome dello stato e la lunghezza totale in minuti delle registrazioni (0 se lo stato non ha
--registrazioni) (scrivere due versioni della query).

--Versione 1  
SELECT area.name, COALESCE(sum(recording.length)/60000, 0) recording_length FROM area --length/60000 + length%60/100 non cambia nulla nell'output
JOIN area_type ON area.type = area_type.id AND area_type.name = 'Country'	      --TODO SIAMO SICURI CHE LA MISURA IN MINUTI SIA GIUSTA? 
JOIN artist ON artist.area = area.id
JOIN artist_credit_name ON artist_credit_name.artist = artist.id 
JOIN artist_credit ON artist_credit.id = artist_credit_name.artist_credit
JOIN recording ON artist_credit.id = recording.artist_credit 
GROUP BY area.id

--Versione 2
SELECT sub.name, sum(sub.recording_length)/60000 recording_length FROM --TODO SIAMO SICURI CHE LA MISURA IN MINUTI SIA GIUSTA? 
(
	SELECT area.name, COALESCE(recording.length, 0) recording_length FROM area 
	JOIN area_type ON area.type = area_type.id AND area_type.name = 'Country'
	JOIN artist ON artist.area = area.id
	JOIN artist_credit_name ON artist_credit_name.artist = artist.id 
	JOIN artist_credit ON artist_credit.id = artist_credit_name.artist_credit
	LEFT JOIN recording ON artist_credit.id = recording.artist_credit 
) AS sub
GROUP BY sub.name

--Query 13:
--Ricavare gli artisti britannici che hanno pubblicato almeno 10 release (il risultato deve contenere il nome
--dell’artista, il nome dello stato (cioè United Kingdom) e il numero di release) (scrivere due versioni della query).

--Versione 1:
SELECT artist.name, area.name, COUNT(release.name) AS releases_num
FROM release 
JOIN artist_credit ON release.artist_credit = artist_credit.id
JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
JOIN artist ON artist.id = artist_credit_name.artist
JOIN area ON artist.area = area.id AND area.name = 'United Kingdom'
GROUP BY artist.id, artist.name, area.name
HAVING COUNT(release.name) >= 10

--Versione 2:
SELECT artist.name, 'United Kingdom' AS country, uk_rel.*
FROM artist
JOIN
(
	SELECT artist.id, COUNT(release.name) AS releases_num
	FROM release
	JOIN artist_credit ON release.artist_credit = artist_credit.id
	JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
	JOIN artist ON artist.id = artist_credit_name.artist
	JOIN area ON artist.area = area.id AND area.name = 'United Kingdom'
	GROUP BY artist.id
) uk_rel
ON uk_rel.id = artist.id
WHERE releases_num >= 10

--Query 14:
--Considerando il numero medio di tracce tra le release pubblicate su CD, ricavare gli artisti che hanno pubblicato
--esclusivamente release con più tracce della media (il risultato deve contenere il nome dell’artista e il numero di
--release ed essere ordinato per numero di release discendente) (scrivere due versioni della query).

--Versione 1
WITH average AS( --Numero medio di tracce tra le release pubblicate su cd
	SELECT avg(medium.track_count) FROM medium
	JOIN medium_format ON medium.format = medium_format.id AND medium_format.name = 'CD'
),

not_all AS( --Artisti che NON hanno rilasciato ESCLUSIVAMENTE release su cd con più tracce della media 
	SELECT artist_credit.id 
	FROM medium  --Artisti che hanno rilasciato release su cd 
	JOIN medium_format ON medium.format = medium_format.id AND medium_format.name = 'CD'
	JOIN release ON medium.release = release.id
	JOIN artist_credit ON artist_credit.id = release.artist_credit

	EXCEPT

	SELECT artist_credit.id 
	FROM medium  --Artisti che hanno rilasciato release su cd con più tracce della media 
	JOIN medium_format ON medium.format = medium_format.id AND medium_format.name = 'CD' AND medium.track_count > (SELECT * FROM average)
	JOIN release ON medium.release = release.id
	JOIN artist_credit ON artist_credit.id = release.artist_credit
),

final_artists AS( --Lista di artisti che rispettano le condizioni richieste
	SELECT artist_credit.id 
	FROM artist_credit --Tutti gli artisti

	EXCEPT

	SELECT * FROM not_all --Artisti che NON hanno rilasciato ESCLUSIVAMENTE release su cd con più tracce della media 
)

SELECT artist_credit.name, count(release.id) release_count 
FROM release
JOIN artist_credit ON artist_credit.id = release.artist_credit
JOIN final_artists ON final_artists.id = artist_credit.id
GROUP BY artist_credit.name
ORDER BY release_count DESC


--Versione 2 --TODO SUL DB ORIGINALE NON TERMINA
WITH average AS( 
	SELECT avg(medium.track_count) FROM medium
	JOIN medium_format ON medium.format = medium_format.id AND medium_format.name = 'CD'
)

SELECT artist_credit.name, count(release.id) release_count 
FROM release
JOIN artist_credit ON artist_credit.id = release.artist_credit
WHERE artist_credit.id IN
(
	SELECT artist_credit.id 
	FROM artist_credit 
	WHERE artist_credit NOT IN
	(
		SELECT artist_credit.id 
		FROM medium  --Artisti che hanno rilasciato release su cd 
		JOIN medium_format ON medium.format = medium_format.id AND medium_format.name = 'CD'
		JOIN release ON medium.release = release.id
		JOIN artist_credit ON artist_credit.id = release.artist_credit
		WHERE artist_credit NOT IN
		(
			SELECT artist_credit.id 
			FROM medium  --Artisti che hanno rilasciato release su cd con più tracce della media 
			JOIN medium_format ON medium.format = medium_format.id AND medium_format.name = 'CD' AND medium.track_count > (SELECT * FROM average)
			JOIN release ON medium.release = release.id
			JOIN artist_credit ON artist_credit.id = release.artist_credit
		)
	)
)
GROUP BY artist_credit.name
ORDER BY release_count DESC

--Query 15:
--Ricavare il primo artista morto dopo Louis Armstrong (il risultato deve contenere il nome dell’artista, la sua data
--di nascita e la sua data di morte) (scrivere due versioni della query).

--Dalla documentazione: Begin date represents date of birth, and end date represents date of death.
--Questo vale solo per le persone, dobbiamo quindi usare 'Person' come artist_type

--Versione 1:
SELECT a.name, MAKE_DATE(a.begin_date_year,a.begin_date_month,a.begin_date_day) AS birth, MAKE_DATE(a.end_date_year,a.end_date_month,a.end_date_day) AS death
FROM artist a
JOIN
(
	--Trovo la data di morte minore tra le date maggiori di quella di Louis
	SELECT MIN(MAKE_DATE(end_date_year,end_date_month,end_date_day)) AS death
	FROM artist
	JOIN artist_type ON artist.type = artist_type.id AND artist_type.name = 'Person'
	WHERE MAKE_DATE(end_date_year,end_date_month,end_date_day) > 
	(
		--Seleziono la data di morte di Louis
		SELECT MAKE_DATE(end_date_year,end_date_month,end_date_day) AS death
		FROM artist 
		WHERE name = 'Louis Armstrong'	
	)
) ar
ON MAKE_DATE(a.end_date_year,a.end_date_month,a.end_date_day) =  ar.death

--Versione 2:

SELECT a.name, MAKE_DATE(a.begin_date_year,a.begin_date_month,a.begin_date_day) AS birth, MAKE_DATE(a.end_date_year,a.end_date_month,a.end_date_day) AS death
FROM artist a
JOIN
(
	SELECT MIN(MAKE_DATE(min.end_date_year,min.end_date_month,min.end_date_day)) AS death
	FROM artist AS min
	JOIN artist_type ON min.type = artist_type.id AND artist_type.name = 'Person'
	JOIN artist AS l ON l.name = 'Louis Armstrong' 
	AND MAKE_DATE(min.end_date_year,min.end_date_month,min.end_date_day) > MAKE_DATE(l.end_date_year,l.end_date_month,l.end_date_day) 
) min_artist 
ON MAKE_DATE(a.end_date_year,a.end_date_month,a.end_date_day) = min_artist.death

--Query 16:
--Elencare le coppie di etichette discografiche che non hanno mai fatto uscire una release in comune ma hanno fatto
--uscire una release in collaborazione con una medesima terza etichetta (il risultato deve comprendere i nomi delle
--coppie di etichette discografiche) (scrivere due versioni della query).

--Versione 1: --TODO SUL DB ORIGINALE NON TERMINA (termina con un errore di "memoria")
WITH no_common_release AS(
	SELECT l1.id label1id, l1.name label1, l2.id label2id, l2.name label2 
	FROM label l1 
	JOIN label l2 ON l1.id <> L2.id --Ogni coppia di label

	EXCEPT

	SELECT DISTINCT l1.id, l1.name, l2.id, l2.name FROM label l1 --Coppie di label che hanno rilasciato release in comune, ovvero che hanno collaborato
	JOIN label l2 ON l1.id <> L2.id
	JOIN release_label r_label1 ON r_label1.label = l1.id
	JOIN release_label r_label2 ON r_label2.label = l2.id
	WHERE r_label1.release = r_label2.release
),

collaborations AS(
	SELECT DISTINCT l1.id collab1id, l2.id collab2id FROM label l1 --Coppie di label che hanno rilasciato release in comune, ovvero che hanno collaborato
	JOIN label l2 ON l1.id <> L2.id
	JOIN release_label r_label1 ON r_label1.label = l1.id
	JOIN release_label r_label2 ON r_label2.label = l2.id
	WHERE r_label1.release = r_label2.release
) 

SELECT label1, label2 FROM no_common_release 
WHERE EXISTS
(--l3 terza etichetta
	SELECT l3.id 
	FROM label l3
	WHERE EXISTS
	(--collaborazione fra l1 ed l3
		SELECT c.collab1id 
		FROM collaborations c
		WHERE (c.collab1id = l3.id AND c.collab2id = no_common_release.label1id)
			OR 
			(c.collab1id = no_common_release.label1id AND c.collab2id = l3.id)
	)
	AND EXISTS
	(--collaborazione fra l2 ed l3
		SELECT c.collab1id 
		FROM collaborations c
		WHERE (c.collab1id = l3.id AND c.collab2id = no_common_release.label2id)
			OR 
			(c.collab1id = no_common_release.label2id AND c.collab2id = l3.id)
	)
)
--ORDER BY no_common_release.label1id DESC --Utile per confrontare il risultato con la versione 2


--Versione 2 --TODO SUL DB ORIGINALE NON TERMINA 
SELECT l1.name label1, l2.name label2 
FROM label l1 
JOIN label l2 ON l1.id <> L2.id --Ogni coppia di label
WHERE NOT EXISTS
(--Release in comune
	SELECT rl1.id
	FROM release_label rl1 
	JOIN release_label rl2 ON rl2.label = l2.id AND rl1.release = rl2.release
	WHERE rl1.label = l1.id
)
AND EXISTS
(--collaborazione con terza etichetta
	SELECT lt.id
	FROM label lt
	WHERE EXISTS
	(--Release in comune con lt e l1
		SELECT rl1.id
		FROM release_label rl1 
		JOIN release_label rl2 ON rl2.label = l1.id AND rl1.release = rl2.release
		WHERE rl1.label = lt.id
	)
	AND EXISTS
	(--Release in comune con lt e l2
		SELECT rl1.id
		FROM release_label rl1 
		JOIN release_label rl2 ON rl2.label = l2.id AND rl1.release = rl2.release
		WHERE rl1.label = lt.id
	)
)
--ORDER BY l1.id DESC --Utile per confrontare il risultato con la versione 1


--Query 17 (facoltativa):
--Trovare il nome e la lunghezza della traccia più lunga appartenente a una release rilasciata in almeno due paesi (il
--risultato deve contenere il nome della traccia e la sua lunghezza in secondi) (scrivere due versioni della query).

--Versione 1: --TODO SUL DB ORIGINALE NON TERMINA (Errore di memoria) --TODO Unità di misura sbagliata?
WITH c_releases AS --Release uscite in più paesi
(
	SELECT release --,COUNT(*)
	FROM release_country
	GROUP BY release
	HAVING COUNT(*)>1
),
c_tracks AS --track appartenenti a release uscite in più paesi 
(
	SELECT track.id, track.name, track.length
	FROM track
	JOIN medium ON track.medium = medium.id
	JOIN release ON medium.release = release.id
	JOIN c_releases ON release.id = c_releases.release
)
SELECT c_tracks.name, c_tracks.length 
FROM c_tracks
WHERE c_tracks.id NOT IN --Negazione essenziale: escludiamo tutte le tuple minori di qualcun'altra
(
	SELECT c1.id
	FROM c_tracks c1
	JOIN c_tracks c2 ON c1.length < c2.length
)

--Versione 2: --TODO Unità di misura sbagliata?
SELECT DISTINCT track.name, track.length
FROM track
JOIN
(
	SELECT MAX(track.length) AS max_length
	FROM track
	JOIN medium ON track.medium = medium.id
	JOIN release ON medium.release = release.id
	JOIN
	(
		SELECT release --,COUNT(*)
		from release_country
		GROUP BY release
		HAVING COUNT(*)>1
	) c_releases 
	ON release.id = c_releases.release
) max_track
ON track.length = max_track.max_length
