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
