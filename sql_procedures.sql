SET serveroutput ON;
/

/*********************************************************************
/**
/** Procedure: sp_add_ort
/** Out: l_n_pk_out - primary Key ID of the existing or added element
/** Out: l_n_error_out - Error code if error occured
/** In: l_n_plz_in - the desired PLZ for the new Ort
/** In: l_v_ortsname_in - the desired name for the new Ort
/** Developer: Albert Schleidt
/** Description: Creates a new Ort, IF it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_add_ort (l_n_plz_in IN NUMBER, l_v_ortsname_in IN VARCHAR, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
    l_n_countEntries NUMBER;
BEGIN
    SELECT count(*) INTO l_n_countEntries FROM "Ort" WHERE "plz" = l_n_plz_in AND "name" = l_v_ortsname_in;
    IF l_n_countEntries > 0 THEN
        l_n_pk_out := l_n_plz_in;
        RETURN;
    ELSE
        INSERT INTO "Ort" VALUES (l_n_plz_in, l_v_ortsname_in);
        l_n_pk_out := l_n_plz_in;
    END IF;
EXCEPTION
    WHEN others THEN
        l_n_error_out := SQLCODE;
END;
/

/*********************************************************************
/**
/** Procedure: sp_add_adresse
/** Out: l_n_pk_out - primary Key ID of the existing or added element
/** Out: l_n_error_out - Error code if error occured
/** In: l_n_plzpk_in - the primary key of the plz to be associated with the Adresse
/** In: l_v_strasse_in - the Strasse parameter to be added to the Adresse
/** In: l_v_hausnummer_in - the Hausnummer parameter to be added to the Adresse
/** Developer: Albert Schleidt
/** Description: Creates a new Adresse, if it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_add_adresse (l_n_plzpk_in IN NUMBER, l_v_strasse_in IN VARCHAR, l_v_hausnummer_in IN VARCHAR, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
    l_n_countEntries NUMBER;
    l_n_adresseid NUMBER;
    l_n_maxAdresseid NUMBER;
BEGIN
    SELECT COUNT(*) INTO l_n_countEntries FROM "Adresse" WHERE "plz" = l_n_plzpk_in AND "strasse" = l_v_strasse_in AND "hausnummer" = l_v_hausnummer_in;
    IF l_n_countEntries > 0 THEN
        SELECT "adresseid" INTO l_n_pk_out FROM "Adresse" WHERE "plz" = l_n_plzpk_in AND "strasse" = l_v_strasse_in AND "hausnummer" = l_v_hausnummer_in;
        RETURN;
    ELSE
        SELECT MAX("adresseid") INTO l_n_maxAdresseid FROM "Adresse";
        INSERT INTO "Adresse" VALUES (l_n_maxAdresseid+1, l_n_plzpk_in, l_v_strasse_in, l_v_hausnummer_in);
        l_n_pk_out := l_n_maxAdresseid+1;
    END IF;
EXCEPTION
    WHEN others THEN
        l_n_error_out := SQLCODE;
END;
/

/*********************************************************************
/**
/** Procedure: sp_add_rolle
/** Out: l_n_pk_out - primary Key ID of the existing or added element
/** Out: l_n_error_out - Error code if error occured
/** In: l_v_titel_in - Title of the Rolle
/** In: l_v_beschreibung_in - Beschreibung of the Rolle
/** Developer: Albert Schleidt
/** Description: Creates a new Rolle, if it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_add_rolle (l_v_titel_in IN VARCHAR, l_v_beschreibung_in IN VARCHAR, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
    l_n_countEntries NUMBER;
    l_n_maxRolleid NUMBER;
BEGIN
    SELECT COUNT(*) INTO l_n_countEntries FROM "Rolle" WHERE "title" = l_v_titel_in AND "beschreibung" = l_v_beschreibung_in;
    IF l_n_countEntries > 0 THEN
        SELECT "rolleid" INTO l_n_pk_out FROM "Rolle" WHERE "title" = l_v_titel_in AND "beschreibung" = l_v_beschreibung_in;
        RETURN;
    ELSE
        SELECT MAX("rolleid") INTO l_n_maxRolleid FROM "Rolle";
        INSERT INTO "Rolle" VALUES (l_n_maxRolleid+1, l_v_titel_in, l_v_beschreibung_in);
        l_n_pk_out := l_n_maxRolleid+1;
    END IF;
EXCEPTION
    WHEN others THEN
        l_n_error_out := SQLCODE;
END;
/

/*********************************************************************
/**
/** Procedure: sp_add_user
/** Out: l_n_pk_out - primary Key ID of the existing or added element
/** Out: l_n_error_out - Error code if error occured
/** In: l_n_rollepk_in - rolleid of the user
/** In: l_v_vorname_in - vorname of the user
/** In: l_v_nachname_in - nachname of the user
/** In: l_v_dob_in - date of birth of the user, following "YYYY-MM-DD"
/** In: l_n_adressepk_in - adresseid of the user
/** Developer: Albert Schleidt
/** Description: Creates a new user, if it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_add_user (l_n_rollepk_in IN NUMBER, l_v_vorname_in IN VARCHAR, l_v_nachname_in IN VARCHAR, l_v_dob_in IN VARCHAR, l_n_adressepk_in IN NUMBER, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
    l_n_countEntries NUMBER;
    l_n_maxUserid NUMBER;
    l_d_dob DATE;
BEGIN
    l_d_dob := TO_DATE(l_v_dob_in, 'YYYY-MM-DD');
    SELECT COUNT(*) INTO l_n_countEntries FROM "User" WHERE "rolleid" = l_n_rollepk_in AND "vorname" = l_v_vorname_in AND "nachname" = l_v_nachname_in AND "dob" = l_d_dob AND "adresseid" = l_n_adressepk_in;
    IF l_n_countEntries > 0 THEN
    SELECT "userid" INTO l_n_pk_out FROM "User" WHERE "rolleid" = l_n_rollepk_in AND "vorname" = l_v_vorname_in AND "nachname" = l_v_nachname_in AND "dob" = l_d_dob AND "adresseid" = l_n_adressepk_in;
        RETURN;
    ELSE
        SELECT MAX("userid") INTO l_n_maxUserid FROM "User";
        INSERT INTO "User" VALUES (l_n_maxUserid+1, l_n_rollepk_in, l_v_vorname_in, l_v_nachname_in, l_d_dob, l_n_adressepk_in);
        l_n_pk_out := l_n_maxUserid+1;
    END IF;
EXCEPTION
    WHEN others THEN
        l_n_error_out := SQLCODE;
END;
/

/*********************************************************************
/**
/** Procedure: sp_addProduct
/** Out: l_v_error_out - Eventual error message. 
/** In: l_n_saisonid_in - The Saisonid of the product.
/** In: l_n_bioid_in - The Bioid of the product.
/** In: l_v_name_in - The name of the product.
/** Developer: Jakob Neuhauser
/** Description: The procedure takes all the arguments needed for a product and inserts the data into the database. If saionid or bioid are not valid, the data will not be inserted. 
/**
/*********************************************************************/

