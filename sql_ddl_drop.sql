/*********************************************************************/
/**
/** Table: All tables
/** Developer: Paul Pavlis
/** Description: Deletes all tables and constraints
/**
/*********************************************************************/

DROP TABLE "User" CASCADE CONSTRAINTS;
DROP TABLE "Nachrichten" CASCADE CONSTRAINTS;
DROP TABLE "Rolle" CASCADE CONSTRAINTS;
DROP TABLE "Adresse" CASCADE CONSTRAINTS;
DROP TABLE "Ort" CASCADE CONSTRAINTS;
DROP TABLE "Angebot" CASCADE CONSTRAINTS;
DROP TABLE "Transaktion" CASCADE CONSTRAINTS;
DROP TABLE "Angebotskategorie" CASCADE CONSTRAINTS;
DROP TABLE "Produkt" CASCADE CONSTRAINTS;
DROP TABLE "Produkt_Angebot" CASCADE CONSTRAINTS;
DROP TABLE "Bio_Faktor" CASCADE CONSTRAINTS;
DROP TABLE "Saison" CASCADE CONSTRAINTS;
COMMIT;