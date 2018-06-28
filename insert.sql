--Categoria Sito
INSERT INTO categoriasito VALUES('Primo Piano', '');
INSERT INTO categoriasito VALUES('Nuovo', '');
INSERT INTO categoriasito VALUES('In Salita', '');

--Categoria
INSERT INTO categoria VALUES('Fantasy', '', false);
INSERT INTO categoria VALUES('Horror', '', false);
INSERT INTO categoria VALUES('Sci-Fi', '', false);
INSERT INTO categoria VALUES('Avventura', '', false);
INSERT INTO categoria VALUES('Azione', '', false);
INSERT INTO categoria VALUES('Thriller', '', false);
INSERT INTO categoria VALUES('Divulgazione', '', false);
INSERT INTO categoria VALUES('Scienza', '', false);
INSERT INTO categoria VALUES('Romanzi', '', false);
INSERT INTO categoria VALUES('Scientifico', '', true);
INSERT INTO categoria VALUES('Divulgativo', '', true);
INSERT INTO categoria VALUES('Distopico', '', true);
INSERT INTO categoria VALUES('Futuristico', '', true);
INSERT INTO categoria VALUES('Matematica', '', true);
INSERT INTO categoria VALUES('Saggio', '', true);
INSERT INTO categoria VALUES('Romanzo', '', true);
INSERT INTO categoria VALUES('Classico', '', true);
INSERT INTO categoria VALUES('Saga', '', true);
INSERT INTO categoria VALUES('Vegano', '', true);

--Utente
INSERT INTO utente VALUES ('Philip K. Dick', '2015-11-23', 'Philip', 'K. Dick', '', 1, 0);
INSERT INTO utente VALUES ('Claudio Giunta', '2016-06-23', 'Claudio', 'Giunta', '', 1, 1);
INSERT INTO utente VALUES ('Denis Guedj', '1999-02-11', 'Denis', 'Guedj', '', 1, 0);
INSERT INTO utente VALUES ('J.K. Rowling', '2014-10-23', 'Joanne', 'Rowling', '', 2, 1);
INSERT INTO utente VALUES ('George Orwell', '2009-10-23', 'George', 'Orwell', '', 2, 0);
INSERT INTO utente VALUES ('Douglas R. Hofstadter', '2000-03-17', 'Douglas', 'R. Hofstadter', '', 1, 0);
INSERT INTO utente VALUES ('Marco Perronet', '2044-03-17', 'Marco', 'Perronet', '', 1, 3);
INSERT INTO utente VALUES ('Marco Maida', '1994-03-17', 'Marco', 'Maida', 'Utente Vegano', 1, 2);
INSERT INTO utente VALUES ('C.S. Lewis', '1999-03-30', 'Clive', 'Lewis', '', 1, 0);
INSERT INTO utente VALUES ('George R.R. Martin', '1993-03-01', 'George', 'Martin', '', 1, 0);
INSERT INTO utente VALUES ('Odio Di Palma', '1990-07-17', 'Andrea', 'Mori', 'Utente Vegano', 1, 1);
INSERT INTO utente VALUES ('Shy', '1994-07-17', 'Alessandro', 'Masala', 'Utente Sardo', 0, 1);

--Libro
INSERT INTO libro VALUES ('Blade Runner', 'Philip K. Dick', '', 621, 5000, 3, 'Primo Piano');
INSERT INTO libro VALUES ('Come Non Scrivere', 'Claudio Giunta', '', 200, 1000, 1, 'Nuovo');
INSERT INTO libro VALUES ('Il Teorema Del Pappagallo', 'Denis Guedj', '', 7, 200, 1, NULL);
INSERT INTO libro VALUES ('Harry Potter E La Camera Dei Segreti', 'J.K. Rowling', 'Un classico della letteratura fantasy', 1000, 40000, 1, 'Primo Piano');
INSERT INTO libro VALUES ('1984', 'George Orwell', 'Libro cult', 600, 5000, 1, 'In Salita');
INSERT INTO libro VALUES ('La Fattoria Degli Animali', 'George Orwell', '', 56, 199, 2, NULL);
INSERT INTO libro VALUES ('Harry Potter E L Ordine Della Fenice', 'J.K. Rowling', '', 1000, 43000, 2, 'In Salita');
INSERT INTO libro VALUES ('Un Eterna Ghirlanda Brillante', 'Douglas R. Hofstadter', '', 2, 50, 1, 'In Salita');
INSERT INTO libro VALUES ('Disegnum', 'Marco Perronet', '', 0, 5, 1, NULL);
INSERT INTO libro VALUES ('Farmageddon', 'Marco Maida', '', 30, 400, 1, 'Nuovo');
INSERT INTO libro VALUES ('Le Cronache Di Narnia', 'C.S. Lewis', '', 5, 6000, 1, NULL);
INSERT INTO libro VALUES ('Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin', '', 500, 10000, 2, 'Primo Piano');
INSERT INTO libro VALUES ('Ma I Vegani Sognano Pecore Elettriche?', 'Odio Di Palma', 'Ottimo libro, molto vegano', 30, 400, 1, 'Nuovo');

