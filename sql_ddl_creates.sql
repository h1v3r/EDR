/*********************************************************************/
/** 
/** 
/** CREATE TABLES
/** 
/** 
/*********************************************************************/


/*********************************************************************/
/**
/** Table: User
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "User" 
(
    "userid" NUMBER NOT NULL,
    "rolleid" NUMBER NOT NULL,
    "vorname" VARCHAR2(30) NOT NULL,
    "nachname" VARCHAR2(50) NOT NULL,
    "dob" DATE,
    "adresseid" NUMBER,
    PRIMARY KEY("userid")
);

/*********************************************************************/
/**
/** Table: Nachrichten
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Nachrichten" 
(
    "nachrichtenid" NUMBER NOT NULL,
    "userid_sender" NUMBER NOT NULL,
    "userid_empf" NUMBER NOT NULL,
    "inhalt" VARCHAR2(500) NOT NULL,
    "message_time" TIMESTAMP NOT NULL,
    PRIMARY KEY("nachrichtenid")
);

/*********************************************************************/
/**
/** Table: Rolle
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Rolle" 
(
    "rolleid" NUMBER NOT NULL,
    "title" VARCHAR2(30) NOT NULL,
    "beschreibung" VARCHAR2(100) NOT NULL,
    PRIMARY KEY("rolleid")
);

/*********************************************************************/
/**
/** Table: Adresse
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Adresse" 
(
    "adresseid" NUMBER NOT NULL,
    "plz" NUMBER NOT NULL,
    "strasse" VARCHAR2(100) NOT NULL,
    "hausnummer" VARCHAR2(50) NOT NULL,
    PRIMARY KEY("adresseid")
);

/*********************************************************************/
/**
/** Table: Ort
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Ort" 
(
    "plz" NUMBER NOT NULL,
    "name" VARCHAR2(50) NOT NULL,
    PRIMARY KEY("plz")
);

/*********************************************************************/
/**
/** Table: Angebot
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Angebot" 
(
    "angebotid" NUMBER NOT NULL,
    "userid_verkaeufer" NUMBER NOT NULL,
    "kategorieid" NUMBER NOT NULL,
    "anzeigetext" VARCHAR2(500),
    PRIMARY KEY("angebotid")
);

/*********************************************************************/
/**
/** Table: Transaktion
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Transaktion"
(
    "transaktionid" NUMBER NOT NULL,
    "angebotid" NUMBER NOT NULL,
    "userid_kaeufer" NUMBER NOT NULL,
    "bewertung_verkaeufer_text" VARCHAR2(200),
    "bewertung_verkaeufer_value" NUMBER,
    "bewertung_kaeufer_text" VARCHAR2(200),
    "bewertung_kaeufer_value" NUMBER,
    PRIMARY KEY("transaktionid")
);

/*********************************************************************/
/**
/** Table: User
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Angebotskategorie" 
(
    "kategorieid" NUMBER NOT NULL,
    "beschreibung" VARCHAR2(100) NOT NULL,
    PRIMARY KEY("kategorieid")
);

/*********************************************************************/
/**
/** Table: Produkt
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Produkt" 
(
    "produktid" NUMBER NOT NULL,
    "saisonid" NUMBER NOT NULL,
    "bioid" NUMBER NOT NULL,
    "name" VARCHAR2(50) NOT NULL,
    PRIMARY KEY("produktid")
);

/*********************************************************************/
/**
/** Table: Produkt_Angebot
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Produkt_Angebot"
(
    "produktid" NUMBER NOT NULL,
    "angebotid" NUMBER NOT NULL,
    "menge" NUMBER NOT NULL,
    PRIMARY KEY("produktid", "angebotid")
);

/*********************************************************************/
/**
/** Table: Bio_Faktor
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Bio_Faktor" 
(
    "bioid" NUMBER NOT NULL,
    "kategorie_bezeichnung" VARCHAR2(30) NOT NULL,
    "beschreibung" VARCHAR2(300) NOT NULL,
    PRIMARY KEY("bioid")
);

/*********************************************************************/
/**
/** Table: Saison
/** Developer: Paul Pavlis
/** Description: <trigger_description>
/**
/*********************************************************************/

CREATE TABLE "Saison" 
(
    "saisonid" NUMBER NOT NULL,
    "name" VARCHAR2(30) NOT NULL,
    "beschreibung" VARCHAR2(300) NOT NULL,
    PRIMARY KEY("saisonid")
);

/*********************************************************************/
/**
/** Table: User_Rolle_Log
/** Developer: Jakob Neuhauser
/** Description: A Table to log all userrole changes. 
/**
/*********************************************************************/

CREATE TABLE "User_Rolle_Log"
(
    "logid" NUMBER, 
    "userid" NUMBER, 
    "rolleid_alt" number, 
    "rolleid_neu" number, 
    "time" TIMESTAMP, 
    "aktion" varchar(10), 
    PRIMARY KEY("logid")
);

/*********************************************************************/
/** 
/** 
/** INDEXES (Removed by Paul Pavlis because they are wrong ._.)
/** 
/** 
/*********************************************************************/


