--COMPONENTI DEL GRUPPO
--Marco Maida
--Marco Perronet

--set search_path = "$user", public, musicbrainz;

------------------------------------------------------------------------------------------------------------------------
﻿
--Query 1:
--Contare il numero di lingue in cui le release contenute nel database sono scritte (il risultato deve contenere
--soltanto il numero delle lingue, rinominato “Numero_Lingue”).

SELECT COUNT(DISTINCT language) Numero_Lingue
FROM release

--************
--Consideriamo tutte le tuple della tabella "release": Per risolvere la query basterà contare
--tutte le distinte lingue. Eventuali valori nulli non vengono considerati nel conteggio.
--Per verificare la correttezza,possiamo notare come eseguendo la seguente query:
SELECT DISTINCT language
FROM release
--appaiano esattamente lo stesso numero di tuple del count +1 (alcune release non hanno lingua)


------------------------------------------------------------------------------------------------------------------------
﻿
--Query 2:
--Elencare gli artisti che hanno cantato canzoni in italiano (il risultato deve contenere il nome dell’artista e il nome
--della lingua).

SELECT DISTINCT artist_credit.name AS artist_name, language.name AS language
FROM track
JOIN medium ON track.medium = medium.id
JOIN release ON medium.release = release.id
JOIN language ON release.language = language.id AND language.name = 'Italian' 
JOIN artist_credit ON track.artist_credit = artist_credit.id

--************
--Per risolvere questa query, dobbiamo partire dalla tabella track e ripercorrere
--la base di dati fino a ricollegarci all'informazione sulla lingua.
--Passiamo quindi da medium e release
--Partendo dalla lista delle canzoni in italiano:
WITH italian_tracks AS 
(
	SELECT track.artist_credit AS artist
	FROM track
	JOIN medium ON track.medium = medium.id
	JOIN release ON medium.release = release.id
	JOIN language ON release.language = language.id AND language.name = 'Italian'
)
-- ricaviamo gli autori associati e li stampiamo
SELECT *
FROM italian_tracks
JOIN artist_credit ON italian_tracks.artist = artist_credit.id
--Possiamo verificare il risultato includendo nella proiezione finale il nome della traccia
--e i dati su medium e release.

------------------------------------------------------------------------------------------------------------------------
﻿
--Query 3:
--Elencare le release di cui non si conosce la lingua (il risultato deve contenere soltanto il nome della release).

SELECT release.name
FROM release
WHERE language IS NULL

--************
--Dobbiamo semplicemente selezionare tra le release quelle che hanno l'attributo "language"
--valido. Dato che esiste un vincolo di integrità referenziale, se "language" non è nullo
--deve esistere una corrispettiva lingua. Abbiamo quindi finito


------------------------------------------------------------------------------------------------------------------------

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

--************
--Questa query si risolve senza alcun join: tutta la difficoltà sta nella manipolazione delle stringhe
--Con il primo set di where ci assicuriamo che il nome contenga almeno una volta tutte le vocali.
--L'ultima condizione assicura la presenza di una sola parola.
--Eventuali valori nulli vengono esclusi automaticamente.
--Possiamo convincerci della correttezza della query osservando i risultati o costruendo una 
--versione più pesante ma più esplicita basata sulle intersezioni

------------------------------------------------------------------------------------------------------------------------

