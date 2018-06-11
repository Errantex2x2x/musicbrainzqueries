--Pari: io
--Dispari: tu
--OCCHIO: se vuoi elencare release senza ripetizioni usa release_group piuttosto che release con la distinct

--Query 1:
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
JOIN language ON release.language = language.id AND language.name = 'Italian' --TO TEST ON FULL DB, HERE THERE ARE NO ITA SONGS
JOIN artist_credit ON track.artist_credit = artist_credit.id

--Query 3:
--Elencare le release di cui non si conosce la lingua (il risultato deve contenere soltanto il nome della release).

SELECT release.name
FROM release
JOIN language ON release.language = language.id AND language.iso_code_1 IS NULL --RIVEDERE

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

SELECT artist.name, release_group.name FROM release_group 
JOIN artist_credit ON release_group.artist_credit = artist_credit.id
JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
JOIN artist ON artist.id = artist_credit_name.artist AND artist.ended = FALSE
JOIN artist_type ON artist.type = artist_type.id AND artist_type.name = 'Group'
JOIN area ON artist.area = area.id AND area.name = 'United Kingdom' --TODO siamo sicuri che vada bene uk?
--NOTA:GUARDA LA QUERY 13. PENSO CHE VADA BENE UNITED KINGDOM
ORDER BY artist.name, release_group.name

--Query 7:
--Trovare le release in cui il nome dell’artista è diverso dal nome accreditato nella release (il risultato deve
--contenere il nome della release, il nome dell’artista accreditato (cioè artist_credit.name) e il nome dell’artista
--(cioè artist.name))

SELECT release.name, artist_credit.name, artist.name 
FROM release 
JOIN artist_credit ON release.artist_credit = artist_credit.id
JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
JOIN artist ON artist.id = artist_credit_name.artist
WHERE artist.name <> artist_credit.name

--Query 8:
--Trovare gli artisti con meno di tre release (il risultato deve contenere il nome dell’artista ed il numero di
--release).

SELECT artist.name, count(release.id) total_releases FROM release
JOIN artist_credit ON release.artist_credit = artist_credit.id
JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
JOIN artist ON artist.id = artist_credit_name.artist
GROUP BY artist.id
HAVING count(release.id) < 3

--Query 9:
--Trovare la registrazione più lunga di un’artista donna (il risultato deve contenere il nome della registrazione, la
--sua durata in minuti e il nome dell’artista; tenere conto che le durate sono memorizzate in millesimi di secondo)
--(scrivere due versioni della query con e senza operatore aggregato MAX).
--07/05/18

--Versione 1:
WITH female_rec AS 
(
	SELECT recording.name AS recording_name, length, artist.name AS artist_name
	FROM recording
	JOIN artist_credit_name ON artist_credit_name.artist = recording.artist_credit
	JOIN artist ON artist.id = artist_credit_name.artist
	JOIN gender ON gender.id = artist.gender AND gender.name = 'Female'
)
SELECT recording_name, length/60000 + length%60/100. AS length, artist_name
FROM female_rec
WHERE length = ( SELECT MAX(length) AS max_length FROM female_rec )--Potrebbe ritornare più di un valore, in caso di pari lunghezza

--Versione 2:
WITH female_rec AS 
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

SELECT * FROM
(SELECT language.name FROM language
EXCEPT
SELECT language.name FROM language
JOIN release ON release.language = language.id) AS result--TODO MANCA IL COUNT MA CHE CAZZO DI SENSO HA!?!?!
ORDER BY result.name
--Che schifo cazzo!!!
--TODO FARE VERSIONE 2 CON LEFT O RIGHT JOIN

--Query 11:
--Ricavare la seconda registrazione per lunghezza di un artista uomo (il risultato deve comprendere l'artista
--accreditato, il nome della registrazione e la sua lunghezza) (scrivere due versioni della query).

--Versione 1:
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

--Versione 2:
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
--TODO DEVONO ESSERE IN MINUTI!!!!!!!!!!!!!!!!!!!!!!!!!! GUARDA SOPRA
SELECT area.name, sum(recording.length) total_length FROM area
JOIN area_type ON area.type = area_type.id AND area_type.name = 'Country'
JOIN artist ON artist.area = area.id
JOIN artist_credit_name ON artist_credit_name.artist = artist.id
JOIN artist_credit ON artist_credit.id = artist_credit_name.artist_credit
JOIN recording ON artist_credit.id = recording.artist_credit --nemmeno facendo LEFT JOIN qui stampa gli zeri!
GROUP BY area.id

--Test left join (funziona ma comunque niente zeri)
SELECT artist_credit.name, sum(length) FROM artist_credit LEFT JOIN recording ON artist_credit.id = recording.artist_credit GROUP BY artist_credit.id

--TODO SECONDA VERSIONE

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
SELECT artist.name, 'United Kingdom', uk_rel.*
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

--Query 17 (facoltativa):
--Trovare il nome e la lunghezza della traccia più lunga appartenente a una release rilasciata in almeno due paesi (il
--risultato deve contenere il nome della traccia e la sua lunghezza in secondi) (scrivere due versioni della query).

--Versione 1:
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

--Versione 2:
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