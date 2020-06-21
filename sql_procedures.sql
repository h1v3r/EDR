/*********************************************************************
/**
/** Procedure: sp_add_ort
/** Out: l_n_pk_out - rimary Key ID of the existing or added element
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
/** Out: l_n_pk_out - rimary Key ID of the existing or added element
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
/** Out: l_n_pk_out - rimary Key ID of the existing or added element
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
/** Out: l_n_pk_out - rimary Key ID of the existing or added element
/** Out: l_n_error_out - Error code if error occured
/** In: l_n_rollepk_in - rolleid of the user
/** In: l_v_vorname_in - vorname of the user
/** In: l_v_nachname_in - nachname of the user
/** In: l_d_dob_in - date of birth of the user
/** In: l_n_adressepk_in - adresseid of the user
/** Developer: Albert Schleidt
/** Description: Creates a new user, if it doesn't exist already.
/**
/*********************************************************************/
CREATE OR REPLACE PROCEDURE sp_add_user (l_n_rollepk_in IN NUMBER, l_v_vorname_in IN VARCHAR, l_v_nachname_in IN VARCHAR, l_d_dob_in DATE, l_n_adressepk_in IN NUMBER, l_n_pk_out OUT NUMBER, l_n_error_out OUT NUMBER) AS
    l_n_countEntries NUMBER;
    l_n_maxUserid NUMBER;
BEGIN
    SELECT COUNT(*) INTO l_n_countEntries FROM "User" WHERE "rolleid" = l_n_rollepk_in AND "vorname" = l_v_vorname_in AND "nachname" = l_v_nachname_in AND "dob" = l_d_dob_in AND "adresseid" = l_n_adressepk_in;
    IF l_n_countEntries > 0 THEN
    SELECT "userid" INTO l_n_pk_out FROM "User" WHERE "rolleid" = l_n_rollepk_in AND "vorname" = l_v_vorname_in AND "nachname" = l_v_nachname_in AND "dob" = l_d_dob_in AND "adresseid" = l_n_adressepk_in;
        RETURN;
    ELSE
        SELECT MAX("userid") INTO l_n_maxUserid FROM "User";
        INSERT INTO "User" VALUES (l_n_maxUserid+1, l_n_rollepk_in, l_v_vorname_in, l_v_nachname_in, l_d_dob_in, l_n_adressepk_in);
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
/** Out: nothing
/** In: l_n_saisonid_in - The Saisonid of the product.
/** In: l_n_bioid_in - The Bioid of the product.
/** In: l_v_name_in - The name of the product.
/** Developer: Jakob Neuhauser
/** Description: The procedure takes all the arguments needed for a product and inserts the data into the database. If saisonid or bioid are not valid, the data will not be inserted. 
/**
/*********************************************************************/

create or replace procedure sp_addProduct (l_n_saisonid_in number, l_n_bioid_in number, l_v_name_in varchar) as
  l_n_produktid number;
  l_n_count number;
begin  
  
  select count(*) into l_n_count from "Saison" where "saisonid" = l_n_saisonid_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no saisonid ' || l_n_saisonid_in || '. Aborting!');
    return;
  end if; 
  
  select count(*) into l_n_count from "Bio_Faktor" where "bioid" = l_n_bioid_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no bioid ' || l_n_bioid_in || '. Aborting!');
    return;
  end if;

  select max("produktid")+1 into l_n_produktid from "Produkt";
  insert into "Produkt" ("produktid", "saisonid", "bioid", "name") values (l_n_produktid, l_n_saisonid_in, l_n_bioid_in, l_v_name_in);