--Correlazione
INSERT INTO correlazione VALUES('1984', 'George Orwell', 'Blade Runner', 'Philip K. Dick');
INSERT INTO correlazione VALUES('Harry Potter E L Ordine Della Fenice', 'J.K. Rowling', 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling');
INSERT INTO correlazione VALUES('Harry Potter E L Ordine Della Fenice', 'J.K. Rowling', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO correlazione VALUES('Harry Potter E La Camera Dei Segreti', 'J.K. Rowling', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO correlazione VALUES('Il Teorema Del Pappagallo', 'Denis Guedj', 'Un Eterna Ghirlanda Brillante', 'Douglas R. Hofstadter');
INSERT INTO correlazione VALUES('Ma I Vegani Sognano Pecore Elettriche?', 'Odio Di Palma', 'Farmageddon', 'Marco Maida');

--Follow
INSERT INTO follow VALUES('Marco Perronet', 'Marco Maida', '2015-11-23');
INSERT INTO follow VALUES('Marco Maida', 'Marco Perronet', '2000-03-17');
INSERT INTO follow VALUES('Marco Perronet', 'Philip K. Dick', '2014-10-23');
INSERT INTO follow VALUES('Marco Maida', 'George Orwell', '2015-11-23');

--Elenco di lettura
INSERT INTO elencodilettura VALUES('Libri belli', 'Marco Maida');
INSERT INTO elencodilettura VALUES('Libri fantasy da leggere', 'Marco Perronet');
INSERT INTO elencodilettura VALUES('Libri a caso', 'Claudio Giunta');
INSERT INTO elencodilettura VALUES('Libri belli di Orwell', 'Denis Guedj');

--Lettura
INSERT INTO lettura VALUES('Libri belli', 'Marco Maida', 'Marco Maida');
INSERT INTO lettura VALUES('Libri fantasy da leggere', 'Marco Perronet', 'Marco Perronet');
INSERT INTO lettura VALUES('Libri fantasy da leggere', 'Marco Perronet', 'Odio Di Palma');
INSERT INTO lettura VALUES('Libri a caso', 'Claudio Giunta', 'Marco Perronet');
INSERT INTO lettura VALUES('Libri a caso', 'Claudio Giunta', 'J.K. Rowling');
INSERT INTO lettura VALUES('Libri a caso', 'Claudio Giunta', 'Claudio Giunta');
INSERT INTO lettura VALUES('Libri a caso', 'Claudio Giunta', 'Marco Maida');
INSERT INTO lettura VALUES('Libri belli di Orwell', 'Denis Guedj', 'Marco Perronet');
INSERT INTO lettura VALUES('Libri belli di Orwell', 'Denis Guedj', 'Shy');

--Composizione
INSERT INTO composizioneelencolettura VALUES('Libri belli', 'Marco Maida', 'Farmageddon', 'Marco Maida');
INSERT INTO composizioneelencolettura VALUES('Libri belli', 'Marco Maida', 'La Fattoria Degli Animali', 'George Orwell');
INSERT INTO composizioneelencolettura VALUES('Libri belli', 'Marco Maida', 'Ma I Vegani Sognano Pecore Elettriche?', 'Odio Di Palma');
INSERT INTO composizioneelencolettura VALUES('Libri belli', 'Marco Maida', 'Il Teorema Del Pappagallo', 'Denis Guedj');
INSERT INTO composizioneelencolettura VALUES('Libri fantasy da leggere', 'Marco Perronet', 'Le Cronache Di Narnia', 'C.S. Lewis');
INSERT INTO composizioneelencolettura VALUES('Libri fantasy da leggere', 'Marco Perronet', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO composizioneelencolettura VALUES('Libri fantasy da leggere', 'Marco Perronet', 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling');
INSERT INTO composizioneelencolettura VALUES('Libri a caso', 'Claudio Giunta', 'Disegnum', 'Marco Perronet');
INSERT INTO composizioneelencolettura VALUES('Libri a caso', 'Claudio Giunta', 'Come Non Scrivere', 'Claudio Giunta');
INSERT INTO composizioneelencolettura VALUES('Libri a caso', 'Claudio Giunta', 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling');
INSERT INTO composizioneelencolettura VALUES('Libri belli di Orwell', 'Denis Guedj', 'La Fattoria Degli Animali', 'George Orwell');
INSERT INTO composizioneelencolettura VALUES('Libri belli di Orwell', 'Denis Guedj', '1984', 'George Orwell');

--AssociazioneCat 
INSERT INTO associazionecat VALUES('Fantasy', 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling');
INSERT INTO associazionecat VALUES('Avventura', 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling');
INSERT INTO associazionecat VALUES('Romanzo', 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling');
INSERT INTO associazionecat VALUES('Classico', 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling');
INSERT INTO associazionecat VALUES('Saga', 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling');

INSERT INTO associazionecat VALUES('Fantasy', 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling');
INSERT INTO associazionecat VALUES('Avventura', 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling');
INSERT INTO associazionecat VALUES('Romanzo', 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling');
INSERT INTO associazionecat VALUES('Classico', 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling');
INSERT INTO associazionecat VALUES('Saga', 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling');

INSERT INTO associazionecat VALUES('Fantasy', 'Le Cronache Di Narnia', 'C.S. Lewis');
INSERT INTO associazionecat VALUES('Avventura', 'Le Cronache Di Narnia', 'C.S. Lewis');
INSERT INTO associazionecat VALUES('Romanzo', 'Le Cronache Di Narnia', 'C.S. Lewis');
INSERT INTO associazionecat VALUES('Classico', 'Le Cronache Di Narnia', 'C.S. Lewis');
INSERT INTO associazionecat VALUES('Saga', 'Le Cronache Di Narnia', 'C.S. Lewis');

INSERT INTO associazionecat VALUES('Fantasy', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO associazionecat VALUES('Avventura', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO associazionecat VALUES('Romanzo', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO associazionecat VALUES('Classico', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO associazionecat VALUES('Saga', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');

INSERT INTO associazionecat VALUES('Sci-Fi', 'Blade Runner', 'Philip K. Dick');
INSERT INTO associazionecat VALUES('Distopico', 'Blade Runner', 'Philip K. Dick');
INSERT INTO associazionecat VALUES('Futuristico', 'Blade Runner', 'Philip K. Dick');
INSERT INTO associazionecat VALUES('Classico', 'Blade Runner', 'Philip K. Dick');

INSERT INTO associazionecat VALUES('Divulgazione', 'Come Non Scrivere', 'Claudio Giunta');
INSERT INTO associazionecat VALUES('Scienza', 'Il Teorema Del Pappagallo', 'Denis Guedj');

INSERT INTO associazionecat VALUES('Romanzi', '1984', 'George Orwell');
INSERT INTO associazionecat VALUES('Distopico', '1984', 'George Orwell');
INSERT INTO associazionecat VALUES('Futuristico', '1984', 'George Orwell');
INSERT INTO associazionecat VALUES('Classico', '1984', 'George Orwell');

INSERT INTO associazionecat VALUES('Romanzi', 'La Fattoria Degli Animali', 'George Orwell');
INSERT INTO associazionecat VALUES('Scienza', 'Un Eterna Ghirlanda Brillante', 'Douglas R. Hofstadter');
INSERT INTO associazionecat VALUES('Divulgazione', 'Disegnum', 'Marco Perronet');
INSERT INTO associazionecat VALUES('Matematica', 'Un Eterna Ghirlanda Brillante', 'Douglas R. Hofstadter');
INSERT INTO associazionecat VALUES('Matematica', 'Disegnum', 'Marco Perronet');
INSERT INTO associazionecat VALUES('Divulgazione', 'Farmageddon', 'Marco Maida');
INSERT INTO associazionecat VALUES('Divulgazione', 'Ma I Vegani Sognano Pecore Elettriche?', 'Odio Di Palma');
INSERT INTO associazionecat VALUES('Vegano', 'Farmageddon', 'Marco Maida');
INSERT INTO associazionecat VALUES('Vegano', 'Ma I Vegani Sognano Pecore Elettriche?', 'Odio Di Palma');

--Correlazione 
INSERT INTO correlazione VALUES('Harry Potter E La Camera Dei Segreti', 'J.K. Rowling', 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling');
INSERT INTO correlazione VALUES('Harry Potter E La Camera Dei Segreti', 'J.K. Rowling', 'Le Cronache Di Narnia', 'C.S. Lewis');
INSERT INTO correlazione VALUES('Harry Potter E La Camera Dei Segreti', 'J.K. Rowling', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO correlazione VALUES('Le Cronache Di Narnia', 'C.S. Lewis', 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling');
INSERT INTO correlazione VALUES('Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin', 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling');
INSERT INTO correlazione VALUES('Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin', 'Le Cronache Di Narnia', 'C.S. Lewis');
INSERT INTO correlazione VALUES('Blade Runner', 'Philip K. Dick', '1984', 'George Orwell');

--ScritturaCorrelata 
INSERT INTO scritturacorrelata VALUES('Romanzi', 'George Orwell');
INSERT INTO scritturacorrelata VALUES('Fantasy', 'J.K. Rowling');
INSERT INTO scritturacorrelata VALUES('Avventura', 'J.K. Rowling');

--Paragrafo
INSERT INTO paragrafo VALUES(0, 
'Etiam luctus non leo vel luctus. Nunc mollis felis a porta ultrices. Etiam in ligula nulla. Aliquam et tincidunt massa. Pellentesque facilisis efficitur sem vitae commodo. Suspendisse maximus rutrum sodales. Nunc commodo iaculis iaculis. Aenean pretium malesuada orci et convallis. Quisque egestas iaculis orci vel blandit. Sed sit amet velit neque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris vehicula lacus quis nibh commodo imperdiet. Nam posuere euismod quam et tincidunt.'
);
INSERT INTO paragrafo VALUES(1, 1, 'Blade Runner', 'Philip K. Dick',
'Proin viverra, nibh in consectetur maximus, orci leo dictum dolor, vel tincidunt est ante eu orci. Etiam posuere, sapien id elementum consequat, nibh lectus finibus ipsum, id molestie nisl ex ut turpis. Aliquam gravida, nulla id iaculis pharetra, metus nibh blandit nunc, eu maximus eros elit et dolor. Vivamus euismod a risus quis fermentum. Donec vitae risus ligula. Pellentesque iaculis eleifend fermentum. In lacinia vehicula orci, nec mattis purus malesuada eu. Mauris imperdiet at enim eu vestibulum. Morbi mauris lectus, porta semper felis nec, varius egestas nunc. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent pulvinar non sem quis aliquam. Donec eget mi sed purus vulputate finibus. '
);
INSERT INTO paragrafo VALUES(2, 3, 'Blade Runner', 'Philip K. Dick',
'Maecenas ac dignissim ipsum. Donec vel scelerisque lorem. Fusce vel ultricies massa. Suspendisse nec enim quis augue tempus luctus. Duis eu ligula justo. Suspendisse in molestie metus. Donec purus quam, laoreet nec consectetur eget, convallis id elit. Aenean iaculis a ante eu aliquet. Vivamus elementum posuere nisl ac fermentum. Nam mollis mi ac interdum euismod. Fusce urna velit, sodales et tristique nec, feugiat eget urna. Suspendisse potenti. '
);
INSERT INTO paragrafo VALUES(3, 2, 'Blade Runner', 'Philip K. Dick',
'Duis pharetra ullamcorper enim, non blandit nibh faucibus vitae. Nulla arcu lacus, volutpat vel neque id, feugiat feugiat magna. Quisque sed nisl nec purus luctus commodo nec ut erat. Aenean ornare placerat ipsum, quis consectetur diam iaculis a. Nullam et rutrum purus. Aliquam commodo malesuada tortor. Aliquam pulvinar odio sem, sit amet gravida eros mollis at. Integer semper eros eu porttitor vestibulum. Proin scelerisque hendrerit arcu, et auctor massa. Sed at nulla purus. Donec tortor ligula, blandit eget arcu iaculis, bibendum viverra lacus. Aliquam blandit ultricies mi eget aliquam. Nullam eget turpis ut tortor vulputate placerat. Vestibulum leo tortor, sollicitudin sed convallis nec, posuere vitae urna. Mauris tristique viverra euismod. Ut cursus orci lorem, et sodales risus vestibulum eget. '
);
INSERT INTO paragrafo VALUES(4, 1, 'Blade Runner', 'Philip K. Dick',
'Praesent id tristique lorem. Vivamus posuere justo risus, pellentesque interdum leo pretium eu. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus lobortis mi nisl, in sodales magna pharetra sed. Vivamus pharetra placerat velit ac pellentesque. Ut quis maximus sapien, ut sollicitudin nisi. In eget lorem eleifend, euismod tortor id, rutrum dolor. Suspendisse et mauris imperdiet, ullamcorper mi nec, placerat nunc. Phasellus ac nisi dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nullam efficitur ut arcu eget pulvinar. Pellentesque metus massa, molestie a velit sodales, dapibus dignissim sapien. Aenean eget condimentum massa. Aenean non efficitur neque. Suspendisse at iaculis ligula. '
);
INSERT INTO paragrafo VALUES(5, 1, 'Blade Runner', 'Philip K. Dick',
'Etiam eleifend ornare ante, id feugiat mauris. Phasellus vitae tellus luctus ipsum eleifend feugiat in et massa. Phasellus in vestibulum leo, vitae fringilla lacus. Proin hendrerit erat et nisi tempor, in dignissim orci viverra. Mauris eu rutrum purus. Phasellus auctor lacinia risus, sed iaculis nisl auctor non. Nullam feugiat ex vitae lacus luctus mollis. Nam pharetra nibh libero. Etiam ac massa at nunc pellentesque elementum eu sit amet justo. Sed pretium neque vitae interdum lobortis. Maecenas ac porttitor ex, ac elementum mi. Cras convallis lacus id pellentesque porta. '
);
INSERT INTO paragrafo VALUES(6, 1, 'Come Non Scrivere', 'Claudio Giunta',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis hendrerit gravida purus, iaculis malesuada ligula mattis eget. Mauris nec faucibus odio. Quisque fermentum rhoncus dolor, vitae cursus elit facilisis sed. Cras vel massa faucibus, efficitur lorem sit amet, blandit diam. Cras at sagittis orci, quis posuere felis. Duis velit sem, maximus ac mollis non, pellentesque vel lacus. Aliquam elementum maximus mauris. Phasellus at purus lorem. In hac habitasse platea dictumst. Aliquam erat volutpat. Suspendisse urna turpis, mattis vel libero quis, tempor porta quam. Duis pretium, neque nec tempus gravida, turpis odio ullamcorper dui, in gravida nulla erat vitae libero. Donec cursus faucibus congue. '
);
INSERT INTO paragrafo VALUES(7, 1, 'Il Teorema Del Pappagallo', 'Denis Guedj',
'Aliquam tincidunt pulvinar ante blandit tincidunt. Nunc mi nulla, ullamcorper vitae finibus eu, mattis tempus sapien. Nunc luctus facilisis mi, at ornare sapien viverra ut. Ut semper lorem in ornare venenatis. Quisque pharetra consequat aliquet. Praesent ut nibh nec diam scelerisque venenatis rutrum eu dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris gravida consequat purus, ac dapibus arcu consequat vel. Praesent accumsan, arcu in commodo convallis, nulla ex hendrerit ipsum, eget consequat dui nibh ut dui. Donec sit amet sollicitudin est, eu finibus erat. Donec euismod elit ut lacinia fringilla. Nulla facilisi. '
);
INSERT INTO paragrafo VALUES(8, 1, '1984', 'George Orwell',
'Pellentesque vel leo a dui varius dictum at eget ex. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec vitae massa at ipsum malesuada tempor. Maecenas tortor quam, posuere et gravida et, congue nec magna. Nullam vulputate, ante eu tempor luctus, est elit feugiat metus, eu venenatis libero magna in felis. Maecenas euismod consequat lectus rutrum venenatis. Donec sit amet rhoncus tellus, at tempor elit. Fusce sed pellentesque metus. Nullam non magna ac elit tempus molestie. Praesent ipsum est, pulvinar vitae condimentum nec, vehicula et dui. Proin aliquam semper mi vel congue. Nullam in ligula eget mi mollis posuere ut eu ligula. Praesent ac molestie nisl. Cras varius tempor placerat. Aliquam erat volutpat. Phasellus justo sem, malesuada dictum ante a, egestas scelerisque metus. '
);
INSERT INTO paragrafo VALUES(9, 1, 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling',
'Suspendisse massa lectus, luctus eu facilisis in, elementum sit amet arcu. Nulla malesuada mi sit amet cursus convallis. Nam a velit est. Duis consequat metus in odio gravida blandit. Duis iaculis malesuada quam quis tristique. Aenean auctor quis velit a vulputate. Fusce tincidunt ex eu tristique maximus. Aenean lacus sem, porta in diam vitae, porta molestie justo. Aenean ut faucibus tellus. Integer mauris nunc, blandit in felis in, convallis posuere diam. Nullam in iaculis lectus, nec lobortis enim. Duis eget tortor at nisl pellentesque fringilla scelerisque non felis. '
);
INSERT INTO paragrafo VALUES(10, 1, 'La Fattoria Degli Animali', 'George Orwell',
'Maecenas vehicula lectus quis enim elementum malesuada. Integer turpis lorem, facilisis ac mattis nec, sodales vitae massa. Etiam finibus, magna vel molestie tristique, lectus ex viverra libero, eget hendrerit augue ante in tortor. Maecenas bibendum dolor urna, a vulputate enim auctor id. Nulla hendrerit pellentesque est, quis lobortis tortor suscipit at. Sed tempor non mauris nec tempor. Vivamus dignissim congue neque quis maximus. In placerat, eros ac lacinia ullamcorper, nulla risus eleifend neque, sed eleifend mauris ante in odio. Phasellus egestas mauris nec magna finibus gravida. '
);
INSERT INTO paragrafo VALUES(11, 2, 'La Fattoria Degli Animali', 'George Orwell',
'Ut tristique imperdiet tortor vitae suscipit. Proin suscipit malesuada tortor in elementum. Etiam varius lorem et arcu viverra molestie. Quisque volutpat nulla vel congue suscipit. Duis cursus feugiat felis, bibendum volutpat nisl pretium id. Aliquam vestibulum mollis neque non iaculis. Nunc sodales vel nisl at finibus. Maecenas neque augue, vehicula eget libero ac, auctor lobortis risus. Ut laoreet diam nunc, vitae ultricies nisi ultrices at. Sed sit amet varius dui. Ut eget efficitur nisl. Nam bibendum eget sapien a tempor. Quisque sed turpis condimentum, auctor metus sed, tincidunt est. Ut nisl lacus, condimentum sit amet neque vitae, luctus commodo enim. '
);
INSERT INTO paragrafo VALUES(12, 1, 'Un Eterna Ghirlanda Brillante', 'Douglas R. Hofstadter',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam porttitor volutpat purus ut blandit. Donec cursus sit amet purus sed maximus. Nam a est aliquet, hendrerit massa vitae, cursus urna. Maecenas eu massa sit amet nulla rhoncus venenatis vitae ac purus. Nullam eget dui venenatis, commodo sem id, eleifend tortor. Donec commodo lobortis nisl, eget iaculis odio elementum sit amet. Suspendisse varius tincidunt tellus vulputate efficitur. Donec at placerat risus. Nullam interdum malesuada cursus. Curabitur faucibus purus eu venenatis fermentum. Quisque non pulvinar odio, nec bibendum leo. Pellentesque malesuada nisi varius enim commodo, ac efficitur mi posuere. Nulla in sem at ante pellentesque hendrerit eget sit amet lacus. Sed sed justo in dolor suscipit porta et ac lacus. Proin tempor convallis dui, non bibendum erat sagittis in.'
);
INSERT INTO paragrafo VALUES(13, 1, 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacus ex, vehicula ut diam id, feugiat malesuada est. Aenean tellus nunc, aliquet at venenatis non, porttitor quis ligula. Donec gravida et mauris ac egestas. Cras consequat tincidunt laoreet. Nulla ultrices, neque nec commodo lobortis, purus sem posuere turpis, eu efficitur lectus diam nec sem. Nullam imperdiet sit amet urna eget pulvinar. Aliquam eget semper ipsum. Nulla nunc dui, auctor volutpat sollicitudin vel, accumsan et erat. Curabitur pellentesque porta purus, nec efficitur purus lacinia eu. Nunc mattis vestibulum lacus ac faucibus.'
);
INSERT INTO paragrafo VALUES(14, 2, 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vulputate arcu non sem pretium, quis tempor dui aliquet. Sed scelerisque, tortor sit amet aliquet laoreet, ex arcu cursus arcu, vel euismod nulla nunc at enim. Praesent facilisis lectus quis efficitur dapibus. Nam pellentesque, eros at tempus malesuada, justo sem finibus arcu, nec interdum orci libero vitae nulla. Cras ut laoreet justo. Donec sodales odio a ultricies convallis. Cras consectetur pulvinar ullamcorper. Phasellus auctor purus vitae quam accumsan, in vestibulum mi pulvinar. Duis nunc risus, sagittis ac mattis ac, pretium nec tortor. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Quisque lacus tortor, sollicitudin a pharetra auctor, semper ut tortor. Duis a nibh lacus.'
);
INSERT INTO paragrafo VALUES(15, 'Farmageddon', 'Marco Maida',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas placerat arcu eu mauris semper ullamcorper. Nullam semper mauris tortor, vel pretium urna bibendum vel. Curabitur pulvinar varius libero, a suscipit nunc sodales et. Phasellus vel tincidunt nulla, a pellentesque nunc. Duis ultrices id tellus vitae ullamcorper. Fusce sodales a sapien vel accumsan. Ut porta ante non dignissim suscipit. Quisque aliquet commodo magna. Proin rhoncus mi et urna egestas, vitae sollicitudin sapien pharetra. In et tortor magna. Nunc maximus aliquet volutpat. Curabitur in semper diam, scelerisque convallis mi. Donec vestibulum vestibulum diam sit amet vestibulum. Curabitur nulla lorem, facilisis a elementum eu, volutpat eget lorem. Morbi tincidunt ligula eget ultrices volutpat. Cras ac elementum massa, sit amet hendrerit mi.'
);
INSERT INTO paragrafo VALUES(16, 1, 'Disegnum', 'Marco Perronet',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis mi non odio volutpat fringilla ut ut orci. Nunc quis sem eu mauris dignissim vehicula ut a orci. Vestibulum ac pulvinar arcu. In urna nibh, pharetra lacinia finibus nec, eleifend sed turpis. Nam vitae augue venenatis, blandit ipsum non, volutpat lorem. Curabitur dignissim quam nibh, ut bibendum enim consectetur ut. Suspendisse potenti. Vestibulum viverra accumsan euismod. Curabitur id vestibulum nisi, sit amet molestie ligula. Sed consequat eros sed porttitor luctus. Duis lobortis maximus suscipit. Nulla posuere, enim ornare efficitur viverra, ante magna convallis augue, id suscipit tellus dui eu diam. In hac habitasse platea dictumst. Praesent quis pretium diam. Cras mollis lacinia tortor, in viverra lacus convallis in. Duis aliquam malesuada lacinia.'
);
INSERT INTO paragrafo VALUES(17, 1, 'Le Cronache Di Narnia', 'C.S. Lewis',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer vel augue in risus bibendum imperdiet. Vivamus viverra ligula at maximus efficitur. Phasellus elementum sapien leo, vel varius sem auctor suscipit. Sed malesuada cursus congue. Duis ultricies quam non enim condimentum, laoreet mattis leo fermentum. In quis euismod leo. Duis imperdiet ultricies erat, vitae imperdiet ante vulputate sit amet.'
);
INSERT INTO paragrafo VALUES(18, 1, 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum maximus dolor odio, at pellentesque augue suscipit quis. Pellentesque cursus blandit enim in dictum. Aliquam sollicitudin, nibh vitae fringilla fermentum, mauris lacus consequat sem, ut efficitur velit erat vitae leo. Etiam tincidunt consectetur sapien, sed fringilla est dignissim id. Phasellus in orci eget metus posuere vestibulum eu quis nisl. Nam vestibulum, arcu ac rhoncus consectetur, nunc quam pulvinar leo, non finibus magna nisl non turpis. Integer et dictum massa. Praesent congue non ipsum vitae suscipit. Sed eu gravida justo. Curabitur augue nibh, iaculis condimentum nibh at, vestibulum lobortis lectus. Pellentesque convallis porta nisl, eu finibus tortor mollis a. Cras maximus interdum malesuada.'
);
INSERT INTO paragrafo VALUES(19, 2, 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean malesuada eros ac nunc volutpat sollicitudin. Pellentesque ac tempor ipsum, nec molestie tortor. Donec ut nulla at tortor tristique tempor in eu sem. Nam eros massa, mollis vel lorem eu, imperdiet dignissim ex. Vestibulum eget laoreet felis. Phasellus a dolor hendrerit, congue tellus eget, iaculis lectus. Nulla auctor iaculis consectetur. Sed ut consectetur ante, sed porta tortor. Duis finibus facilisis leo tristique rhoncus.'
);
INSERT INTO paragrafo VALUES(20, 1, 'Ma I Vegani Sognano Pecore Elettriche?', 'Odio Di Palma',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sem ex, ultrices quis vehicula ac, congue non nisl. Etiam lobortis nisl et arcu fringilla ornare. Vestibulum vel erat blandit, luctus mauris et, imperdiet dui. Mauris fermentum ligula sem, et condimentum elit consectetur a. Quisque pellentesque a erat sed consequat. Integer dictum nisi sit amet dolor sagittis, scelerisque tempor risus ullamcorper. Fusce quis varius nibh. Donec fermentum diam at tincidunt sollicitudin. Aliquam erat volutpat. In augue augue, tincidunt sit amet nibh id, dictum accumsan mi. Nullam dictum neque quis massa tempus, non pharetra mi blandit. Vivamus sit amet lacus bibendum mi efficitur sodales sit amet sed tellus. Aenean at nisi sollicitudin, pulvinar ante ac, facilisis ante.'
);

--Capitolo
INSERT INTO scritturacorrelata VALUES(1, 'Blade Runner', 'Philip K. Dick', 'In interdum');
INSERT INTO scritturacorrelata VALUES(2, 'Blade Runner', 'Philip K. Dick', 'Pellentesque habitant');
INSERT INTO scritturacorrelata VALUES(3, 'Blade Runner', 'Philip K. Dick', 'Curabitur at');
INSERT INTO scritturacorrelata VALUES(1, 'Come Non Scrivere', 'Claudio Giunta', 'Suspendisse vitae');
INSERT INTO scritturacorrelata VALUES(1, 'Il Teorema Del Pappagallo', 'Denis Guedj', 'Sed vestibulum');
INSERT INTO scritturacorrelata VALUES(1, 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling', 'Nam felis');
INSERT INTO scritturacorrelata VALUES(1, '1984', 'George Orwell', 'Phasellus lobortis');
INSERT INTO scritturacorrelata VALUES(1, 'La Fattoria Degli Animali', 'George Orwell', 'Nunc pellentesque');
INSERT INTO scritturacorrelata VALUES(2, 'La Fattoria Degli Animali', 'George Orwell', 'Aenean mattis');
INSERT INTO scritturacorrelata VALUES(1, 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling', 'Nunc faucibus');
INSERT INTO scritturacorrelata VALUES(2, 'Harry Potter E L Ordine Della Fenice', 'J.K. Rowling', 'Praesent iaculis');
INSERT INTO scritturacorrelata VALUES(1, 'Un Eterna Ghirlanda Brillante', 'Douglas R. Hofstadter', 'Vivamus in');
INSERT INTO scritturacorrelata VALUES(1, 'Disegnum', 'Marco Perronet', 'Sed a');
INSERT INTO scritturacorrelata VALUES(1, 'Farmageddon', 'Marco Maida', 'Quisque id');
INSERT INTO scritturacorrelata VALUES(1, 'Le Cronache Di Narnia', 'C.S. Lewis', 'Donec vel');
INSERT INTO scritturacorrelata VALUES(1, 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin', 'Praesent in');
INSERT INTO scritturacorrelata VALUES(2, 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin', 'Aliquam eu');
INSERT INTO scritturacorrelata VALUES(1, 'Ma I Vegani Sognano Pecore Elettriche?', 'Odio Di Palma', 'Ut felis');

--Commento
INSERT INTO commento VALUES(20, 'Marco Maida', '2015-11-23', 'Bel passaggio, molto vegano');
INSERT INTO commento VALUES(17, 'Marco Perronet', '2000-03-17', 'Praesent iaculis augue a erat pulvinar tempor. In vulputate.');
INSERT INTO commento VALUES(1, 'Philip K. Dick', '2014-10-23', 'Nunc molestie quis leo sit amet cursus. Fusce rhoncus');
INSERT INTO commento VALUES(5, 'George Orwell', '2015-11-23', 'Vivamus suscipit risus consectetur mauris viverra, non mollis est.');
INSERT INTO commento VALUES(2, 'J.K. Rowling', '2014-10-23', 'Maecenas vel iaculis purus. Integer eu posuere tellus. Maecenas.');
INSERT INTO commento VALUES(2, 'Marco Perronet', '2014-10-23', 'Curabitur vulputate urna sem. Cras tortor nisl, lacinia eu.');
INSERT INTO commento VALUES(13, 'Odio Di Palma', '2015-11-23', 'Maecenas pretium sodales tortor eget elementum. Etiam porttitor eget.');
INSERT INTO commento VALUES(13, 'Marco Maida', '2000-03-17', 'Mauris rhoncus imperdiet metus ultrices efficitur. Suspendisse quis ante.');