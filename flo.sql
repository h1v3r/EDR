SET SERVEROUTPUT ON;
/
/*********************************************************************
/**
/** Table: "User"
/** Developer: Florian Weiss
/** Description: Zeigt Userdetails aller User mit Adresse und Rolle
/**
/*********************************************************************/

CREATE OR REPLACE VIEW User_Details AS
SELECT * FROM "User" 
	LEFT JOIN "Adresse" USING("adresseid")
	LEFT JOIN "Ort" USING("plz")
	LEFT JOIN "Rolle" USING("rolleid")
/
--Test der View
select * from User_Details
/
select * from "Adresse"
/
/*********************************************************************
/**
/** Function: Transaktionen_UserX
/** In: UserID ? ID des Users der seine Transaktionen sehen will.
/** Returns: Cursor der alle Transaktionen auflistet diese Users Values: Transaktionsid, Userid_verkäufer und der Anzeigetext
/** Developer: Florian Weiss
/** Description: Diese Funktion Liefert einen Cursor mit allen Transaktionen eines Users zurück. 
/**
/*********************************************************************/

CREATE OR REPLACE FUNCTION f_transaktion_userx (i_n_userid IN NUMBER) RETURN SYS_REFCURSOR 
AS

rc SYS_REFCURSOR;

BEGIN
 OPEN rc FOR SELECT "transaktionid", "userid_verkaeufer", "anzeigetext" FROM "User" 
	LEFT JOIN "Transaktion" ON "userid" = "userid_kaeufer"
	LEFT JOIN "Angebot" USING("angebotid")
	WHERE "userid" = i_n_userid;
	
RETURN rc;
EXCEPTION 
  WHEN no_data_found THEN 
    dbms_output.put_line('No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200));
  WHEN timeout_on_resource THEN 
    dbms_output.put_line('Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200));
  WHEN OTHERS THEN
    dbms_output.put_line('Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200));

END;
/
---Function testen
DECLARE
test SYS_REFCURSOR;
v_trans_id number;
v_trans_vk_id number;
v_trans_text VARCHAR(255);
BEGIN
test := f_transaktion_userx(10004);

LOOP
FETCH test INTO v_trans_id, v_trans_vk_id, v_trans_text;
EXIT WHEN test%NOTFOUND;
dbms_output.put_line(v_trans_id ||v_trans_vk_id ||v_trans_text);

END LOOP;

	

END;
/
---?Test Select für f_Transaktionen_UserX
Select * from "User" 
	LEFT JOIN "Transaktion" on "userid" = "userid_kaeufer"
	LEFT JOIN "Angebot" using("angebotid")
	
	WHERE "userid" = 10004
/
/*********************************************************************
/**
/** Function: Nachrichten_UserX
/** In: UserID ? ID des Users der seine Nachrichten sehen will.
/** Returns: Cursor der alle Nachriten auflistet die der User versendet hat Values: Vorname empfänger, Nachname Empfänger, Text und Timestamp
/** Developer: Florian Weiss
/** Description: Diese Funktion Liefert einen Cursor mit allen Nachrichten die ein Users versendet hat zurück. 
/**
/*********************************************************************/

CREATE OR REPLACE FUNCTION f_Nachrichten_UserX (i_n_userid IN number) RETURN SYS_REFCURSOR 
AS

rc SYS_REFCURSOR;

BEGIN
 OPEN rc FOR SELECT empf."vorname", empf."nachname", n."inhalt", n."message_time" FROM "User" s
	LEFT JOIN "Nachrichten" n ON s."userid" = n."userid_sender"
	LEFT JOIN "User" empf ON n."userid_empf" = empf."userid"
		WHERE s."userid" = i_n_userid;
	
RETURN rc;

EXCEPTION 
  WHEN no_data_found THEN 
    dbms_output.put_line('No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200));
  WHEN timeout_on_resource THEN 
    dbms_output.put_line('Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200));
  WHEN OTHERS THEN
    dbms_output.put_line('Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200));
END;
/
---Function testen
DECLARE
test SYS_REFCURSOR;
v_mes_vn VARCHAR(255);
v_mes_nn VARCHAR(255);
v_mes_text VARCHAR(255);
v_mes_time DATE;
BEGIN
test := f_Nachrichten_UserX(10002);

LOOP
FETCH test INTO v_mes_vn, v_mes_nn, v_mes_text,v_mes_time;
EXIT WHEN test%NOTFOUND;
dbms_output.put_line(v_mes_vn||v_mes_nn||v_mes_text||v_mes_time);

END LOOP;
END;
/
-- Test Select für die f_Nachrichten_UserX
SELECT empf."vorname", empf."nachname", n."inhalt", n."message_time" FROM "User" s
	LEFT JOIN "Nachrichten" n ON s."userid" = n."userid_sender"
	LEFT JOIN "User" empf ON n."userid_empf" = empf."userid"
		WHERE s."userid" = 10002

/
/*********************************************************************
/**
/** Function: Angebote_Saison
/** In: SaisonId ? ID der gewünschten Saison 
/** Returns: Cursor der alle Nachriten auflistet die der User versendet hat Values: Vorname empfänger, Nachname Empfänger, Text und Timestamp
/** Developer: Florian Weiss
/** Description: Diese Funktion Liefert einen Cursor mit allen Nachrichten die ein Users versendet hat zurück. 
/**
/*********************************************************************/
CREATE OR REPLACE FUNCTION f_angebote_saison (i_in_sid IN NUMBER) RETURN SYS_REFCURSOR
AS

rc SYS_REFCURSOR;

BEGIN
OPEN rc FOR SELECT a."angebotid", a."anzeigetext", p."name" FROM "Angebot" a 
		LEFT JOIN "Produkt_Angebot" pa ON a."angebotid"= pa."angebotid"
		LEFT JOIN "Produkt" p USING("produktid")
		WHERE "saisonid" = i_in_sid;
RETURN rc;
EXCEPTION 
  WHEN no_data_found THEN 
    dbms_output.put_line('No Data Found!    ' ||  SUBSTR(SQLERRM, 1, 200));
  WHEN timeout_on_resource THEN 
    dbms_output.put_line('Timeout....!'    ||  SUBSTR(SQLERRM, 1, 200));
  WHEN OTHERS THEN
    dbms_output.put_line('Some unknown error occoured!'    ||  SUBSTR(SQLERRM, 1, 200));
END;
/
---Function testen
DECLARE
test SYS_REFCURSOR;
v_ang_id VARCHAR(255);
v_ang_name VARCHAR(255);
v_ang_text VARCHAR(255);

BEGIN
test := f_Angebote_Saison(3);

LOOP
FETCH test INTO v_ang_id, v_ang_name, v_ang_text;
EXIT WHEN test%NOTFOUND;
dbms_output.put_line(v_ang_id||v_ang_name||v_ang_text);

END LOOP;

END;
/
-- Test select 
select a."angebotid", a."anzeigetext", p."name" from "Angebot" a 
		LEFT JOIN "Produkt_Angebot" pa on a."angebotid"= pa."angebotid"
		LEFT JOIN "Produkt" p using("produktid")
		WHERE "saisonid" = 3
/
