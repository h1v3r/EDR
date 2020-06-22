/*********************************************************************/
/** 
/** 
/** INSERT INTO TABLES
/** 
/** 
/*********************************************************************/

/*********************************************************************/
/** Table: Ort
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Ort" ("plz", "name")
    VALUES (1010, 'Wien, Innere Stadt');
INSERT INTO "Ort" ("plz", "name")
    VALUES (1020, 'Wien, Leopoldstadt');
INSERT INTO "Ort" ("plz", "name")
    VALUES (1030, 'Wien, Landstraße');
INSERT INTO "Ort" ("plz", "name")
    VALUES (1210, 'Wien, Floridsdorf');
INSERT INTO "Ort" ("plz", "name")
    VALUES (2024, 'Mailberg');
INSERT INTO "Ort" ("plz", "name")
    VALUES (2063, 'Zwingendorf');
INSERT INTO "Ort" ("plz", "name")
    VALUES (3182, 'Marktl');
INSERT INTO "Ort" ("plz", "name")
    VALUES (4075, 'Aumühle, Steinholz');

/*********************************************************************/
/** Table: Adresse
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer")
    VALUES (101, 1010, 'Landmarktgasse', '10/4');
INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer")
    VALUES (102, 1010, 'Salastraße', '2');
INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer")
    VALUES (103, 1010, 'Salastraße', '3');
INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer")
    VALUES (104, 1210, 'Juliusgasse', '3234');
INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer")
    VALUES (105, 1210, 'Meredithstraße', '23/4/9');
INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer")
    VALUES (106, 2063, 'Landstraße', '69');
INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer")
    VALUES (107, 4075, 'Kellergasse', '3/4');

/*********************************************************************/
/** Table: Rolle
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Rolle" ("rolleid", "title", "beschreibung")
    VALUES (1, 'Default User', '-');
INSERT INTO "Rolle" ("rolleid", "title", "beschreibung")
    VALUES (2, 'Premium User', 'Most premium features');
INSERT INTO "Rolle" ("rolleid", "title", "beschreibung")
    VALUES (3, 'Premium User Plus', 'All premium features');

/*********************************************************************/
/** Table: User
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "User" ("userid", "rolleid", "vorname", "nachname", "dob", "adresseid")
    VALUES (10001, 1, 'Leonard', 'Mauer', to_date('01.01.1970','DD.MM.YYYY'), 101);
INSERT INTO "User" ("userid", "rolleid", "vorname", "nachname", "dob", "adresseid")
    VALUES (10002, 3, 'Theodore', 'Selma', to_date('21.04.1992','DD.MM.YYYY'), 106);
INSERT INTO "User" ("userid", "rolleid", "vorname", "nachname", "dob", "adresseid")
    VALUES (10003, 1, 'Sam', 'Milker', to_date('02.07.1988','DD.MM.YYYY'), 106);
INSERT INTO "User" ("userid", "rolleid", "vorname", "nachname", "dob", "adresseid")
    VALUES (10004, 1, 'Meredith', 'Porster', to_date('31.05.2001','DD.MM.YYYY'), 104);

/*********************************************************************/
/** Table: Nachrichten
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Nachrichten" ("nachrichtenid", "userid_sender", "userid_empf", "inhalt", "message_time")
    VALUES (001, 10002, 10003, 'Hello from me ._.', to_date('01.01.1970 10:05:31','DD.MM.YYYY HH24:MI:SS'));
INSERT INTO "Nachrichten" ("nachrichtenid", "userid_sender", "userid_empf", "inhalt", "message_time")
    VALUES (002, 10003, 10002, 'Hello back Nerd', to_date('01.01.1970 10:05:58','DD.MM.YYYY HH24:MI:SS'));
INSERT INTO "Nachrichten" ("nachrichtenid", "userid_sender", "userid_empf", "inhalt", "message_time")
    VALUES (003, 10002, 10003, 'Got some apples for me?', to_date('01.01.1970 10:06:21','DD.MM.YYYY HH24:MI:SS'));
INSERT INTO "Nachrichten" ("nachrichtenid", "userid_sender", "userid_empf", "inhalt", "message_time")
    VALUES (004, 10004, 10001, 'Hello, I would like your strawberrys', to_date('01.01.1970 10:06:21','DD.MM.YYYY HH24:MI:SS'));

/*********************************************************************/
/** Table: Angebotskategorie
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Angebotskategorie" ("kategorieid", "beschreibung")
    VALUES (501, 'Bio Produkte - Self harvest');
INSERT INTO "Angebotskategorie" ("kategorieid", "beschreibung")
    VALUES (502, 'Bio Produkte - Already harvested');
INSERT INTO "Angebotskategorie" ("kategorieid", "beschreibung")
    VALUES (503, 'Bio Produkte - Already harvested - free');

/*********************************************************************/
/** Table: Angebot
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Angebot" ("angebotid", "userid_verkaeufer", "kategorieid", "anzeigetext")
    VALUES (801, 10001, 502, 'Fresh Berrys - 500g -> 1€');
INSERT INTO "Angebot" ("angebotid", "userid_verkaeufer", "kategorieid", "anzeigetext")
    VALUES (802, 10001, 503, 'Rotten Berrys - Everyone welcome');
INSERT INTO "Angebot" ("angebotid", "userid_verkaeufer", "kategorieid", "anzeigetext")
    VALUES (803, 10003, 502, 'Apples HERE - BUY NOW');

/*********************************************************************/
/** Table: Transaktion
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Transaktion" ("transaktionid", "angebotid", "userid_kaeufer", "bewertung_verkaeufer_text", "bewertung_verkaeufer_value", "bewertung_kaeufer_text", "bewertung_kaeufer_value")
    VALUES (201, 801, 10002, 'Friendly buyer', 5, 'Nice person. Would buy again.', 5);
INSERT INTO "Transaktion" ("transaktionid", "angebotid", "userid_kaeufer", "bewertung_verkaeufer_text", "bewertung_verkaeufer_value", "bewertung_kaeufer_text", "bewertung_kaeufer_value")
    VALUES (202, 803, 10004, 'Was okay', 3, 'Not the best stuff.', 2);
INSERT INTO "Transaktion" ("transaktionid", "angebotid", "userid_kaeufer")
    VALUES (203, 803, 10004);


/*********************************************************************/
/** Table: Bio_Faktor
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Bio_Faktor" ("bioid", "kategorie_bezeichnung", "beschreibung")
    VALUES (567, 'Bio-1', 'Beste Qualitität. Hat ...');
INSERT INTO "Bio_Faktor" ("bioid", "kategorie_bezeichnung", "beschreibung")
    VALUES (568, 'Bio-2', 'Sehr gute Qualitität. Hat ...');
INSERT INTO "Bio_Faktor" ("bioid", "kategorie_bezeichnung", "beschreibung")
    VALUES (569, 'Bio-3', 'Akzeptable Qualitität. Hat ...');

/*********************************************************************/
/** Table: Saison
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Saison" ("saisonid", "name", "beschreibung")
    VALUES (01, 'Winter', 'Keine gute Zeit für die meisten Früchte');
INSERT INTO "Saison" ("saisonid", "name", "beschreibung")
    VALUES (02, 'Frühling', 'Start zum anbauen');
INSERT INTO "Saison" ("saisonid", "name", "beschreibung")
    VALUES (03, 'Sommer', 'Beste Zeit zum ernten');
INSERT INTO "Saison" ("saisonid", "name", "beschreibung")
    VALUES (04, 'Herbst', 'Langsamer Rückgang von ernten oder saisonale Produkte');

/*********************************************************************/
/** Table: Produkt
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Produkt" ("produktid", "saisonid", "bioid", "name")
    VALUES (701, 03, 567, 'Sommer-Äpfel');
INSERT INTO "Produkt" ("produktid", "saisonid", "bioid", "name")
    VALUES (702, 04, 569, 'Kürbis');
INSERT INTO "Produkt" ("produktid", "saisonid", "bioid", "name")
    VALUES (703, 03, 567, 'Blueberries');

/*********************************************************************/
/** Table: Produkt_Angebot
/** Developer: Paul Pavlis
/*********************************************************************/
INSERT INTO "Produkt_Angebot" ("produktid", "angebotid", "menge")
    VALUES (703, 801, 100000);
INSERT INTO "Produkt_Angebot" ("produktid", "angebotid", "menge")
    VALUES (703, 803, 67);

/*********************************************************************/
/** Table: Ort, Adresse, User
/** Developer: Jakob Neuhauser 
/** Discription: Create a User System. Is needed for a trigger. 
/*********************************************************************/
INSERT INTO "Ort" ("plz", "name") 
    VALUES (0, 'System Ort'); 
INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer") 
    VALUES (0, 0, 'Systemgasse', 0);
INSERT INTO "User" ("userid", "rolleid", "vorname", "nachname", "adresseid") 
    VALUES (0, 3, 'EDR', 'System', 0);

COMMIT;