CREATE OR REPLACE PROCEDURE sp_addProduct (l_n_saisonid_in IN NUMBER, l_n_bioid_in IN NUMBER, l_v_name_in IN VARCHAR, l_v_error_ou OUT VARCHAR) AS
  l_n_produktid NUMBER;
  l_n_count NUMBER;
BEGIN  

  SELECT COUNT(*) INTO l_n_count FROM "Saison" WHERE "saisonid" = l_n_saisonid_in;
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no saisonid ' || l_n_saisonid_in || '. Aborting!';
    RETURN;
  END IF; 
  
  SELECT COUNT(*) INTO l_n_count FROM "Bio_Faktor" WHERE "bioid" = l_n_bioid_in;
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no bioid ' || l_n_bioid_in || '. Aborting!';
    RETURN;
  END IF;

  SELECT max("produktid")+1 INTO l_n_produktid FROM "Produkt";
  INSERT INTO "Produkt" ("produktid", "saisonid", "bioid", "name") VALUES (l_n_produktid, l_n_saisonid_in, l_n_bioid_in, l_v_name_in);

EXCEPTION
  WHEN no_data_found THEN 
    l_v_error_ou := 'No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200); 
  WHEN too_many_rows THEN 
    l_v_error_ou := 'Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200);
  WHEN timeout_on_resource THEN 
    l_v_error_ou := 'Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200);
  WHEN OTHERS THEN
    l_v_error_ou := 'Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200);

