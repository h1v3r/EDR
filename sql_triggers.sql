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
--The following inserts are mandatory! They should also be found in the insert script. 
--INSERT INTO "Ort" ("plz", "name") VALUES (0, 'System Ort'); 
--INSERT INTO "Adresse" ("adresseid", "plz", "strasse", "hausnummer") VALUES (0, 0, 'Systemgasse', 0);
--INSERT INTO "User" ("userid", "rolleid", "vorname", "nachname", "adresseid") VALUES (0, 3, 'EDR', 'System', 0);

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

CREATE OR REPLACE TRIGGER tr_ar_logUserRolle
  BEFORE DELETE OR INSERT OR UPDATE ON "User"
  FOR EACH ROW 
DECLARE 
  l_n_logid NUMBER; 
  l_d_now TIMESTAMP;    
BEGIN

  SELECT MAX("logid")+1 INTO l_n_logid FROM "User_Rolle_Log";
  IF l_n_logid IS NULL THEN
    l_n_logid := 1; 
  END IF; 

  SELECT current_date INTO l_d_now FROM dual;

  IF INSERTING THEN
    INSERT INTO "User_Rolle_Log" ("logid", "userid", "rolleid_neu","time", "aktion") VALUES (l_n_logid, :new."userid", :new."rolleid", l_d_now, 'INSERT');
  END IF;
    
  IF UPDATING THEN
    INSERT INTO "User_Rolle_Log" ("logid", "userid", "rolleid_alt", "rolleid_neu", "time", "aktion") VALUES (l_n_logid, :new."userid", :old."rolleid", :new."rolleid", l_d_now, 'UPDATE');
  END IF;

  IF DELETING THEN
    INSERT INTO "User_Rolle_Log" ("logid", "userid", "rolleid_alt", "time", "aktion") VALUES (l_n_logid, :old."userid", :old."rolleid", l_d_now, 'DELETE');
  END IF;  
  
EXCEPTION 
  WHEN OTHERS THEN
    raise_application_error(-20000, 'Some error occurred');

END;  


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