exception 
  when no_data_found then 
    dbms_output.put_line('No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200));
  when too_many_rows then 
    dbms_output.put_line('Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200));
  when timeout_on_resource then 
    dbms_output.put_line('Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200));
  when others then
    dbms_output.put_line('Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200));

end;
/

/*********************************************************************
/**
/** Procedure: sp_addOffer
/** Out: nothing
/** In: l_n_useridVerkaeufer_in - The userid of the seller.
/** In: l_n_kategorieid_in - The id of the kathegorie of the offer.
/** In: l_v_anzeigetext_in - A short discription or the offer or the title. 
/** Developer: Jakob Neuhauser
/** Description: The procedure takes all the arguments needed for an offer and inserts the data into the database. If kategorieid or useridVerkaeufer are not valid, the data will not be inserted. 
/**
/*********************************************************************/

create or replace procedure sp_addOffer (l_n_useridVerkaeufer_in number, l_n_kategorieid_in number, l_v_anzeigetext_in varchar) as
  l_n_angebotid number;
  l_n_count number;
begin  
  
  select count(*) into l_n_count from "User" where "userid" = l_n_useridVerkaeufer_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no userid ' || l_n_useridVerkaeufer_in || '. Aborting!');
    return;
  end if; 
  
  select count(*) into l_n_count from "Angebotskategorie" where "kategorieid" = l_n_kategorieid_in; 
  if l_n_count = 0 then
    dbms_output.put_line('There is no kategorieid ' || l_n_kategorieid_in || '. Aborting!');
    return;
  end if;

  select max("angebotid")+1 into l_n_angebotid from "Angebot";
  insert into "Angebot" ("angebotid", "userid_verkaeufer", "kategorieid", "anzeigetext") values (l_n_angebotid, l_n_useridVerkaeufer_in, l_n_kategorieid_in, l_v_anzeigetext_in);

exception 
  when no_data_found then 
    dbms_output.put_line('No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200));
  when too_many_rows then 
    dbms_output.put_line('Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200));
  when timeout_on_resource then 
    dbms_output.put_line('Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200));
  when others then
    dbms_output.put_line('Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200));
    
 end;
/

/*********************************************************************
/**
/** Procedure: sp_addTransaction
/** Out: nothing
/** In: l_n_angebotid_in - The angebotid of the transaction.
/** In: l_n_useridKaufer_in - The userid of teh buyer.
/** In: l_v_bewertungVerkaeuferT_in - A rating in Text from the seller. 
/** In: l_v_bewertungVerkaeuferV_in - A rating in form of a value from the seller. 
/** In: l_v_bewertungKaeuferT_in - A rating in Text from the buyer. 
/** In: l_v_bewertungKaeuferV_in - A rating in form of a value from the buyer.
/** Developer: Jakob Neuhauser
/** Description: The procedure takes all the arguments needed for a transaction and inserts the data into the database. If angebotid or useridKaeufer are not valid, the data will not be inserted. 
/**
/*********************************************************************/

create or replace procedure sp_addTransaction (l_n_angebotid_in number, l_n_useridKaeufer_in number, l_v_bewertungVerkaeuferT_in varchar, l_n_bewertungVerkaeuferV_in number, l_v_bewertungKaeuferT_in varchar, l_n_bewertungKaeuferV_in number) as
  l_n_transaktionid number;
  l_n_count number;
begin  
  
  select count(*) into l_n_count from "Angebot" where "angebotid" = l_n_angebotid_in; 
  if l_n_count = 0 then
    dbms_output.put_line('There is no angebotid ' || l_n_angebotid_in || '. Aborting!');
    return;
  end if;

  select count(*) into l_n_count from "User" where "userid" = l_n_useridKaeufer_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no userid ' || l_n_useridKaeufer_in || '. Aborting!');
    return;
  end if; 

  select max("transaktionid")+1 into l_n_transaktionid from "Transaktion";
  insert into "Transaktion" ("transaktionid", "angebotid", "userid_kaeufer", "bewertung_verkaeufer_text", "bewertung_verkaeufer_value", "bewertung_kaeufer_text", "bewertung_kaeufer_value") values (l_n_transaktionid, l_n_angebotid_in, l_n_useridKaeufer_in, l_v_bewertungVerkaeuferT_in, l_n_bewertungVerkaeuferV_in, l_v_bewertungKaeuferT_in, l_n_bewertungKaeuferV_in);

exception 
  when no_data_found then 
    dbms_output.put_line('No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200));
  when too_many_rows then 
    dbms_output.put_line('Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200));
  when timeout_on_resource then 
    dbms_output.put_line('Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200));
  when others then
    dbms_output.put_line('Some unknowen error occoured!'    ||  SUBSTR(SQLERRM, 1, 200));
    
 end;
/

/*********************************************************************
/**
/** Procedure: sp_sendMessage
/** Out: nothing
/** In: l_n_useridSender_in - The userid of the sender of the message.
/** In: l_n_useridEmpf_in - The userid of the receiver of the message.
/** In: l_v_inhalt_in - The content of the message. 
/** Developer: Jakob Neuhauser
/** Description: The procedure takes all the arguments needed for a Message and inserts the data into the database. If useridSender or useridEmpf are not valid, the data will not be inserted. The timestamp will be the time the procedure is executed. It is allowd that the userid of the sender and receiver are the same (for saving notes). 
/**
/*********************************************************************/

create or replace procedure sp_sendMessage (l_n_useridSender_in number, l_n_useridEmpf_in number, l_v_inhalt_in varchar) as
  l_n_nachrichtenid number;
  l_n_count number;
  l_d_now timestamp; 
begin  
  
  select count(*) into l_n_count from "User" where "userid" = l_n_useridSender_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no userid ' || l_n_useridSender_in || '. Aborting!');
    return;
  end if; 

  select count(*) into l_n_count from "User" where "userid" = l_n_useridEmpf_in;
  if l_n_count = 0 then
    dbms_output.put_line('There is no userid ' || l_n_useridEmpf_in || '. Aborting!');
    return;
  end if; 
  
  select current_date into l_d_now from dual; 

  select max("nachrichtenid")+1 into l_n_nachrichtenid from "Nachrichten";
  insert into "Nachrichten" ("nachrichtenid", "userid_sender", "userid_empf", "message_time", "inhalt") values (l_n_nachrichtenid, l_n_useridSender_in, l_n_useridEmpf_in, l_d_now, l_v_inhalt_in);
  
exception 
  when no_data_found then 
    dbms_output.put_line('No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200));
  when too_many_rows then 
    dbms_output.put_line('Got too many rows!    ' || SUBSTR(SQLERRM, 1, 200));
  when timeout_on_resource then 
    dbms_output.put_line('Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200));
  when others then
    dbms_output.put_line('Some unknowen error occoured!'    ||  SUBSTR(SQLERRM, 1, 200));
    
 end;
/