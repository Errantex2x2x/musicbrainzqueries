begin;

--Libro
INSERT INTO libro VALUES ('Blade Runner', 'Philip K. Dick', '', 621, 5000, 20, 'Primo Piano');
INSERT INTO libro VALUES ('Come Non Scrivere', 'Claudio Giunta', '', 200, 1000, 13, 'Nuovo');
INSERT INTO libro VALUES ('Il Teorema Del Pappagallo', 'Denis Guedj', '', 7, 200, 35, NULL);
INSERT INTO libro VALUES ('Harry Potter E La Camera Dei Segreti', 'J.K. Rowling', 'Un classico della letteratura fantasy', 1000, 40000, 27, 'Primo Piano');
INSERT INTO libro VALUES ('1984', 'George Orwell', 'Libro cult', 600, 5000, 18, 'In Salita');
INSERT INTO libro VALUES ('La Fattoria Degli Animali', 'George Orwell', '', 56, 199, 17, NULL);
INSERT INTO libro VALUES ('Harry Potter E L Ordine Della Fenice', 'J.K. Rowling', '', 1000, 43000, 30, 'In Salita');
INSERT INTO libro VALUES ('Un Eterna Ghirlanda Brillante', 'Douglas R. Hofstadter', '', 2, 50, 100, 'In Salita');
INSERT INTO libro VALUES ('Disegnum', 'Marco Perronet', '', 0, 5, 8, NULL);
INSERT INTO libro VALUES ('Farmageddon', 'Marco Maida', '', 30, 400, 3, 'Nuovo');
INSERT INTO libro VALUES ('Le Cronache Di Narnia', 'C.S. Lewis', '', 5, 6000, 25, NULL);
INSERT INTO libro VALUES ('Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin', '', 500, 10000, 30, 'Primo Piano');
INSERT INTO libro VALUES ('Ma I Vegani Sognano Pecore Elettriche?', 'Odio Di Palma', 'Ottimo libro, molto vegano', 30, 400, 3, 'Nuovo');

--Utente
INSERT INTO utente VALUES ('Philip K. Dick', 23-11-2015, 'Philip', 'K. Dick', '', 1, 0);
INSERT INTO utente VALUES ('Claudio Giunta', 23-06-2016, 'Claudio', 'Giunta', '', 1, 1);
INSERT INTO utente VALUES ('Denis Guedj', 11-02-1999, 'Denis', 'Guedj', '', 1, 0);
INSERT INTO utente VALUES ('J.K. Rowling', 23-10-2014, 'Joanne', 'Rowling', '', 2, 1);
INSERT INTO utente VALUES ('George Orwell', 23-10-2009, 'George', 'Orwell', '', 2, 0);
INSERT INTO utente VALUES ('Douglas R. Hofstadter', 17-03-2000, 'Douglas', 'R. Hofstadter', '', 1, 0);
INSERT INTO utente VALUES ('Marco Perronet', 17-03-2044, 'Marco', 'Perronet', '', 1, 3);
INSERT INTO utente VALUES ('Marco Maida', 17-03-1994, 30, 'Marco', 'Maida', 'Utente Vegano', 1, 2);
INSERT INTO utente VALUES ('C.S. Lewis', 30-03-1999, 333, 'Clive', 'Lewis', '', 1, 0);
INSERT INTO utente VALUES ('George R.R. Martin', 01-03-1993, 'George', 'Martin', '', 1, 0);
INSERT INTO utente VALUES ('Odio Di Palma', 17-07-1990, 'Andrea', 'Mori', 'Utente Vegano', 1, 1);
INSERT INTO utente VALUES ('Shy', 17-07-1994, 'Alessandro', 'Masala', 'Utente Sardo', 0, 1);