END;
/

/*********************************************************************
/**
/** Procedure: sp_addOffer
/** Out: l_v_error_out - Eventual error message.
/** In: l_n_useridVerkaeufer_in - The userid of the seller.
/** In: l_n_kategorieid_in - The id of the kathegorie of the offer.
/** In: l_v_anzeigetext_in - A short discription or the offer or the title. 
/** Developer: Jakob Neuhauser
/** Description: The procedure takes all the arguments needed for an offer and inserts the data into the database. If kategorieid or useridVerkaeufer are not valid, the data will not be inserted. 
/**
/*********************************************************************/

CREATE OR REPLACE PROCEDURE sp_addOffer (l_n_useridVerkaeufer_in IN NUMBER, l_n_kategorieid_in IN NUMBER, l_v_anzeigetext_in IN VARCHAR, l_v_error_ou OUT VARCHAR) AS
  l_n_angebotid NUMBER;
  l_n_count NUMBER;
BEGIN  
  
  SELECT COUNT(*) INTO l_n_count FROM "User" WHERE "userid" = l_n_useridVerkaeufer_in;
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no userid ' || l_n_useridVerkaeufer_in || '. Aborting!';
    RETURN;
  END IF; 
  
  SELECT COUNT(*) INTO l_n_count FROM "Angebotskategorie" WHERE "kategorieid" = l_n_kategorieid_in; 
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no kategorieid ' || l_n_kategorieid_in || '. Aborting!';
    RETURN;
  END IF;

  SELECT MAX("angebotid")+1 INTO l_n_angebotid FROM "Angebot";
  INSERT INTO "Angebot" ("angebotid", "userid_verkaeufer", "kategorieid", "anzeigetext") VALUES (l_n_angebotid, l_n_useridVerkaeufer_in, l_n_kategorieid_in, l_v_anzeigetext_in);

EXCEPTION
  WHEN no_data_found THEN 
    l_v_error_ou := 'No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200); 
  WHEN too_many_rows THEN 
    l_v_error_ou := 'Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200);
  WHEN timeout_on_resource THEN 
    l_v_error_ou := 'Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200);
  WHEN OTHERS THEN
    l_v_error_ou := 'Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200);
    
 END;
/

/*********************************************************************
/**
/** Procedure: sp_addTransaction
/** Out: l_v_error_out - Eventual error message.
/** In: l_n_angebotid_in - The angebotid of the transaction.
/** In: l_n_useridKaufer_in - The userid of teh buyer.
/** In: l_v_bewertungVerkaeuferT_in - A rating in Text FROM the seller. 
/** In: l_v_bewertungVerkaeuferV_in - A rating in form of a value FROM the seller. 
/** In: l_v_bewertungKaeuferT_in - A rating in Text FROM the buyer. 
/** In: l_v_bewertungKaeuferV_in - A rating in form of a value FROM the buyer.
/** Developer: Jakob Neuhauser
/** Description: The procedure takes all the arguments needed for a transaction and inserts the data into the database. If angebotid or useridKaeufer are not valid, the data will not be inserted. 
/**
/*********************************************************************/

CREATE OR REPLACE PROCEDURE sp_addTransaction (l_n_angebotid_in IN NUMBER, l_n_useridKaeufer_in IN NUMBER, l_v_bewertungVerkaeuferT_in IN VARCHAR, l_n_bewertungVerkaeuferV_in IN NUMBER, l_v_bewertungKaeuferT_in IN VARCHAR, l_n_bewertungKaeuferV_in IN NUMBER, l_v_error_ou OUT VARCHAR) AS
  l_n_transaktionid NUMBER;
  l_n_count NUMBER;
