SET serveroutput ON;
/
/*********************************************************************
/**
/** Procedure: sp_addProduct
/** Out: l_v_error_ou - Eventual error message. 
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
/** Out: l_v_error_ou - Eventual error message.
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
/** Out: l_v_error_ou - Eventual error message.
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
/** Out: l_v_error_ou - Eventual error message.
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
/** Table: Bio_Faktor_User_Durchschnitt
/** Developer: Jakob Neuhauser
/** Description: A View which shows the average Bio_factor of every seller. 
/**
/*********************************************************************/


CREATE OR REPLACE VIEW Bio_Faktor_User_Durchschnitt AS 
  SELECT "userid", AVG(TO_NUMBER(SUBSTR("kategorie_bezeichnung", 5, 1))) AS bio_faktor FROM "User"
    FULL JOIN "Angebot" ON "User"."userid"="Angebot"."userid_verkaeufer"
    LEFT JOIN "Produkt_Angebot" USING ("angebotid")
    LEFT JOIN "Produkt" USING ("produktid")
    LEFT JOIN "Bio_Faktor" USING ("bioid")
    GROUP BY "userid"
    ORDER BY "userid" ASC;
   
/
/*********************************************************************
/**
/** Procedure: sp_updateUserRolle
/** Out: l_v_error_ou - Eventual error message.
/** In: l_n_userId - The Userid of the user whom I wnat to change the role. 
/** In: l_n_roleId - The id of the role to which I want to change.  
/** Developer: Jakob Neuhauser
/** Description: The Procedure changes the role of one User. 
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_updateUserRolle (l_n_userId IN NUMBER, l_n_rolleId_in IN NUMBER, l_v_error_ou OUT VARCHAR) AS
BEGIN
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

/
/*********************************************************************
/**
/** Trigger: tr_br_welcomeMessage
/** Type: Before row
/** Type Extension: insert
/** Developer: Jakob Neuhauser
/** Description: Automaticaly writes a welcomeing Message to the User whom was just created. 
/**
/*********************************************************************/
/
--@Albert Diese Inserts werden für den Trigger benötigt. Bitte ins insert script einfügen. 
INSERT INTO "Ort" ("plz", "name") VALUES (0, 'System Ort'); 
INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer") VALUES (0, 0, 'Systemgasse', 0);
INSERT INTO "User" ("userid", "rolleid", "vorname", "nachname", "adresseid") VALUES (0, 3, 'EDR', 'System', 0);

/
CREATE OR REPLACE TRIGGER tr_welcomeMessage_v
  AFTER INSERT ON "User"
  FOR EACH ROW 
DECLARE
  l_v_error_ou VARCHAR(1000); 
  l_n_nachrichtenid NUMBER;
  l_d_now TIMESTAMP;  
BEGIN

  SELECT MAX("nachrichtenid")+1 INTO l_n_nachrichtenid FROM "Nachrichten";
  IF l_n_nachrichtenid IS NULL THEN
    l_n_nachrichtenid := 1; 
  END IF; 
  
  SELECT current_date INTO l_d_now FROM dual; 
  
  INSERT INTO "Nachrichten" ("nachrichtenid", "userid_sender", "userid_empf", "message_time", "inhalt") VALUES (l_n_nachrichtenid, 0, :new."userid", l_d_now, 'HI ' || :new."vorname" || ', welcome to the EDR App.');
 
EXCEPTION 
  WHEN OTHERS THEN
    raise_application_error(-20000, 'Some error occurred');
  
END;  
/

/
/*********************************************************************
/**
/** Trigger: tr_br_deleteUserCompletely
/** Type: Before row
/** Type Extension: delete
/** Developer: Jakob Neuhauser
/** Description: Deletes everything related to a User. 
/**
/*********************************************************************/
CREATE OR REPLACE TRIGGER tr_br_deleteUserCompletely
  BEFORE DELETE ON "User"
  FOR EACH ROW  
DECLARE 
  CURSOR l_n_angebotids_cur IS SELECT * FROM "Angebot" WHERE "userid_verkaeufer" =  :old."userid";
  
BEGIN

  DELETE FROM "Nachrichten" WHERE "userid_sender" = :old."userid" OR "userid_empf" = :old."userid";
  DELETE FROM "Transaktion" WHERE "userid_kaeufer" = :old."userid"; 
  
  FOR i IN l_n_angebotids_cur LOOP
    DELETE FROM "Transaktion" WHERE "angebotid" = i."angebotid"; 
  END LOOP; 
  
  DELETE FROM "Angebot" WHERE "userid_verkaeufer" =  :old."userid";
  
EXCEPTION 
  WHEN OTHERS THEN
    raise_application_error(-20000, 'Some error occurred');
  
END;  
/

/
/*********************************************************************
/**
/** Trigger: tr_ar_logUserRole
/** Type: After row
/** Type Extension: update or insert or delete
/** Developer: Jakob Neuhauser
/** Description: Logs if the role of a user is changed.  
/**
/*********************************************************************/
/
/*********************************************************************/
/**
/** Table: User_Rolle_Log
/** Developer: Jakob Neuhauser
/** Description: A Table to log all userrole changes. 
/**
/*********************************************************************/
--@Albert Diese Creates werden für den Trigger benötigt. Bitte ins DDL script einfügen. 
CREATE TABLE "User_Rolle_Log"(userid NUMBER, rolleid_alt number, rolleid_neu number, aktion varchar(10));
 
/
CREATE OR REPLACE TRIGGER tr_br_deleteUserCompletely
  BEFORE DELETE OR INSERT OR UPDATE ON "User"
  FOR EACH ROW    
BEGIN

  IF INSERTING THEN
    INSERT INTO "User_Rolle_Log" (userid, rolleid_neu, aktion) VALUES (:new."userid", :new."rolleid", 'INSERT');
  END IF;
    
  IF UPDATING THEN
    INSERT INTO "User_Rolle_Log" (userid, rolleid_alt, rolleid_neu, aktion) VALUES (:new."userid", :old."rolleid", :new."rolleid", 'UPDATE');
  END IF;

  IF DELETING THEN
    INSERT INTO "User_Rolle_Log" (userid, rolleid_alt, aktion) VALUES (:old."userid", :old."rolleid", 'DELETE');
  END IF;  
  
EXCEPTION 
  WHEN OTHERS THEN
    raise_application_error(-20000, 'Some error occurred');

END;  
/


/
/*********************************************************************
/**
/** Trigger: tr_br_checkOfferAmmount
/** Type: Before row
/** Type Extension: insert
/** Developer: Jakob Neuhauser
/** Description: Checks if the "Menge" of an offer is at least 5. 
/**
/*********************************************************************/
CREATE OR REPLACE TRIGGER tr_br_checkOfferAmmount
  BEFORE INSERT ON "Produkt_Angebot"
  FOR EACH ROW  
BEGIN

  IF :new."menge" < 5 THEN
    raise_application_error(-20000, '"Menge" must be at least 5.');
  END IF; 
  
EXCEPTION 
  WHEN OTHERS THEN
    raise_application_error(-20000, 'Some error occurred');
END;  
/