--Correlazione
INSERT INTO correlazione VALUES('1984', 'George Orwell', 'Blade Runner', 'Philip K. Dick');
INSERT INTO correlazione VALUES('Harry Potter E L Ordine Della Fenice', 'J.K. Rowling', 'Harry Potter E La Camera Dei Segreti', 'J.K. Rowling');
INSERT INTO correlazione VALUES('Harry Potter E L Ordine Della Fenice', 'J.K. Rowling', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO correlazione VALUES('Harry Potter E La Camera Dei Segreti', 'J.K. Rowling', 'Le Cronache Del Ghiaccio E Del Fuoco', 'George R.R. Martin');
INSERT INTO correlazione VALUES('Il Teorema Del Pappagallo', 'Denis Guedj', 'Un Eterna Ghirlanda Brillante', 'Douglas R. Hofstadter');
INSERT INTO correlazione VALUES('Ma I Vegani Sognano Pecore Elettriche?', 'Odio Di Palma', 'Farmageddon', 'Marco Maida');

--Follow
INSERT INTO follow VALUES('Marco Perronet', 'Marco Maida');
INSERT INTO follow VALUES('Marco Maida', 'Marco Perronet');
INSERT INTO follow VALUES('Marco Perronet', 'Philip K. Dick');
INSERT INTO follow VALUES('Marco Maida', 'George Orwell');

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

--Categoria Sito
INSERT INTO categoriasito VALUES('Primo Piano', '');
INSERT INTO categoriasito VALUES('Nuovo', '');
INSERT INTO categoriasito VALUES('In Salita', '');

--Categoria
INSERT INTO categoriasito VALUES('Fantasy', '', false);
INSERT INTO categoriasito VALUES('Saggio', '', false);
INSERT INTO categoriasito VALUES('Romanzo', '', false);
INSERT INTO categoriasito VALUES('Horror', '', false);
INSERT INTO categoriasito VALUES('Scientifico', '', false);
INSERT INTO categoriasito VALUES('Divulgativo', '', false);
--continuare da qui

--Paragrafo
INSERT INTO paragrafo VALUES(0, 
'Etiam luctus non leo vel luctus. Nunc mollis felis a porta ultrices. Etiam in ligula nulla. Aliquam et tincidunt massa. Pellentesque facilisis efficitur sem vitae commodo. Suspendisse maximus rutrum sodales. Nunc commodo iaculis iaculis. Aenean pretium malesuada orci et convallis. Quisque egestas iaculis orci vel blandit. Sed sit amet velit neque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris vehicula lacus quis nibh commodo imperdiet. Nam posuere euismod quam et tincidunt.'
)
INSERT INTO paragrafo VALUES(1, 
'Proin viverra, nibh in consectetur maximus, orci leo dictum dolor, vel tincidunt est ante eu orci. Etiam posuere, sapien id elementum consequat, nibh lectus finibus ipsum, id molestie nisl ex ut turpis. Aliquam gravida, nulla id iaculis pharetra, metus nibh blandit nunc, eu maximus eros elit et dolor. Vivamus euismod a risus quis fermentum. Donec vitae risus ligula. Pellentesque iaculis eleifend fermentum. In lacinia vehicula orci, nec mattis purus malesuada eu. Mauris imperdiet at enim eu vestibulum. Morbi mauris lectus, porta semper felis nec, varius egestas nunc. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent pulvinar non sem quis aliquam. Donec eget mi sed purus vulputate finibus. '
)
INSERT INTO paragrafo VALUES(2, 
'Maecenas ac dignissim ipsum. Donec vel scelerisque lorem. Fusce vel ultricies massa. Suspendisse nec enim quis augue tempus luctus. Duis eu ligula justo. Suspendisse in molestie metus. Donec purus quam, laoreet nec consectetur eget, convallis id elit. Aenean iaculis a ante eu aliquet. Vivamus elementum posuere nisl ac fermentum. Nam mollis mi ac interdum euismod. Fusce urna velit, sodales et tristique nec, feugiat eget urna. Suspendisse potenti. '
)
INSERT INTO paragrafo VALUES(3, 
'Duis pharetra ullamcorper enim, non blandit nibh faucibus vitae. Nulla arcu lacus, volutpat vel neque id, feugiat feugiat magna. Quisque sed nisl nec purus luctus commodo nec ut erat. Aenean ornare placerat ipsum, quis consectetur diam iaculis a. Nullam et rutrum purus. Aliquam commodo malesuada tortor. Aliquam pulvinar odio sem, sit amet gravida eros mollis at. Integer semper eros eu porttitor vestibulum. Proin scelerisque hendrerit arcu, et auctor massa. Sed at nulla purus. Donec tortor ligula, blandit eget arcu iaculis, bibendum viverra lacus. Aliquam blandit ultricies mi eget aliquam. Nullam eget turpis ut tortor vulputate placerat. Vestibulum leo tortor, sollicitudin sed convallis nec, posuere vitae urna. Mauris tristique viverra euismod. Ut cursus orci lorem, et sodales risus vestibulum eget. '
)
INSERT INTO paragrafo VALUES(4, 
'Praesent id tristique lorem. Vivamus posuere justo risus, pellentesque interdum leo pretium eu. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus lobortis mi nisl, in sodales magna pharetra sed. Vivamus pharetra placerat velit ac pellentesque. Ut quis maximus sapien, ut sollicitudin nisi. In eget lorem eleifend, euismod tortor id, rutrum dolor. Suspendisse et mauris imperdiet, ullamcorper mi nec, placerat nunc. Phasellus ac nisi dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nullam efficitur ut arcu eget pulvinar. Pellentesque metus massa, molestie a velit sodales, dapibus dignissim sapien. Aenean eget condimentum massa. Aenean non efficitur neque. Suspendisse at iaculis ligula. '
)
INSERT INTO paragrafo VALUES(5, 
'Etiam eleifend ornare ante, id feugiat mauris. Phasellus vitae tellus luctus ipsum eleifend feugiat in et massa. Phasellus in vestibulum leo, vitae fringilla lacus. Proin hendrerit erat et nisi tempor, in dignissim orci viverra. Mauris eu rutrum purus. Phasellus auctor lacinia risus, sed iaculis nisl auctor non. Nullam feugiat ex vitae lacus luctus mollis. Nam pharetra nibh libero. Etiam ac massa at nunc pellentesque elementum eu sit amet justo. Sed pretium neque vitae interdum lobortis. Maecenas ac porttitor ex, ac elementum mi. Cras convallis lacus id pellentesque porta. '
)
INSERT INTO paragrafo VALUES(6, 
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis hendrerit gravida purus, iaculis malesuada ligula mattis eget. Mauris nec faucibus odio. Quisque fermentum rhoncus dolor, vitae cursus elit facilisis sed. Cras vel massa faucibus, efficitur lorem sit amet, blandit diam. Cras at sagittis orci, quis posuere felis. Duis velit sem, maximus ac mollis non, pellentesque vel lacus. Aliquam elementum maximus mauris. Phasellus at purus lorem. In hac habitasse platea dictumst. Aliquam erat volutpat. Suspendisse urna turpis, mattis vel libero quis, tempor porta quam. Duis pretium, neque nec tempus gravida, turpis odio ullamcorper dui, in gravida nulla erat vitae libero. Donec cursus faucibus congue. '
)
INSERT INTO paragrafo VALUES(7, 
'Aliquam tincidunt pulvinar ante blandit tincidunt. Nunc mi nulla, ullamcorper vitae finibus eu, mattis tempus sapien. Nunc luctus facilisis mi, at ornare sapien viverra ut. Ut semper lorem in ornare venenatis. Quisque pharetra consequat aliquet. Praesent ut nibh nec diam scelerisque venenatis rutrum eu dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris gravida consequat purus, ac dapibus arcu consequat vel. Praesent accumsan, arcu in commodo convallis, nulla ex hendrerit ipsum, eget consequat dui nibh ut dui. Donec sit amet sollicitudin est, eu finibus erat. Donec euismod elit ut lacinia fringilla. Nulla facilisi. '
)
INSERT INTO paragrafo VALUES(8, 
'Pellentesque vel leo a dui varius dictum at eget ex. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec vitae massa at ipsum malesuada tempor. Maecenas tortor quam, posuere et gravida et, congue nec magna. Nullam vulputate, ante eu tempor luctus, est elit feugiat metus, eu venenatis libero magna in felis. Maecenas euismod consequat lectus rutrum venenatis. Donec sit amet rhoncus tellus, at tempor elit. Fusce sed pellentesque metus. Nullam non magna ac elit tempus molestie. Praesent ipsum est, pulvinar vitae condimentum nec, vehicula et dui. Proin aliquam semper mi vel congue. Nullam in ligula eget mi mollis posuere ut eu ligula. Praesent ac molestie nisl. Cras varius tempor placerat. Aliquam erat volutpat. Phasellus justo sem, malesuada dictum ante a, egestas scelerisque metus. '
)
INSERT INTO paragrafo VALUES(9, 
'Suspendisse massa lectus, luctus eu facilisis in, elementum sit amet arcu. Nulla malesuada mi sit amet cursus convallis. Nam a velit est. Duis consequat metus in odio gravida blandit. Duis iaculis malesuada quam quis tristique. Aenean auctor quis velit a vulputate. Fusce tincidunt ex eu tristique maximus. Aenean lacus sem, porta in diam vitae, porta molestie justo. Aenean ut faucibus tellus. Integer mauris nunc, blandit in felis in, convallis posuere diam. Nullam in iaculis lectus, nec lobortis enim. Duis eget tortor at nisl pellentesque fringilla scelerisque non felis. '
)
INSERT INTO paragrafo VALUES(10, 
'Maecenas vehicula lectus quis enim elementum malesuada. Integer turpis lorem, facilisis ac mattis nec, sodales vitae massa. Etiam finibus, magna vel molestie tristique, lectus ex viverra libero, eget hendrerit augue ante in tortor. Maecenas bibendum dolor urna, a vulputate enim auctor id. Nulla hendrerit pellentesque est, quis lobortis tortor suscipit at. Sed tempor non mauris nec tempor. Vivamus dignissim congue neque quis maximus. In placerat, eros ac lacinia ullamcorper, nulla risus eleifend neque, sed eleifend mauris ante in odio. Phasellus egestas mauris nec magna finibus gravida. '
)
INSERT INTO paragrafo VALUES(11, 
'Ut tristique imperdiet tortor vitae suscipit. Proin suscipit malesuada tortor in elementum. Etiam varius lorem et arcu viverra molestie. Quisque volutpat nulla vel congue suscipit. Duis cursus feugiat felis, bibendum volutpat nisl pretium id. Aliquam vestibulum mollis neque non iaculis. Nunc sodales vel nisl at finibus. Maecenas neque augue, vehicula eget libero ac, auctor lobortis risus. Ut laoreet diam nunc, vitae ultricies nisi ultrices at. Sed sit amet varius dui. Ut eget efficitur nisl. Nam bibendum eget sapien a tempor. Quisque sed turpis condimentum, auctor metus sed, tincidunt est. Ut nisl lacus, condimentum sit amet neque vitae, luctus commodo enim. '
)

commit;