BEGIN  
  
  SELECT COUNT(*) INTO l_n_count FROM "Angebot" WHERE "angebotid" = l_n_angebotid_in; 
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no angebotid ' || l_n_angebotid_in || '. Aborting!';
    RETURN;
  END IF;

  SELECT COUNT(*) INTO l_n_count FROM "User" WHERE "userid" = l_n_useridKaeufer_in;
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no userid ' || l_n_useridKaeufer_in || '. Aborting!';
    RETURN;
  END IF; 

  SELECT MAX("transaktionid")+1 INTO l_n_transaktionid FROM "Transaktion";
  INSERT INTO "Transaktion" ("transaktionid", "angebotid", "userid_kaeufer", "bewertung_verkaeufer_text", "bewertung_verkaeufer_value", "bewertung_kaeufer_text", "bewertung_kaeufer_value") VALUES (l_n_transaktionid, l_n_angebotid_in, l_n_useridKaeufer_in, l_v_bewertungVerkaeuferT_in, l_n_bewertungVerkaeuferV_in, l_v_bewertungKaeuferT_in, l_n_bewertungKaeuferV_in);

EXCEPTION 
  WHEN no_data_found THEN 
    l_v_error_ou := 'No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200); 
  WHEN too_many_rows THEN 
    l_v_error_ou := 'Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200);
  WHEN timeout_on_resource THEN 
    l_v_error_ou := 'Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200);
  WHEN OTHERS THEN
    l_v_error_ou := 'Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200);
    
 END;
/

/*********************************************************************
/**
/** Procedure: sp_sendMessage
/** Out: l_v_error_out - Eventual error message.
/** In: l_n_useridSender_in - The userid of the sender of the message.
/** In: l_n_useridEmpf_in - The userid of the receiver of the message.
/** In: l_v_inhalt_in - The content of the message. 
/** Developer: Jakob Neuhauser
/** Description: The procedure takes all the arguments needed for a Message and inserts the data into the database. If useridSender or useridEmpf are not valid, the data will not be inserted. The timestamp will be the time the procedure is executed. It is allowd that the userid of the sENDer and receiver are the same (for saving notes). 
/**
/*********************************************************************/

CREATE OR REPLACE PROCEDURE sp_sendMessage (l_n_useridSender_in IN NUMBER, l_n_useridEmpf_in IN NUMBER, l_v_inhalt_in IN VARCHAR, l_v_error_ou OUT VARCHAR) AS
  l_n_nachrichtenid NUMBER;
  l_n_count NUMBER;
  l_d_now TIMESTAMP; 
BEGIN  
  
  SELECT COUNT(*) INTO l_n_count FROM "User" WHERE "userid" = l_n_useridSender_in;
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no userid ' || l_n_useridSender_in || '. Aborting!';
    RETURN;
  END IF; 

  SELECT COUNT(*) INTO l_n_count FROM "User" WHERE "userid" = l_n_useridEmpf_in;
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no userid ' || l_n_useridEmpf_in || '. Aborting!';
    RETURN;
  END IF; 
  
  SELECT current_date INTO l_d_now FROM dual; 

  SELECT MAX("nachrichtenid")+1 INTO l_n_nachrichtenid FROM "Nachrichten";
  IF l_n_nachrichtenid IS NULL THEN
    l_n_nachrichtenid := 1; 
  END IF; 
  
  INSERT INTO "Nachrichten" ("nachrichtenid", "userid_sender", "userid_empf", "message_time", "inhalt") VALUES (l_n_nachrichtenid, l_n_useridSender_in, l_n_useridEmpf_in, l_d_now, l_v_inhalt_in);
  
  
EXCEPTION 
  WHEN no_data_found THEN 
    l_v_error_ou := 'No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200); 
  WHEN too_many_rows THEN 
    l_v_error_ou := 'Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200);
  WHEN timeout_on_resource THEN 
    l_v_error_ou := 'Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200);
  WHEN OTHERS THEN
    l_v_error_ou := 'Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200);
    
 END;
/