/*********************************************************************/
/** Table: User
/** IndexName: SYS_I_USER_ROLLEID
/** IndexName: SYS_I_USER_ADRESSEID
/** Developer: Paul Pavlis
/*********************************************************************/
-- CREATE UNIQUE INDEX "SYS_I_USER_ROLLEID" ON "User" ("rolleid");
-- CREATE UNIQUE INDEX "SYS_I_USER_ADRESSEID" ON "User" ("adresseid");

/*********************************************************************/
/** Table: Adresse
/** IndexName: SYS_I_ADRESSE_PLZ
/** Developer: Paul Pavlis
/*********************************************************************/
-- CREATE UNIQUE INDEX "SYS_I_ADRESSE_PLZ" ON "Adresse" ("plz");

/*********************************************************************/
/** Table: Transaktion
/** IndexName: SYS_I_TRANSAKTION_ANGEBOTID
/** IndexName: SYS_I_TRANSAKTION_USERID_KAEUFER
/** Developer: Paul Pavlis
/*********************************************************************/
-- CREATE UNIQUE INDEX "SYS_I_TRANSAKTION_ANGEBOTID" ON "Transaktion" ("angebotid");
-- CREATE UNIQUE INDEX "SYS_I_TRANSAKTION_USERID_Kae" ON "Transaktion" ("userid_kaeufer");

/*********************************************************************/
/** Table: Angebot
/** IndexName: SYS_I_ANGEBOT_USERID_VERKAEUFER
/** IndexName: SYS_I_ANGEBOT_KATEGORIEID
/** Developer: Paul Pavlis
/*********************************************************************/
-- CREATE UNIQUE INDEX "SYS_I_ANGEBOT_USERID_VER" ON "Angebot" ("userid_verkaeufer");
-- CREATE UNIQUE INDEX "SYS_I_ANGEBOT_KATEGORIEID" ON "Angebot" ("kategorieid");

/*********************************************************************/
/** Table: Produkt
/** IndexName: SYS_I_PRODUKT_SAISONID
/** IndexName: SYS_I_PRODUKT_BIOID
/** Developer: Paul Pavlis
/*********************************************************************/
-- CREATE UNIQUE INDEX "SYS_I_PRODUKT_SAISONID" ON "Produkt" ("saisonid");
-- CREATE UNIQUE INDEX "SYS_I_PRODUKT_BIOID" ON "Produkt" ("bioid");


/*********************************************************************/
/** 
/** 
/** Foreign Key Constraint
/** 
/** 
/*********************************************************************/

/*********************************************************************/
/** Table: User
/** Developer: Paul Pavlis
/*********************************************************************/
ALTER TABLE "User" ADD FOREIGN KEY ("rolleid")
    REFERENCES "Rolle" ("rolleid");
ALTER TABLE "User" ADD FOREIGN KEY ("adresseid")
    REFERENCES "Adresse" ("adresseid");

/*********************************************************************/
/** Table: Nachrichten
/** Developer: Paul Pavlis
/*********************************************************************/
ALTER TABLE "Nachrichten" ADD FOREIGN KEY ("userid_sender")
    REFERENCES "User" ("userid");
ALTER TABLE "Nachrichten" ADD FOREIGN KEY ("userid_empf")
    REFERENCES "User" ("userid");

/*********************************************************************/
/** Table: Adresse
/** Developer: Paul Pavlis
/*********************************************************************/
ALTER TABLE "Adresse" ADD FOREIGN KEY ("plz")
    REFERENCES "Ort" ("plz");

/*********************************************************************/
/** Table: Transaktion
/** Developer: Paul Pavlis
/*********************************************************************/
ALTER TABLE "Transaktion" ADD FOREIGN KEY ("userid_kaeufer")
    REFERENCES "User" ("userid");
ALTER TABLE "Transaktion" ADD FOREIGN KEY ("angebotid")
    REFERENCES "Angebot" ("angebotid");

/*********************************************************************/
/** Table: Angebot
/** Developer: Paul Pavlis
/*********************************************************************/
ALTER TABLE "Angebot" ADD FOREIGN KEY ("userid_verkaeufer")
    REFERENCES "User" ("userid");
ALTER TABLE "Angebot" ADD FOREIGN KEY ("kategorieid")
    REFERENCES "Angebotskategorie" ("kategorieid");

/*********************************************************************/
/** Table: Produkt_Angebot
/** Developer: Paul Pavlis
/*********************************************************************/
ALTER TABLE "Produkt_Angebot" ADD FOREIGN KEY ("produktid")
    REFERENCES "Produkt" ("produktid");
ALTER TABLE "Produkt_Angebot" ADD FOREIGN KEY ("angebotid")
    REFERENCES "Angebot" ("angebotid");

/*********************************************************************/
/** Table: Produkt
/** Developer: Paul Pavlis
/*********************************************************************/
ALTER TABLE "Produkt" ADD FOREIGN KEY ("saisonid")
    REFERENCES "Saison" ("saisonid");
ALTER TABLE "Produkt" ADD FOREIGN KEY ("bioid")
    REFERENCES "Bio_Faktor" ("bioid");
COMMIT;