--Query 5:
--Elencare tutti gli pseudonimi di Prince con il loro tipo, se disponibile (il risultato deve contenere lo pseudonimo
--dell'artista, il nome dell’artista (cioè Prince) e il tipo di pseudonimo (se disponibile)).

SELECT artist.name, alias.name, type.name
FROM artist
JOIN artist_alias alias ON alias.artist = artist.id
JOIN artist_alias_type type ON alias.type = type.id
WHERE artist.name = 'Prince'

--************
--Per risolvere questa query dobbiamo trovare la tupla che rappresenta Prince e poi 
--utilizzare la sua chiave primaria per trovare gli pseudonimi contenuti nella tabella degli alias.
--Dato che la query richiede anche il tipo di pseudonimo, eseguiamo una semplice join tra gli alias e i tipi di pseudonimo.
--Il primo sottoproblema consiste nell'individuare Price:
SELECT *
FROM artist
WHERE artist.name = 'Prince'
--NB: in questa fase, dato che il nome dell'artista non costituisce chiave primaria, potremmo incontrare duplicati.
--Potremmo risolvere il problema controllando dei dati extra come la data di nascita o le canzoni create, ma comunque
--la query risulterebbe ambigua. Inoltre, in quel caso non potremmo sapere di quale 'Prince' parli la query.
--Ammettiamo quindi di mostrare entrambi i risultati in caso di duplicato. Il db ne contiene uno.
--La parte successiva della query consiste soltanto in due semplici join senza condizioni particolari.

--Potremmo filtrare gli pseudonimi del tipo "search hint" ma alcuni sono rilevanti.

------------------------------------------------------------------------------------------------------------------------

--Query 6:
--Elencare le release di gruppi inglesi ancora in attività (il risultato deve contenere il nome del gruppo e il nome
--della release e essere ordinato per nome del gruppo e nome della release)

SELECT artist.name AS artist, release_group.name AS release 
FROM release_group 
--TODO cosi non escludi automaticamente tutti gli artisti che non hanno mai fatto una release?
JOIN artist_credit ON release_group.artist_credit = artist_credit.id
JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
JOIN artist ON artist.id = artist_credit_name.artist AND artist.ended = FALSE
JOIN artist_type ON artist.type = artist_type.id AND artist_type.name = 'Group'
JOIN area ON artist.area = area.id AND area.name = 'United Kingdom' 
ORDER BY artist.name, release_group.name

--************
--Per risolvere questa query dobbiamo trovare, per ogni artista, la sua area di appartenenza
--e se è ancora in attività (artist.ended).

------------------------------------------------------------------------------------------------------------------------

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

--************
--Per prima cosa associamo ad ogni release l'artista accreditato, il nome e da quest'ultimo 
--ricaviamo l'artista.
--L'unica parte interessante della query è la selezione che include le tuple in cui il nome dell'artista associato
--utilizzando le chiavi è effettivamente diverso da quello che appare nella tabella artist_credit

--Possiamo verificare la correttezza della query osservando i risultati: la colonna artista_accreditato è
--sempre differente da "artista". Dato che le join sono effettuate su chiavi esterne e primarie, possiamo dedurre
--la correttezza della query

------------------------------------------------------------------------------------------------------------------------

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

--************


------------------------------------------------------------------------------------------------------------------------

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
SELECT DISTINCT recording_name, length/60000 + length%60/100. AS length, artist_name
FROM female_rec
WHERE length = ( SELECT MAX(length) AS max_length FROM female_rec )

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

--************
--Per risolvere questa query è necessario isolare tutte le tuple contenenti registrazioni
--di artiste. Per fare questo, partiamo da recording e raggiungiamo l'attributo gender.name
--passando tramile le chiavi esterne in artist_credit_name, artist e gender.
--Entrambe le versioni partono in questo modo, tramite la query parziale che definisce female_rec.

--A questo punto, la versione uno esegue semplicemente una query che seleziona il massimo
--La versione due adotta un approccio diverso, che è a tutti gli effetti una negazione essenziale
--che ha come insieme universo female_rec da cui vengono tolte tutte le registrazioni minori di almeno un'altra.
--Per via della sua inottimalità, la versione 2 fa fatica a terminare quando il numero di tuple diventa molto grande.

--NB:La query potrebbe ritornare più di un valore, in caso di pari lunghezza. Dato che non 
--è specificato cosa fare in cui esistono due brani di massima lunghezza, semplicemente
--accettiamo che vengano ritornati entrambi.


------------------------------------------------------------------------------------------------------------------------

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

--************


------------------------------------------------------------------------------------------------------------------------

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
 
--************
--la tabella male_rec è costruita esattamente con lo stesso sistema di female_rec della query 9.
--Nella versione 1, ricaviamo il massimo della tabella temporanea contenente tutte le registrazioni maschili
--eccetto quella più lunga.
--Nella versione 2, selezioniamo da male_rec solamente le tuple che abbiano una sola registrazione
--di lunghezza maggiore all'interno della stessa tabella.
--Entrambe le versioni hanno difficoltà a terminare sul database completo. L'assenza di LIMIT e OFFSET è un forte vincolo in questo caso.
--Come per la query 9, semplicemente presentiamo più tuple nel caso di multiple registrazioni più lunghe di tutte.

------------------------------------------------------------------------------------------------------------------------

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

--************


------------------------------------------------------------------------------------------------------------------------

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
SELECT artist.name, 'United Kingdom' AS country, uk_rel.releases_num
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

--************
--Dato che dobbiamo trovare gli artisti con più di 10 release, è necessario collegare la
--tabella artist con release. Joiniamo quindi utilizzando le chiavi esterne e primarie 
--passando per artist_credit e artist_credit_name.

--La prima versione, sfrutta una group by per ottenere immediatamente il risultato: 
--raggruppiamo per artist.id, artist.name, area.name (che equivale a raggruppare per artist.id)
--ed utilizziamo l'operatore di aggregazione COUNT per selezionare solo gli artisti con più di 10 release.

--La seconda versione è logicamente equivalente alla prima ma sfrutta una sottoquery su cui poi
--effettua una selezione. Fondamentalmente, questa sarebbe la strategia di risoluzione nel caso in cui
--non avessimo a disposizione il costrutto "HAVING".

--Possiamo verificare la correttezza delle query visualizzando le diverse release:
SELECT release.id,release.name, artist.id 
FROM release 
JOIN artist_credit ON release.artist_credit = artist_credit.id
JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
JOIN artist ON artist.id = artist_credit_name.artist
WHERE artist.id IN
(--Query versione 1:
	SELECT artist.id
	FROM release 
	JOIN artist_credit ON release.artist_credit = artist_credit.id
	JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
	JOIN artist ON artist.id = artist_credit_name.artist
	JOIN area ON artist.area = area.id AND area.name = 'United Kingdom'
	GROUP BY artist.id, artist.name, area.name
	HAVING COUNT(release.name) >= 10
)
ORDER BY artist.id
--Notiamo come per ogni id dell'artista esistano diverse release (sempre più di 10)
--Notiamo inoltre come i risultati siano equivalenti:
--Basta inserire una EXCEPT tra una query e l'altra per ottenere in output una relazione vuota.
--(questo deve valere a prescindere dall'ordinamento delle query) 

------------------------------------------------------------------------------------------------------------------------

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

--************


------------------------------------------------------------------------------------------------------------------------

--Query 15:
--Ricavare il primo artista morto dopo Louis Armstrong (il risultato deve contenere il nome dell’artista, la sua data
--di nascita e la sua data di morte) (scrivere due versioni della query).

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
(--Artisti con data di morte maggiore di Louis
	SELECT MIN(MAKE_DATE(min.end_date_year,min.end_date_month,min.end_date_day)) AS death
	FROM artist AS min
	JOIN artist_type ON min.type = artist_type.id AND artist_type.name = 'Person'
	JOIN artist AS l ON l.name = 'Louis Armstrong' 
	AND MAKE_DATE(min.end_date_year,min.end_date_month,min.end_date_day) > MAKE_DATE(l.end_date_year,l.end_date_month,l.end_date_day) 
) min_artist 
ON MAKE_DATE(a.end_date_year,a.end_date_month,a.end_date_day) = min_artist.death

--************
--Dalla documentazione: "Begin date represents date of birth, and end date represents date of death."
--Questo vale SOLO per le persone, dobbiamo quindi usare 'Person' come artist_type
--Per questa query, dobbiamo partire ricercando la tupla contenente le informazioni su
--Louis Armstrong. Valgono le stesse considerazioni riportate per la query di Prince (5)
SELECT MAKE_DATE(end_date_year,end_date_month,end_date_day) AS death
FROM artist 
WHERE name = 'Louis Armstrong'
--Nella versione 1, ricaviamo il minimo tra le date maggiori di quella della morte di Louis.
--Anche qui, come in altre situazioni, mostriamo più tuple nel caso in cui ci siano due artisti morti
--per primi dopo Louis.
--La versione 2 arriva allo stesso risultato sfruttando una self join, in cui vengono eliminati gli artisti
--con data minore o uguale a Louis.

--Possiamo convincerci della correttezza ordinando gli artisti con data di morte maggiore
--di Louis in senso crescente
SELECT min.name, MAKE_DATE(min.end_date_year,min.end_date_month,min.end_date_day) AS death
FROM artist AS min
JOIN artist_type ON min.type = artist_type.id AND artist_type.name = 'Person'
JOIN artist AS l ON l.name = 'Louis Armstrong' 
AND MAKE_DATE(min.end_date_year,min.end_date_month,min.end_date_day) > MAKE_DATE(l.end_date_year,l.end_date_month,l.end_date_day) 
ORDER BY death
--Notiamo che il primo della lista è lo stesso

------------------------------------------------------------------------------------------------------------------------

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

--************


------------------------------------------------------------------------------------------------------------------------

--Query 17 (facoltativa):
--Trovare il nome e la lunghezza della traccia più lunga appartenente a una release rilasciata in almeno due paesi (il
--risultato deve contenere il nome della traccia e la sua lunghezza in secondi) (scrivere due versioni della query).

--Versione 1:
SELECT DISTINCT track.name, track.length/1000.
FROM track
JOIN
(--Lunghezza massima delle track che ci interessano
	SELECT MAX(track.length) AS max_length
	FROM track
	JOIN medium ON track.medium = medium.id
	JOIN
	(--Selezioniamo le release rilasciate in almeno due paesi
		SELECT release --,COUNT(*)
		from release_country
		GROUP BY release
		HAVING COUNT(*)>1
	) c_releases 
	ON medium.release = c_releases.release
) max_track
ON track.length = max_track.max_length

--Versione 2:
WITH c_releases AS 
(--Release uscite in più paesi
	SELECT release --,COUNT(*)
	FROM release_country
	GROUP BY release
	HAVING COUNT(*)>1
),
c_tracks AS 
(--track appartenenti a release uscite in più paesi 
	SELECT track.id, track.name, track.length
	FROM track
	JOIN medium ON track.medium = medium.id
	JOIN release ON medium.release = release.id
	JOIN c_releases ON release.id = c_releases.release
)
SELECT c_tracks.name, c_tracks.length/1000.
FROM c_tracks
WHERE c_tracks.id NOT IN --Negazione essenziale: escludiamo tutte le tuple minori di qualcun'altra
(
	SELECT c1.id
	FROM c_tracks c1
	JOIN c_tracks c2 ON c1.length < c2.length
)

--************
--Per risolvere questa query, partiamo ottenendo la lista delle release uscite in più paesi:
SELECT release --,COUNT(*)
from release_country
GROUP BY release
HAVING COUNT(*)>1
--NB:essendo release e country chiavi di release_country, possiamo effettuare un count senza distinct:
--Raggruppando per release, non possiamo che includere paesi diversi tra loro nel raggruppamento.

--Una volta fatto ciò, possiamo procedere come nelle precedenti query alla ricerca della traccia
--di lunghezza massima.

--Nella versione 1, ci assicuriamo di eliminare tutte le track appartenenti a release che non
--ci interessano effettuando una Join con la tabella di release filtrata (c_releases).
--A questo punto selezioniamo il massimo usando MAX.
--NB: anche in questa query potremmo ritornare più valori nel caso in cui esistano due track della stessa
--lunghezza come massimo. Dato che la richiesta non specifica che cosa fare in questi casi, noi riportiamo entrambe.

--La versione 2 sfrutta invece una negazione essenziale per raggiungere lo stesso risultato.
--Per prima cosa vengono costruite c_releases (già spiegata sopra) c_tracks, ovvero tutte
--le track associabili a release di c_releases.
--Una volta fatto questo eseguiamo una semplice negazione essenziale utilizzando c_tracks.

--La versione 2 mette in difficoltà il db completo per via della sua inottimalità.