/*********************************************************************
/**
/** Procedure: sp_updateUserRolle
/** Out: l_v_error_out - Eventual error message.
/** In: l_n_userId - The Userid of the user whom I wnat to change the role. 
/** In: l_n_roleId - The id of the role to which I want to change.  
/** Developer: Jakob Neuhauser
/** Description: The Procedure changes the role of one User. 
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_updateUserRolle (l_n_userId IN NUMBER, l_n_rolleId_in IN NUMBER, l_v_error_ou OUT VARCHAR) AS
    
  l_v_tmp VARCHAR(2); 
BEGIN

  SELECT CASE WHEN EXISTS (
    SELECT "rolleid" FROM "Rolle" WHERE "rolleid"=l_n_rolleId_in) 
            THEN 'Y' 
            ELSE 'N' 
        END AS rec_exists INTO l_v_tmp
  FROM dual;
  
  IF l_v_tmp = 'N' THEN
    RAISE no_data_found; 
  END IF; 
  UPDATE "User" SET "rolleid" = l_n_rolleId_in WHERE "userid" = l_n_userId; 
  
EXCEPTION 
  WHEN no_data_found THEN 
    l_v_error_ou := 'No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200); 
  WHEN too_many_rows THEN 
    l_v_error_ou := 'Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200);
  WHEN timeout_on_resource THEN 
    l_v_error_ou := 'Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200);
  WHEN OTHERS THEN
    l_v_error_ou := 'Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200);
    
END;
/

/*********************************************************************
/**
/** Procedure: sp_delete_user
/** Out: l_n_error_out - Error code if error occured
/** In: l_n_userid_in - the primary key userid of the user to be deleted
/** Developer: Albert Schleidt
/** Description: Deletes a given user and assigns the following elements to the demo-deleted user: Nachrichten (sent or received), Transaktionen & Angebote
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_delete_user (l_n_userid_in IN NUMBER, l_n_error_out OUT NUMBER) AS
  l_n_demouserid NUMBER;
  l_n_add_user_error NUMBER;
BEGIN
  sp_add_user(1, 'DELETED', 'USER', TO_DATE('2000/06/09', 'yyyy/mm/dd'), 107, l_n_demouserid, l_n_add_user_error);

  UPDATE "Angebot" SET "userid_verkaeufer" = l_n_demouserid WHERE "userid_verkaeufer" = l_n_userid_in;
  UPDATE "Transaktion" SET "userid_kaeufer" = l_n_demouserid WHERE "userid_kaeufer" = l_n_userid_in;
  UPDATE "Nachrichten" SET "userid_sender" = l_n_demouserid WHERE "userid_sender" = l_n_userid_in;
  UPDATE "Nachrichten" SET "userid_empf" = l_n_demouserid WHERE "userid_empf" = l_n_userid_in;

  DELETE FROM "User" WHERE "userid" = l_n_userid_in;
-- EXCEPTION
END;
/


/
/*********************************************************************
/**
/** Procedure: sp_addProductOffer
/** Out: l_v_error_ou - Eventual error message.
/** In: l_n_angebotId_in - The id of the offer.
/** In: l_n_produktId_in - The id of the produkt
/** In: l_v_menge_in - The ammount of the prdukt. 
/** Developer: Jakob Neuhauser
/** Description: The procedure takes all arguments needet for a record in the table "Produkt_Angebot" and inserts the data into that table. 
/**
/*********************************************************************/

CREATE OR REPLACE PROCEDURE sp_addProductOffer (l_n_angebotId_in IN NUMBER, l_n_produktId_in IN NUMBER, l_v_menge_in IN NUMBER, l_v_error_ou OUT VARCHAR) AS

  l_n_count NUMBER;

BEGIN  
  
  SELECT COUNT(*) INTO l_n_count FROM "Angebot" WHERE "angebotid" = l_n_angebotId_in;
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no angebotid ' || l_n_angebotId_in || '. Aborting!';
    RETURN;
  END IF; 

  SELECT COUNT(*) INTO l_n_count FROM "Produkt" WHERE "produktid" = l_n_produktId_in;
  IF l_n_count = 0 THEN
    l_v_error_ou := 'There is no produktid ' || l_n_produktId_in || '. Aborting!';
    RETURN;
  END IF; 
  
  
  INSERT INTO "Produkt_Angebot" ("produktid", "angebotid", "menge") VALUES (l_n_angebotId_in, l_n_produktId_in, l_v_menge_in);
  
  
EXCEPTION 
  WHEN no_data_found THEN 
    l_v_error_ou := 'No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200); 
  WHEN too_many_rows THEN 
    l_v_error_ou := 'Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200);
  WHEN timeout_on_resource THEN 
    l_v_error_ou := 'Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200);
  WHEN OTHERS THEN
    l_v_error_ou := 'Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200);
    
 END;
/